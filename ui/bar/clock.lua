local A = require("awful")
local W = require("wibox")
local B = require("beautiful")
local S = require("gears").shape

local clock = W.widget({
	{
		{
			{
				format = "%I:%M:%S %p",
				refresh = 1,
                forced_height = 25,
				widget = W.widget.textclock,
			},
			margins = {
				left = 10,
				right = 10,
				top = 0,
				bottom = 0,
			},
			widget = W.container.margin,
		},
		bg = B.barhi,
		shape = function(cr, w, h)
			S.rounded_rect(cr, w, h, 4)
		end,
		widget = W.container.background,
	},
	widget = W.container.place,
})

return clock
