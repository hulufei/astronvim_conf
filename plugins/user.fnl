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
                                  (set vim.g.nvlime_config {:implementation "ccl"
                                                            :cmp {:enabled true}})
                                  ;; Remap to solve keymap override (mostly by sexp)
                                  (set vim.g.nvlime_mappings {:lisp {:normal {:load_file "<LocalLeader>sl"}}})
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
 (uu.tx :Robitx/gp.nvim {:event "VeryLazy"
                         :enabled false
                         :config (fn []
                                   (local gp (require "gp"))
                                   (gp.setup {:openai_api_key (os.getenv "OPENAI_API_KEY")
                                              :curl_params ["--proxy" "socks5h://localhost:10800"]
                                              :chat_model {:model "gpt-3.5"}}))})
]
