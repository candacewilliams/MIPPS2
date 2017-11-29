.data
char_array: .space 1001 #allocates space for 1000 characters and 1 NULL
new_line: .asciiz "\n" #used to separate 1000 characters from extra ones
invalid_hex: .asciiz "NaN" #for substrings with invalid characters
hex_too_large: .asciiz "too large" #for substrings with 8+ characters
found_comma: .asciiz "found comma" #temporary to see if comma was found
.text
  main:
      li $v0, 8 #receives input
      la $a0, char_array #loads buffer into address
      li $a1, 1001 # allocates buffer space for string
      syscall

      la $a0, new_line # loads newline
      li $v0, 4 #prints new line for string
      syscall

      addi $t1, $0, 0 #initializes $t1 to zero (stores character)
      la $t2, char_array #stores string address into register
      add $t3, $0, $0 #initializes $t3 to zero (counter)


find_substring:
      lb $t1,0($t2) #loads first index of string
      addi $t2, $t2, 1 #points to next character in string
      beq $t1, 44, isValid_Hex #if comma is found check substring
      addi $t3, $t3, 1 #increments counter
      j find_substring #jumps to continue loop

isValid_Hex:
      la $a0, found_comma #loads found comma test case
      li $v0, 4 #prints comma was found
      syscall

      li $v0,10 #ends program
      syscall
