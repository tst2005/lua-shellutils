local shellutils = require "shellutils"


assert(
shellutils.dos2unix and
shellutils.unix2dos and
shellutils.dos2mac and
shellutils.mac2dos and
shellutils.unix2mac and
shellutils.mac2unix
)

print("OK")
