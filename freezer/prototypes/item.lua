data:extend({
  {
    type = "item",
    name = "freezer",
    icon = "__freezer__/graphics/icons/freezer.png",
    icon_size = 256,
    subgroup = "freezing-machines-subgroup",
    order = "1",
    stack_size = 50,
    place_result = "freezer",
    weight = 40000,
  },
  {
    type = "item",
    name = "spoilables-freezer",
    icon = "__freezer__/graphics/icons/spoilables-freezer.png",
    icon_size = 256,
    subgroup = "freezing-machines-subgroup",
    order = "2",
    stack_size = 50,
    place_result = "spoilables-freezer",
    weight = 40000,
    place_as_equipment_result = "cargo-wagon-freezer-equipment"
  },
  {
    type = "item",
    name = "cargo-wagon-freezer",
    icon = "__freezer__/graphics/icons/cargo-wagon-freezer.png",
    icon_size = 64,
    subgroup = "freezing-machines-subgroup",
    order = "3",
    stack_size = 5,
    place_result = "cargo-wagon-freezer",
    weight = 200000,
  }
})
