local naughty = require("naughty")
local wibox = require("wibox")
local gears = require("gears")
local theme = require("beautiful")

naughty.config.padding = 8
naughty.config.spacing = 8
naughty.config.defaults.margin = 5
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
naughty.config.defaults.shape = function(cr, w, h)
	gears.shape.rounded_rect(cr, w, h, 4)
end
naughty.config.defaults.hover_timeout = nil
naughty.config.presets.ok.bg = theme.popup.bg
naughty.config.presets.critical.bg = theme.popup.bg
naughty.config.presets.info.bg = theme.popup.bg
naughty.config.presets.warn.bg = theme.popup.bg

-- local actions_template = wibox.widget({
-- 	notification = n,
-- 	base_layout = wibox.widget({
-- 		spacing = 0,
-- 		layout = wibox.layout.flex.horizontal,
-- 	}),
-- 	widget_template = {
-- 		{
-- 			{
-- 				{
-- 					{
-- 						id = "text_role",
-- 						font = "Roboto Regular 10",
-- 						widget = wibox.widget.textbox,
-- 					},
-- 					widget = wibox.container.place,
-- 				},
-- 				widget = wibox.container.margin,
-- 			},
-- 			bg = theme.groups_bg,
-- 			shape = gears.shape.rounded_rect,
-- 			forced_height = 30,
-- 			widget = wibox.container.background,
-- 		},
-- 		margins = 4,
-- 		widget = wibox.container.margin,
-- 	},
-- 	style = { underline_normal = false, underline_selected = true },
-- 	widget = naughty.actions,
-- })
