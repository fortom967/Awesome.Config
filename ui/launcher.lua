local A = require("awful")
local W = require("wibox")
local B = require("beautiful")

local promptpopup
local prompt = W.widget.textbox()

local function getCommand()
	A.prompt.run({
		prompt = "# ",
		text = "",
		bg_cursor = B.accent,
		textbox = prompt,
		done_callback = function()
			promptpopup.visible = false
		end,
		exe_callback = function(input)
			if input and #input > 0 then
				A.spawn.with_shell(input)
			end
		end,
	})
end

promptpopup = A.popup({
	widget = W.widget({
		prompt,
		margins = {
			left = 20,
			right = 20,
			top = 10,
			bottom = 10,
		},
		forced_width = 400,
		forced_height = 40,
		widget = W.container.margin,
	}),
    hide_on_right_click = true,
	placement = A.placement.centered,
	ontop = true,
	bg = B.barbg,
	visible = false,
})

local M = {}

function M.setup()
	A.keyboard.append_global_keybindings({
		A.key({ modkey }, "r", function()
			promptpopup.visible = true
			getCommand()
		end),
	})
	return promptpopup
end

return M
