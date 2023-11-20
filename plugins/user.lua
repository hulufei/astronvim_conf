-- [nfnl] Compiled from plugins/user.fnl by https://github.com/Olical/nfnl, do not edit.
local uu = require("user.util")
local function _1_()
  vim.g.backlinks_search_dir = "~/vimwiki"
  vim.g.backlinks_exclude_pattern = "/assets/"
  return vim.keymap.set("n", ",b", (require("backlinks")).find_files_back_linked, {desc = "Search backlinks"})
end
local function _2_()
  vim.g.nvlime_config = {implementation = "ccl", cmp = {enabled = true}}
  local cmp = require("cmp")
  return cmp.setup.filetype({"lisp"}, {sources = {{name = "nvlime"}}})
end
local function _3_()
  return (require("flash")).treesitter()
end
local function _4_()
  return (require("flash")).remote()
end
local function _5_()
  return (require("flash")).treesitter_search()
end
local function _6_()
  return (require("flash")).toggle()
end
return {uu.tx("Olical/nfnl", {ft = "fennel"}), uu.tx("Olical/conjure", {ft = {"clojure", "fennel"}}), uu.tx("jaawerth/fennel.vim", {ft = {"fennel"}}), uu.tx("tpope/vim-repeat", {lazy = false}), uu.tx("hulufei/backlinks.nvim", {event = "BufEnter */vimwiki/*.md", config = _1_}), uu.tx("monkoose/nvlime", {ft = "lisp", dependencies = {"monkoose/parsley"}, init = _2_}), uu.tx("folke/flash.nvim", {event = "VeryLazy", opts = {}, keys = {{"S", _3_, mode = {"n", "x", "o"}, desc = "Flash Treesitter"}, {"r", _4_, mode = "o", desc = "Remote Flash"}, {"R", _5_, mode = {"x", "o"}, desc = "Treesitter Search"}, {"<c-s>", _6_, mode = {"c"}, desc = "Toggle Flash Search"}}})}
