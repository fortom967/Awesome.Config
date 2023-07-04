local lib = require("libs.lib")

local mod = {}

local cache = { upload = 0, download = 0 }

local function show(n)
	local function truncate(num)
		local mult = 100
		return math.floor(num * mult + 0.5) / mult
	end

	local in_Kb = truncate(n / 1024)
	if n < 1024 then
		return tostring(in_Kb) .. " Kb"
	end

	local in_Mb = truncate(in_Kb / 1024)
	if in_Mb < 1024 then
		return tostring(in_Mb) .. " Mb"
	end

	local in_Gb = truncate(in_Mb / 1024)
	if in_Gb < 1024 then
		return tostring(in_Gb) .. " Gb"
	end
end

function mod.get_speed(iface)
	local stat = lib.c_get_speed(iface)

	local ns = {
		upload = show(stat.upload - cache.upload),
		download = show(stat.download - cache.download),
	}

	cache = stat

	return ns
end

return mod
