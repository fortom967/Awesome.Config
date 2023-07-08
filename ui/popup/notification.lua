local naughty = require("naughty")
-- local wibox = require("wibox")
local gears = require("gears")
local theme = require("beautiful")

naughty.connect_signal("request::display_error", function(message, startup)
	naughty.notification({
		urgency = "critical",
		title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
		message = message,
	})
end)

naughty.config.padding = 10
naughty.config.spacing = 10
naughty.config.defaults.margin = 10
naughty.config.defaults.ontop = true
naughty.config.defaults.timeout = 5
naughty.config.defaults.position = "top_right"
naughty.config.defaults.font = theme.font
naughty.config.defaults.icon = nil
naughty.config.defaults.icon_size = 64
naughty.config.defaults.border_width = 0
naughty.config.icon_dirs = {
	"/usr/share/icons/Papirus/",
}
naughty.config.defaults.shape = gears.shape.rectangle
-- naughty.config.defaults.hover_timeout = nil
-- naughty.config.presets.ok.bg = theme.popup_bg
-- naughty.config.presets.critical.bg = theme.popup_bg
-- naughty.config.presets.info.bg = theme.popup_bg
-- naughty.config.presets.warn.bg = theme.popup_bg
