local awful = require("awful")
local wibox = require("wibox")
local theme = require("beautiful")

local Wifi = function(_)
	local popup = awful.popup({
		x = 280,
		y = 5,

		type = "dock",
		bg = theme.popup_bg,

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
					buttons = {
						awful.button({}, 1, function()
                            awesome.emit_signal("UI::NetPanel")
						end),
					},
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

	-- local sel = 1
	-- local colors = {
	-- 	theme.accent,
	-- 	"#80aaff",
	-- 	"#0affae",
	-- 	"#fa6e70",
	-- }
	-- local stat = { upload = 0, download = 0 }
	-- gears.timer({
	-- 	timeout = 1,
	-- 	call_now = true,
	-- 	autostart = true,
	-- 	callback = function()
	-- 		local ns = utils.get_speed("wlan0")
	-- 		naughty.notification({ message = inspect(ns) })
	-- 	end,
	-- })

	return popup
end

return Wifi
