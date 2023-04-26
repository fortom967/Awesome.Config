local A = require("awful")
local W = require("wibox")
local B = require("beautiful")
local S = require("gears").shape

local M = {}

function M.bgWithMargin(widget, margin, bg)
    return W.widget{
        {
            widget,
            margin = margin,
            widget = W.container.margin
        },
        bg = bg,
        widget = W.container.background
    }
end

return M
