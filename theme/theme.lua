---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi

-- local gfs = require("gears.filesystem")
local themes_path = os.getenv("HOME") .. "/.config/awesome/theme/"

local theme = {}

theme.font = "Bellota Bold Italic 10"

theme.barbg = "#101213"
theme.barfg = "#ABABAB"
theme.barhi = "#2E2D2D"
theme.accent = "#6E36C9"

theme.disconnected = themes_path .. "icons/connected.svg"
theme.connected = themes_path .. "icons/connected.svg"
theme.clock = themes_path .. "icons/clock.svg"
theme.menu = themes_path .. "icons/menu.svg"
theme.notifications = themes_path .. "icons/notifications.svg"
theme.poweroff = themes_path .. "icons/poweroff.svg"
theme.restart = themes_path .. "icons/restart.svg"
theme.lock = themes_path .. "icons/lock.svg"
theme.logout = themes_path .. "icons/logout.svg"
theme.search = themes_path .. "icons/search.svg"
theme.volume = themes_path .. "icons/volume.svg"
theme.brightness = themes_path .. "icons/brightness.svg"
theme.battery = themes_path .. "icons/battery.svg"

theme.layoutlist_bg_selected = theme.accent

-- theme.bg_normal = "#121212"
-- theme.bg_focus = "#121321"
-- theme.bg_urgent = "#123130"
-- theme.bg_minimize = "#121212"
-- theme.bg_systray = theme.bg_normal
--
-- theme.fg_normal = "#ffffff"
-- theme.fg_focus = "#ffffff"
-- theme.fg_urgent = "#ffffff"
-- theme.fg_minimize = "#ffffff"

theme.useless_gap = 8
theme.border_width = 0
-- theme.border_color_normal = "#000000"
-- theme.border_color_active = "#535d6c"
-- theme.border_color_marked = "#91231c"

-- theme.taglist_fg_focus = "#6E36C9"
-- theme.taglist_fg_occupied = "#6E36C9"
-- theme.taglist_fg_empty = "#ABABAB"
-- theme.taglist_shape_focus = gears.shape.star
-- theme.taglist_shape = gears.shape.rectangle
--
-- There are other variable sets
-- overriding the one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
-- local taglist_square_size = 10
-- theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- theme.notification_bg = "#ffffff"
-- theme.notification_fg = "#121212"
-- theme.notification_margin = 10
-- theme.notification_border_width = 0
-- theme.notification_shape = gears.shape.rounded_rect
-- theme.notification_border_color = "#121221"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path .. "submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path .. "titlebar/close_normal.png"
theme.titlebar_close_button_focus = themes_path .. "titlebar/close_focus.png"

theme.titlebar_floating_button_normal_inactive = themes_path .. "titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = themes_path .. "titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path .. "titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = themes_path .. "titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path .. "titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = themes_path .. "titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = themes_path .. "titlebar/maximized_focus_active.png"

theme.wallpaper = themes_path .. "wallpaper.jpg"

theme.layout_fairh = themes_path .. "layouts/fairh.svg"
theme.layout_fairv = themes_path .. "layouts/fairv.svg"
theme.layout_floating = themes_path .. "layouts/floating.svg"
theme.layout_tilebottom = themes_path .. "layouts/tilebottom.svg"
theme.layout_tile = themes_path .. "layouts/tile.svg"

theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

theme.icon_theme = nil

rnotification.connect_signal("request::rules", function()
	rnotification.append_rule({
		rule = { urgency = "critical" },
		properties = { bg = "#121221", fg = "#ffffff" },
	})
end)

return theme
