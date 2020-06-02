.data
	lower_bound: .asciiz "enter lower_bound: "
	upper_bound: .asciiz "enter upper_bound: "
	get_number: .asciiz "enter number: "	

.text
	main:

#t0: lower_bound
#t1: upper_bound
#t2: i in the loop
#t3: number


	#print message to take lower_bound
	li $v0, 4 
	la $a0, lower_bound
	syscall
	
	#t0:lower bound
	#input lower_bound to $t0
	li $v0 5	#v0 = input
	syscall
	move $t0, $v0 	#t0 = v0
	
	#print message to take upper_bound
	li $v0, 4 
	la $a0, upper_bound
	syscall

	#t1:upper_bound
	#input upper_bound to $t1
	li $v0 5	#v0 = input
	syscall
	move $t1, $v0 	#t1 = v0
	
	#print message to take third number
	li $v0, 4 
	la $a0, get_number
	syscall

	#t3:third number
	#input third number to $t3
	li $v0 5	#v0 = input
	syscall
	move $t3, $v0 	#t3 = v0
	
	move $t2, $t0
	while:
		
		div $t2, $t3 #t2/t3
		mfhi $s0	#s0=t2 % t3
		bne $s0, $zero, not_print

		li $v0, 1 
		move $a0, $t2
		syscall
		
		#prints newline
		li $a0, 10 
        li $v0, 11 
        syscall
		
		not_print:

	addi $t2, $t2, 1
	ble $t2 $t1 while 		

	exit:
	li $v0, 10
	syscall
