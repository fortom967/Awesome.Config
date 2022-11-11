naughty.connect_signal("request::display", function(n)
	naughty.layout.box({
		shape = gears.shape.rounded_rect,
		y = 100,
		bg = beautiful.barbg,
		notification = n,
		-- widget_template = wibox.container.margin({
		-- 	layout = wibox.layout.align.horizontal,
		-- 	expand = "none",
		-- }, 20, 20, 0, 0),
	})
end)

naughty.config.defaults.position = "top_left"
