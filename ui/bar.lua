local menu = place({
	{
		layout = layout.align.horizontal,
		margin({
			layout = layout.align.horizontal,
			iconbox(beautiful.menu, 15, 15),
		}, 4, 4, 4, 4),
	},
	widget = background,
	shape = gears.shape.circle,
	bg = beautiful.barhi,
	buttons = {
		awful.button({}, 1, nil, function()
			awful.spawn.with_shell("notify-send 'menu'")
		end),
	},
}, "center", "center")

function taglist(s)
	local ta = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		widget_template = {
			{
				{

					{
						widget = wibox.widget.background,
						id = "tag",
						forced_width = 6,
						forced_height = 6,
						bg = beautiful.barfg,
						shape = gears.shape.circle,
					},
					layout = layout.fixed.horizontal,
				},
				widget = margin,
				margins = 8,
			},
			widget = place,

			create_callback = function(self, c3, index, objects) --luacheck: no unused args
				local t = self:get_children_by_id("tag")[1]
				if c3.selected then
					t.bg = beautiful.accent
					t.shape = gears.shape.rounded_rect
					t.forced_width = 20
				elseif #c3:clients() ~= 0 then
					t.bg = beautiful.accent
					t.shape = gears.shape.circle
					t.forced_width = 6
				else
					t.bg = beautiful.barfg
					t.shape = gears.shape.circle
					t.forced_width = 6
				end
			end,
			update_callback = function(self, c3, index, objects) --luacheck: no unused args
				local t = self:get_children_by_id("tag")[1]
				if c3.selected then
					t.bg = beautiful.accent
					t.shape = gears.shape.rounded_rect
					t.forced_width = 20
				elseif #c3:clients() ~= 0 then
					t.bg = beautiful.accent
					t.shape = gears.shape.circle
					t.forced_width = 6
				else
					t.bg = beautiful.barfg
					t.shape = gears.shape.circle
					t.forced_width = 6
				end
			end,
		},
		buttons = {

			awful.button({}, 1, function(t)
				t:view_only()
			end),
			awful.button({ modkey }, 1, function(t)
				if client.focus then
					client.focus:move_to_tag(t)
				end
			end),
			awful.button({}, 3, awful.tag.viewtoggle),
			awful.button({ modkey }, 3, function(t)
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

	return place({
		ta,
		widget = background,
		shape = gears.shape.rounded_rect,
		bg = beautiful.barhi,
	}, "center", "center")
end

local clock = place({
	{
		layout = layout.align.horizontal,
		margin({
			layout = layout.align.horizontal,
			iconbox(beautiful.clock, 13, 13),
			wibox.widget({
				format = "  %I %M %S %p",
				refresh = 1,
				widget = wibox.widget.textclock,
				fg = beautiful.barfg,
			}),
		}, 15, 15, 3, 3),
	},
	buttons = {
		awful.button({}, 1, nil, function()
			awesome.emit_signal("calender")
		end),
	},

	widget = background,
	shape = gears.shape.rounded_rect,
	bg = beautiful.barhi,
}, "center", "center")

net = wibox.widget({
	text = " " .. "Disconnected",
	widget = wibox.widget.textbox,
	fg = beautiful.barfg,
})

neticon = iconbox(beautiful.disconnected, 13, 13)

local wifi = place({
	{
		layout = layout.align.horizontal,
		margin({
			layout = layout.align.horizontal,
			neticon,
			net,
		}, 15, 15, 3, 3),
	},
	widget = background,
	shape = gears.shape.rounded_rect,
	bg = beautiful.barhi,

	buttons = {
		awful.button({}, 1, nil, function()
			awful.spawn.with_shell("iwctl station wlan0 scan")
		end),

		awful.button({}, 3, nil, function()
			awful.spawn.with_shell("iwgtk")
		end),
	},
}, "center", "center")

gears.timer({
	timeout = 1,
	call_now = true,
	autostart = true,
	callback = function()
		awful.spawn.easy_async_with_shell("iwctl station wlan0 show | grep network", function(out)
			if out == "" then
				neticon.image = beautiful.disconnected
				net.text = " Disconnected"
			else
				neticon.image = beautiful.connected
				net.text = " " .. string.gsub(string.sub(out, 35), "[ \t]+%f[\r\n%z]", "")
			end
		end)
	end,
})

local notifications = place({
	{
		layout = layout.align.horizontal,
		margin({
			layout = layout.align.horizontal,
			iconbox(beautiful.notifications, 8, 8),
		}, 8, 8, 8, 8),
	},
	buttons = {
		awful.button({}, 1, nil, function()
			awesome.emit_signal("npanelT")
		end),
	},
	widget = background,
	shape = gears.shape.circle,
	bg = beautiful.barhi,
}, "center", "center")

screen.connect_signal("request::desktop_decoration", function(s)
	s.padding = { left = 0, right = 0, top = 50, bottom = 0 }

	awful.tag({ "", "", "", "", "", "", "", "", "" }, s, awful.layout.layouts[1])

	awful.popup({
		screen = s,
		type = "dock",
		shape = gears.shape.rounded_rect,

		ontop = true,
		x = barpos,
		y = 10,

		bg = beautiful.barbg,
		fg = beautiful.barfg,

		minimum_height = 38,
		minimum_width = barWidth,
		maximum_height = 38,
		maximum_width = barWidth,

		widget = margin({
			layout = layout.align.horizontal,
			expand = "none",
			menu,
			taglist(s),
			{
				layout = layout.fixed.horizontal,
				spacing = 10,
				wifi,
				clock,
				notifications,
			},
		}, 20, 20, 0, 0),
	})
end)
