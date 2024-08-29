(local uu (require :user.util))

; Caution: Lazy loading for plugins by default
; see https://docs.astronvim.com/recipes/custom_plugins/

[
 (uu.tx :Olical/nfnl {:ft "fennel"})
 (uu.tx :Olical/conjure {:ft ["clojure" "fennel" "typescript" "javascript"]
                         :config (fn []
                                   ; Rebind it from K to <prefix>gk
                                   (set vim.g.conjure#mapping#doc_word "gk"))})
 (uu.tx :sigmaSd/conjure-deno {:ft ["typescript" "javascript"]})
 (uu.tx :jaawerth/fennel.vim {:ft ["fennel"]})
 (uu.tx :tpope/vim-repeat {:lazy false})
 (uu.tx :dhruvasagar/vim-table-mode {:ft "markdown"})
 (uu.tx {:dir "~/diary.nvim" :lazy false :opts {:diary-dir "~/vimwiki/diary"}})
 (uu.tx :hulufei/backlinks.nvim {:event "BufEnter */vimwiki/*.md"
                                 :config (fn []
                                           (set vim.g.backlinks_search_dir "~/vimwiki")
                                           (set vim.g.backlinks_exclude_pattern "/assets/")
                                           (vim.keymap.set :n ",b" (. (require :backlinks) :find_files_back_linked) {:desc "Search backlinks"}))})
 (uu.tx :monkoose/nvlime {:ft "lisp"
                          :dependencies [:monkoose/parsley]
                          :init (fn []
                                  (set vim.g.nvlime_config {:implementation "sbcl"
                                                            ; :compiler_policy {:DEBUG 3 :SPEED 0}
                                                            :cmp {:enabled true}})
                                  (set vim.g.nvlime_mappings {:lisp {:normal {:load_file "<LocalLeader>sl"
                                                                              :repl {:show "<LocalLeader>so"
                                                                                     :clear "<LocalLeader>sC"}}}})
                                  (local cmp (require :cmp))
                                  ;; Note: file-specify cmp override global sources, instead of extending
                                  (cmp.setup.filetype [:lisp] {:sources [{:name "nvlime"}
                                                                         {:name "luasnip"}
                                                                         {:name "buffer"}
                                                                         {:name "path"}]}))})
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
 (uu.tx :olimorris/codecompanion.nvim
        {:lazy false
         :dependencies ["nvim-lua/plenary.nvim" "nvim-treesitter/nvim-treesitter"]
         :config
         (fn []
           (local codecompanion (require :codecompanion))
           (codecompanion.setup
              {:strategies {:chat {:adapter "gemini"}
                            :inline {:adapter "gemini"}
                            :agent {:adapter "gemini"}}
               :adapters
               {:gemini
                (fn []
                  (let [adapters (require "codecompanion.adapters")]
                    (adapters.extend
                      "gemini" {:env {:api_key (os.getenv "GEMINI_API_KEY")}})))}
               }))
         })
]
