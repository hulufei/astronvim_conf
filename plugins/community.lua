-- [nfnl] Compiled from plugins/community.fnl by https://github.com/Olical/nfnl, do not edit.
local uu = require("user.util")
local fun = require("user.vendor.fun")
local function _1_(_, opts)
  for index, value in ipairs(opts.ensure_installed) do
    if fun.index(value, {"luap"}) then
      table.remove(opts.ensure_installed, index)
    else
    end
  end
  return nil
end
return {uu.tx("AstroNvim/astrocommunity"), uu.tx({import = "astrocommunity.pack.rust"}), uu.tx({import = "astrocommunity.pack.lua"}), uu.tx({import = "astrocommunity.pack.typescript-all-in-one"}), uu.tx({import = "astrocommunity.pack.markdown"}), uu.tx({import = "astrocommunity.motion.nvim-surround"}), uu.tx({import = "astrocommunity.motion.leap-nvim", enabled = false}), uu.tx({import = "astrocommunity.note-taking.obsidian-nvim", enabled = false}), uu.tx("nvim-treesitter/nvim-treesitter", {opts = _1_}), uu.tx("epwalsh/obsidian.nvim", {event = {("BufReadPre " .. vim.env.HOME .. "/vimwiki/*.md")}, opts = {dir = "~/vimwiki"}, enabled = false})}
