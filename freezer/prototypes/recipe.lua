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
        category = "freezer-cryogenics-category",
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
    {
        type = "recipe",
        name = "cargo-wagon-freezer",
        category = "crafting-with-fluid",
        enabled = false,
        energy_required = 5,
        order = "3",
        subgroup = "freezing-machines-subgroup",
        ingredients = {
            {
                type = "fluid",
                name = "fluoroketone-cold",
                amount = 50
            },
            {
                type = "item",
                name = "cargo-wagon",
                amount = 1
            },
            {
                type = "item",
                name = "pump",
                amount = 2
            },
            {
                type = "item",
                name = "iron-plate",
                amount = 20
            }
        },
        results = {
            {
                type = "item",
                name = "cargo-wagon-freezer",
                amount = 1
            }
        }
    },
})