local awful = require("awful")
local gears = require("gears")
local theme = require("beautiful")
local wibox = require("wibox")

local LayoutList = function(s)
	local list = awful.widget.layoutlist({
		base_layout = {
			spacing = 5,
			layout = wibox.layout.fixed.horizontal,
		},
		widget_template = {
			{
				{
					id = "icon_role",
					forced_height = 10,
					forced_width = 10,
					widget = wibox.widget.imagebox,
				},
				margins = 5,
				widget = wibox.container.margin,
			},
			{
				id = "background_role",
				forced_width = 25,
				forced_height = 5,
				widget = wibox.container.background,
			},
			layout = wibox.layout.fixed.vertical,
			forced_width = 25,
			forced_height = 25,
		},
	})

	local width = #list.layouts * 30 + 5

	local popup = awful.popup({
		x = s.geometry.width - (s.geometry.width + width) / 2,
		y = 50,

		ontop = true,
		visible = false,
		type = "dock",
		bg = theme.popup.bg,

		widget = {
			list,
			forced_width = width,
			forced_height = 40,
			margins = 5,
			widget = wibox.container.margin,
		},
	})

	awful.keygrabber({
		start_callback = function()
			popup.visible = true
		end,
		stop_callback = function()
			popup.visible = false
		end,
		export_keybindings = true,
		stop_event = "release",
		stop_key = { "Escape", "Super_L", "Super_R" },
		keybindings = {
			{
				{ "Mod4" },
				" ",
				function()
					awful.layout.set((gears.table.cycle_value(list.layouts, list.current_layout, 1)))
				end,
			},
			{
				{ "Mod4", "Shift" },
				" ",
				function()
					awful.layout.set((gears.table.cycle_value(list.layouts, list.current_layout, -1)), nil)
				end,
			},
		},
	})

	return popup
end

return LayoutList
