local gears = require("gears")

local conf_path = os.getenv("HOME") .. "/.config/awesome/theme/"

local theme = {
	font = "Recursive Sans Casual Static 10",

	popup = { bg = "#000000bf" },
	barhi = "#2E2D2D",
	accent = "#6E36C9",

	prompt_bg_cursor = "#6E36C9",
    prompt_font = "Maple Mono NF Italic 10",

	snapper_gap = 6,
	snap_bg = "#000",
	snap_shape = gears.shape.rectangle,
	snap_border_width = 1,

	disconnected = conf_path .. "icons/connected.svg",
	connected = conf_path .. "icons/connected.svg",
	clock = conf_path .. "icons/clock.svg",
	menu = conf_path .. "icons/menu.svg",
	notifications = conf_path .. "icons/notifications.svg",
	poweroff = conf_path .. "icons/poweroff.svg",
	restart = conf_path .. "icons/restart.svg",
	lock = conf_path .. "icons/lock.svg",
	logout = conf_path .. "icons/logout.svg",
	search = conf_path .. "icons/search.svg",
	volume = conf_path .. "icons/volume.svg",
	brightness = conf_path .. "icons/brightness.svg",
	battery = conf_path .. "icons/battery.svg",

	useless_gap = 5,
	border_width = 0,

	wallpaper = conf_path .. "wallpaper.jpg",
    lockscreen = conf_path .. "lock.jpg",
    avatar = conf_path .. "avatar.jpg",

	layout_fairh = conf_path .. "layouts/fairh.svg",
	layout_fairv = conf_path .. "layouts/fairv.svg",
	layout_floating = conf_path .. "layouts/floating.svg",
	layout_tilebottom = conf_path .. "layouts/tilebottom.svg",
	layout_tile = conf_path .. "layouts/tile.svg",
    layoutlist_bg_selected = "#6E36C9",

}

return theme
