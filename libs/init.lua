local lib = require("libs.lib")

local mod = {}

local cache = { upload = 0, download = 0 }

function mod.truncate(num)
	local mult = 100
	return math.floor(num * mult + 0.5) / mult
end

local truncate = mod.truncate

function mod.show(n)
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
		upload = mod.show(stat.upload - cache.upload),
		download = mod.show(stat.download - cache.download),
	}

	print(ns.upload)
	print(ns.download)

	cache = stat

	return ns
end

return mod
