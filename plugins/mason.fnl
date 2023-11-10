(local uu (require :user.util))
(local fun (require :user.vendor.fun))

[
 (uu.tx :williamboman/mason-lspconfig.nvim
        {:opts (fn [_ opts]
                 (local utils (require :astronvim.utils))
                 (set opts.ensure_installed
                       (utils.list_insert_unique
                         opts.ensure_installed 
                         [:fennel_language_server])))})
 (uu.tx :jay-babu/mason-null-ls.nvim
        {:opts (fn [_ opts]
                 ; Remove unsure installed tools
                 (set opts.ensure_installed
                       (fun.filter (fn [v] (not (fun.index v [:luacheck])))
                         opts.ensure_installed)))})
]
