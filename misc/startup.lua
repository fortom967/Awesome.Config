local awful = require("awful")

local cmds = {
	"picom -b",
	"xsetroot -cursor_name left_ptr",
	"xmodmap -e 'pointer = 3 2 1'",
    "xinput disable 'AlpsPS/2 ALPS DualPoint Stick'"
	-- [[ xss-lock awesome-client "awesome.emit_signal('UI::Lockscreen')" ]],
}

for _, v in pairs(cmds) do
	awful.spawn.easy_async_with_shell(v, function() end)
end
