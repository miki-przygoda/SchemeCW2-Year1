;; THIS FILE SHOULD NOT BE A PART OF THE UPLAOD - WILL NOT RESULT IN EXTRA MARKS 
;; -- This is only for the actual upload of the coursework as it uses non functional code such as (displayln) and loops

(include "scheme-cw-template.rkt")
(include "A.rkt")
(include "B.rkt")
(include "C.rkt")

;; Navigation Stack
(define current-position '()) 

;; Menu Options
(define menu-options
  (list "Main" "PartnerA" "PartnerB" "WorkC"
        "A1" "A2" "A3" "A4" "A5" "A6"
        "B1" "B2" "B3" "B4" "B5" "B6"
        "C1" "C2" "C3"))

;; Partner Menus
(define partner-options
  (list
    (cons 1 "Partner A")
    (cons 2 "Partner B")
    (cons 3 "Both")
    (cons 4 "Exit")))

(define PartnerA
  (list
   (cons 1 "A1 - Parents in the branch")
   (cons 2 "A2 - Living members in the branch ")
   (cons 3 "A3 - Current age of all living members in the branch")
   (cons 4 "A4 - Members with the same birthday month as you")
   (cons 5 "A5 - Names of family members, sorted by last name")
   (cons 6 "A6 - Change all people named John, to Juan")
   (cons 7 "Back")))

(define PartnerB
  (list
   (cons 1 "B1 - List all children in the branch")
   (cons 2 "B2 - Find the oldest living member in the branch")
   (cons 3 "B3 - Compute the average age at death in the branch")
   (cons 4 "B4 - List all members with the same birth month as you")
   (cons 5 "B5 - Sort all members in the branch by first name")
   (cons 6 "B6 - Change all 'Mary' names to 'Maria'")
   (cons 7 "Back")))

(define Both
  (list
   (cons 1 "C1")
   (cons 2 "C2")
   (cons 3 "C3")
   (cons 4 "Back")))

;; Display Menu
(define (display-menu menu message)
  (newline)
  (displayln message)
  (for-each (lambda (option)
              (printf "~a. ~a~n" (car option) (cdr option)))
            menu))

;; Get User Input
(define (get-choice)
  (newline)
  (display "Enter Your Choice: ")
  (define user-input (read)) 
  (newline)
  user-input)

;; Navigation Management
(define (navigate-to index)
  (if (and (>= index 0) (< index (length menu-options)))
      (begin
        (set! current-position (cons index current-position))
        (display "Navigated to: ")
        (display (list-ref menu-options index))
        (newline))
      (display "Invalid option.")))

(define (go-back)
  (if (null? (cdr current-position))
      (begin
        (display "Already at the main menu.")
        (newline)
        (main-loop))
      (begin
        (set! current-position (cdr current-position))
        (display "Went back to: ")
        (display (list-ref menu-options (car current-position)))
        (newline)
        (rerun-menu))))

;; Automatically Rerun Current Menu
(define (rerun-menu)
  (newline)
  (case (car current-position)
    [(1) (display-partner-A)]
    [(2) (display-partner-B)]
    [(3) (display-both)]
    [else (main-loop)]))

;; Main Menu Handler
(define (handle-choice choice)
  (cond
    [(= choice 1) (navigate-to 1) (display-partner-A)]
    [(= choice 2) (navigate-to 2) (display-partner-B)]
    [(= choice 3) (navigate-to 3) (display-both)]
    [(= choice 4) (displayln "Exiting...") (exit)]
    [else (displayln "Invalid Choice, Try Again.") (main-loop)]))

;; Partner A Menu
(define (handle-optionsA choice)
  (cond
    [(= choice 1) (a1) (rerun-menu)]
    [(= choice 2) (a2) (rerun-menu)]
    [(= choice 3) (a3) (rerun-menu)]
    [(= choice 4) (a4) (rerun-menu)]
    [(= choice 5) (a5) (rerun-menu)]
    [(= choice 6) (a6) (rerun-menu)]
    [(= choice 7) (go-back)]
    [else (displayln "Invalid Choice, Try Again.") (display-partner-A)]))

;; Partner B Menu
(define (handle-optionsB choice)
  (cond
    [(= choice 1) (b1) (rerun-menu)]
    [(= choice 2) (b2) (rerun-menu)]
    [(= choice 3) (b3) (rerun-menu)]
    [(= choice 4) (b4) (rerun-menu)]
    [(= choice 5) (b5) (rerun-menu)]
    [(= choice 6) (b6) (rerun-menu)]
    [(= choice 7) (go-back)]
    [else (displayln "Invalid Choice, Try Again.") (display-partner-B)]))

;; Both Partners Menu
(define (handle-both choice)
  (cond
    [(= choice 1) (c1) (rerun-menu)]
    [(= choice 2) (c2) (rerun-menu)]
    [(= choice 3) (c3) (rerun-menu)]
    [(= choice 4) (go-back)]
    [else (displayln "Invalid Choice, Try Again.") (display-both)]))

;; Display Menus
(define (display-partner-A)
  (display-menu PartnerA "Danna's Work:")
  (handle-optionsA (get-choice)))

(define (display-partner-B)
  (display-menu PartnerB "Mikolaj's Work:")
  (handle-optionsB (get-choice)))

(define (display-both)
  (display-menu Both "Section C:")
  (handle-both (get-choice)))

;; Main Loop
(define (main-loop)
  (display-menu partner-options "Which Partner's Work Would You Like To Look At?")
  (handle-choice (get-choice)))

;; Start TUI
(main-loop)