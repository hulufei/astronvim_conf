(local uu (require :user.util))

; Caution: Lazy loading for plugins by default
; see https://docs.astronvim.com/recipes/custom_plugins/
[
 (uu.tx :Olical/nfnl {:ft "fennel"})
 (uu.tx :Olical/conjure {:ft ["clojure" "fennel"]})
 (uu.tx :jaawerth/fennel.vim {:ft ["fennel"]})
 (uu.tx :tpope/vim-repeat {:lazy false})
 (uu.tx :folke/flash.nvim {:event "VeryLazy"
                           :opts []
                           :keys [{1 "S"
                                   :mode ["n" "x" "o"] 
                                   2 (fn []  ((. (require "flash") :treesitter)))
                                   :desc "Flash Treesitter"}
                                  {1 "R"
                                   :mode ["x" "o"] 
                                   2 (fn []  ((. (require "flash") :treesitter_search))) 
                                   :desc "Treesitter Search"}
                                  {1 "<c-s>" 
                                   :mode ["c"] 
                                   2 (fn []  ((. (require "flash") :toggle))) 
                                   :desc "Toggle Flash Search"}]})
]
