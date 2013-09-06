;;;; regexp.lisp
;;;; author: breakds@gmail.com (BreakDS)

(in-package :breakds.pl-topics.regexp)


;;; Representation of Regular Expression

;; regexp = nil (epsilon)
;;        | Character Character ....
;;        | (+ regexp) <- 1 or many occurences
;;        | (* regexp) <- 0 or many occurences
;;        | (or regexp regexp ...) <- or list



;;; Regular Expression Simplification

;; rules:
;; 1. (or (* x) nil) -> (* x)
;; 2. (or (+ x) nil) -> (* x)

(defun disjunction-p (rexp)
  (eq (car rexp) 'or))

(defun repetition-p (rexp)
  (member (car rexp) '(+ *)))



(defun sort-regexp-list (rexp-list)
  (sort rexp-list #'string> :key #'mkstr))       

(defun regexp-equal (rexp-a rexp-b)
  "Return true if identical and false otherwise. Assuming already
normalized (simplified) regular expressions."
  (or (and (atom rexp-a)
           (eq rexp-a rexp-b))
      (and (consp rexp-a)
           (consp rexp-b)
           (= (length rexp-a) (length rexp-b))
           (or (and (disjunction-p rexp-a)
                    (disjunction-p rexp-b)
                    (every #'regexp-equal
                           (tail rexp-a)
                           (tail rexp-b)))
               (and (repetition-p rexp-a)
                    (eq (car rexp-a) (car rexp-b))
                    (regexp-equal (cadr rexp-a)
                                  (cadr rexp-b)))
               (every #'regexp-equal rexp-a rexp-b)))))
           
           
(defun simplify-to-wildcard (rexp)
  "Handle rules 1 and 2"
  (let ((a (and (cadr rexp) (caddr rexp)))
        (b (or ((cadr rexp) (caddr rexp)))))
    (and (not a)
         (= (length rexp) 3)
         (member (car b) '(+ *))
         `(* ,(cadr b)))))


(defun simplify-disjunction (rexp)
  (when (disjunction-p rexp)
    (let* ((tail (mapcar #'simplify (rest rexp)))
           (prelim (cons 'or 
                         (remove-duplicates tail
                                            #'regexp-equal))))
      (or (simplify-to-wildcard prelim)
          prelim))))
      
(defun simplify-repetition (rexp)
  (when (repetition-p rexp)
    (cons (car rexp)
          (simplify (cadr rexp)))))

(defun simplify-concatenation (rexp)
  (mapcar #'simplify rexp))
             
(defun simplify (rexp)
  (if (atom rexp)
      rexp
      (or (simplify-disjunction rexp)
          (simplify-repetition rexp)
          (simplify-concatenation rexp))))




;; TODO (breakds) unit-test