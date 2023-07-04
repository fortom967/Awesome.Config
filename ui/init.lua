local awful = require("awful")

local Clock = require("ui.popup.clock")

screen.connect_signal("request::desktop_decoration", function(s)
	s.padding = {
		top = 35,
		left = 0,
		right = 0,
		bottom = 0,
	}

	awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

	Clock(s)
end)
