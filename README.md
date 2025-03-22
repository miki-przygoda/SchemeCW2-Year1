# Family Tree Analysis in Scheme

This project implements a family tree data structure and various analysis functions using Scheme (Racket). The program provides a text-based interface to explore and analyze family relationships across maternal and paternal branches.

## Project Structure

- `scheme-cw-template.rkt` - Contains the family tree data structures
- `A.rkt` - Implementation of Part A functions (Partner A)
- `B.rkt` - Implementation of Part B functions (Partner B)
- `C.rkt` - Implementation of Part C functions (both partners)
- `main.rkt` - Main program with text UI for navigating the features

## Data Format

Family members are represented in the following format:
```
(Name, Parents (Mother, Father), Dates (Date of birth, Date of death))
```

Where:
- Empty lists represent unknown information
- Dates are in the format (day month year)

## Features

### Part A (Partner A's Work)
- A1: List all parents in a branch
- A2: List all living members in a branch
- A3: Calculate current age of all living members
- A4: Find members with the same birthday month as you
- A5: Sort family members by last name
- A6: Replace all occurrences of "John" with "Juan"

### Part B (Partner B's Work - Mikolaj)
- B1: List all children in a branch
- B2: Find the oldest living member in a branch
- B3: Compute the average age at death in a branch
- B4: List all members with the same birth month as you
- B5: Sort all members by first name
- B6: Change all occurrences of "Mary" to "Maria"

### Part C (Combined Work)
- C1: List all members in the maternal branch
- C2: List all members in the paternal branch
- C3: List all members in both branches

## Running the Program

To run the program:
1. Make sure you have Racket installed
2. Run `main.rkt` using the Racket interpreter
3. Navigate through the menu options to explore different functions

## Implementation Details

The program uses a functional programming approach with Scheme, incorporating:
- List processing techniques
- Higher-order functions
- Recursive algorithms
- Data transformation functions
