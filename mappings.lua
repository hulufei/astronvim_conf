-- [nfnl] Compiled from mappings.fnl by https://github.com/Olical/nfnl, do not edit.
local uu = require("user.util")
local fun = require("user.vendor.fun")
local wiki = "~/vimwiki"
local function list_bufs_match(test)
  local tbl_17_auto = {}
  local i_18_auto = #tbl_17_auto
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local val_19_auto
    if (vim.api.nvim_buf_is_loaded(buf) and test(buf)) then
      val_19_auto = buf
    else
      val_19_auto = nil
    end
    if (nil ~= val_19_auto) then
      i_18_auto = (i_18_auto + 1)
      do end (tbl_17_auto)[i_18_auto] = val_19_auto
    else
    end
  end
  return tbl_17_auto
end
local function list_bufs_match_dir(path)
  local function _3_(buf)
    return string.find(vim.api.nvim_buf_get_name(buf), path, 1, true)
  end
  return list_bufs_match(_3_)
end
local function list_bufs_match_help()
  local function _4_(buf)
    return (vim.api.nvim_buf_get_option(buf, "filetype") == "help")
  end
  return list_bufs_match(_4_)
end
local function list_wins_with_bufs(bufs)
  if unpack(bufs) then
    local tbl_17_auto = {}
    local i_18_auto = #tbl_17_auto
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local val_19_auto
      if (vim.api.nvim_win_is_valid(win) and fun.index(vim.api.nvim_win_get_buf(win), bufs)) then
        val_19_auto = win
      else
        val_19_auto = nil
      end
      if (nil ~= val_19_auto) then
        i_18_auto = (i_18_auto + 1)
        do end (tbl_17_auto)[i_18_auto] = val_19_auto
      else
      end
    end
    return tbl_17_auto
  else
    return {}
  end
end
local function filter_current_tab_wins(wins)
  local current_wins = vim.api.nvim_tabpage_list_wins(0)
  local tbl_17_auto = {}
  local i_18_auto = #tbl_17_auto
  for _, win in ipairs(wins) do
    local val_19_auto
    if fun.index(win, current_wins) then
      val_19_auto = nil
    else
      val_19_auto = win
    end
    if (nil ~= val_19_auto) then
      i_18_auto = (i_18_auto + 1)
      do end (tbl_17_auto)[i_18_auto] = val_19_auto
    else
    end
  end
  return tbl_17_auto
end
local function get_win_match_dir(path)
  local path0 = vim.fn.expand(path)
  local bufs = list_bufs_match_dir(path0)
  return unpack(filter_current_tab_wins(list_wins_with_bufs(bufs)))
end
local function get_win_with_help()
  local bufs = list_bufs_match_help()
  return unpack(filter_current_tab_wins(list_wins_with_bufs(bufs)))
end
local function tab_open_file_in(dir)
  local telescope = require("telescope.builtin")
  do
    local memo_tab_win_2_auto = get_win_match_dir(dir)
    if memo_tab_win_2_auto then
      vim.fn.win_gotoid(memo_tab_win_2_auto)
    else
      vim.cmd.tabnew()
      vim.cmd.tcd(dir)
    end
  end
  return telescope.find_files()
end
local function tab_open_help()
  local input = uu["get-input"]("Help> ", "help")
  if input then
    local memo_tab_win_2_auto = get_win_with_help()
    if memo_tab_win_2_auto then
      vim.fn.win_gotoid(memo_tab_win_2_auto)
      return vim.cmd.help(input)
    else
      return vim.cmd((":tab help " .. input))
    end
  else
    return nil
  end
end
local function tab_open_cmd()
  local input = uu["get-input"]("Command> ", "command")
  if input then
    local output = vim.fn.execute(input)
    vim.cmd.tabnew()
    return vim.api.nvim_buf_set_lines(0, 0, -1, nil, vim.fn.split(output, "\n"))
  else
    return nil
  end
end
local function _14_()
  return tab_open_help()
end
local function _15_()
  return tab_open_cmd()
end
local function _16_()
  return tab_open_file_in("~/.config/nvim/lua/user")
end
local function _17_()
  return tab_open_file_in(wiki)
end
local function _18_()
  local date = os.date("%Y-%m-%d")
  local diary = (wiki .. "/diary/" .. date .. ".md")
  local memo_tab_win_2_auto = get_win_match_dir(wiki)
  if memo_tab_win_2_auto then
    vim.fn.win_gotoid(memo_tab_win_2_auto)
    return vim.cmd.edit(diary)
  else
    vim.cmd.tabnew()
    return vim.cmd.tcd(wiki)
  end
end
return {n = {[";"] = {":"}, Y = {"^y$"}, ["<leader>bn"] = uu.tx(":tabnew<cr>", {desc = "Create a new tab"}), ["<leader>bt"] = uu.tx(":%s/\\s\\+$//e<cr>", {desc = "Delete trailing whitespace"}), ["<leader>ct"] = uu.tx(":tabclose<cr>", {desc = "Close tab"}), ["<leader>ht"] = uu.tx(_14_, {desc = "Help in new tab"}), ["<leader>tc"] = uu.tx(_15_, {desc = "Vim command output in a new tab"}), ["<leader>wc"] = uu.tx(_16_, {desc = "AstroNvim config in new tab"}), ["<leader>ww"] = uu.tx(_17_, {desc = "Wiki in new tab"}), ["<leader>w<leader>w"] = uu.tx(_18_, {desc = "Today's diary in new tab"})}, t = {[",jj"] = uu.tx("<C-\\><C-N>", {desc = "Switch to normal mode"})}}
