-- [nfnl] Compiled from plugins/cmp.fnl by https://github.com/Olical/nfnl, do not edit.
local uu = require("user.util")
local function _1_(_config, opts)
  local cmp = require("cmp")
  table.insert(opts.sources, {name = "nvlime"})
  return cmp.setup.filetype({"lisp"}, {sources = opts.sources})
end
return uu.tx("hrsh7th/nvim-cmp", {config = _1_})
