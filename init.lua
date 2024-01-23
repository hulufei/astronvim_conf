-- [nfnl] Compiled from init.fnl by https://github.com/Olical/nfnl, do not edit.
local uu = require("user.util")
local function _1_()
  local lspconfig = require("lspconfig")
  return {cmd = {"fennel-language-server"}, filetypes = {"fennel"}, root_dir = lspconfig.util.root_pattern("fnl"), settings = {fennel = {diagnostics = {globals = {"vim"}}, workspace = {library = vim.api.nvim_list_runtime_paths()}}}, single_file_support = true}
end
local function _2_()
  local group = vim.api.nvim_create_augroup("md_augroup", {clear = true})
  local function _3_(_args)
    do end (vim.opt_local.formatoptions):append("cmB")
    vim.keymap.set("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u")
    vim.keymap.set("n", "<tab>", ":call search('\\V](\\.\\+)')<cr>", {buffer = true})
    vim.keymap.set("n", "<s-tab>", ":call search('\\V](\\.\\+)', 'b')<cr>", {buffer = true})
    local function _4_()
      local line = vim.fn.getline(".")
      local link = string.match(line, "%b[]%((.-)%)")
      if (link and not string.match(link, "https?://")) then
        local dir = vim.fn.expand("%:p:h")
        local link0
        if not string.match(link, "%.md") then
          link0 = (link .. ".md")
        else
          link0 = link
        end
        local file = vim.fn.resolve((dir .. "/" .. link0))
        return vim.cmd.edit(file)
      else
        return nil
      end
    end
    vim.keymap.set("n", "<cr>", _4_, {buffer = true, desc = "Basic create on press enter on links"})
    vim.opt_local.spell = true
    local surround = require("nvim-surround")
    local function _7_()
      local link = uu["get-input"]("Enter the link:", "file")
      if link then
        return {{"["}, {("](" .. link .. ")")}}
      else
        return nil
      end
    end
    local function _9_()
      return {{""}, {""}}
    end
    local function _10_()
      local link = uu["get-vselect-text"]()
      if link then
        return {{"["}, {("](" .. string.lower(string.gsub(link, "[%p%s]+", "-")) .. ")")}}
      else
        return nil
      end
    end
    local function _12_()
      return {{"**"}, {"**"}}
    end
    return surround.buffer_setup({surrounds = {l = {add = _7_, find = "%b[]%b()", delete = "^(%[)().-(%]%b())()$", change = {target = "^()()%b[]%((.-)()%)$", replacement = _9_}}, ["<cr>"] = {add = _10_}, s = {add = _12_, find = "%*%*.-%*%*", delete = "^(%*%*)().-(%*%*)()$"}}})
  end
  vim.api.nvim_create_autocmd("FileType", {pattern = "markdown", group = group, callback = _3_})
  vim.opt.shell = "fish"
  return vim.cmd("\n                    map ,ch :call SetColorColumn()<CR>\n                    function! SetColorColumn()\n                      let col_num = virtcol('.')\n                      let cc_list = split(&cc, ',')\n                      if count(cc_list, string(col_num)) <= 0\n                      execute 'set cc+='.col_num\n                      else\n                      execute 'set cc-='.col_num\n                      endif\n                    endfunction\n                    ")
end
return {updater = {branch = "nightly", channel = "stable", commit = nil, pin_plugins = nil, remote = "origin", remotes = {}, show_changelog = true, version = "latest", auto_quit = false, skip_prompts = false}, colorscheme = "astrodark", diagnostics = {underline = true, virtual_text = true}, lazy = {defaults = {lazy = true}, performance = {rtp = {disabled_plugins = {"tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin"}}}}, lsp = {config = {fennel_language_server = _1_}, formatting = {disabled = {}, format_on_save = {allow_filetypes = {}, enabled = true, ignore_filetypes = {"markdown"}}, timeout_ms = 1000}, servers = {}}, polish = _2_}
