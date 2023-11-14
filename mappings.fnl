(local uu (require :user.util))

(local wiki "~/vimwiki")

(fn tab-open-file-in [dir]
  (local telescope (require :telescope.builtin))
  (vim.cmd.tabnew)
  (vim.cmd.tcd dir)
  (telescope.find_files))

; (fn fix-link-in-file [filename]
;   ; Wrap links with whitespace with <> to be valid
;   (with-open [f (io.open filename :r+)]
;     (local pattern "(%[[^]]+%])%(([^<)]+[%s]+[^>)]+)%)")
;     (local replace-link (fn [s]
;                           (string.gsub s pattern "%1(<%2>)")))
;     (local newcontent (vim.fn.join 
;                         (icollect [line (f:lines)]
;                           (replace-link line))
;                         "\n"))
;     (f:seek "set") ; Go to beginning
;     (f:write newcontent)))
;
; (each [_ file (ipairs (vim.fn.glob (.. wiki "/**/*.md") nil true true))]
;   (print file)
;   (fix-link-in-file file))

{:n {";" [":"]
     :<leader>bn (uu.tx ":tabnew<cr>" {:desc "Create a new tab"})
     :<leader>bt (uu.tx ":%s/\\s\\+$//e<cr>" {:desc "Delete trailing whitespace"})
     :<leader>ht (uu.tx ":tab help " {:desc "Help in new tab"})
     :<leader>ct (uu.tx ":tabclose<cr>" {:desc "Close tab"})
     :<leader>wc [(fn []
                    (tab-open-file-in "~/.config/nvim/lua/user"))]
     :<leader>ww [(fn []
                    (tab-open-file-in wiki))]
     :<leader>w<leader>w [(fn []
                            ; Create a new diary
                            (local date (os.date "%Y-%m-%d"))
                            (vim.cmd.tabnew (.. wiki "/diary/" date ".md"))
                            (vim.cmd.tcd wiki))]}
 :t {",jj" (uu.tx "<C-\\><C-N>" {:desc "Switch to normal mode"})}}	
