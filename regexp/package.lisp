;;;; packages.lisp
;;;; author: breakds@gmail.com (BreakDS)


;;; regular expression
(defpackage #:breakds.pl-topics.regexp
  (:nicknames #:regexp)
  (:use #:cl #:exmac)
  (:export #:disjunction-p
	   #:repetition-p
	   #:sort-regexp-list
	   #:regexp-equal
	   #:simplify-to-wildcard
	   #:simplify-disjunction
	   #:simplify-repetition
	   #:simplify-concatenation
	   #:simplify
	   #:regexp-test))

(defpackage #:breakds.pl-topics.regexp-test
  (:nicknames #:regexp-test)
  (:use #:cl #:stefil #:regexp)
  (:export #:test-all))
  

  
  