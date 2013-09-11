;;;; regexp-test.lisposetfil:
;;;; author: breakds@gmail.com (BreakDS)
;;;; Unit test for regexp

(in-package :breakds.pl-topics.regexp-test)


(defsuite* (test-all :in root-suite 
		     :documentation "test regular expression routines"))

(in-suite test-all)


;; test disjunction-p
(deftest test-disjunction-p (rexp &optional (expected t))
  (is (eq (disjunction-p rexp) expected)))

(deftest test-disjunction-p-cases ()
  (every #'test-disjunction-p
	 '((or #\a #\b)
	   (or (#\a #\b) (#\c #\d))))
  (every (lambda (x) (test-disjunction-p x nil))
	 '((#\a #\b #\c)
	   (+ #\a)
	   (* (#\a #\a)))))



    