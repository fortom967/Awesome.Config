local awful = require("awful")
local wibox = require("wibox")
local theme = require("beautiful")

theme.init(os.getenv("HOME") .. "/.config/awesome/theme/theme.lua")

local Clock = require("ui.popup.clock")
local Launcher = require("ui.popup.launcher")
local Taglist = require("ui.popup.taglist")
local Wifi = require("ui.popup.wifi")
local LayoutList = require("ui.popup.layoutlist")
local Lockscreen = require("ui.popup.lockscreen")
local NetPanel = require("ui.popup.netpanel")
require("ui.popup.notification")

root.buttons = {
	awful.button({}, 1, function()
		awesome.emit_signal("UI::Clear")
	end),
}

tag.connect_signal("request::default_layouts", function()
	awful.layout.append_default_layouts({
		awful.layout.suit.tile,
		awful.layout.suit.tile.bottom,
		awful.layout.suit.fair,
		awful.layout.suit.fair.horizontal,
		awful.layout.suit.floating,
	})
end)

screen.connect_signal("request::wallpaper", function(s)
	awful.wallpaper({
		screen = s,
		bg = "#00000000",
		widget = {
			image = theme.wallpaper,
			resize = true,
			vertical_fit_policy = "fit",
			horizontal_fit_policy = "fit",
			widget = wibox.widget.imagebox,
		},
	})
end)

screen.connect_signal("request::desktop_decoration", function(s)
	s.padding = {
		top = 40,
		left = 0,
		right = 0,
		bottom = 0,
	}

	awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

	Clock(s)
	Launcher(s)
	Taglist(s)
	Wifi(s)
	LayoutList(s)
	Lockscreen(s)
end)
