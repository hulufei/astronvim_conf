-- [nfnl] Compiled from plugins/luasnip.fnl by https://github.com/Olical/nfnl, do not edit.
local uu = require("user.util")
local function _1_(plugin, opts)
  local config = require("plugins.configs.luasnip")
  local ls = require("luasnip")
  local loader = require("luasnip.loaders.from_lua")
  config(plugin, opts)
  loader.lazy_load({paths = {"./lua/user/snippets"}, fs_event_providers = {autocmd = true, libuv = true}})
  ls.filetype_extend("tex", {"katex"})
  ls.filetype_extend("markdown", {"tex", "katex", "html"})
  local function _2_()
    local loader0 = require("luasnip.loaders")
    return loader0.reload_file((vim.fn.expand("%:p:r") .. ".lua"))
  end
  vim.keymap.set("n", "<leader>sr", _2_, {desc = "Reload current snippet file(should invoke in snippet file)"})
  local function _3_()
    return ls.jump(1)
  end
  vim.keymap.set({"i", "s"}, "jk", _3_, {silent = true})
  local function _4_()
    return ls.jump(-1)
  end
  vim.keymap.set({"i", "s"}, "kj", _4_, {silent = true})
  vim.keymap.set({"i", "s"}, "<c-n>", "<Plug>uasnip-next-choice", {})
  vim.keymap.set({"i", "s"}, "<c-p>", "<Plug>uasnip-prev-choice", {})
  return vim.api.nvim_create_user_command("LuaSnipEdit", "lua require('luasnip.loaders').edit_snippet_files()", {})
end
return uu.tx("L3MON4D3/LuaSnip", {config = _1_})
