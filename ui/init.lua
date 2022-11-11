awful = require("awful")
gears = require("gears")
require("awful.autofocus")
wibox = require("wibox")
beautiful = require("beautiful")
hotkeys_popup = require("awful.hotkeys_popup")
naughty = require("naughty")
keygrabber = require("awful.keygrabber")
require("config")

require("ui.base")
require("ui.bar")
require("ui.panel")
require("ui.notifications")
require("ui.runprompt")
require("ui.calender")

awful.mouse.append_global_mousebindings({
	awful.button({}, 1, function()
		calender.visible = false
		npanel.visible = false
		runprompt.visible = false
		keygrabber.stop(p.grabber)
		keygrabber.stop(searchpr.grabber)
	end),
})
