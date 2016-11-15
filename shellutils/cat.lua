
local fs = require "shellutils".fs

local function cat(name, outputline)
	assert(outputline)
	local fd = fs.open(name, "r")
	while true do
		local line = fd:read("*l")
		if not line then break end
		outputline(name, line)
	end
	fd:close()
	return
end

return cat
