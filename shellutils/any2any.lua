local M = {}

local eol = {
	["dos"] = '\r\n',	-- CRLF
	["mac"] = '\r',		-- CR
	["unix"] = '\n',	-- LF
}
local function any2any(str, srcname, dstname)
	assert(type(str)=="string", "invalid #1 argument")
	return ( -- use only the first returned argument, drop the rest
		str:gsub(
			assert(eol[srcname], "invalid source format"),
			assert(eol[dstname], "invalid destination format")
		)
	)
end

M.dos2unix = function(str) return any2any(str, "dos",  "unix") end
M.unix2dos = function(str) return any2any(str, "unix", "dos")  end
M.dos2mac  = function(str) return any2any(str, "dos",  "mac")  end
M.mac2dos  = function(str) return any2any(str, "mac",  "dos")  end
M.unix2mac = function(str) return any2any(str, "unix", "mac")  end
M.mac2unix = function(str) return any2any(str, "mac",  "unix") end

--[[
for _i, ab in ipairs{
	{"dos", "unix"},
	{"unix", "dos"},
	{"dos", "mac"},
	{"mac", "dos"},
	{"unix", "mac"},
	{"mac", "unix"},
} do
	M[ab[1].."2"..ab[2] ] = function(str) return any2any(str, ab[1], ab[2]) end
end
]]--

return M
