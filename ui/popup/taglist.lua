local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local theme = require("beautiful")

local Taglist = function(s)
	local update_callback = function(self, tag, _, _)
		self.widget.bg = #tag:clients() > 0 and theme.accent or "#e0e0e0"
		self.widget.forced_width = tag.selected and 30 or 7
	end

	local taglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		layout = {
			spacing = 0,
			layout = wibox.layout.flex.horizontal,
		},
		widget_template = {
			{
				forced_width = 30,
				forced_height = 7,
				bg = theme.accent,
				shape = gears.shape.rounded_rect,
				widget = wibox.container.background,
			},
			widget = wibox.container.place,
			create_callback = update_callback,
			update_callback = update_callback,
		},
		buttons = {
			awful.button({}, 1, function(t)
				t:view_only()
			end),
			awful.button({ "Mod4" }, 1, function(t)
				if client.focus then
					client.focus:move_to_tag(t)
				end
			end),
			awful.button({}, 3, awful.tag.viewtoggle),
			awful.button({ "Mod4" }, 3, function(t)
				if client.focus then
					client.focus:toggle_tag(t)
				end
			end),
			awful.button({}, 4, function(t)
				awful.tag.viewprev(t.screen)
			end),
			awful.button({}, 5, function(t)
				awful.tag.viewnext(t.screen)
			end),
		},
	})

	return awful.popup({
		x = 10,
		y = 5,
		screen = s,

		bg = theme.popup.bg,

		widget = {
			taglist,
			margins = {
				left = 20,
				right = 20,
				top = 0,
				bottom = 0,
			},
			forced_width = 250,
			forced_height = 40,
			widget = wibox.container.margin,
		},
	})
end

return Taglist
