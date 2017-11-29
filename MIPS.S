.data
char_array: .space 1001 #allocates space for 1000 characters and 1 NULL
new_line: .asciiz "\n" #used to separate 1000 characters from extra ones
invalid_hex: .asciiz "NaN" #for substrings with invalid characters
hex_too_large: .asciiz "too large" #for substrings with 8+ characters
.text
  main:
      li $v0, 8 #receives input
      la $a0, char_array #loads buffer into address
      li $a1, 1001 # allocates buffer space for string
      syscall

      la $a0, new_line # loads newline
      li $v0, 4 #prints new line for string
      syscall

      li $v0,10 #ends program
      syscall
