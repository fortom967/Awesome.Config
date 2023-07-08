local awful = require("awful")
local wibox = require("wibox")
local theme = require("beautiful")
local gears = require("gears")
local user = require("libs")

local popup

local status = wibox.widget({
	{
		{
			text = "",
			halign = "center",
			forced_width = 200,
			wrap_text = true,
			widget = wibox.widget.textbox,
		},
		margins = { top = 5, bottom = 5, left = 10, right = 10 },
		widget = wibox.container.margin,
	},
	visible = false,
	widget = wibox.container.place,
})

local timer = wibox.widget({
	{
		{
			{
				text = "",
				halign = "center",
				forced_height = 15,
				widget = wibox.widget.textbox,
			},
			margins = { left = 10, right = 10, top = 5, bottom = 5 },
			widget = wibox.container.margin,
		},
		bg = "#000",
		widget = wibox.container.background,
	},
	visible = false,
	widget = wibox.container.place,
})

local time = 600 -- 10 minutes
local clock
clock = gears.timer({
	timeout = 1,

	call_now = true,

	callback = function()
		local minutes, seconds = math.modf(time / 60)

		timer.widget.widget.widget.text = string.format("%.2d:%.2d", minutes, math.floor(0.5 + seconds * 60))

		time = time - 1
	end,
})

local passwd
local stop_prompt = false
local attempt = 1

passwd = awful.widget.prompt({
	prompt = "",

	done_callback = function()
		if not stop_prompt then
			passwd:run()
		end
	end,

	exe_callback = function(pwd)
		if attempt >= 3 then
			status.visible = true
			status.widget.widget.text = "You provided wrong password for three times. Try again later."
			clock:start()
			return
		end

		if user.authenticate(pwd) then
			stop_prompt = true
			popup.visible = false
		else
			stop_prompt = false
			status.visible = true
			status.widget.widget.text = "Wrong password. Try again."
			attempt = attempt + 1
			passwd:run()
		end
	end,
})

local buttons = wibox.widget({
	{
		{
			{
				{
					image = theme.poweroff,
					widget = wibox.widget.imagebox,
				},
				margins = 10,
				widget = wibox.container.margin,
			},
			shape = gears.shape.circle,
			forced_width = 35,
			forced_height = 35,
			bg = "#000",
			widget = wibox.container.background,
			buttons = {
				awful.button({}, 1, function()
					awful.spawn.with_shell("systemctl poweroff")
				end),
			},
		},
		{
			{
				{
					image = theme.restart,
					widget = wibox.widget.imagebox,
				},
				margins = 10,
				widget = wibox.container.margin,
			},
			shape = gears.shape.circle,
			forced_width = 35,
			forced_height = 35,
			bg = "#000",
			widget = wibox.container.background,
			buttons = {
				awful.button({}, 1, function()
					awful.spawn.with_shell("systemctl reboot")
				end),
			},
		},
		{
			{
				{
					image = theme.logout,
					widget = wibox.widget.imagebox,
				},
				margins = 10,
				widget = wibox.container.margin,
			},
			shape = gears.shape.circle,
			forced_width = 35,
			forced_height = 35,
			bg = "#000",
			widget = wibox.container.background,
			buttons = {
				awful.button({}, 1, function()
					awesome.quit()
				end),
			},
		},
		spacing = 20,
		layout = wibox.layout.fixed.horizontal,
	},
	widget = wibox.container.place,
})

local Lockscreen = function(s)
	popup = awful.popup({
		x = 0,
		y = 0,

		ontop = true,
		visible = false,
		type = "normal",

		widget = {
			{
				image = theme.lockscreen,
				vertical_fit_policy = "fit",
				horizontal_fit_polity = "fit",
				widget = wibox.widget.imagebox,

				forced_width = s.geometry.width,
				forced_height = s.geometry.height,
			},
			{
				{
					{
						{
							{
								forced_width = 100,
								forced_height = 100,
								image = theme.avatar,
								valign = "center",
								halign = "center",

								widget = wibox.widget.imagebox,
								clip_shape = gears.shape.circle,
							},
							{
								{
									{
										{
											text = user.get_username(),
											halign = "center",
											widget = wibox.widget.textbox,
										},
										margins = { top = 5, bottom = 5, left = 10, right = 10 },
										widget = wibox.container.margin,
									},
									bg = theme.accent,
									fg = "#000",
									widget = wibox.container.background,
								},
								widget = wibox.container.place,
							},
							{
								{
									{
										passwd,
										margins = { top = 5, bottom = 5, left = 10, right = 10 },
										widget = wibox.container.margin,
									},
									bg = "#000",
									forced_width = 150,
									forced_height = 40,
									widget = wibox.container.background,
								},
								widget = wibox.container.place,
							},
							status,
							timer,
							buttons,
							spacing = 15,
							layout = wibox.layout.fixed.vertical,
						},
						margins = 20,
						widget = wibox.container.margin,
					},
					forced_width = 500,
					forced_height = 400,
					bg = theme.popup.bg,
					widget = wibox.container.background,
				},
				widget = wibox.container.place,
			},

			layout = wibox.layout.stack,
		},
	})

	awesome.connect_signal("UI::Lockscreen", function()
		_ = not popup.visible and passwd:run() or nil
		popup.visible = not popup.visible
	end)

	return popup
end

return Lockscreen
