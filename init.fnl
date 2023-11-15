(local uu (require :user.util))

{:updater {:auto_quit false
           :branch :nightly
           :channel :stable
           :commit nil
           :pin_plugins nil
           :remote :origin
           :remotes {}
           :show_changelog true
           :skip_prompts false
           :version :latest}
 :colorscheme :astrodark
 :diagnostics {:underline true :virtual_text true}
 :lazy {:defaults {:lazy true}
        :performance {:rtp {:disabled_plugins [:tohtml
                                               :gzip
                                               :matchit
                                               :zipPlugin
                                               :netrwPlugin
                                               :tarPlugin]}}}
 :lsp {:config {:fennel_language_server (fn []
                                          (local lspconfig (require :lspconfig))
                                          {:cmd [:fennel-language-server]
                                           :filetypes [:fennel]
                                           :root_dir (lspconfig.util.root_pattern "fnl")
                                           :settings {:fennel {:diagnostics {:globals ["vim"]}
                                                               :workspace {:library (vim.api.nvim_list_runtime_paths)}}}
                                           :single_file_support true})}
       :formatting {:disabled {}
                    :format_on_save {:allow_filetypes {}
                                     :enabled true
                                     :ignore_filetypes ["markdown"]}
                    :timeout_ms 1000}
       :servers {}}
 :polish (fn []
           (local group (vim.api.nvim_create_augroup "md_augroup" {:clear true}))
           (vim.api.nvim_create_autocmd "FileType" {:pattern "markdown"
                                                    :group group
                                                    :callback (fn [_args]
                                                                (vim.opt.formatoptions:append "cmB") ; Make `gw` works for cjk, m - Also break at a multi-byte character above 255.

                                                                ; -- It basically jumps to the previous spelling mistake [s,
                                                                ; -- then picks the first suggestion 1z=, and then jumps back `]a.
                                                                ; -- The <c-g>u in the middle make it possible to undo the spelling correction quickly.
                                                                (vim.keymap.set "i" "<C-l>" "<c-g>u<Esc>[s1z=`]a<c-g>u")

                                                                (set vim.o.spell true) ; Enable spell
                                                                (set vim.o.conceallevel 2) ; Enable conceal

                                                                ; Add surround with link
                                                                ; https://github.com/kylechui/nvim-surround/discussions/53#discussioncomment-3134891
                                                                (local surround (require "nvim-surround"))
                                                                (surround.buffer_setup {:surrounds {"l" {:add (fn [] ; [text](link)
                                                                                                                (local link (uu.get-input "Enter the link:" "file"))
                                                                                                                (if link [["["] [(.. "](" link ")")]]))
                                                                                                         :find "%b[]%b()"
                                                                                                         :delete "^(%[)().-(%]%b())()$"
                                                                                                         :change {:target "^()()%b[]%((.-)()%)$"
                                                                                                                  :replacement (fn [] [[""] [""]])}}
                                                                                                    "s" {:add (fn [] [[:**] [:**]]) ; **strong**
                                                                                                         :find "%*%*.-%*%*"
                                                                                                         :delete "^(%*%*)().-(%*%*)()$"}}}))}))}
