-- [nfnl] Compiled from mappings.fnl by https://github.com/Olical/nfnl, do not edit.
local uu = require("user.util")
local fun = require("user.vendor.fun")
local wiki = "~/vimwiki"
local function get_tabpage_by_win(id)
  if id then
    local function _1_()
      local tbl_17_auto = {}
      local i_18_auto = #tbl_17_auto
      for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
        local val_19_auto
        if (vim.api.nvim_tabpage_is_valid(tab) and fun.index(id, vim.api.nvim_tabpage_list_wins(tab))) then
          val_19_auto = tab
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
    return unpack(_1_())
  else
    return nil
  end
end
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
  local function _7_(buf)
    return string.find(vim.api.nvim_buf_get_name(buf), path, 1, true)
  end
  return list_bufs_match(_7_)
end
local function list_bufs_match_help()
  local function _8_(buf)
    return (vim.api.nvim_buf_get_option(buf, "filetype") == "help")
  end
  return list_bufs_match(_8_)
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
local function get_tabpage_match_dir(path)
  local path0 = vim.fn.expand(path)
  local bufs = list_bufs_match_dir(path0)
  local win = unpack(list_wins_with_bufs(bufs))
  return get_tabpage_by_win(win)
end
local function get_tabpage_with_help()
  local bufs = list_bufs_match_help()
  local win = unpack(list_wins_with_bufs(bufs))
  return get_tabpage_by_win(win)
end
local function tab_open_file_in(dir)
  local telescope = require("telescope.builtin")
  do
    local activetab_2_auto = get_tabpage_match_dir(dir)
    if activetab_2_auto then
      vim.cmd((":tabnext" .. vim.api.nvim_tabpage_get_number(activetab_2_auto)))
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
    local activetab_2_auto = get_tabpage_with_help()
    if activetab_2_auto then
      vim.cmd((":tabnext" .. vim.api.nvim_tabpage_get_number(activetab_2_auto)))
      return vim.cmd.help(input)
    else
      return vim.cmd((":tab help " .. input))
    end
  else
    return nil
  end
end
local function _15_()
  return tab_open_help()
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
  local activetab_2_auto = get_tabpage_match_dir(wiki)
  if activetab_2_auto then
    vim.cmd((":tabnext" .. vim.api.nvim_tabpage_get_number(activetab_2_auto)))
    return vim.cmd.edit(diary)
  else
    vim.cmd.tabnew()
    return vim.cmd.tcd(wiki)
  end
end
return {n = {[";"] = {":"}, ["<leader>bn"] = uu.tx(":tabnew<cr>", {desc = "Create a new tab"}), ["<leader>bt"] = uu.tx(":%s/\\s\\+$//e<cr>", {desc = "Delete trailing whitespace"}), ["<leader>ct"] = uu.tx(":tabclose<cr>", {desc = "Close tab"}), ["<leader>ht"] = {_15_}, ["<leader>wc"] = {_16_}, ["<leader>ww"] = {_17_}, ["<leader>w<leader>w"] = {_18_}}, t = {[",jj"] = uu.tx("<C-\\><C-N>", {desc = "Switch to normal mode"})}}
