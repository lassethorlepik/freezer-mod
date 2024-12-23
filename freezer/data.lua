require("prototypes.item")
require("prototypes.recipe")
require("prototypes.entity")
require("prototypes.technology")

data:extend({
    {
        type = "recipe-category",
        name = "freezer-category"
    },
    {
        type = "recipe-category",
        name = "freezer-cryogenics-category"
    },
    {
        type = "surface-property",
        name = "temperature",
        default_value = -270,
    },
    {
        type = "item-group",
        name = "freezing-group",
        order = "zzz",
        icon = "__freezer__/graphics/icons/freeze-tab.png",
        icon_size = 128
    },
    {
        type = "item-subgroup",
        name = "freezing-machines-subgroup",
        group = "freezing-group",
        order = "1"
    },
    {
        type = "item-subgroup",
        name = "ice-subgroup",
        group = "freezing-group",
        order = "2"
    },
    {
        type = "item-subgroup",
        name = "freezing-subgroup",
        group = "freezing-group",
        order = "3"
    },
    {
        type = "item-subgroup",
        name = "unfreezing-subgroup",
        group = "freezing-group",
        order = "4"
    },
    {
        type = "equipment-category",
        name = "cargo-wagon-freezer"
    },
    {
        type = "equipment-grid",
        name = "cargo-wagon-freezer-equipment-grid",
        width = 6,
        height = 4,
        equipment_categories = {"cargo-wagon-freezer"}
    },
    {
        type = "belt-immunity-equipment",
        name = "cargo-wagon-freezer-equipment",
        equipment_categories = {"cargo-wagon-freezer"},
        energy_consumption = "2MW",
        energy_source = {
            type = "electric",
            buffer_capacity = "10MJ",
            usage_priority = "primary-input",
            input_flow_limit = "3MW",
            output_flow_limit = "0W",
        },
        shape = {
            width = 2,
            height = 2,
            type = "full"
        },
        hidden_in_factoriopedia = true,
        sprite = {
            filename = "__freezer__/graphics/icons/spoilables-freezer.png",
            size = 256
        },
        categories = {"cargo-wagon-freezer"},
        take_result = "spoilables-freezer"
    }
})

data.raw.planet.nauvis.surface_properties.temperature = 18
data.raw.planet.vulcanus.surface_properties.temperature = 60
data.raw.planet.gleba.surface_properties.temperature = 28
data.raw.planet.fulgora.surface_properties.temperature = 10
data.raw.planet.aquilo.surface_properties.temperature = -40
