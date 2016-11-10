local M = {}

--M.all =

function M.l(fd)
	local count = 0
	while true do
		local line = fd:read("*l")
		if not line then break end
		count = count +1
	end
	return count
end

function M.c(fd)
	local count = 0
	while true do
		local line = fd:read(1024)
		if not line then break end
		count = count + #line
	end
	return count
end
function M.w(fd)
	local count = 0
	while true do
		local line = fd:read("*l")
		if not line then break end
		local _,n = line:gsub("%S+","")
		count = count +(n or 0)
	end
	return count
end
-- see also : https://github.com/juditacs/wordcount/blob/master/lua/wordcount.lua

-- M.m -- need utf8
return M
