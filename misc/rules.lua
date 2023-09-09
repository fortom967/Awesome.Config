local awful = require("awful")
local ruled = require("ruled")

local modkey = "Mod4"

ruled.client.connect_signal("request::rules", function()
	ruled.client.append_rule({
		id = "global",
		rule = {},
		properties = {
			focus = awful.client.focus.filter,
			raise = true,
			screen = awful.screen.preferred,
			titlebars_enabled = false,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	})

	ruled.client.append_rule({
		id = "floating",
		rule_any = {
			instance = { "copyq", "pinentry" },
			class = {
				"osu!",
				"mgba",
			},

			name = {},
			role = {},
		},
		properties = { floating = true },
	})

	ruled.client.append_rule({
		id = "titlebars",
		rule_any = { type = { "normal", "dialog" } },
		properties = { titlebars_enabled = false },
	})

	ruled.client.append_rule({
		id = "maximized",
        tag = 3,
		rule_any = { class = { "figma-linux", "Google-chrome" } },
		properties = { maximized_vertical = true, maximized_horizontal = true },
	})
end)

ruled.notification.connect_signal("request::rules", function()
	ruled.notification.append_rule({
		rule = {},
		properties = {
			screen = awful.screen.preferred,
			implicit_timeout = 5,
		},
	})
end)

client.connect_signal("request::default_mousebindings", function()
	awful.mouse.append_client_mousebindings({
		awful.button({}, 1, function(c)
			c:activate({ context = "mouse_click" })
		end),
		awful.button({ modkey }, 1, function(c)
			c:activate({ context = "mouse_click", action = "mouse_move" })
		end),
		awful.button({ modkey, "Shift" }, 1, function(c)
			c:activate({ context = "mouse_click", action = "mouse_resize" })
		end),
	})
end)

client.connect_signal("request::default_keybindings", function()
	awful.keyboard.append_client_keybindings({
		awful.key({ modkey }, "f", function(c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end),
		awful.key({ modkey }, "c", function(c)
			c:kill()
		end),
		awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle),
		awful.key({ modkey, "Control" }, "Return", function(c)
			c:swap(awful.client.getmaster())
		end),
		awful.key({ modkey }, "o", function(c)
			c:move_to_screen()
		end),
		awful.key({ modkey }, "t", function(c)
			c.ontop = not c.ontop
		end),
		awful.key({ modkey }, "n", function(c)
			c.minimized = true
		end),
		awful.key({ modkey }, "m", function(c)
			c.maximized = not c.maximized
			c:raise()
		end),
		awful.key({ modkey, "Control" }, "m", function(c)
			c.maximized_vertical = not c.maximized_vertical
			c:raise()
		end),
		awful.key({ modkey, "Shift" }, "m", function(c)
			c.maximized_horizontal = not c.maximized_horizontal
			c:raise()
		end),
	})
end)
