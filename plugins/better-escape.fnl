(local uu (require :user.util))

(uu.tx
  :max397574/better-escape.nvim
  {:config (fn []
             (local bs (require "better_escape"))
             (bs.setup
               ;; Remove default jk, reserved for luasnip
               {:mapping ["jj"]}))})
