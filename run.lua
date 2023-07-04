local t = require"libs"

while true do
    local m = require"inspect".inspect(t.get_speed("wlan0"))
    print(m)
    os.execute("sleep 1")
end
