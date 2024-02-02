-- [nfnl] Compiled from plugins/better-escape.fnl by https://github.com/Olical/nfnl, do not edit.
local uu = require("user.util")
local function _1_()
  local bs = require("better_escape")
  return bs.setup({mapping = {"jj"}})
end
return uu.tx("max397574/better-escape.nvim", {config = _1_})
