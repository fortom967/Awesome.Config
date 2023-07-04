local awful = require("awful")
local wibox = require("wibox")
local theme = require("beautiful")

local Clock = function(s)
	return awful.popup({
		x = 1280 - 150 - 10,
		y = 6,

		bg = theme.popup.bg,

		widget = {
			{
				{
					bg = theme.accent,
					forced_width = 20,
					forced_height = 20,
					widget = wibox.container.background,
				},
				{
					format = "%I:%M:%S %p",
					refresh = 1,
					widget = wibox.widget.textclock,
				},

				spacing = 10,
				layout = wibox.layout.fixed.horizontal,
			},
			margins = 8,
			forced_width = 140,
			forced_height = 35,
			widget = wibox.container.margin,
		},
	})
end

return Clock
