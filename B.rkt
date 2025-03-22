(require racket/string)
(include "scheme-cw-template.rkt")

;;B:

(define (average lst) ;; used to find the average
  (if (null? lst) ;; cannot find an average of an empty list so if it is
      0 ;; should return nothing
      (/ (apply + lst) (length lst)))) ;; returns an average -- all elements / number of all elements

(define (earlier-date? dob1 dob2) ;; Used to compare dates
  (let* ((day1 (car dob1)) ;days
         (month1 (cadr dob1)) ;months
         (year1 (caddr dob1)) ;years
         
         (day2 (car dob2)) ;days
         (month2 (cadr dob2)) ;months
         (year2 (caddr dob2))) ;years
    (or (< year1 year2)
        (and (= year1 year2) (< month1 month2))
        (and (= year1 year2) (= month1 month2) (< day1 day2)))))

(define (add-items lst)
  (let ((avrg (average lst)))  ; compute the average using function (average)
    (map (lambda (x) avrg) lst)))  ; replace each element with the average

(define (convrt-days date)
  ;; e.g. input => '(14 2 1972) output => date in days - 1972.2027397260274
  (let* ((day (car date))
         (month (cadr date))
         (year (caddr date)))
    (/ (+ day (+ (* month 30) (* year 365))) 365.0)))



;; B1 - Mikolaj

;; This function should return a list of all the children in the branch. (function children) -- if has parents -- is child
(define (is-child lst)
  (let loop ((remaining lst))
    (if (null? remaining)
        (begin
          (display "\nand that's it...\n"))
        (let* ((person (car remaining))
               (name (car person))
               (parents (cadr person))  ;; Extract parents structure ((Mother) (Father))
               (mother (car parents))   ;; Extract Mother's sublist
               (father (cadr parents))  ;; Extract Father's sublist
               (has-parents? (or (not (null? mother)) (not (null? father)))))  ;; Check if either parent exists
          (if has-parents?
              (newline))
          (if has-parents?
              (display name))
          (if has-parents?
              (display " has parents, therfore is a child.")) ;; if a person has parents they are a child
          (loop (cdr remaining))))))



;; B2 - Mikolaj
;; This function should return the oldest living member to date of your branch. (function oldest-living-member)
(define (oldest-living-member lst)
  (let loop ((remaining lst)
             (oldest-person #f)  ;; Store the oldest living person
             (oldest-dob #f))    ;; Store DOB of oldest living person
    (if (null? remaining)
        (begin
          (display "\nThe oldest living person is: ")
          (if oldest-person
              (begin
                (display (car oldest-person)) ;; Print name for the oldest person
                (display " (born ")
                (display oldest-dob)
                (display ")"))
              (display "No living members found."))
          (newline))
        (let* ((person (car remaining))
               (name (car person))
               (dates (caddr person))
               (dob (car dates))
               (dod (cadr dates))
               (is-alive (null? dod)))  ;; Alive if DOD is empty list ()
          (display name)
          (display " ")
          (display dob)
          (display " ")
          (display dod)
          (newline)
          (if (and is-alive
                   (or (not oldest-dob) (earlier-date? dob oldest-dob)))
              (loop (cdr remaining) person dob) ;; Update oldest person
              (loop (cdr remaining) oldest-person oldest-dob))))))



;; B3 - Mikolaj
;; This function should return the average age on death of members of your branch. (function average-age-on-death)
(define (average-age-on-death lst)
  (let loop ((remaining lst) (ages '()))  ; accumulator for valid ages - people that died
    (if (null? remaining)
        (if (null? ages)
            (display "No valid ages found.")
            (begin
              (display "Average age: ")
              (display (/ (apply + ages) (length ages)))
              (newline)))
        (let* ((person (car remaining)) ;; iterate through person, rest added to the back, so looking at the first element and adding the rest to the tail 
               (name (car person))
               (dates (caddr person))
               (dob (car dates))
               (dod (cadr dates))
               (is-alive? (null? dod))
               (age (if (and (not (null? dob)) (not (null? dod)))
                        (- (convrt-days dod) (convrt-days dob))
                        #f)))  ; Calculate age at death
          (if (not is-alive?)
              (begin
                (display name)
                (display ": ")
                (display age)
                (newline)))
          (loop (cdr remaining)
                (if (or is-alive? (not age))  ; Ignore living people & missing dates
                    ages
                    (cons age ages)))))))  ; Add valid ages to list



;; B4 - Mikolaj
;; This function should return a list of all members who have birthdays in the same month as your birthday. (function birthday-month-same)
(define (birthday-month-same month lst)
  (let loop ((remaining lst) (matches '()))  ; Accumulator for matches
    (if (null? remaining)
        (if (null? matches)
            (display "No Matches Found...")  ; Display nothing if no matches
            (begin
              (for-each (lambda (name)
                          (display name)
                          (newline)) 
                        matches)))  ; Iterate through and display names on separate lines
        (let* ((person (car remaining))
               (name (car person))  ; Extract the person's name
               (dates (caddr person))  ; Extract date info
               (dob (car dates))  ; Extract date of birth
               (exists? (and (not (null? dob)) (pair? dob)))  ; Ensure valid dob
               (birth-month (if exists? (cadr dob) #f)))  ; Extract birth month safely

          (loop (cdr remaining)
                (if (and exists? (= birth-month month))  ; If birth month matches
                    (cons name matches)  ; Add name to matches
                    matches))))))  ; Otherwise, continue



;; B5 - Mikolaj
;; This function should return a sorted list of all members in your branch. Sort the members by their first names. (function sort-by-first)
(define (sort-by-first lst)
  (let loop ((remaining lst) (names '()))  ; Accumulator for storing names
    (if (null? remaining)
        (begin
          (display "\nSorted Names:\n")
          (for-each (lambda (name)
                      (display name)
                      (newline))
                    (sort (map symbol->string names) string<?))  ; Convert to strings and sort
          (display "\nand that's it...\n"))
        
        (let* ((person (car remaining))
               (full-name (car person))
               (name (if (pair? full-name) (car full-name) '())))  ; Extract first name as symbol
          
          (loop (cdr remaining) (cons name names))))))  ; Accumulate names



;; B6 - Mikolaj
;; This function should return a new family tree changing the name of any member of the family with the first name of Mary to Maria. (function change-name-to-Maria)
(define (change-name-to-Maria lst)
  (let loop ((remaining lst))
    (if (null? remaining)
        (display "\nand that's it...\n")
        (let* ((person (car remaining))
               (full-name (car person))  ; Extract full name
               (first (symbol->string (car full-name)))  ; Convert first name to string
               (new-name (if (string=? first "Mary") "Maria" first))  ; Replace "Mary" with "Maria"
               (final-symbol (string->symbol new-name)))  ; Convert back to symbol
          (display (list final-symbol))  ; Display in symbol format (as a list)
          (newline)
          (loop (cdr remaining))))))


(define (month)
  (let* ((input "10/4")
         (parts (string-split input "/")))
    (if (and (= (length parts) 2)
             (string->number (car parts))
             (string->number (cadr parts)))
        (list (string->number (car parts)) 
              (string->number (cadr parts)))
        #f)))


;; for testing / debugging -- defined each function by task number used to test if code is working accurately 

(define b1 (lambda () (begin(is-child Mb) "")))
(define b2 (lambda () (oldest-living-member Mb) ""))
(define b3 (lambda () (average-age-on-death Mb) ""))
(define b4 (lambda () (birthday-month-same (cadr (month)) Mb) ""))
(define b5 (lambda () (sort-by-first Mb) ""))
(define b6 (lambda () (change-name-to-Maria Mb) ""))

;; for video -- display all functions testing Pb branch.

(define B1 (lambda () (begin(is-child Pb) "")))
(define B2 (lambda () (oldest-living-member Pb) ""))
(define B3 (lambda () (average-age-on-death Pb) ""))
(define B4 (lambda () (birthday-month-same (cadr (month)) Pb) ""))
(define B5 (lambda () (sort-by-first Pb) ""))
(define B6 (lambda () (change-name-to-Maria Pb) ""))


(define (run)
  (display "\nB1) A Function Used To Display A List Of Children In The Branch.")
  (display (B1))
  (newline)
  (display "\nB2) A Function Used To Return The Oldest Member Of The Branch.")
  (newline)
  (display (B2))
  (newline)
  (display "\nB3) A Function Used To Display The Average Age At Death.")
  (newline)
  (display (B3))
  (newline)
  (display "\nB4) A Function Used To Display All The Family Members Who Share A Birthday With You.")
  (newline)
  (display (B4))
  (newline)
  (display "\nB5) A Function Used To Return A Alphabetically Sorted List Of Family Members")
  (display (B5))
  (display "\nB6) A Function Used To Change All People Named Mary To Maria.")
  (newline)
  (display (B6))
  (newline)
  )

(run)