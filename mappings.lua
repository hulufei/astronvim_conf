-- [nfnl] Compiled from mappings.fnl by https://github.com/Olical/nfnl, do not edit.
local uu = require("user.util")
local wiki = "~/vimwiki"
local function tab_open_file_in(dir)
  local telescope = require("telescope.builtin")
  vim.cmd.tabnew()
  vim.cmd.tcd(dir)
  return telescope.find_files()
end
local function _1_()
  return tab_open_file_in("~/.config/nvim/lua/user")
end
local function _2_()
  return tab_open_file_in(wiki)
end
local function _3_()
  local date = os.date("%Y-%m-%d")
  vim.cmd.tabnew((wiki .. "/diary/" .. date .. ".md"))
  return vim.cmd.tcd(wiki)
end
return {n = {[";"] = {":"}, ["<leader>bn"] = uu.tx(":tabnew<cr>", {desc = "Create a new tab"}), ["<leader>bt"] = uu.tx(":%s/\\s\\+$//e<cr>", {desc = "Delete trailing whitespace"}), ["<leader>ht"] = uu.tx(":tab help ", {desc = "Help in new tab"}), ["<leader>ct"] = uu.tx(":tabclose<cr>", {desc = "Close tab"}), ["<leader>wc"] = {_1_}, ["<leader>ww"] = {_2_}, ["<leader>w<leader>w"] = {_3_}}, t = {[",jj"] = uu.tx("<C-\\><C-N>", {desc = "Switch to normal mode"})}}
