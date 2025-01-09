script.on_init(function()
    storage.spoilage_freezers = {}
    storage.spoilage_freezer_wagons = {}
end)

script.on_configuration_changed(function()
    storage.spoilage_freezers = storage.spoilage_freezers or {}
    storage.spoilage_freezer_wagons = storage.spoilage_freezer_wagons or {}
end)

local event_filter = {
    {filter="name", name="spoilables-freezer"},
    {filter="name", name="cargo-wagon-freezer"},
}

local function on_built(event)
    local entity = event.entity
    if entity.name == "spoilables-freezer" then
        local surf = entity.surface
        local planet = surf.planet
        local temp = -270
        if planet then
            temp = planet.prototype.surface_properties.temperature or 18
        end
        local power = math.max(temp, 0) / 18
        entity.power_usage = power * 1000000 / 60
        local container = surf.create_entity{
            name = "spoilables-freezer-container",
            position = entity.position,
            force = entity.force,
            raise_built = false,
            create_build_effect_smoke = false,
            quality = entity.quality
        }
        container.destructible = false
        storage.spoilage_freezers[entity.unit_number] = {entity = entity, container = container}
    elseif entity.name == "cargo-wagon-freezer" then
        storage.spoilage_freezer_wagons[entity.unit_number] = entity
    end
end

local function on_entity_removed(event)
    local entity = event.entity
    if entity.name == "spoilables-freezer" then
        local data = storage.spoilage_freezers[entity.unit_number]
        if data then
            local container = data.container
            if container and container.valid then
                local inv = container.get_inventory(defines.inventory.chest)
                for i = 1, #inv do
                    local item_stack = inv[i]
                    if item_stack and item_stack.valid_for_read then
                        entity.surface.spill_item_stack{position=entity.position, stack=item_stack, enable_looted=true, force=entity.force, allow_belts=false}
                    end
                end
                container.destroy()
            end
        end
        storage.spoilage_freezers[entity.unit_number] = nil
    elseif entity.name == "cargo-wagon-freezer" then
        storage.spoilage_freezer_wagons[entity.unit_number] = nil
        for index, equipment in ipairs(entity.grid.equipment) do
            local item = equipment.prototype.take_result
            local item_stack = {name=item.name, count=1, quality=equipment.quality}
            entity.surface.spill_item_stack{position=entity.position, stack=item_stack, enable_looted=true, force=entity.force, allow_belts=false}
        end
    end
end

script.on_event(defines.events.on_built_entity, on_built, event_filter)

script.on_event(defines.events.on_robot_built_entity, on_built, event_filter)

script.on_event(defines.events.on_space_platform_built_entity, on_built, event_filter)

script.on_event(defines.events.on_player_mined_entity, on_entity_removed, event_filter)

script.on_event(defines.events.on_robot_mined_entity, on_entity_removed, event_filter)

script.on_event(defines.events.on_entity_died, on_entity_removed, event_filter)

script.on_event(defines.events.on_space_platform_pre_mined, on_entity_removed, event_filter)

local function freeze_stack(stack)
    if stack and stack.valid_for_read and stack.spoil_percent ~= 0 then
        local time_left = stack.spoil_tick - game.tick
        stack.spoil_tick = game.tick + math.min(stack.prototype.get_spoil_ticks(stack.quality), time_left + 300)
    end
end

local function freeze_container_items(container, type)
    if not container or not container.valid then return end
    local inventory = container.get_inventory(type)
    if not inventory then return end
    for i = 1, #inventory, 1 do
        local stack = inventory[i]
        freeze_stack(stack)
    end
end

local function is_subzero(entity)
    local planet = entity.surface.planet
    if planet then
        return planet.prototype.surface_properties.temperature or 1 <= 0
    end
    return true
end

script.on_nth_tick(300, function(event)
    for unit_nr, data in pairs(storage.spoilage_freezers) do
        local entity = data.entity
        local container = data.container
        if not entity or not entity.valid then
            storage.spoilage_freezers[unit_nr] = nil
            goto continue
        end
        if entity.energy > 5000000 or is_subzero(entity) then -- 5MJ
            freeze_container_items(container, defines.inventory.chest)
        end
        ::continue::
    end
    for unit_nr, entity in pairs(storage.spoilage_freezer_wagons) do
        if not entity or not entity.valid then
            storage.spoilage_freezer_wagons[unit_nr] = nil
            goto continue2
        end
        local equipment = entity.grid.find("cargo-wagon-freezer-equipment")
        if not equipment then goto continue2 end
        if equipment.energy > 5000000 or is_subzero(entity) then -- 5MJ
            freeze_container_items(entity, defines.inventory.cargo_wagon)
        end
        ::continue2::
    end
end)

-- Handle GUI opening
script.on_event(defines.events.on_gui_opened, function(event)
    local player = game.players[event.player_index]
    local entity = event.entity
    if entity then
        if entity.name == "spoilables-freezer" then
            player.opened = nil  -- Prevent GUI from opening
        end
    end
end)
