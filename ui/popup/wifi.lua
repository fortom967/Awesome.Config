local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")
local theme = require("beautiful")

local Wifi = function(_)
	-- local sel = 1
	-- local colors = {
	-- 	theme.accent,
	-- 	"#80aaff",
	-- 	"#0affae",
	-- 	"#fa6e70",
	-- }

	local popup = awful.popup({
		x = 280,
		y = 5,

		bg = theme.popup.bg,

		widget = wibox.widget({
			{
				{
					{
						{

							image = theme.connected,
							widget = wibox.widget.imagebox,
						},
						margins = 4,
						widget = wibox.container.margin,
					},
					forced_width = 20,
					forced_height = 20,
					bg = theme.accent,
					id = "sigstrength",
					widget = wibox.container.background,
				},

				{
					{
						text = "TomLance",
						widget = wibox.widget.textbox,
					},
					widget = wibox.container.background,
				},

                spacing = 10,
				layout = wibox.layout.fixed.horizontal,
			},
			forced_width = 150,
			forced_height = 40,
			margins = 10,
			widget = wibox.container.margin,
		}),
	})

	-- gears.timer({
	-- 	timeout = 0.5,
	-- 	call_now = true,
	-- 	autostart = true,
	-- 	callback = function()
	-- 		local sigstrength = popup.widget:get_children_by_id("sigstrength")[1]
	-- 		sigstrength.bg = colors[sel % 4 + 1]
	-- 		sel = sel + 1
	-- 	end,
	-- })

	return popup
end

return Wifi
