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
                                     :ignore_filetypes {}}
                    :timeout_ms 1000}
       :servers {}}
 :polish (fn [])}	
