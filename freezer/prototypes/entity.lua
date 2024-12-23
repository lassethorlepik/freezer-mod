
-- Remnants
data:extend({
  {
    type = "assembling-machine",
    name = "freezer",
    icon = "__freezer__/graphics/icons/freezer.png",
    icon_size = 256,
    surface_conditions = {
        {
            property = "temperature",
            max = 50,
        }
    },
    source_inventory_size = 1,
    result_inventory_size = 1,
    minable = {mining_time = 0.5, result = "freezer"},
    flags = {"placeable-player", "player-creation"},
    max_health = 200,
    dying_explosion = "medium-explosion",
    corpse = "medium-remnants",
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    graphics_set = {
      animation = {
          filename = "__freezer__/graphics/entity/freezer/freezer.png",
          width = 256,
          height = 256,
          scale = 0.42, --0.375
      },
    },
    module_slots = 4,
    allowed_effects = {"consumption", "speed", "pollution", "quality"},
    --fixed_recipe = "freeze-water",
    vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
    open_sound = {filename = "__base__/sound/machine-open.ogg", volume = 0.85},
    close_sound = {filename = "__base__/sound/machine-close.ogg", volume = 0.75},
    crafting_categories = {"freezer-category", "freezer-cryogenics-category"},
    crafting_speed = 1,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      drain = "50kW",
      emissions_per_minute = {pollution=1},
    },
    energy_usage = "0.45MW",
    fluid_boxes = {
      {
          production_type = "input",
          pipe_picture = assembler2pipepictures(),
          pipe_covers = pipecoverspictures(),
          base_area = 10,
          base_level = -1,
          pipe_connections = {{ flow_direction="input", position = {0, -1}, direction = 0 }},
          secondary_draw_orders = { north = -1 },
          volume = 100
      }
    },
    working_sound = {
      audible_distance_modifier = 0.6,
      fade_in_ticks = 4,
      fade_out_ticks = 20,
      sound = { filename = "__base__/sound/electric-furnace.ogg", volume = 0.3 },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 }
    }
  },
  {
    type = "electric-energy-interface",
    name = "spoilables-freezer",
    icon = "__freezer__/graphics/icons/spoilables-freezer.png",
    icon_size = 256,
    flags = {"placeable-player", "player-creation"},
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    minable = {mining_time = 0.5, result = "spoilables-freezer"},
    max_health = 200,
    corpse = "medium-remnants",
    dying_explosion = "medium-explosion",
    energy_source = {
        type = "electric",
        usage_priority = "secondary-input",
        buffer_capacity = "10MJ",
        input_flow_limit = "2MW",
        output_flow_limit = "0W",
        emissions_per_minute = {pollution=2},
    },
    energy_usage = "1MW",
    picture = {
      filename = "__freezer__/graphics/entity/spoilables-freezer/spoilables-freezer.png",
      width = 256,
      height = 256,
      scale = 0.375,
    },
    surface_conditions = {
      {
          property = "temperature",
          max = 50,
      }
    },
  },
  --[[
  {
    type = "fusion-reactor",
    name = "spoilables-freezer",
    icon = "__freezer__/graphics/icons/freezer.png",
    icon_size = 256,
    order = "999",
    surface_conditions = {
        {
            property = "temperature",
            max = 50,
        }
    },
    neighbour_bonus = 0,
    flags = {"placeable-player", "player-creation"},
    max_health = 200,
    minable = {mining_time = 0.5, result = "spoilables-freezer"},
    dying_explosion = "medium-explosion",
    corpse = "medium-remnants",
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    graphics_set = {
      plasma_category = "fusion-reactor-plasma",
      structure = {
        north = {
          filename = "__freezer__/graphics/entity/spoilables-freezer/spoilables-freezer.png",
          width = 256,
          height = 256,
          scale = 0.375,
        },
        east = {
          filename = "__freezer__/graphics/entity/spoilables-freezer/spoilables-freezer.png",
          width = 256,
          height = 256,
          scale = 0.375,
        },
        south = {
          filename = "__freezer__/graphics/entity/spoilables-freezer/spoilables-freezer.png",
          width = 256,
          height = 256,
          scale = 0.375,
        },
        west = {
          filename = "__freezer__/graphics/entity/spoilables-freezer/spoilables-freezer.png",
          width = 256,
          height = 256,
          scale = 0.375,
        }
      }
    },
    vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
    open_sound = {filename = "__base__/sound/machine-open.ogg", volume = 0.85},
    close_sound = {filename = "__base__/sound/machine-close.ogg", volume = 0.75},
    max_fluid_usage = 0.1 / 6,
    power_input = "200kW",
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      input_flow_limit = "500kW",
      output_flow_limit = "0W"
    },
    burner = {
      effectivity = 1000,
      emissions_per_minute = {
        pollution = 0
      },
      fuel_categories = {
        "coolant"
      },
      fuel_inventory_size = 1,
      light_flicker = {
        color = {
          1,
          0,
          0.7
        },
        maximum_intensity = 0.1,
        minimum_intensity = 0
      },
      type = "burner"
    },
    working_sound = {
      audible_distance_modifier = 0.6,
      fade_in_ticks = 4,
      fade_out_ticks = 20,
      sound = {
        {
          filename = "__base__/sound/chemical-plant-1.ogg",
          volume = 0.3
        },
        {
          filename = "__base__/sound/chemical-plant-2.ogg",
          volume = 0.3
        },
        {
          filename = "__base__/sound/chemical-plant-3.ogg",
          volume = 0.3
        }
      },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 }
    },
    input_fluid_box = {
        production_type = "input",
        filter = "fluoroketone-cold",
        pipe_picture = assembler2pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {
          {
            flow_direction="input",
            position = {0, 1},
            direction = 8,
          }
        },
        secondary_draw_orders = { north = -1 },
        volume = 100
    },
    output_fluid_box = {
      production_type = "output",
      filter = "fluoroketone-hot",
      pipe_picture = assembler2pipepictures(),
      pipe_covers = pipecoverspictures(),
      base_area = 10,
      base_level = -1,
      pipe_connections = {
        {
          flow_direction="output",
          position = {0, -1},
          direction = 0,
        }
      },
      secondary_draw_orders = { north = -1 },
      volume = 100
    }
  },
  ]]
})

local container = util.table.deepcopy(data.raw["container"]["steel-chest"])
container.name = "spoilables-freezer-container"
container.collision_box = {{-1.2, -1.2}, {1.2, 1.2}}
container.selection_box = {{-1.2, -1.2}, {1.2, 1.2}}
container.minable = nil
container.picture = nil
container.surface_conditions = nil
container.icon = "__freezer__/graphics/icons/spoilables-freezer-container.png"
container.inventory_size = 19
data:extend({container})