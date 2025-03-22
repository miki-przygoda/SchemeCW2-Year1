;;A:
(include "scheme-cw-template.rkt")
(require racket/date)

;Function that makes the user decides which branch would the function be executed in, it is called in all the functions

(define (which-branch)
  (display "Which branch of the family would you like to see?")
  (newline)
  (display "1. Paternal")
  (newline)
  (display "2. Maternal")
  (newline)
  (define read-input (read))
  read-input)

;; A1:
;; This function should return a list of all the parents in the branch. (function parents).


(define (parents)
  (let ((opt (which-branch)))
    (cond
      [(= opt 1)
       (find-parents Pb)]
      [(= opt 2)
       (find-parents Mb)]
      [else
       (display "invalid option, please try again")
       (newline)
       (parents)]
      )))

;I made a separate function that access the second element of each sublist
;called from the main function (parents), so each branch of the tree is accessed separately
(define (find-parents lst) 
  (cond
    [(empty? lst) 'done]
    [(empty? (cadr (cadr (car lst))))
     (remove (cadr (car lst)) lst)
     (find-parents (cdr lst))]
    [else
     (display (cadr (car lst)))  ;each person displays parents, so 
     (newline)                   ;parents with more than one child will appear multiple times
     (find-parents (cdr lst))]))

;; A2:
;; This function should return all living members of the branch. (function living-members).

(define (living-members)
  (define (members lst)
    (cond
      [(empty? lst) 'done]
      [(empty? (cadr (car (reverse (car lst))))); checks if the person has a date of death 
       (display (car (car lst))) ; if they don't, it means they are alive so display name
       (newline)
       (members (cdr lst))]
      [else
       (remove (car lst) lst) ; if they do, delete and continue with the rest of the branch
       (members (cdr lst))]))
      
  (let ((opt (which-branch)))
    (cond
      [(= opt 1)(members Pb)]
      [(= opt 2)(members Mb)]
      [else
       (display "invalid option, please try again")
       (newline)
       (living-members)])))

  
;; A3:
;; This function should return a list of the current age of all living members. (function current-age).

(define (current-age)
  (define (birthday lst)
    (let(
         (day (date-day (current-date)))     ; I used chatGPT to learn about integrated functions to get current date in Racket
         (month (date-month (current-date)))
         (year (date-year (current-date))))
      (cond
        [(empty? lst) 'done]
        [else
         (let(
               (birth-month (cadr (car (car (reverse (car lst))))))   ;I assigned names to those positions in the list
               (birth-day (car (car (car (reverse (car lst))))))      ;so that I could compare the numbers later on
               (birth-year (car (reverse (car (car (reverse (car lst))))))))
            (cond
              [(empty? (cadr (car (reverse (car lst)))))   ;checks if date of death is empty, if it is that means person is alive
               (cond
                 [(< month birth-month)
                  (display (car (car lst)))
                  (display " ")
                  (display (- year birth-year))
                  (newline)
                  (birthday (cdr lst))]
                 [(and (= month birth-month) (<= day birth-day))
                  (display (car (car lst)))
                  (display (- year birth-year))
                  (newline)
                  (birthday (cdr lst))]
                 [else
                  (display (car (car lst)))
                  (display (- (- year birth-year) 1))
                  (newline)
                  (birthday (cdr lst))])]
              [else
               (remove (car lst) lst)
               (birthday (cdr lst))]))])))
      
  (let ((opt (which-branch)))
    (cond
      [(= opt 1)(birthday Pb)]
      [(= opt 2)(birthday Mb)]
      [else
       (display "invalid option, please try again")
       (newline)
       (current-age)])))
;; A4:
;; This function should return a list of all members who have birthdays in the same month as your birthday. (function same-birthday-month).

(define (same-birthday-month)    ;This function checks for the people in the branch with their birthday in December
  (define (birthday lst)         ;This is my Birthday Month
    (cond
      [(empty? lst) 'done]
      [else
       (let ((birth-month (cadr (car (car (reverse (car lst)))))))
         (cond
           [(= birth-month 12)
            (display (car (car lst)))
            (newline)
            (birthday (cdr lst))]
           [else
            (remove (car lst) lst)
            (birthday (cdr lst))]))]))
  (let ((opt (which-branch)))
    (cond
      [(= opt 1)(birthday Pb)]
      [(= opt 2)(birthday Mb)]
      [else
       (display "invalid option, please try again")
       (newline)
       (same-birthday-month)])))
  
;; A5:
;; This function should return a sorted list of all members in your branch. Sort the members by their last names. (function sort-by-last)

(define (sort-by-last)
  (define new-list '())
  (define (names lst)
    (cond
      [(null? lst)
       (set! new-list         ;set it is used to maintain the new-list every time something is modified
             (sort new-list   ;compares two adjacent last names repeats until the whole list is sorted
                   (lambda (a b)
                     (string<? (symbol->string (cadr a))   ; all elements in the list are symbols, but they need to be strings
                               (symbol->string (cadr b)))))); in order to be compared and sorted, so the last names are converted to string
       new-list]
      [else
       (let ((full-name (car (car lst))))
         (set! new-list (append new-list (list full-name))) 
         (names (cdr lst)))]))
  (let ((opt (which-branch)))
    (cond
      [(= opt 1)(names Pb)]
      [(= opt 2)(names Mb)]
      [else
       (display "invalid option, please try again")
       (newline)
       (sort-by-last)]))
  )

  
;; A6:
;; This function should return a new family tree changing the name of any member of the family with the first name of John to Juan. (function change-name-to-Juan)

(define (change-name-to-Juan)
  (define (new-name lst)
    (cond
      [(empty? lst) 'done]
      [else
       (let ((full-name (car (car lst))))
         (cond
           [(equal? 'John (car full-name)) ;if name is John then display the name as Juan (last name)
            (display 'Juan)                ;if name is not John display the name and continue with list
            (display " ")
            (display (cadr full-name))
            (newline)
            (new-name (cdr lst))]
           [else
            (display full-name)
            (newline)
            (new-name (cdr lst))]))]))
  
  (let ((opt (which-branch)))
    (cond
      [(= opt 1)(new-name Pb)]
      [(= opt 2)(new-name Mb)]
      [else
       (display "invalid option, please try again")
       (newline)
       (change-name-to-Juan)]))

  )

