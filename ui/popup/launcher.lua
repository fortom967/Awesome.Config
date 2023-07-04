local awful = require("awful")
local wibox = require("wibox")
local theme = require("beautiful")
local naughty = require("naughty")

local Launcher = function(s)
	local prompt = wibox.widget.textbox()
	local launcher

	local run = function()
		return awful.prompt.run({
			prompt = "#! ",
			textbox = prompt,

			done_callback = function()
				launcher.visible = false
			end,

			exe_callback = function(cmd)
				awful.spawn.easy_async_with_shell(cmd, function(stdout, stderr, reason, code)
					_ = code == 0
						or naughty.notification({
							message = "stdout:\n" .. stdout .. "\nstderr:\n" .. stderr .. "\n:reason\n" .. reason,
						})
				end)
			end,
		})
	end

	launcher = awful.popup({
		x = 1280 - (1280 / 2) - 150,
		y = 50,
        screen = s,

		bg = theme.popup.bg,

		ontop = true,
		visible = false,
		widget = {
			prompt,
			forced_width = 300,
			forced_height = 40,
			margins = 10,
			widget = wibox.container.margin,
		},
	})

	awesome.connect_signal("UI::Launcher", function()
		_ = not launcher.visible and run() or nil
		launcher.visible = true
	end)
end

return Launcher
