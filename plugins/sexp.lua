-- [nfnl] Compiled from plugins/sexp.fnl by https://github.com/Olical/nfnl, do not edit.
local uu = require("user.util")
local lisps = {"scheme", "lisp", "clojure", "fennel"}
local function _1_()
  vim.g.sexp_filetypes = "clojure,scheme,lisp,timl,fennel,janet"
  return nil
end
return {uu.tx("guns/vim-sexp", {ft = lisps, init = _1_}), uu.tx("tpope/vim-sexp-mappings-for-regular-people", {ft = lisps})}
