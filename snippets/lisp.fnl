[
 (s {:trig "slot" :desc "Slot property definition"}
    (fmta "(<k>
  :accessor <k>
  :initarg :<k>)" 
          {:k (i 1 "name")}
          {:repeat_duplicates true}))
 (s {:trig "clp" :desc "Generate modern project skeletons"}
    (fmta "
          ;; https://github.com/fukamachi/cl-project
          (ql:quickload :cl-project)
          (cl-project:make-project 
            #p\"<>\"
            :name \"<>\"
            :depends-on <>)
          " [(i 1 ".") (i 2 "project-name") (i 3 "'(:clack :cl-annot)")]))
 (s {:trig "defp" :desc "Define package"}
    (fmta "(defpackage :<k>
  (:use :cl))
    
(in-package :<k>)"
          {:k (i 1 "name")}
          {:repeat_duplicates true}))
 ]
