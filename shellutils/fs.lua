
--[[
do
	local lfs = require"lfs"
	assert(lfs.symlinkattributes)
end
]]--

local fs
do
	local inst, proxy = require "mini.fs.backend.lfs"()
	if proxy then
		fs = proxy -- workaround: convert from fs:foo(a) to fs.foo(a)
		assert(inst.list and inst.list ~= proxy.list)
		assert(inst._shadowself and not proxy._shadowself, "proxy shadowself issue!")
	else
		fs = inst
	end
end

assert(fs)
assert(fs.list)

assert( fs.exists("."), ". directory does not exists ?!")
--assert( not fs.exists("nonexistant.123456789"), "non existant test FAIL")

assert(not fs.find("nonexistant", {error = function() return false end}))

return fs
