local awful = require("awful")
local wibox = require("wibox")
local theme = require("beautiful")
local gears = require("gears")
-- local naughty = require"naughty"

local Lockscreen = function(s)
	local popup = awful.popup({
		x = 0,
		y = 0,

		ontop = true,
		visible = false,
		type = "normal",

		widget = {
			{
				image = theme.lockscreen,
				vertical_fit_policy = "fit",
				horizontal_fit_polity = "fit",
				widget = wibox.widget.imagebox,

				forced_width = s.geometry.width,
				forced_height = s.geometry.height,
			},
			{
				{
					{
						forced_width = 75,
						forced_height = 75,
						image = theme.avatar,

						widget = wibox.widget.imagebox,
						clip_shape = gears.shape.circle,
					},
					forced_width = 500,
					forced_height = 350,
					bg = theme.popup.bg,
					widget = wibox.container.background,
					layout = wibox.layout.fixed.vertical,
				},
				widget = wibox.container.place,
			},

			layout = wibox.layout.stack,
		},
	})

	awesome.connect_signal("UI::Lockscreen", function()
		popup.visible = not popup.visible
	end)

	return popup
end

return Lockscreen
