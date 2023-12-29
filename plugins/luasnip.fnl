(local uu (require :user.util))

(uu.tx
  :L3MON4D3/LuaSnip
  {:config 
   (fn [plugin opts]
     (local config (require "plugins.configs.luasnip"))
     (local ls (require "luasnip"))
     (local loader (require "luasnip.loaders.from_lua"))
     
     (config plugin opts) ; include the default astronvim config that calls the setup call
     (loader.lazy_load 
       {:paths ["./lua/user/snippets"]
        :fs_event_providers {:autocmd true
                             :libuv true}})

     (ls.filetype_extend :tex [:katex])
     (ls.filetype_extend :markdown [:tex :katex :html])

     ;; Since we write snippets in fnl, auto reload will not work
     (vim.keymap.set
       "n" "<leader>sr"
       (fn []
         (local loader (require "luasnip.loaders"))
         (loader.reload_file 
           (.. (vim.fn.expand "%:p:r") ".lua")))
       {:desc "Reload current snippet file"})
     
     ;; Create user commands
     (vim.api.nvim_create_user_command 
       :LuaSnipEdit
       "lua require('luasnip.loaders').edit_snippet_files()"
       {})
     )})
