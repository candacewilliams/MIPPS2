.data
char_array: .space 1001 #allocates space for 1000 characters and 1 NULL
invalid_hex: .asciiz "NaN" #for substrings with invalid characters
hex_too_large: .asciiz "too large" #for substrings with 8+ characters
.text
	main: 
		li $v0, 8 #receives input
		la $a0, char_array #loads buffer into address
		li $a1, 1001 # allocates buffer space for string
		syscall

		addi $t0, $0, 0 #initializes $t1 to zero (stores character)
		addi $t1, $0, 0 #initializes ending index to zero

		la $t2, char_array #stores string address into register
		add $t3, $0, $0 #initializes $t3 to zero (counter)
		lb $t4,0($t2) #loads first index of string
		beq $t4, 10, invalid #looks for new line character at first index$t0, $t0, 0 #initializes starting index to zero
	
		check_substring:
			lb $t4, 0($t2) #loads first index of 
			beq $t4, 0, SubProgram_2 #checks for null, then jumps to evaluate substring
			beq $t4, 10, SubProgram_2 #looks for new line character, then jumps to evaluate substring
			beq $t4, 44, SubProgram_2 #looks for comma, then jumps to evaluate substring
			addi $t2, $t2, 1 #points to next character in string
			beq $t4, 32, check_substring  # to skip spaces
      		addi $t3, $t3, 1 #counter increments
			j check_substring #jumps to continues loop

		SubProgram_2: 
			

		invalid:
			la $a0, invalid_hex #loads string
			li $v0, 4 #prints new line for string
			syscall

		end_program:
			li $v0,10 #ends program
			syscall
