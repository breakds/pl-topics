;;;; packages.lisp
;;;; packages for the parser

(defpackage #:breakds.pl-topics.parser.scanner
  (:nicknames #:parser.scanner)
  (:use #:cl #:basicl.swiss-knife)
  (:export #:character-p
	   #:number-p
	   #:stack-buf-input
	   #:single-character-picker
	   #:single-predicate-picker
	   #:character-set-picker
	   #:space-picker
	   #:simple-identifier-picker
	   #:create-scanner))
