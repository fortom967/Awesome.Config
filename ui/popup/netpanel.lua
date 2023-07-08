local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
-- local naughty = require("naughty")
local theme = require("beautiful")

local panel = awful.popup({
	x = 280,
	y = 50,

	type = "dock",
	bg = theme.popup_bg,
	ontop = true,
	visible = true,

	widget = {
		{
			wibox.widget.textbox("useauthasuth"),
			margins = 10,
			forced_width = 400,
			forced_height = 355,
			widget = wibox.container.margin,
		},
		{
			{
				{
					{
						{
							{
								{
									image = theme.scan,
									forced_width = 15,
									forced_height = 15,
									valign = "center",
									widget = wibox.widget.imagebox,
								},
								{
									text = "Scan",
									halign = "center",
									widget = wibox.widget.textbox,
								},
								spacing = 5,
								layout = wibox.layout.fixed.horizontal,
							},
							margins = { left = 10, right = 10, top = 5, bottom = 5 },
							widget = wibox.container.margin,
						},
						bg = "#101010",
						forced_height = 30,
						widget = wibox.container.background,
						shape = function(cr, width, height)
							gears.shape.squircle(cr, width, height, 10, 0.08)
						end,
					},
					{
						{
							{
								{
									image = theme.connect,
									forced_width = 15,
									forced_height = 15,
									valign = "center",
									widget = wibox.widget.imagebox,
								},
								{
									text = "Connect",
									halign = "center",
									widget = wibox.widget.textbox,
								},
								spacing = 5,
								layout = wibox.layout.fixed.horizontal,
							},
							margins = { left = 10, right = 10, top = 5, bottom = 5 },
							widget = wibox.container.margin,
						},
						bg = "#101010",
						forced_height = 30,
						widget = wibox.container.background,
						shape = function(cr, width, height)
							gears.shape.squircle(cr, width, height, 10, 0.08)
						end,
					},
					{
						{
							{
								{
									image = theme.disconnect,
									forced_width = 15,
									forced_height = 15,
									valign = "center",
									widget = wibox.widget.imagebox,
								},
								{
									text = "Disconnect",
									halign = "center",
									widget = wibox.widget.textbox,
								},
								spacing = 5,
								layout = wibox.layout.fixed.horizontal,
							},
							margins = { left = 10, right = 10, top = 5, bottom = 5 },
							widget = wibox.container.margin,
						},
						bg = "#101010",
						forced_height = 30,
						widget = wibox.container.background,
						shape = function(cr, width, height)
							gears.shape.squircle(cr, width, height, 10, 0.08)
						end,
					},
					{
						{
							{
								image = theme.close,
								forced_width = 15,
								forced_height = 15,
								valign = "center",
								halign = "center",
								widget = wibox.widget.imagebox,
							},
							margins = 7.5,
							widget = wibox.container.margin,
						},
						bg = "#101010",
						forced_height = 30,
						forced_width = 30,
						widget = wibox.container.background,
						shape = function(cr, width, height)
							gears.shape.squircle(cr, width, height, 10, 0.08)
						end,
					},
					spacing = 20,
					layout = wibox.layout.fixed.horizontal,
				},
				margins = 10,
				widget = wibox.container.margin,
			},
			bg = "#000",
			forced_width = 400,
			forced_height = 45,
			widget = wibox.container.background,
		},
		layout = wibox.layout.fixed.vertical,
		forced_width = 400,
		forced_height = 400,
		widget = wibox.container.background,
	},
})

awesome.connect_signal("UI::Clear", function()
	panel.visible = false
end)

awesome.connect_signal("UI::NetPanel", function()
	panel.visible = not panel.visible
end)

local NetPanel = function()
	return panel
end

return NetPanel
