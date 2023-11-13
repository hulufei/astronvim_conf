(local uu (require :user.util))

(local lisps [:scheme :lisp :clojure :fennel])

[(uu.tx
   :guns/vim-sexp
   {:ft lisps
    :init (fn []
            ; insert_double_quote in fennel works not well, two options, see https://github.com/guns/vim-sexp/issues/31
            ; 1. Disable insert mode mappings
            ; 2. Enabled additional_vim_regex_highlighting in fennel
            ; (set vim.g.sexp_enable_insert_mode_mappings 0) 
            (set vim.g.sexp_filetypes "clojure,scheme,lisp,timl,fennel,janet"))})

 (uu.tx :tpope/vim-sexp-mappings-for-regular-people {:ft lisps})]
