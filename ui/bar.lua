local M = {
}

local W = require("wibox")
local B = require("beautiful")
local S = require("gears").shape

local bar = require("awful").wibar {
    x = 0,
    y = 0,
    width = 1260,
    height = 35,
    bg = B.bar_bg,
    margins = 10,
    shape = S.rounded_rect,
    widget = W.widget.textbox
}

function M.setup()
    return bar
end

return M
