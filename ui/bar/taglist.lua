local A = require("awful")
local W = require("wibox")
local B = require("beautiful")
local S = require("gears").shape

local function create_callback(self, tag, _, _)
	self.update_callback(self, tag, nil, nil)

	self:connect_signal("mouse::enter", function()
		self.widget.widget.bg = B.accent
	end)

	self:connect_signal("mouse::leave", function()
		if tag.selected and #tag:clients() > 0 then
			self.widget.widget.bg = B.accent
		elseif tag.selected then
			self.widget.widget.bg = "#fff"
		else
			self.widget.widget.bg = "#fff"
		end
	end)
end

local update_callback = function(self, tag, _, _)
	if tag.selected and #tag:clients() > 0 then
		self.widget.widget.forced_width = 25
		self.widget.widget.bg = B.accent
	elseif tag.selected then
		self.widget.widget.forced_width = 25
		self.widget.widget.bg = "#fff"
	elseif #tag:clients() > 0 then
		self.widget.widget.forced_width = 6
		self.widget.widget.bg = B.accent
	else
		self.widget.widget.forced_width = 6
		self.widget.widget.bg = "#fff"
	end
end

local buttons = {
	A.button({}, 1, function(t)
		t:view_only()
	end),
	A.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	A.button({}, 3, A.tag.viewtoggle),
	A.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	A.button({}, 4, function(t)
		A.tag.viewprev(t.screen)
	end),
	A.button({}, 5, function(t)
		A.tag.viewnext(t.screen)
	end),
}

local taglist = {
	{
		{
			A.widget.taglist({
				screen = screen[1],
				filter = A.widget.taglist.filter.all,
				widget_template = {
					{
						{
							bg = "#fff",
							forced_width = 6,
							forced_height = 6,
							shape = S.rounded_rect,
							widget = W.container.background,
						},
						valign = "center",
						halign = "center",
						forced_width = 25,
						forced_height = 12,
						widget = W.container.place,
					},
					widget = W.container.background,
					update_callback = update_callback,
					create_callback = create_callback,
				},
				buttons = buttons,
			}),
			margins = {
				left = 10,
				right = 10,
				top = 6,
				bottom = 6,
			},
			widget = W.container.margin,
		},
		bg = B.barhi,
		shape = function(cr, w, h)
			S.rounded_rect(cr, w, h, 4)
		end,
		widget = W.container.background,
	},
	widget = W.container.place,
}

return taglist
