local awful = require("awful")
local wibox = require("wibox")
local theme = require("beautiful")
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
				resize = true,
				vertical_fit_policy = "fit",
				horizontal_fit_policy = "fit",

				forced_width = s.geometry.width,
				forced_height = s.geometry.height,
				widget = wibox.widget.imagebox,
			},
			{
				bg = theme.popup.bg,
				forced_width = 400,
				forced_height = 300,
				widget = wibox.container.background,
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
