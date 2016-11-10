local wc = require "shellutils.wc"

local wc_l = tonumber( io.popen("wc -l < /etc/passwd"):read("*all") )
local wc_c = tonumber( io.popen("wc -c < /etc/passwd"):read("*all") )
assert( wc.l(io.open("/etc/passwd")) == wc_l)
assert( wc.c(io.open("/etc/passwd")) == wc_c)

local tmp = os.tmpname()
local fd = io.open(tmp, "w+")

fd:write(" a b'c d\n ")
fd:seek("set", 0)

local wc_w = tonumber( io.popen("wc -w < "..tmp):read("*all") )
assert( wc.w(fd) == wc_w)

fd:close()
os.remove(tmp)

print("OK")
