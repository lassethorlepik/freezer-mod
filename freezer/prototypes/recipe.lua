data:extend({
    {
        type = "recipe",
        name = "freezer",
        category = "crafting",
        enabled = false,
        energy_required = 5,
        order = "1",
        subgroup = "freezing-machines-subgroup",
        ingredients = {
            {
                type = "item",
                name = "iron-plate",
                amount = 20
            },
            {
                type = "item",
                name = "electronic-circuit",
                amount = 5
            },
            {
                type = "item",
                name = "pump",
                amount = 1
            },
            {
                type = "item",
                name = "pipe",
                amount = 4
            }
        },
        results = {
            {
                type = "item",
                name = "freezer",
                amount = 1
            }
        }
    },
    {
        type = "recipe",
        name = "freeze-water",
        category = "freezer-category",
        order = "1",
        subgroup = "ice-subgroup",
        enabled = false,
        energy_required = 30,
        ingredients = {
            {
                type = "fluid",
                name = "water",
                amount = 400
            }
        },
        results = {
            {
                type = "item",
                name = "ice",
                amount = 10
            }
        }
    },
    {
        type = "recipe",
        name = "spoilables-freezer",
        category = "crafting",
        enabled = false,
        energy_required = 5,
        order = "2",
        subgroup = "freezing-machines-subgroup",
        ingredients = {
            {
                type = "item",
                name = "iron-plate",
                amount = 20
            },
            {
                type = "item",
                name = "electronic-circuit",
                amount = 5
            },
            {
                type = "item",
                name = "pump",
                amount = 1
            },
            {
                type = "item",
                name = "pipe",
                amount = 4
            }
        },
        results = {
            {
                type = "item",
                name = "spoilables-freezer",
                amount = 1
            }
        }
    },
})