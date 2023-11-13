-- [nfnl] Compiled from init.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local lspconfig = require("lspconfig")
  return {cmd = {"fennel-language-server"}, filetypes = {"fennel"}, root_dir = lspconfig.util.root_pattern("fnl"), settings = {fennel = {diagnostics = {globals = {"vim"}}, workspace = {library = vim.api.nvim_list_runtime_paths()}}}, single_file_support = true}
end
local function _2_()
end
return {updater = {branch = "nightly", channel = "stable", commit = nil, pin_plugins = nil, remote = "origin", remotes = {}, show_changelog = true, version = "latest", auto_quit = false, skip_prompts = false}, colorscheme = "astrodark", diagnostics = {underline = true, virtual_text = true}, lazy = {defaults = {lazy = true}, performance = {rtp = {disabled_plugins = {"tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin"}}}}, lsp = {config = {fennel_language_server = _1_}, formatting = {disabled = {}, format_on_save = {allow_filetypes = {}, enabled = true, ignore_filetypes = {}}, timeout_ms = 1000}, servers = {}}, polish = _2_}
