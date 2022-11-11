p = awful.widget.prompt({
	prompt = "",
	bg_cursor = beautiful.accent,
	done_callback = function()
		awesome.emit_signal("Rprompt")
		keygrabber.stop(p.grabber)
	end,
})

runprompt = awful.popup({
	screen = s,
	shape = gears.shape.rounded_rect,
	ontop = true,

	x = (screenWidth - 400) / 2,
	y = 60,

	bg = beautiful.barbg,
	fg = beautiful.barfg,

	minimum_height = 40,
	minimum_width = 400,
	maximum_height = 40,
	maximum_width = 400,
	visible = false,

	widget = margin({
		layout = layout.align.horizontal,
		expand = "none",
		p,
	}, 20, 20, 0, 0),
})

awesome.connect_signal("Rprompt", function()
	runprompt.visible = not runprompt.visible
	p:run()
end)
