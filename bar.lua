awful = require("awful")
gears = require("gears")
require("awful.autofocus")
wibox = require("wibox")
beautiful = require("beautiful")
hotkeys_popup = require("awful.hotkeys_popup")
require("config")

local menu = wibox.container.place({
	{
		layout = wibox.layout.align.horizontal,
		wibox.container.margin({
			layout = wibox.layout.align.horizontal,
			wibox.widget({
				image = beautiful.menu,
				resize = true,
				valign = "center",
				widget = wibox.widget.imagebox,
				forced_width = 15,
				forced_height = 15,

				buttons = {
					awful.button({}, 1, nil, function()
						awful.spawn.with_shell("notify-send 'menu'")
					end),
				},
			}),
		}, 4, 4, 4, 4),
	},
	widget = wibox.container.background,
	shape = gears.shape.circle,
	bg = beautiful.barhi,
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
					layout = wibox.layout.fixed.horizontal,
				},
				widget = wibox.container.margin,
				top = 8,
				bottom = 8,
				left = 8,
				right = 8,
			},
			widget = wibox.container.place,

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

	return wibox.container.place({
		ta,
		widget = wibox.container.background,
		shape = gears.shape.rounded_rect,
		bg = beautiful.barhi,
	}, "center", "center")
end

local clock = wibox.container.place({
	{
		layout = wibox.layout.align.horizontal,
		wibox.container.margin({
			layout = wibox.layout.align.horizontal,
			wibox.widget({
				image = beautiful.clock,
				resize = true,
				valign = "center",
				widget = wibox.widget.imagebox,
				forced_width = 13,
				forced_height = 13,
			}),
			wibox.widget({
				format = "  %I:%M:%S %p",
				refresh = 1,
				widget = wibox.widget.textclock,
				fg = beautiful.barfg,
			}),
		}, 15, 15, 3, 3),
	},
	widget = wibox.container.background,
	shape = gears.shape.rounded_rect,
	bg = beautiful.barhi,
}, "center", "center")

net = wibox.widget({
	text = " " .. "Disconnected",
	widget = wibox.widget.textbox,
	fg = beautiful.barfg,
})

neticon = wibox.widget({
	image = beautiful.disconnected,
	resize = true,
	valign = "center",
	widget = wibox.widget.imagebox,
	forced_width = 13,
	forced_height = 13,
})

local wifi = wibox.container.place({
	{
		layout = wibox.layout.align.horizontal,
		wibox.container.margin({
			layout = wibox.layout.align.horizontal,
			neticon,
			net,
		}, 15, 15, 3, 3),
	},
	widget = wibox.container.background,
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

local notifications = wibox.container.place({
	{
		layout = wibox.layout.align.horizontal,
		wibox.container.margin({
			layout = wibox.layout.align.horizontal,
			wibox.widget({
				image = beautiful.notifications,
				resize = true,
				valign = "center",
				widget = wibox.widget.imagebox,
				forced_width = 8,
				forced_height = 8,

				buttons = {
					awful.button({}, 1, nil, function()
						awesome.emit_signal("npanelT")
					end),
				},
			}),
		}, 8, 8, 8, 8),
	},
	widget = wibox.container.background,
	shape = gears.shape.circle,
	bg = beautiful.barhi,
}, "center", "center")

screen.connect_signal("request::desktop_decoration", function(s)
	s.padding = { left = 0, right = 0, top = 35, bottom = 0 }

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

		widget = wibox.container.margin({
			layout = wibox.layout.align.horizontal,
			expand = "none",
			menu,
			taglist(s),
			{
				layout = wibox.layout.fixed.horizontal,
				spacing = 10,
				wifi,
				clock,
				notifications,
			},
		}, 20, 20, 0, 0),
	})
end)
