(defconstant *ebnf-ast* `(syntax (production syntax = { production } .)
				 (production production = 
					     identifier "="
					     expression ".")
				 (production expression = term {
					     "|" term } .)
				 (production term = factor
					     { factor } .)
				 (production factor =
					     identifier \|
					     

					     
					     
					       
					       
