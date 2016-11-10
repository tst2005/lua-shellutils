local M = {}
local any2any = require "shellutils.any2any"

M.dos2unix = any2any.dos2unix
M.unix2dos = any2any.unix2dos
M.dos2mac  = any2any.dos2mac
M.mac2dos  = any2any.mac2dos
M.unix2mac = any2any.unix2mac
M.mac2unix = any2any.mac2unix

return M
