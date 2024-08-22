-- [nfnl] Compiled from plugins/user.fnl by https://github.com/Olical/nfnl, do not edit.
local uu = require("user.util")
local function _1_()
  vim.g["conjure#mapping#doc_word"] = "gk"
  return nil
end
local function _2_()
  vim.g.backlinks_search_dir = "~/vimwiki"
  vim.g.backlinks_exclude_pattern = "/assets/"
  return vim.keymap.set("n", ",b", (require("backlinks")).find_files_back_linked, {desc = "Search backlinks"})
end
local function _3_()
  vim.g.nvlime_config = {implementation = "sbcl", cmp = {enabled = true}}
  vim.g.nvlime_mappings = {lisp = {normal = {load_file = "<LocalLeader>sl", repl = {show = "<LocalLeader>so", clear = "<LocalLeader>sC"}}}}
  local cmp = require("cmp")
  return cmp.setup.filetype({"lisp"}, {sources = {{name = "nvlime"}, {name = "luasnip"}, {name = "buffer"}, {name = "path"}}})
end
local function _4_()
  return (require("flash")).treesitter()
end
local function _5_()
  return (require("flash")).remote()
end
local function _6_()
  return (require("flash")).treesitter_search()
end
local function _7_()
  return (require("flash")).toggle()
end
local function _8_()
  local gp = require("gp")
  return gp.setup({openai_api_key = os.getenv("OPENAI_API_KEY"), curl_params = {"--proxy", "socks5h://localhost:10800"}, chat_model = {model = "gpt-3.5"}})
end
return {uu.tx("Olical/nfnl", {ft = "fennel"}), uu.tx("Olical/conjure", {ft = {"clojure", "fennel", "typescript", "javascript"}, config = _1_}), uu.tx("sigmaSd/conjure-deno", {ft = {"typescript", "javascript"}}), uu.tx("jaawerth/fennel.vim", {ft = {"fennel"}}), uu.tx("tpope/vim-repeat", {lazy = false}), uu.tx("dhruvasagar/vim-table-mode", {ft = "markdown"}), uu.tx("hulufei/backlinks.nvim", {event = "BufEnter */vimwiki/*.md", config = _2_}), uu.tx("monkoose/nvlime", {ft = "lisp", dependencies = {"monkoose/parsley"}, init = _3_}), uu.tx("folke/flash.nvim", {event = "VeryLazy", opts = {}, keys = {{"S", _4_, mode = {"n", "x", "o"}, desc = "Flash Treesitter"}, {"r", _5_, mode = "o", desc = "Remote Flash"}, {"R", _6_, mode = {"x", "o"}, desc = "Treesitter Search"}, {"<c-s>", _7_, mode = {"c"}, desc = "Toggle Flash Search"}}}), uu.tx("Robitx/gp.nvim", {event = "VeryLazy", config = _8_, enabled = false})}
