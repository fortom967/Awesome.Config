local A = require("awful")
local G = require("gears")
local W = require("wibox")
local B = require("beautiful")

local ll = A.widget.layoutlist({
	base_layout = W.widget({
		spacing = 5,
		forced_num_cols = 5,
		layout = W.layout.grid.vertical,
	}),
	widget_template = {
		{
			{
				id = "icon_role",
				forced_height = 28,
				forced_width = 28,
				widget = W.widget.imagebox,
			},
			margins = 4,
			widget = W.container.margin,
		},
		id = "background_role",
		forced_width = 30,
		forced_height = 30,
		shape = G.shape.rounded_rect,
		widget = W.container.background,
	},
})

local layout_popup = A.popup({
	widget = W.widget({
		ll,
		margins = 4,
		widget = W.container.margin,
	}),
	border_color = B.border_color,
	border_width = B.border_width,
	placement = A.placement.centered,
    ontop = true,
	visible = false,
})

A.keygrabber({
	start_callback = function()
		layout_popup.visible = true
	end,
	stop_callback = function()
		layout_popup.visible = false
	end,
	export_keybindings = true,
	stop_event = "release",
	stop_key = { "Escape", "Super_L", "Super_R" },
	keybindings = {
		{
			{ modkey },
			" ",
			function()
				A.layout.set((G.table.cycle_value(ll.layouts, ll.current_layout, 1)))
			end,
		},
		{
			{ modkey, "Shift" },
			" ",
			function()
				A.layout.set((G.table.cycle_value(ll.layouts, ll.current_layout, -1)), nil)
			end,
		},
	},
})

local M = {}

function M.setup()
	return ll
end

return M
