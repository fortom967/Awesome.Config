local A = require("awful")
local W = require("wibox")
local B = require("beautiful")
local S = require("gears").shape

local M = {}

function M.bgWithMargin(table)
    return W.widget{
        {
            table.widget,
            margin = table.margin,
            widget = W.container.margin
        },
        bg = table.bg,
        widget = W.container.background
    }
end

return M
