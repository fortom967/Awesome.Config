local function highlight(widget, flag, date)
	local color = beautiful.barbg
	if flag == "focus" then
		color = beautiful.accent
	end
	widget.halign = "center"
	local ret = {
		{
			widget,
			fg = beautiful.barfg,
			bg = color,
			widget = background,
			shape = gears.shape.rounded_rect,
		},
		widget = constraint,
		strategy = "min",
		width = 28,
		height = 28,
	}
	return ret
end

calender = awful.popup({
	screen = s,
	shape = gears.shape.rounded_rect,
	ontop = true,

	x = (screenWidth - 300),
	y = 60,

	bg = beautiful.barbg,
	fg = beautiful.barfg,

	minimum_height = 200,
	minimum_width = 280,
	maximum_height = 200,
	maximum_width = 280,
	visible = false,

	widget = margin({
		layout = layout.align.horizontal,
		halign = "center",
		wibox.widget({
			date = os.date("*t"),
			font = beautiful.font,
			flex_height = true,
			start_sunday = true,
			fn_embed = highlight,
			widget = wibox.widget.calendar.month,
		}),
	}, 20, 20, 20, 20),
})

awesome.connect_signal("calender", function()
	calender.visible = not calender.visible
end)
