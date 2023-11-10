-- [nfnl] Compiled from plugins/mason.fnl by https://github.com/Olical/nfnl, do not edit.
local uu = require("user.util")
local fun = require("user.vendor.fun")
local function _1_(_, opts)
  local utils = require("astronvim.utils")
  opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, {"fennel_language_server"})
  return nil
end
local function _2_(_, opts)
  local function _3_(v)
    return not fun.index(v, {"luacheck"})
  end
  opts.ensure_installed = fun.filter(_3_, opts.ensure_installed)
  return nil
end
return {uu.tx("williamboman/mason-lspconfig.nvim", {opts = _1_}), uu.tx("jay-babu/mason-null-ls.nvim", {opts = _2_})}
