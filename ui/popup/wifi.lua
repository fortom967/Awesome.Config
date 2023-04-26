local A = require("awful")
local W = require("wibox")
local B = require("beautiful")
local G = require("gears")
local S = G.shape
local N = require("naughty")

local function hover(self, _, _, _)
	self:connect_signal("mouse::enter", function()
		self.bg = "#fff"
	end)
end

local wifipopup
local wifiactions
local wifi

local networks = {
	layout = W.layout.fixed.vertical,
	spacing = 20,
}

local function newNetwork(str)
	local n = W.widget({
		{

			{
				{
					text = str,
					halign = "center",
					valign = "center",
					widget = W.widget.textbox,
				},
				width = 360,
				height = 50,
				strategy = "min",
				widget = W.container.constraint,
			},
			bg = "#444",
			shape = function(cr, w, h)
				S.rounded_rect(cr, w, h, 4)
			end,
			widget = W.container.background,
		},
		id = str,
		widget = W.container.place,
		buttons = {
			A.button({}, 1, nil, function()
				N.notification({ message = str })
				local m = wifi:get_children_by_id(str)[1]
				m.widget.widget.bg = "#fff"
			end),
		},
	})
	return n
end

wifiactions = W.widget({
	{
		{
			{

				text = "✖",
				halign = "center",
				valign = "center",
				widget = W.widget.textbox,
			},
			forced_width = 35,
			forced_height = 30,
			fg = "#fe8a90",
			bg = B.barhi,
			shape = function(cr, w, h)
				S.rounded_rect(cr, w, h, 4)
			end,
			widget = W.container.background,
			buttons = {
				A.button({}, 1, nil, function()
					wifipopup.visible = false
				end),
			},
		},
		{
			{
				text = "Scan",
				halign = "center",
				valign = "center",
				widget = W.widget.textbox,
			},
			forced_width = 90,
			forced_height = 30,
			bg = B.barhi,
			shape = function(cr, w, h)
				S.rounded_rect(cr, w, h, 4)
			end,
			widget = W.container.background,
			id = "Scan",
			buttons = {
				A.button({}, 1, nil, function()
					wifi.widget.widget = {}
					local m = wifiactions:get_children_by_id("Scan")[1]
					m.bg = "#60edca"
					m.fg = "#000"
					A.spawn.easy_async_with_shell(
						"iwctl station wlan0 scan && sleep 3 && iwctl station wlan0 get-networks | sed 's,\x1B\\[[0-9;]*[a-zA-Z],,g' | awk 'NR > 4 { print substr($0, 7, 34)}'",
						function(out)
							m.bg = B.barhi
							m.fg = "#fff"
							for s in out:gmatch("[^\r\n]+") do
								table.insert(networks, newNetwork(s))
							end
							wifi.widget.widget = networks
						end
					)
				end),
			},
		},
		{
			{
				text = "Connect",
				halign = "center",
				valign = "center",
				widget = W.widget.textbox,
			},
			forced_width = 90,
			forced_height = 30,
			bg = B.barhi,
			shape = function(cr, w, h)
				S.rounded_rect(cr, w, h, 4)
			end,
			widget = W.container.background,
			id = "Connect",
			buttons = {
				A.button({}, 1, nil, function()
					wifipopup.visible = false
				end),
			},
		},
		{
			{
				text = "Disconnect",
				halign = "center",
				valign = "center",
				widget = W.widget.textbox,
			},
			forced_width = 90,
			forced_height = 30,
			bg = B.barhi,
			shape = function(cr, w, h)
				S.rounded_rect(cr, w, h, 4)
			end,
			widget = W.container.background,
			id = "Disconnect",
			buttons = {
				A.button({}, 1, nil, function()
					wifipopup.visible = false
				end),
			},
		},
		spacing = 25,
		layout = W.layout.fixed.horizontal,
	},
	halign = "center",
	valign = "center",
	widget = W.container.place,
})

wifi = W.widget({
	{
		networks,
		margins = 10,
		widget = W.container.margin,
	},
	bg = B.barhi,
	forced_height = 330,
	widget = W.container.background,
})

wifipopup = A.popup({
	widget = W.widget({
		{
			wifi,
			wifiactions,
			spacing = 20,
			layout = W.layout.fixed.vertical,
		},
		margins = 10,
		forced_width = 400,
		forced_height = 400,
		widget = W.container.margin,
	}),
	x = 1280 - 410,
	y = 50,
	ontop = true,
	bg = B.barbg,
	visible = false,
})

local wifibutton = W.widget({
	{
		{
			{
				text = "",
				valign = "center",
				halign = "center",
				widget = W.widget.textbox,
			},
			margins = {
				left = 10,
				right = 10,
				top = 4,
				bottom = 4,
			},
			widget = W.container.margin,
		},
		bg = B.barhi,
		fg = B.accent,
		shape = function(cr, w, h)
			S.rounded_rect(cr, w, h, 4)
		end,
		widget = W.container.background,
	},
	widget = W.container.place,
	buttons = {
		A.button({}, 1, nil, function()
			awesome.emit_signal("ui::wifipopup")
		end),
	},
})

local M = { wifibutton = wifibutton }

function M.setup()
	G.timer({
		timeout = 5,
		call_now = true,
		autostart = true,
		callback = function()
			A.spawn.easy_async_with_shell(
				"iwctl station wlan0 show | grep 'Connected network' | cut -b 35- | awk '{$1=$1};1'",
				function(out)
					local net = out
					if net ~= "" then
						net = " " .. net
					end
					M.wifibutton.widget.widget.widget.text = "" .. net
				end
			)
		end,
	})
	awesome.connect_signal("ui::wifipopup", function()
		wifipopup.visible = not wifipopup.visible
	end)
	return wifipopup
end

return M
