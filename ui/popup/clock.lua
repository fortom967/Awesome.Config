local awful = require("awful")
local wibox = require("wibox")
local theme = require("beautiful")
local gears = require("gears")

local Calender = function(s)
	local function fn(widget, flag, _)
		widget.halign = "center"

		local ret = wibox.widget({
			widget,
			shape = flag == "focus" and function(cr, width, height)
				gears.shape.squircle(cr, width, height, 8, 0.08)
			end or gears.shape.rectangle,
			fg = flag == "focus" and "#000" or theme.fg,
			bg = flag == "focus" and theme.accent or "#00000000",
			widget = wibox.container.background,
		})
		return ret
	end

	local cal = awful.popup({
		x = s.geometry.width - 320 - 10,
		y = 50,
		screen = s,
		ontop = true,
		visible = false,

		bg = theme.popup.bg,

		widget = {
			{
				fn_embed = fn,
				date = os.date("*t"),
				font = theme.font,
				flex_height = true,
				widget = wibox.widget.calendar.month,
			},
			forced_width = 320,
			forced_height = 250,

			margins = 10,
			widget = wibox.container.margin,
		},
	})

	awesome.connect_signal("UI::Calender", function()
		cal.visible = not cal.visible
	end)

	awesome.connect_signal("UI::Clear", function()
		cal.visible = false
	end)
end

local Clock = function(s)
	Calender(s)

	return awful.popup({
		x = s.geometry.width - 135 - 10,
		y = 5,
		screen = s,

		bg = theme.popup.bg,

		widget = {
			{
				{
					{
						{

							image = theme.clock,
							widget = wibox.widget.imagebox,
						},
						margins = 4,
						widget = wibox.container.margin,
					},
					forced_width = 20,
					forced_height = 20,
					bg = theme.accent,
					widget = wibox.container.background,

					buttons = {
						awful.button({}, 1, function()
							awesome.emit_signal("UI::Calender")
						end),
					},
				},
				{
					{
						format = "%I:%M:%S %p",
						refresh = 1,
						widget = wibox.widget.textclock,
					},
					widget = wibox.container.place,
				},

				spacing = 10,
				layout = wibox.layout.fixed.horizontal,
			},
			margins = 10,
			forced_width = 135,
			forced_height = 40,
			widget = wibox.container.margin,
		},
	})
end

return Clock
