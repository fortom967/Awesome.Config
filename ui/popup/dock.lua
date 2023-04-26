local A = require("awful")
local W = require("wibox")
local B = require("beautiful")
local S = require("gears").shape
local M = A.mouse
local N = require("naughty")

local dock = A.wibar({
	position = "bottom",
	width = 400,
	height = 40,
	bg = "#fff",
	ontop = true,
	restrict_workarea = false,
	shape = S.rounded_rect,
	visible = false,
	widget = W.container.place(W.widget.textbox("ustha")),
})

local M = {}

function M.setup()
	return dock
end

return M
