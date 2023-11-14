-- [nfnl] Compiled from plugins/user.fnl by https://github.com/Olical/nfnl, do not edit.
local uu = require("user.util")
local function _1_()
  return (require("flash")).treesitter()
end
local function _2_()
  return (require("flash")).treesitter_search()
end
local function _3_()
  return (require("flash")).toggle()
end
return {uu.tx("Olical/nfnl", {ft = "fennel"}), uu.tx("Olical/conjure", {ft = {"clojure", "fennel"}}), uu.tx("jaawerth/fennel.vim", {ft = {"fennel"}}), uu.tx("tpope/vim-repeat", {lazy = false}), uu.tx("folke/flash.nvim", {event = "VeryLazy", opts = {}, keys = {{"S", _1_, mode = {"n", "x", "o"}, desc = "Flash Treesitter"}, {"R", _2_, mode = {"x", "o"}, desc = "Treesitter Search"}, {"<c-s>", _3_, mode = {"c"}, desc = "Toggle Flash Search"}}})}
