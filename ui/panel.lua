searchpr = awful.widget.prompt({
	prompt = "Search Google ",
	bg_cursor = beautiful.accent,
	exe_callback = function(c)
		awful.spawn.with_shell("xdg-open 'https://www.google.com/search?q=" .. c .. "'")
		keygrabber.stop(searchpr.grabber)
	end,
	done_callback = function()
		awesome.emit_signal("npanelT")
		keygrabber.stop(searchpr.grabber)
	end,
})

searchpr:run()
keygrabber.stop(searchpr.grabber)

local search = background(
	margin({
		layout = layout.align.horizontal,
		margin(iconbox(beautiful.search, 15, 15), 15, 15, 0, 0),
		searchpr,
	}, 10, 10, 10, 10),
	beautiful.barhi,
	gears.shape.rounded_rect
)

search:connect_signal("button::press", function()
	searchpr:run()
end)

volume = slider("#FF6060", nil, 10, function(n)
	awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ " .. n .. "%")
end)

brightness = slider("#5CC4FF", nil, 10, function(n)
	awful.spawn.with_shell("brightnessctl s " .. n .. "%")
end)

battery = slider("#69EF86", nil, 10, nil)

fs = constraint({
	paddings = 9,
	color = "#69EF86",
	border_color = beautiful.barhi,
	border_width = 6,
	value = 1,
	max_value = 10,
	widget = wibox.container.radialprogressbar,
}, "exact", 40, 40)

cpu = constraint({
	fs,
	paddings = 9,
	color = "#EB4F87",
	border_color = beautiful.barhi,
	border_width = 6,
	value = 1,
	max_value = 100,
	widget = wibox.container.radialprogressbar,
}, "exact", 70, 70)

ram = wibox.widget({
	cpu,
	paddings = 9,
	color = "#5CC4FF",
	border_color = beautiful.barhi,
	border_width = 6,
	value = 1,
	max_value = 3043632,
	widget = wibox.container.radialprogressbar,
})

progress = constraint(ram, "exact", 125, 125)

gears.timer({
	timeout = 1,
	call_now = true,
	autostart = true,
	callback = function()
		awful.spawn.easy_async_with_shell("mpstat | awk 'FNR == 4 {print $3}'", function(a)
			cpu.widget.value = tonumber(a)
		end)

		awful.spawn.easy_async_with_shell("df -BM | grep sda | awk '{print $2" .. '" "' .. "$3}'", function(b)
			local words = {}

			for word in b:gmatch("[0-9]+") do
				table.insert(words, word)
			end

			fs.widget.max_value = tonumber(words[1])
			fs.widget.value = tonumber(words[2])
		end)

		awful.spawn.easy_async_with_shell("free | awk 'FNR == 2 {print $3}'", function(r)
			ram.value = tonumber(r)
		end)

		awful.spawn.easy_async_with_shell("acpi -b | awk '{print $3$4}'", function(out)
			if string.find(out, "Charging") then
				battery.update = not battery.update or false
				if battery.update then
					battery.widget.bar_active_color = "#69EF86"
					battery.widget.handle_color = "#69EF86"
				else
					battery.widget.bar_active_color = "#69BE86"
					battery.widget.handle_color = "#69BE86"
				end
			end
			battery.widget.value = tonumber(string.sub(out, string.find(out, "[0-9]+")))
		end)

		-- awful.spawn.easy_async_with_shell("pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}'", function(out)
		-- 	volume.widget.value = tonumber(string.sub(out, string.find(out, "[0-9]+")))
		-- end)

		awful.spawn.easy_async_with_shell("brightnessctl i | grep Current | awk '{print $4}'", function(bright)
			brightness.widget.value = tonumber(string.sub(bright, string.find(bright, "[0-9]+")))
		end)
	end,
})

sliders = constraint({
	layout = layout.align.vertical,
	margin({
		layout = layout.align.horizontal,
		iconbox(beautiful.volume, 15, 15, { 10, 10, 0, 0 }),
		place(volume),
	}, 10, 10, 10, 10),
	margin({
		layout = layout.align.horizontal,
		iconbox(beautiful.brightness, 15, 15, { 10, 10, 0, 0 }),
		place(brightness),
	}, 10, 10, 10, 10),
	margin({
		layout = layout.align.horizontal,
		iconbox(beautiful.battery, 15, 15, { 10, 10, 0, 0 }),
		place(battery),
	}, 10, 10, 10, 10),
}, "max", 200, 200)

npanel = awful.popup({
	screen = s,
	shape = gears.shape.rounded_rect,
	ontop = true,

	x = screenWidth - barpos - 500,
	y = 60,

	bg = beautiful.barbg,
	fg = beautiful.barfg,

	minimum_height = 500,
	minimum_width = 500,
	maximum_height = 500,
	maximum_width = 500,
	visible = false,
	widget = margin({
		layout = layout.align.vertical,
		search,
		{
			layout = layout.align.horizontal,
			place(sliders),
			place(progress),
		},
	}, 20, 20, 20, 20),
})

awesome.connect_signal("npanelT", function()
	searchpr:run()
	keygrabber.stop(searchpr.grabber)
	npanel.visible = not npanel.visible
end)
