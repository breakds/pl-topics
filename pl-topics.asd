;;;; pl-topics.asd
;;;; author: breakds@gmail.com (BreakDS)

(asdf:defsystem #:pl-topics
    :serial t
    :depends-on (#:basicl
		 #:stefil)
    :components ((:module "parser"
			  :components
			  ((:file "packages")
			   (:file "scanner")))))
			