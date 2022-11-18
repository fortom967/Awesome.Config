local awful = require("awful")
require("awful.autofocus")
local menubar = require("menubar")
require("awful.hotkeys_popup.keys")
local hotkeys_popup = require("awful.hotkeys_popup")

terminal = "alacritty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"

awful.keyboard.append_global_keybindings({
	awful.key({ modkey }, "w", function()
		mymainmenu:show()
	end),
	awful.key({ modkey, "Shift" }, "r", awesome.restart),
	awful.key({ modkey, "Shift" }, "q", awesome.quit),
	awful.key({ modkey }, "Return", function()
		awful.spawn(terminal)
	end),
	awful.key({ modkey }, "r", function()
		awesome.emit_signal("Rprompt")
	end),
	awful.key({ modkey }, "p", function()
		menubar.show()
	end),

	awful.key({ modkey }, "t", function()
		awesome.emit_signal("npanelT")
	end),

	awful.key({ modkey }, "Left", awful.tag.viewprev),
	awful.key({ modkey }, "Right", awful.tag.viewnext),
	awful.key({ modkey }, "Escape", awful.tag.history.restore),

	awful.key({ modkey }, "j", function()
		awful.client.focus.byidx(1)
	end),
	awful.key({ modkey }, "k", function()
		awful.client.focus.byidx(-1)
	end),
	awful.key({ modkey }, "Tab", function()
		awful.client.focus.byidx(1)
	end),
	awful.key({ modkey, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end),
	awful.key({ modkey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end),
	awful.key({ modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:activate({ raise = true, context = "key.unminimize" })
		end
	end),

	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end),
	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end),
	awful.key({ modkey }, "u", awful.client.urgent.jumpto),
	awful.key({ modkey }, "l", function()
		awful.tag.incmwfact(0.05)
	end),
	awful.key({ modkey }, "h", function()
		awful.tag.incmwfact(-0.05)
	end),
	awful.key({ modkey, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end),
	awful.key({ modkey, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end),
	awful.key({ modkey, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end),
	awful.key({ modkey, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end),
	-- awful.key({ modkey }, "space", function()
	-- 	awful.layout.inc(1)
	-- end),
	-- awful.key({ modkey, "Shift" }, "space", function()
	-- 	awful.layout.inc(-1)
	-- end),
})

awful.keyboard.append_global_keybindings({
	awful.key({
		modifiers = { modkey },
		keygroup = "numrow",
		description = "only view tag",
		group = "tag",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				tag:view_only()
			end
		end,
	}),
	awful.key({
		modifiers = { modkey, "Control" },
		keygroup = "numrow",
		description = "toggle tag",
		group = "tag",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end,
	}),
	awful.key({
		modifiers = { modkey, "Shift" },
		keygroup = "numrow",
		description = "move focused client to tag",
		group = "tag",
		on_press = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end,
	}),
	awful.key({
		modifiers = { modkey, "Control", "Shift" },
		keygroup = "numrow",
		description = "toggle focused client on tag",
		group = "tag",
		on_press = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end,
	}),
	awful.key({
		modifiers = { modkey },
		keygroup = "numpad",
		description = "select layout directly",
		group = "layout",
		on_press = function(index)
			local t = awful.screen.focused().selected_tag
			if t then
				t.layout = t.layouts[index] or t.layout
			end
		end,
	}),
})
