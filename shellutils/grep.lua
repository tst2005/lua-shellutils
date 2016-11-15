local fs = require "shellutils".fs
local cat = require "shellutils".cat
local namecat = function(name)
	return cat(name, function(name, line)
		print(name .. ":" .. line)
	end)
end

local cfg = {error = error, follow = true, exec = namecat}

fs.find(arg[1] or ".", cfg) -- like: grep -R '' .
