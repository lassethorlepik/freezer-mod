data:extend({
    {
        type = "double-setting",
        name = "frozen-spoil-time",
        setting_type = "startup",
        minimum_value = 1,
        default_value = 5.0,
        order = "a"
    },
    --[[
    {
        type = "double-setting",
        name = "ice-extra-weight",
        setting_type = "startup",
        minimum_value = 0,
        default_value = 10000,
        order = "b"
    }
    ]]
    {
        type = "bool-setting",
        name = "temp-limit",
        setting_type = "startup",
        default_value = true,
        order = "c"
    },
    {
        type = "string-setting",
        name = "do-not-freeze",
        setting_type = "startup",
        default_value = "",
        auto_trim = true,
        allow_blank = true,
        order = "d"
    }
})