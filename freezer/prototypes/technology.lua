data:extend({
  {
    type = "technology",
    name = "freezing",
    icon = "__freezer__/graphics/technology/freezer.png",
    icon_size = 256,
    prerequisites = {"fluid-handling"},
    unit = {
      count = 100,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
      },
      time = 30
    },
    effects = {
      {
        type = "unlock-recipe",
        recipe = "freezer"
      },
      {
        type = "unlock-recipe",
        recipe = "freeze-water"
      }
    },
    order = "a"
  },
  {
    type = "technology",
    name = "spoilables-processing",
    icon = "__freezer__/graphics/technology/ice.png",
    icon_size = 600,
    prerequisites = {"freezing", "chemical-science-pack"},
    unit = {
      count = 250,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 30
    },
    effects = {

    },
    order = "a"
  },
  {
    type = "technology",
    name = "refrigeration",
    icon = "__freezer__/graphics/technology/spoilables-freezer.png",
    icon_size = 256,
    prerequisites = {"spoilables-processing", "cryogenic-science-pack"},
    unit = {
      count = 1000,
      ingredients = {
        {
          "automation-science-pack",
          1
        },
        {
          "logistic-science-pack",
          1
        },
        {
          "chemical-science-pack",
          1
        },
        {
          "production-science-pack",
          1
        },
        {
          "utility-science-pack",
          1
        },
        {
          "space-science-pack",
          1
        },
        {
          "cryogenic-science-pack",
          1
        }
      },
      time = 60
    },
    effects = {
      {
        type = "unlock-recipe",
        recipe = "spoilables-freezer"
      }
    },
    order = "a"
  },
  {
    type = "technology",
    name = "refrigeration-wagons",
    icon = "__freezer__/graphics/technology/refrigeration-wagons.png",
    icon_size = 256,
    prerequisites = {"refrigeration"},
    unit = {
      count = 5000,
      ingredients = {
        {
          "automation-science-pack",
          1
        },
        {
          "logistic-science-pack",
          1
        },
        {
          "chemical-science-pack",
          1
        },
        {
          "production-science-pack",
          1
        },
        {
          "utility-science-pack",
          1
        },
        {
          "space-science-pack",
          1
        },
        {
          "cryogenic-science-pack",
          1
        }
      },
      time = 60
    },
    effects = {
      {
        type = "unlock-recipe",
        recipe = "cargo-wagon-freezer"
      }
    },
    order = "a"
  }
})
