local class = require "mini.class"
local instance = class.instance

local args = class("args")

-- emulation of $1 $2 $3 / $@ / $* / $# / shift

-- args range :
-- * min = 1
-- * max = #a

function args:init(a, ifs)
	self.ifs = ifs or " \t\n"
	self._offset = 0
	if type(a) == "table" then
		self._orig = a
	elseif type(a) == "string" then
		local pat = "[" .. require "mini.quote_magics"(self.ifs) .. "]+"
		self._orig = require "mini.string.split"(a:gsub('^'..pat,''):gsub(pat..'$',''), pat)
	else
		error("unsupported import type", 2)
	end
	require "mini.class.autometa"(self, args)
end

function args:shift(n)
	n = n==nil and 1 or n
	assert(type(n)=="number")
	n=math.floor(n)
	assert(n>=0)
	if 1 + self._offset + n > #self._orig then
		error("nothing to shift", 2)
	end
	self._offset = self._offset + n
	return self
end

function args:unshift(n)
	n = n==nil and 1 or n
	assert(type(n)=="number")
	n=math.floor(n)
	assert(n>=0)
	if 1 + self._offset - n < 1 then
		error("out of unshift range", 2)
	end
	self._offset = self._offset - n
	return self
end

function args:len()
	return #self._orig - self._offset
end
args.__len = args.len

function args:getall()
	local t = {}
	for i=self._offset+1,#self._orig,1 do
		t[#t+1] = self._orig[i]
	end
	return t
end

function args:get(n)
	assert(type(n)=="number")
	n=math.floor(n)
	assert(n>=0)
	return self._orig[self._offset+n]
end

function args:one()
	return self._orig[self._offset+1]
end

function args:expand()
	local sep = self.ifs:sub(1,1) or " "
	return instance(args, {table.concat(self._orig, sep, 1+self._offset)}, self.ifs)
end

function args:tostring()
	local sep = self.ifs:sub(1,1) or " "
	return table.concat(self._orig, sep)
end

args.__tostring = args.tostring
args.__call = function(self, a, ifs)
	return instance(args, a, ifs or self.ifs)
end

function args:compact()
	for _i=1,self._offset do
		table.remove(self._orig, 1)
	end
	self._offset=0
	return self
end

return args
