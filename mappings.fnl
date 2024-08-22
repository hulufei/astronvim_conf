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

(fn filter-current-tab-wins [wins]
  ;; Buffer may be loaded in different wins, make sure we get the wins in another tab
  ;;
  ;; TOIMPROVE: If there are multiple other tabs contain target buffer, then which one
  ;; tab will active is unpredictable. (:drop seems to solve the problem partly)
  (local current-wins (vim.api.nvim_tabpage_list_wins 0))
  (icollect [_ win (ipairs wins)]
    (if (fun.index win current-wins) nil win)))

(fn get-win-match-dir [path]
  (local path (vim.fn.expand path))
  (local bufs (list-bufs-match-dir path))
  (unpack (filter-current-tab-wins (list-wins-with-bufs bufs))))

(fn get-win-with-help []
  (local bufs (list-bufs-match-help))
  (unpack (filter-current-tab-wins (list-wins-with-bufs bufs))))

(macro tab-open [get-win do-in-memo-tab do-for-newtab]
  `(let [memo-tab-win# ,get-win]
     (if memo-tab-win# 
       (do
         (vim.fn.win_gotoid memo-tab-win#)
         ,do-in-memo-tab)
       (do
         ,do-for-newtab))))

(fn tab-open-file-in [dir]
  (local telescope (require :telescope.builtin))
  (tab-open (get-win-match-dir dir) nil
            (do
              (vim.cmd.tabnew)
              (vim.cmd.tcd dir)))
  (telescope.find_files))

(fn tab-open-help []
  (local input (uu.get-input "Help> " "help"))
  (if input (tab-open (get-win-with-help)
                      (vim.cmd.help input)
                      (vim.cmd (.. ":tab help " input)))))

(fn tab-open-cmd []
  (local input (uu.get-input "Command> " "command"))
  (if input
    (do
      (local output (vim.fn.execute input))
      (vim.cmd.tabnew)
      (vim.api.nvim_buf_set_lines
        0 0 -1 nil (vim.fn.split output "\n"))
      )))

{:n {";" [":"]
     "Y" ["^y$"] ; Copy entire line without the newline at the end
     :<leader>bn (uu.tx ":tabnew<cr>" {:desc "Create a new tab"})
     :<leader>bt (uu.tx ":%s/\\s\\+$//e<cr>" {:desc "Delete trailing whitespace"})
     :<leader>ct (uu.tx ":tabclose<cr>" {:desc "Close tab"})
     :<leader>ht (uu.tx (fn []
                          (tab-open-help))
                        {:desc "Help in new tab"})
     :<leader>tc (uu.tx (fn []
                          (tab-open-cmd))
                        {:desc "Vim command output in a new tab"})
     :<leader>wc (uu.tx (fn []
                          (tab-open-file-in "~/.config/nvim/lua/user"))
                        {:desc "AstroNvim config in new tab"})
     :<leader>ww (uu.tx (fn []
                          (tab-open-file-in wiki))
                        {:desc "Wiki in new tab"})
     :<leader>w<leader>w (uu.tx (fn []
                                  (local date (os.date "%Y-%m-%d"))
                                  (local diary (.. wiki "/diary/" date ".md"))
                                  (tab-open (get-win-match-dir wiki)
                                            (vim.cmd.edit diary)
                                            (do
                                              (vim.cmd.tabnew diary)
                                              (vim.cmd.tcd wiki))))
                                {:desc "Today's diary in new tab"})}
 :i {"jj" ["<Esc>"]}
 :t {",jj" (uu.tx "<C-\\><C-N>" {:desc "Switch to normal mode"})}}	
