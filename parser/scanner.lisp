(defun letter-p (ch)
  (or (lower-case-p ch) (upper-case-p ch)))

(defun number-p (ch)
  (and (char>= ch #\0)
       (char>= #\9 ch)))

(defun stack-buf-input (input-stream)
  (let ((stream input-stream)
	(buffer nil))
    (lambda (&optional (character nil))
      (if character
	  (push character buffer) ;; return a character back
	  (if buffer ;; consume a character
	      (pop buffer)
	      (read stream))))))

(defun single-character-picker (target)
  (alambda (buf-stream)
    (let ((ch (funcall buf-stream)))
      (if (eq ch target)
	  '(:character target)
	  (progn (funcall buf-stream ch)
		 nil)))))

(defun single-predicate-picker (name-keyword test)
  (alambda (buf-stream &optional (accu nil))
    (let ((ch (funcall buf-stream)))
      (if (funcall test ch)
	  (self buf-stream (cons ch accu))
	  (progn (funcall buf-stream ch)
		 (list name-keyword
		       (cons (reverse accu)
			     'string)))))))

(defun character-set-picker (name-keyword &rest targets)
  (single-predicate-picker name-keyword
			   (lambda (ch)
			     (member ch targets))))

(defun space-picker ()
  (character-set-picker :space 
			#\Space #\Tab
			#\Return #\Newline))

(defun simple-identifier-picker ()
  (lambda (buf-stream)
    (let ((ch (funcall buf-stream)))
      (if (letter-p ch)
	  (funcall (single-predicate-picker :simple-identifier
					    (lambda (x)
					      (or (letter-p x)
						  (number-p x))))
		   buf-stream 
		   ch)
	  (progn (funcall buf-stream ch)
		 nil)))))

(defun create-scanner (input-stream &rest pickers)
  (let ((buffer nil)
	(buf-stream (stack-buf-input)))
    (alambda (&optional (token nil))
      (if token 
	  (push token buffer)
	  (progn (loop 
		    for picker in pickers
		    for new-token = (picker buf-stream)
		    when new-token
		    return new-token)
		 nil)))))

		   
					 
	  
	
		
	
	
      
	