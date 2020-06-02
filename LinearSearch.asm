	.data
		arr_size: .word 10
		#target number will be searched on this array. you can change array from here.
		#you also should change array size from above.
		arr: .word 1, 22, 3, 2, 9, 11, 4, 7, 14, 18
		message1: .asciiz " at "
		message2: .asciiz ". indis in the array\n"
		message3: .asciiz "target number not found in the array\n"
		message4: .asciiz "array: "
		message5: .asciiz "enter a target number: "
		space: .asciiz " "
		

	.text
		main:

	#s0: arr_size
	#t0: i in loop
	#t1: arr[i]
	#t2: i*4 (t0 * 4)
	#s2: target number

		lw $s0, arr_size

		
		#prints message4
		li $v0, 4 
		la $a0, message4
		syscall	
	
	
		#####prints arr#########
		li $t0, 0
		li $t2, 0
		while4:						#for(int i = 0; i < size; i++)
			li $v0, 1
			lw $t1, arr($t2)		#print arr[i]
			move $a0, $t1
			syscall
			
			#prints space
			li $v0, 4 
			la $a0, space 
			syscall			
			
		addi $t2, $t2, 4
		addi $t0, $t0, 1
		blt $t0 $s0 while4 

		#prints newline
		li $a0, 10 
		li $v0, 11 
		syscall	
		
		#print message
		li $v0, 4 
		la $a0, message5
		syscall

		#input target number to $s2
		li $v0 5	#v0 = input
		syscall
		move $s2, $v0 	#s2 = v0
		
		
		li $t0, 0
		li $t2, 0

		while:
		
			lw $t1, arr($t2)
			beq $s2, $t1, jump1	#if( target == arr[i] ) jump1;
			
		addi $t2, $t2, 4
		addi $t0, $t0, 1
		blt $t0 $s0 while

		#print message "target number not found in the array\n"
		li $v0, 4 
		la $a0, message3
		syscall
			
		
		exit:
		li $v0, 10
		syscall


		jump1: #target founded
		li $v0, 1 
		move $a0, $s2
		syscall	

		
		#print message 
		li $v0, 4 
		la $a0, message1
		syscall
		
		
		li $v0, 1 
		move $a0, $t0
		syscall
		
		#print message to
		li $v0, 4 
		la $a0, message2
		syscall
		
		b exit
		

