local frozen_multipler = settings.startup["frozen-spoil-time"].value
--local frozen_weight_bonus = settings.startup["ice-extra-weight"].value
local frozen_items = {}

local capsule_action = {
    type = "use-on-self",
    attack_parameters = {
        type = "projectile",
        range = 0,
        cooldown = 60,
        ammo_type = {
                target_type = "position"
            },
        ammo_category = "melee",
        activation_type = "activate"
    },
    uses_stack = false
}

local function get_localized_name(item)
    -- Some items do not have localized names
    if item.place_result then
        return {"entity-name." .. item.place_result}
    elseif item.place_as_equipment_result then
        return {"equipment-name." .. item.place_as_equipment_result}
    else
        return item.localised_name or {'item-name.' .. item.name}
    end
end

for _, category in pairs(data.raw) do
    for _, item in pairs(category) do
        if item.spoil_ticks and item.name ~= "ice" then

        -- Create a deep copy of the original item
        local frozen_item = table.deepcopy(item)
        frozen_item.name = "MOD-FROZEN-" .. item.name
        frozen_item.spoil_result = item.spoil_result
        frozen_item.subgroup = "freezing-subgroup"
        frozen_item.hidden_in_factoriopedia = true

        -- Frozen item spoil time
        frozen_item.spoil_ticks = math.min(item.spoil_ticks * frozen_multipler, 4294967295)
        
        -- Ice icon
        local original_icons = frozen_item.icons or {}
        frozen_item.icons = {
            {
                icon = "__freezer__/graphics/icons/ice.png",
                icon_size = 64
            }
        }
        for _, icon in pairs(original_icons) do
            table.insert(frozen_item.icons, icon)
        end
        if frozen_item.icon then
            local original_icon = {
                icon = frozen_item.icon,
                icon_size = frozen_item.icon_size or 64,
                scale = 32 / (frozen_item.icon_size or 64) * 0.8
            }
            table.insert(frozen_item.icons, original_icon)
        end
        table.insert(frozen_item.icons,  {
            icon = "__freezer__/graphics/icons/ice-translucent.png",
            icon_size = 64
        })
        frozen_item.icon = nil

        -- New display name
        frozen_item.localised_name = {"custom.frozen-item", get_localized_name(item)}

        -- Make frozen item unuseable
        frozen_item.fuel_category = nil
        frozen_item.fuel_value = nil
        frozen_item.fuel_acceleration_multiplier = nil
        frozen_item.fuel_top_speed_multiplier = nil
        frozen_item.fuel_emissions_multiplier = nil
        frozen_item.fuel_glow_color = nil
        frozen_item.place_result = nil
        frozen_item.place_as_equipment_result = nil
        if frozen_item.capsule_action then
            frozen_item.capsule_action = capsule_action
        end

        -- Add to game
        table.insert(frozen_items, frozen_item)
        end
    end
end

data:extend(frozen_items)

local base_recipe = {
    type = "recipe",
    category = "freezer-category",
    enabled = false,
    energy_required = 3,
    ingredients = {
        {
            type = "item",
            name = "ice",
            amount = 1
        },
        {
            type = "item",
            amount = 1
        }
    },
    results = {
        {
            type = "item",
            amount = 1
        }
    }
}

-- Freeze items
for _, item in pairs(frozen_items) do
    local recipe = util.table.deepcopy(base_recipe)
    local o_name = string.sub(item.name, 12)
    recipe.ingredients[2].name = o_name
    recipe.category = "freezer-cryogenics-category"
    recipe.allow_productivity = false
    recipe.allow_quality = false
    recipe.results[1].name = item.name
    recipe.name = "MOD-FREEZE-" .. o_name
    recipe.localised_name = {"custom.freeze", item.localised_name[2]}
    recipe.order = item.order
    recipe.subgroup = "freezing-subgroup"
    local unlock = {
        type = "unlock-recipe",
        recipe = recipe.name
    }
    data:extend({recipe})
    table.insert(data.raw.technology["spoilables-processing"].effects, unlock)
end

-- Unfreeze items
for _, item in pairs(frozen_items) do
    local recipe = util.table.deepcopy(base_recipe)
    local o_name = string.sub(item.name, 12)
    recipe.ingredients = {{type = "item", name = item.name, amount = 1}}
    recipe.results[1].name = o_name
    recipe.name = "MOD-UNFREEZE-" .. item.name
    recipe.localised_name = {"custom.unfreeze", item.localised_name[2]}
    recipe.order = item.order
    recipe.subgroup = "unfreezing-subgroup"
    recipe.category = "smelting"
    recipe.allow_productivity = false
    recipe.allow_quality = false
    recipe.icons = util.table.deepcopy(item.icons)
    table.insert(recipe.icons, {
        icon = "__freezer__/graphics/icons/fire.png",
        icon_size = 64
    })
    local unlock = {
        type = "unlock-recipe",
        recipe = recipe.name
    }
    data:extend({recipe})
    table.insert(data.raw.technology["spoilables-processing"].effects, unlock)
end

table.insert(data.raw["assembling-machine"]["cryogenic-plant"].crafting_categories, "freezer-cryogenics-category")

-- WAGON
local cargo_wagon_freezer = table.deepcopy(data.raw["cargo-wagon"]["cargo-wagon"])
cargo_wagon_freezer.name = "cargo-wagon-freezer"
cargo_wagon_freezer.icon = "__freezer__/graphics/icons/cargo-wagon-freezer.png"
cargo_wagon_freezer.icon_size = 64
cargo_wagon_freezer.weight = cargo_wagon_freezer.weight * 1.2
cargo_wagon_freezer.inventory_size = cargo_wagon_freezer.inventory_size * 0.5
cargo_wagon_freezer.factoriopedia_simulation = {
    init = "    game.simulation.camera_position = {1, 0.5}\n    game.surfaces[1].create_entities_from_blueprint_string\n    {\n      string = \"0eNqN011uwjAMAOC7+DlF0DYFepVpqkIxxVrqoCSFMdS7z6XsR2KT8hjH/pLI8Q12dsCTJ45Q34BaxwHqlxsE6tjYKcamR6jBG7IwKiDe4zvUq/FVAXKkSDhX3BfXhod+h14S1FdliFLbHWN2JxScXJAqxxMuUrZWcIU614LvyWM775WjejLzZFMnm0WyWSSb5bfZGt+57GI6x9nBI37I9rO8XGyL9a8rI5udxca6jkKkNjSXI8m6d2fiDuqDsQEVOE9yrpmh5SLXU3POEnJeIB6s/eNqOvm5q+TnVqlmOrlOJdObskkl//s78uFDdO1bI0PCc/gxK1P0kUERezniZ6oUnNGHO5FvVuWm0FVVlbrS23H8BCsMKtg=\",\n      position = {0, 0}\n    }\n  "
}
-- Update graphics
local tint = {r=0, g=0.6, b=0.9}
cargo_wagon_freezer.pictures.rotated.layers[1].tint = tint
cargo_wagon_freezer.pictures.rotated.layers[2].tint = tint
cargo_wagon_freezer.pictures.sloped.layers[1].tint = tint
cargo_wagon_freezer.pictures.sloped.layers[2].tint = tint
cargo_wagon_freezer.vertical_doors.layers[1].filename = "__freezer__/graphics/entity/cargo-wagon-freezer/cargo-wagon-door-vertical.png"
cargo_wagon_freezer.vertical_doors.layers[2].filename = "__freezer__/graphics/entity/cargo-wagon-freezer/cargo-wagon-door-vertical-mask.png"
cargo_wagon_freezer.horizontal_doors.layers[1].filename = "__freezer__/graphics/entity/cargo-wagon-freezer/cargo-wagon-door-horizontal.png"
cargo_wagon_freezer.horizontal_doors.layers[2].filename = "__freezer__/graphics/entity/cargo-wagon-freezer/cargo-wagon-door-horizontal-mask.png"
cargo_wagon_freezer.minimap_representation.filename = "__freezer__/graphics/icons/cargo-wagon-freezer-minimap-representation.png"
-- Add Equipment Grid
cargo_wagon_freezer.equipment_grid = "cargo-wagon-freezer-equipment-grid"
cargo_wagon_freezer.minable.result = "cargo-wagon-freezer"
data:extend({cargo_wagon_freezer})
-- Allow batteries and generators
for _, equipment in pairs(data.raw["battery-equipment"]) do
    table.insert(equipment.categories, "cargo-wagon-freezer")
end
for _, equipment in pairs(data.raw["generator-equipment"]) do
    table.insert(equipment.categories, "cargo-wagon-freezer")
end
for _, equipment in pairs(data.raw["solar-panel-equipment"]) do
    table.insert(equipment.categories, "cargo-wagon-freezer")
end


local default_planet_temp = 18
local planet_temps = {
    ["nauvis"] = 18,
    ["vulcanus"] = 60,
    ["gleba"] = 28,
    ["fulgora"] = 10,
    ["aquilo"] = -40,
}

for name, data in pairs(data.raw.planet) do
    if not data.surface_properties.temperature then
        data.surface_properties.temperature = planet_temps[name] or default_planet_temp
    end
end
