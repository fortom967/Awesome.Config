awful = require("awful")
gears = require("gears")
require("awful.autofocus")
wibox = require("wibox")
beautiful = require("beautiful")
hotkeys_popup = require("awful.hotkeys_popup")
require("config")

npanel = awful.popup({
	screen = s,
	shape = gears.shape.rounded_rect,
	ontop = true,

	x = screenWidth - barpos - 400,
	y = 60,

	bg = beautiful.barbg,
	fg = beautiful.barfg,

	minimum_height = 400,
	minimum_width = 400,
	maximum_height = 400,
	maximum_width = 400,
	visible = false,

	widget = wibox.container.margin({
		layout = wibox.layout.align.horizontal,
		expand = "none",
		widget = wibox.widget.textbox,
		text = "Hntuha",
	}, 20, 20, 0, 0),
})

awesome.connect_signal("npanelT", function()
	npanel.visible = not npanel.visible
end)
