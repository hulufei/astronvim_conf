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
     
     ;; Create user commands
     (vim.api.nvim_create_user_command 
       :LuaSnipEdit
       "lua require('luasnip.loaders').edit_snippet_files()"
       {})
     )})
