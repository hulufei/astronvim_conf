(local uu (require :user.util))
(local fun (require :user.vendor.fun))

(local wiki "~/vimwiki")

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

(fn get-tabpage-by-win [id]
  (if id
    (unpack (icollect [_ tab (ipairs (vim.api.nvim_list_tabpages))]
              (if (and (vim.api.nvim_tabpage_is_valid tab)
                       (fun.index id (vim.api.nvim_tabpage_list_wins tab)))
                tab)))))

(fn list-bufs-match [test]
  (icollect [_ buf (ipairs (vim.api.nvim_list_bufs))]
              (if (and (vim.api.nvim_buf_is_loaded buf)
                       (test buf))
                buf)))

(fn list-bufs-match-dir [path]
  (list-bufs-match (fn [buf]
                     (string.find (vim.api.nvim_buf_get_name buf) path 1 true))))

(fn list-bufs-match-help []
  (list-bufs-match (fn [buf]
                     (= (vim.api.nvim_buf_get_option buf "filetype") "help"))))

(fn list-wins-with-bufs [bufs]
  (if (unpack bufs)
    (icollect [_ win (ipairs (vim.api.nvim_list_wins))]
      (if (and (vim.api.nvim_win_is_valid win)
               (fun.index (vim.api.nvim_win_get_buf win) bufs))
        win))
    []))

(fn get-tabpage-match-dir [path]
  (local path (vim.fn.expand path))
  (local bufs (list-bufs-match-dir path))
  (local win (unpack (list-wins-with-bufs bufs))) ; First window is enough
  (get-tabpage-by-win win))

(fn get-tabpage-with-help []
  (local bufs (list-bufs-match-help))
  (local win (unpack (list-wins-with-bufs bufs)))
  (get-tabpage-by-win win))

(macro tab-open [get-tab do-in-activetab do-in-newtab]
  `(let [activetab# ,get-tab]
     (if activetab# 
       (do
         (vim.cmd (..  ":tabnext" (vim.api.nvim_tabpage_get_number activetab#)))
         ,do-in-activetab)
       (do
         (vim.cmd.tabnew)
         ,do-in-newtab))))

(fn tab-open-file-in [dir]
  (local telescope (require :telescope.builtin))
  (tab-open (get-tabpage-match-dir dir)
            nil
            (vim.cmd.tcd dir))
  (telescope.find_files))

(fn tab-open-help []
  (local input (uu.get-input "Help> " "help"))
  (if input (tab-open (get-tabpage-with-help)
                      (vim.cmd.help input)
                      (vim.cmd.help input))))

{:n {";" [":"]
     :<leader>bn (uu.tx ":tabnew<cr>" {:desc "Create a new tab"})
     :<leader>bt (uu.tx ":%s/\\s\\+$//e<cr>" {:desc "Delete trailing whitespace"})
     :<leader>ct (uu.tx ":tabclose<cr>" {:desc "Close tab"})
     :<leader>ht [(fn []
                    (tab-open-help))]
     :<leader>wc [(fn []
                    (tab-open-file-in "~/.config/nvim/lua/user"))]
     :<leader>ww [(fn []
                    (tab-open-file-in wiki))]
     :<leader>w<leader>w [(fn []
                            (local date (os.date "%Y-%m-%d"))
                            (local diary (.. wiki "/diary/" date ".md"))
                            (tab-open (get-tabpage-match-dir wiki)
                                      (vim.cmd.edit diary)
                                      (vim.cmd.tcd wiki)))]}
 :t {",jj" (uu.tx "<C-\\><C-N>" {:desc "Switch to normal mode"})}}	
