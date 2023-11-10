(local uu (require :user.util))

; Caution: Lazy loading for plugins by default
; see https://docs.astronvim.com/recipes/custom_plugins/
[
 (uu.tx :Olical/nfnl {:ft "fennel"})
 (uu.tx :Olical/conjure {:ft ["clojure" "fennel"]})
 (uu.tx :jaawerth/fennel.vim {:ft ["fennel"]})
 (uu.tx :tpope/vim-repeat {:lazy false})
 (uu.tx :tpope/vim-surround {:keys ["c" "d" "y" "v"]})
]
