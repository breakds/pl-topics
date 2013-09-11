;;;; pl-topics.asd
;;;; author: breakds@gmail.com (BreakDS)

(asdf:defsystem #:pl-topics
    :serial t
    :depends-on (#:basicl
		 #:stefil)
    :components ((:module "regexp" 
                          :components
                          ((:file "package")
                           (:file "regexp")
                           (:file "regexp-test")))))
			