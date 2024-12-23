local frozen_multipler = settings.startup["frozen-spoil-time"].value
--local frozen_weight_bonus = settings.startup["ice-extra-weight"].value
local frozen_items = {}

for _, category in pairs(data.raw) do
    for _, item in pairs(category) do
        if item.spoil_ticks then

        -- Create a deep copy of the original item
        local frozen_item = table.deepcopy(item)

        frozen_item.name = "MOD-FROZEN-" .. item.name

        -- Frozen item spoil time
        frozen_item.spoil_ticks = math.min(item.spoil_ticks * frozen_multipler, 4294967295)
        local original_icons = frozen_item.icons or {}

        -- Ice icon
        frozen_item.icons = {
            {
                icon = "__freezer__/graphics/icons/ice.png",
                icon_size = 64,
                scale = 0.5
            }
        }
        for _, icon in pairs(original_icons) do
            table.insert(frozen_item.icons, icon)
        end
        if frozen_item.icon then
            local original_icon = {
                icon = frozen_item.icon,
                scale = 0.4
            }
            table.insert(frozen_item.icons, original_icon)
        end
        table.insert(frozen_item.icons,  {
            icon = "__freezer__/graphics/icons/ice-translucent.png",
            icon_size = 64,
            scale = 0.5
        })
        frozen_item.icon = nil

        -- New display name
        local original_name = frozen_item.localised_name or {'item-name.' .. item.name}
        frozen_item.localised_name = {"custom.frozen-item", original_name}

        frozen_item.spoil_result = item.spoil_result
        frozen_item.fuel_category = nil
        frozen_item.fuel_value = nil
        frozen_item.place_result = nil
        frozen_item.hidden_in_factoriopedia = true

        frozen_item.subgroup = "freezing-subgroup"

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
        icon_size = 64,
        scale = 0.5
    })
    local unlock = {
        type = "unlock-recipe",
        recipe = recipe.name
    }
    data:extend({recipe})
    table.insert(data.raw.technology["spoilables-processing"].effects, unlock)
end

table.insert(data.raw["assembling-machine"]["cryogenic-plant"].crafting_categories, "freezer-cryogenics-category")
