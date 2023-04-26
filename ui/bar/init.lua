local A = require("awful")
local W = require("wibox")
local B = require("beautiful")
local S = require("gears").shape

local wifi = require("ui.bar.wifi")
local taglist = require("ui.bar.taglist")
local clock = require("ui.bar.clock")

local bar = A.wibar({
    postion  = "top",
	width = 1260,
	height = 40,
	bg = B.barbg,
	margins = 4,
	shape = S.rounded_rect,
	widget = {
        taglist,
        clock,
        wifi.wifibutton,
        layout = W.layout.flex.horizontal,
        widget = W.container.place
    },
})

local M = {}

function M.setup()
	return bar
end

return M
