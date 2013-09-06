;;;; pl-topics.asd
;;;; author: breakds@gmail.com (BreakDS)

(asdf:defsystem #:pl-topics
    :serial t
    :depends-on (#:basicl)
    :components ((:file "packages")
                 (:file "regexp/regexp")))