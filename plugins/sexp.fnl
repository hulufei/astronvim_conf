(local uu (require :user.util))

(local lisps [:scheme :lisp :clojure :fennel])

[(uu.tx
   :guns/vim-sexp
   {:ft lisps
    :init (fn []
            (set vim.g.sexp_filetypes "clojure,scheme,lisp,timl,fennel,janet"))})

 (uu.tx :tpope/vim-sexp-mappings-for-regular-people {:ft lisps})]
