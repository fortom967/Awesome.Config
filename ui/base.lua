function iconbox(img, width, height, marg)
	local mr = marg or { 0, 0, 0, 0 }
	local icon = margin(
		wibox.widget({
			image = img,
			resize = true,
			valign = "center",
			widget = wibox.widget.imagebox,
			forced_width = width,
			forced_height = height,
		}),
		mr[1],
		mr[2],
		mr[3],
		mr[4]
	)
	return icon
end

function slider(bg, wi, he, f)
	local sl = constraint({
		bar_shape = gears.shape.rounded_rect,
		-- bar_height = 3,
		handle_width = 10,
		bar_active_color = bg,
		bar_color = beautiful.barhi,
		handle_color = bg,
		handle_shape = gears.shape.rounded_rect,
		-- handle_border_color = beautiful.border_color,
		-- handle_border_width = 1,
		maximum = 100,
		minimum = 0,
		value = 25,
		widget = wibox.widget.slider,
	}, "max", wi, he)

	sl.widget:connect_signal("property::value", function(_, new)
		f(new)
	end)

	return sl
end

place = wibox.container.place
background = wibox.container.background
margin = wibox.container.margin
constraint = wibox.container.constraint

layout = wibox.layout
