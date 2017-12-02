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

      addi $t1, $0, 0 #initializes $t1 to zero (stores character)
      la $t2, char_array #stores string address into register
      add $t3, $0, $0 #initializes $t3 to zero (counter)


find_substring:
      lb $t1,0($t2) #loads first index of string
      addi $t2, $t2, 1 #points to next character in string
      beq $t1, 44, Pre_SubProgram #
      addi $t3, $t3, 1 #increments counter
	  bgt $t3, 8, too_large
      j find_substring #jumps to continue loop
	  
Pre_SubProgram:
	  add $a0, $t3, $0 #load sum to print
	  la $t2, char_array #stores string address into Exit:
      addi $a0, $t3, 0 #stores $t3 in $a0
      addi $t1, $0, 0 #initializes $t1 to zero (stores character)
      la $t2, char_array #stores string address into register
      #$t3 stores the counter
      add $t4, $0, $0 #stores the sum for the hex number
      addi $s0, $0, 4 #the 4 in (count -1) * 4
      sub $t3, $t3, 1 #decrements counter by 1
      mult $t3, $s0 #shift amount (count - 1 ) * 4
      mflo $t5 #moves result of (count - 1) * 4 into $t5

Subprogram_1:
      lb $t1, 0($t2) #loads first index of string
      beq $t1, 0, SubProgram_3 #checks for null, then exits
      #beq $t1, 10, Exit_2 #looks for new line character, then exits
	  beq $t1, 44, SubProgram_3 #looks for character, then exits
      addi $t2, $t2, 1 #points to next character in string
      beq $t1, 32, Subprogram_1 #doesn't increment if character is a space
      blt $t1, 48, Invalid #checks if character is before 0 in ASCII chart
      blt $t1, 58, SubProgram_2
	  blt $t1, 65, Invalid #checks if character is between 58 and 64
	  blt $t1, 71, SubProgram_2
	  blt $t1, 97, Invalid #checks if character is between 71 and 96
	  blt $t1, 103, SubProgram_2
	  blt $t1, 128, Invalid #checks if character is between 103 and 127
      
Invalid:
      la $a0, invalid_hex #loads string
      li $v0, 4 #prints new line for string
      syscall

      li $v0,10 #ends program
      syscall

too_large:
      la $a0, hex_too_large #loads string
      li $v0, 4 #prints new line for string
      syscall

      li $v0,10 #ends program
      syscall

SubProgram_2:
	  blt $t1, 58, Translate_Number #checks if character is between 48 and 57
      blt $t1, 71, Translate_UpperCase #checks if character is between 65 and 70
      blt $t1, 103, Translate_LowerCase #checks if character is between 97 and 102

Translate_Number:
      sub $t1, $t1, 48 #subtracts 48 from the ASCII value
      sllv $t1, $t1, $t5 #shifts hex value to represent position in string
      add $t4, $t4, $t1 #adds hex value to the sum
      sub $t5, $t5, 4 #decrements the shift amount
      j Subprogram_1 #returns to check_string loop

Translate_LowerCase:
      sub $t1, $t1, 87 #subtracts 48 from the ASCII value
      sllv $t1, $t1, $t5 #shifts hex value to represent position in string
      add $t4, $t4, $t1 #adds hex value to the sum
      sub $t5, $t5, 4 #decrements the shift amount
      j Subprogram_1 #returns to check_string loop

Translate_UpperCase:
      sub $t1, $t1, 55 #subtracts 48 from the ASCII value
      sllv $t1, $t1, $t5 #shifts hex value to represent position in string
      add $t4, $t4, $t1 #adds hex value to the sum
      sub $t5, $t5, 4 #decrements the shift amount
      j Subprogram_1 #returns to check_string loop

SubProgram_3:
      bgt $t3, 6, Print_2sComplement
      add $a0, $t4, $0 #load sum to print
      li $v0, 1 #print integer
      syscall

      li $v0,10 #ends program
      syscall

Print_2sComplement:
	addi $s0, $0, 10000 # stores 10000 in $s0
    divu $t4, $s0 #divides sum by multiple of 10 (10000)
    mflo $s1 #stores quotient
    mfhi $s2 #stores remainder

    add $a0, $s1, $0 #stores quotient to be printed
    li $v0, 1 #print integer
    syscall

    add $a0, $s2, $0 #load sum to print
    li $v0, 1 #print integer
    syscall

    li $v0,10 #ends program
    syscall