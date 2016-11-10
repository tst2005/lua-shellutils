local args = require "shellutils.args"

local a = args{"a", "b", "c"}
assert(a:one() == "a")
assert(a:getall()[1]=="a")
assert(a:len() == 3)

if #a ~= a:len() then print("FAIL: __len not supported?") end
a:shift()
assert(a:len() == 2)
assert( #a:getall() == a:len() )
assert( a:expand():tostring() == "b c")
a.ifs="; "
assert( a:expand():tostring() == "b;c")
assert( tostring(a:expand()) == "b;c")
a.ifs=" \t\n"
a = a(" a b\t\tc\td e\t\n", " \t\n")
assert( a:tostring() == "a b c d e")
a:shift(2) -- a b [c d e]
a:compact() -- [c d e]
assert(a:len()==3)
a:shift() -- c [d e]
assert(a:one()=="d")
assert(a:get(1) == "d")
assert(a:get(2) == "e")
assert(a:get(3)==nil)
a:unshift()
assert(a:one() == "c")
print("OK")
