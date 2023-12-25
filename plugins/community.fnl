(local uu (require :user.util))
(local fun (require :user.vendor.fun))

[
 (uu.tx :AstroNvim/astrocommunity)
 (uu.tx {:import "astrocommunity.pack.rust"})
 (uu.tx {:import "astrocommunity.pack.lua"})
 (uu.tx {:import "astrocommunity.pack.typescript-all-in-one"})
 (uu.tx {:import "astrocommunity.pack.markdown"})
 (uu.tx {:import "astrocommunity.markdown-and-latex.peek-nvim"})
 (uu.tx {:import "astrocommunity.motion.nvim-surround"})
 (uu.tx {:import "astrocommunity.motion.leap-nvim" :enabled false})
 (uu.tx {:import "astrocommunity.note-taking.obsidian-nvim" :enabled false})
 ; Further customize the options set by the community
 (uu.tx :nvim-treesitter/nvim-treesitter
        {:opts (fn [_ opts]
                ; Remove unsure installed treesitter parsers
                 (each [index value (ipairs opts.ensure_installed)]
                   (if (fun.index value [:luap])
                    (table.remove opts.ensure_installed index))))})
 (uu.tx :epwalsh/obsidian.nvim
        {:enabled false
         :event [( .. "BufReadPre " vim.env.HOME "/vimwiki/*.md" )]
         :opts {:dir "~/vimwiki"}})
 (uu.tx :toppair/peek.nvim
        {:config (fn []
                   (local peek (require "peek"))
                   (peek.setup {:app "browser"})
                   (vim.api.nvim_create_user_command "PeekOpen" peek.open {})
                   (vim.api.nvim_create_user_command "PeekClose" peek.close {})
                   )})
]
