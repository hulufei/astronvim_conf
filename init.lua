-- [nfnl] Compiled from init.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local lspconfig = require("lspconfig")
  return {cmd = {"fennel-language-server"}, filetypes = {"fennel"}, root_dir = lspconfig.util.root_pattern("fnl"), settings = {fennel = {diagnostics = {globals = {"vim"}}, workspace = {library = vim.api.nvim_list_runtime_paths()}}}, single_file_support = true}
end
local function _2_()
  local group = vim.api.nvim_create_augroup("md_augroup", {clear = true})
  local function _3_(_args)
    vim.cmd("set formatoptions+=cmB")
    vim.cmd("inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u")
    local get_input
    local function _4_(prompt, completion)
      local ok, result = pcall(vim.fn.input, {prompt = prompt, completion = completion, cancelreturn = vim.NIL})
      if (ok and (result ~= vim.NIL)) then
        return result
      else
        return nil
      end
    end
    get_input = _4_
    local surround = require("nvim-surround")
    local function _6_()
      local link = get_input("Enter the link:", "file")
      if link then
        return {{"["}, {("](" .. link .. ")")}}
      else
        return nil
      end
    end
    local function _8_()
      return {{""}, {""}}
    end
    return surround.buffer_setup({surrounds = {l = {add = _6_, find = "%b[]%b()", delete = "^(%[)().-(%]%b())()$", change = {target = "^()()%b[]%((.-)()%)$", replacement = _8_}}}})
  end
  return vim.api.nvim_create_autocmd("FileType", {pattern = "markdown", group = group, callback = _3_})
end
return {updater = {branch = "nightly", channel = "stable", commit = nil, pin_plugins = nil, remote = "origin", remotes = {}, show_changelog = true, version = "latest", auto_quit = false, skip_prompts = false}, colorscheme = "astrodark", diagnostics = {underline = true, virtual_text = true}, lazy = {defaults = {lazy = true}, performance = {rtp = {disabled_plugins = {"tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin"}}}}, lsp = {config = {fennel_language_server = _1_}, formatting = {disabled = {}, format_on_save = {allow_filetypes = {}, enabled = true, ignore_filetypes = {}}, timeout_ms = 1000}, servers = {}}, polish = _2_}
