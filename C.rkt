(include "scheme-cw-template.rkt")

;; Iterating through the list:

(define (iterate-list lst)
  (if (null? lst)
      '(and thats it...) ;; displays - end of the list and gets rid of an error - caused by an empty space at the end
      (begin
        (display (car (car lst))) ;; goes into the nested list to get the names out
        (newline)
        (iterate-list (cdr lst)))))



;; C1 - Danna
(define lst-mb (lambda () (iterate-list Mb)))



;; C2 - Mikolaj - This function returns a list of all members in the paternal branch.
(define lst-pb (lambda () (iterate-list Pb)))



;; C3 - Mikolaj - This function returns a list of all members of both branches
(define (append-lst list1 list2)
        (if (null? list1)
            list2
            (cons (car list1) (append-lst (cdr list1) list2))))

(define lst-comb (lambda () (iterate-list (append-lst Pb Mb))))