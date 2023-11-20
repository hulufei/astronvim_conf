(local uu (require :user.util))

(uu.tx
  :hrsh7th/nvim-cmp
  {:config (fn [_config opts]
             (local cmp (require :cmp))
             (table.insert opts.sources {:name "nvlime"})
             (cmp.setup.filetype [:lisp] {:sources opts.sources}))})
