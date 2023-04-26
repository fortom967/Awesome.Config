local A = require("awful")
local W = require("wibox")
local B = require("beautiful")
local G = require("gears")
local S = G.shape

local function decorate_cell(widget, flag, date)
	local bg
	local fg = "#fff"
	if flag == "focus" then
		bg = B.accent
		fg = "#000"
	end

	widget.valign = "center"
	widget.halign = "center"

	local ret = W.widget({
		{
			widget,
			margins = 2,
			widget = W.container.margin,
		},
		fg = fg,
		bg = bg,
			shape = function(cr, w, h)
				S.rounded_rect(cr, w, h, 4)
			end,
		widget = W.container.background,
	})
	return ret
end

local calenderpopup = A.popup({
	widget = W.widget({
		{
			date = os.date("*t"),
			font = B.font,
			spacing = 7,
			week_numbers = false,
			start_sunday = false,
			fn_embed = decorate_cell,
			widget = W.widget.calendar.month,
		},
		margins = {
			left = 20,
			right = 20,
			top = 10,
			bottom = 10,
		},
		forced_width = 280,
		forced_height = 220,
		widget = W.container.margin,
	}),
	x = 500,
	y = 50,
	hide_on_right_click = true,
	ontop = true,
	bg = B.barbg,
	visible = false,
})

awesome.connect_signal("ui::calender", function()
	calenderpopup.visible = not calenderpopup.visible
end)

local M = {}

function M.setup()
	return calenderpopup
end

return M
