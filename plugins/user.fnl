(local uu (require :user.util))

; Caution: Lazy loading for plugins by default
; see https://docs.astronvim.com/recipes/custom_plugins/
[
 (uu.tx :Olical/nfnl {:ft "fennel"})
 (uu.tx :Olical/conjure {:ft ["clojure" "fennel"]})
 (uu.tx :jaawerth/fennel.vim {:ft ["fennel"]})
 (uu.tx :tpope/vim-repeat {:lazy false})
 (uu.tx :hulufei/backlinks.nvim {:event "BufEnter */vimwiki/*.md"
                                 :config (fn []
                                           (set vim.g.backlinks_search_dir "~/vimwiki")
                                           (set vim.g.backlinks_exclude_pattern "/assets/")
                                           (vim.keymap.set :n ",b" (. (require :backlinks) :find_files_back_linked) {:desc "Search backlinks"}))})
 (uu.tx :monkoose/nvlime {:ft "lisp"
                          :dependencies [:monkoose/parsley]
                          :init (fn []
                                  ; (vim.keymap.set :n 
                                  ;                 ",cr"
                                  ;                 ":call nvlime#plugin#ConnectREPL('127.0.0.1', 7002, 'sftp://watney@mars-hab/', 3000)<cr>"
                                  ;                 {:desc "Connect to remote server"})
                                  (set vim.g.nvlime_config {:implementation "ccl"}))})
 (uu.tx :folke/flash.nvim {:event "VeryLazy"
                           :opts []
                           :keys [{1 "S"
                                   :mode ["n" "x" "o"] 
                                   2 (fn []  ((. (require "flash") :treesitter)))
                                   :desc "Flash Treesitter"}
                                  {1 "r" ; Operator on remote (not current position, restore cursor position after operating)
                                   :mode "o" ; Operator-pending mode see :h mode-o
                                   2 (fn [] ((. (require "flash") :remote)))
                                   :desc "Remote Flash"}
                                  {1 "R"
                                   :mode ["x" "o"] 
                                   2 (fn []  ((. (require "flash") :treesitter_search))) 
                                   :desc "Treesitter Search"}
                                  {1 "<c-s>" 
                                   :mode ["c"] ; Command-line mode, see :h mode-c
                                   2 (fn []  ((. (require "flash") :toggle))) 
                                   :desc "Toggle Flash Search"}]})
]
