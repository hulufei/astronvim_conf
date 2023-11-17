(local fun (require :user.vendor.fun))

(fn autoload [name]
  "Like autoload from Vim Script! A replacement for require that will load the
  module when you first use it. Use it in Aniseed module macros with:

  (module foo {autoload {foo x.y.foo}})

  It's a drop in replacement for require that should speed up your Neovim
  startup dramatically. Only works with table modules, if the module you're
  requiring is a function etc you need to use the normal require.
  
  Copied from https://github.com/Olical/aniseed"
  (let [res {:aniseed/autoload-enabled? true :aniseed/autoload-module false}]
    (fn ensure []
      (if (. res :aniseed/autoload-module)
          (. res :aniseed/autoload-module)
          (let [m (require name)]
            (tset res :aniseed/autoload-module m)
            m)))

    (setmetatable
      res
      {:__call (fn [_t ...]
                 ((ensure) ...))
       :__index (fn [_t k]
                  (. (ensure) k))
       :__newindex (fn [_t k v]
                     (tset (ensure) k v))})))


(fn last [xs]
  (fun.nth (fun.length xs) xs))

(fn reverse [xs]
  (let [len (fun.length xs)]
    (fun.take
      (fun.length xs)
      (fun.tabulate (fn [n]
                      (fun.nth (- len n) xs))))))

;; Slightly nicer syntax for things like defining dependencies.
;; Anything that relies on the {1 :foo :bar true} syntax can use this.
(fn tx [...]
  (let [args [...]
        len (fun.length args)]
    (if (= :table (type (last args)))
      (fun.reduce
        (fn [acc n v]
          (tset acc n v)
          acc)
        (last args)
        (fun.zip (fun.range 1 len) (fun.take (- len 1) args)))
      args)))

(fn get-input [prompt completion]
  ; Modified get_input to support completion option
  ; https://github.com/kylechui/nvim-surround/blob/main/lua/nvim-surround/input.lua
  (let [(ok result) (pcall vim.fn.input {: prompt
                                         : completion
                                         :cancelreturn vim.NIL})]
    (if (and ok (not= result vim.NIL)) result)))

(fn get-vselect-text []
  ;; Get visual selected text
  ;; Type: nil -> string
  ;; Constraint: only works for one line
  (local (_ row start) (unpack (vim.fn.getpos "'<")))
  (local (_ _ end) (unpack (vim.fn.getcharpos "'>"))) ; End char may be an unicode char
  (local row (- row 1)) ; getpos return index-1 base, nvim_buf_get_text index-0 base
  (local start (- start 1))
  (local end (vim.fn.byteidx
               (unpack (vim.api.nvim_buf_get_lines 0 row (+ row 1) nil))
               end)) ; Convert charidx to byteidx
  (unpack (vim.api.nvim_buf_get_text 0 row start row end [])))

{: autoload
 : tx
 : get-input
 : get-vselect-text
 : last
 : reverse}
