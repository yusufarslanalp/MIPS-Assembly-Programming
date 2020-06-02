	.data
		arr_size: .word 13
		#target number will be searched on this array. you can change array from here.
		#the array should be sorted in increasing order. because the algorithm is binary search.
		#you also should change array size from above.
		arr: .word 1, 4, 7, 97, 123, 155, 199, 211, 413, 555, 587, 1993, 2011
		message1: .asciiz " at "
		message2: .asciiz ". indis in the array\n"
		message3: .asciiz "target number not found in the array\n"
		message4: .asciiz "array: "
		message5: .asciiz "enter a target number to find: "
		space: .asciiz " "
		error_message: .asciiz "target could not finded in the array"


	.text
		main:
#which register correspond to which variable.
#s0: temp, i
#s1: temp, arr[i]
#t0: mid
#t2: left
#t3: right
#t1: target
#t4: arr[mid]
#t5: mid*4(mid index), i*4
#t6: size (new)
#t7: arr_size


	lw $t7, arr_size

	#prints message4
	li $v0, 4 
	la $a0, message4
	syscall	


	#####prints arr#########
	li $s0, 0
	li $t5, 0
	while4:						#for(int i = 0; i < size; i++)
		li $v0, 1
		lw $s1, arr($t5)		#print arr[i]
		move $a0, $s1
		syscall
		
		#prints space
		li $v0, 4 
		la $a0, space 
		syscall			
		
	addi $t5, $t5, 4
	addi $s0, $s0, 1
	blt $s0 $t7 while4 

	#prints newline
	li $a0, 10 
	li $v0, 11 
	syscall	


	#prints message5
	li $v0, 4 
	la $a0, message5
	syscall	

	
	#input to $t1
	li $v0 5	#v0 = input
	syscall
	move $t1, $v0 	#t0 = v0



	lw $t3, arr_size
	addi $t3, $t3, -1	#right = size-1;
	li $t2, 0			#left = 0;
	
	lw $a0, arr_size		#a0 = size
	jal mid_num		
	move $t0, $v0	#mid = mid_num( size )
	 
	

	while:
		mul $t5, $t0, 4		#t5 = mid*4	
		lw $t4, arr($t5)
		beq $t4, $t1, target_finded		#if( arr[mid] == target ) return mid;
		
		#if( arr[mid] < target )
		blt $t4, $t1, turn_right 
		
		
	
		#if( arr[mid] > target )
		bgt $t4, $t1, turn_left
	
	continue:
	ble $t2 $t3 while 
	


	#print target not founded
	#print message
	li $v0, 4 
	la $a0, error_message
	syscall
	b exit

	
	
	turn_right:
		addi $t2, $t0, 1	#left = mid + 1;

		sub $t6, $t3, $t2	#size = right - left + 1;
		addi $t6, $t6, 1
		
		move $a0, $t6		#a0 = size
		jal mid_num		
		move $t0, $v0		#mid = mid_num( size )
		add $t0, $t0, $t2	#mid = left + mid_num(size);
	b continue

	
	
	turn_left:
		addi $t3, $t0, -1 #right = mid - 1;
		
		sub $t6, $t3, $t2
		addi $t6, $t6, 1
		
		move $a0, $t6		#a0 = size
		jal mid_num		
		move $t0, $v0		#mid = mid_num( size )
		add $t0, $t0, $t2	#mid = left + mid_num(size);
	b continue
	

	target_finded:
	
	li $v0, 1 
	move $a0, $t1
	syscall

	#print message to
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
	


	exit:
	li $v0, 10
	syscall



mid_num:
	li $s0, 2
	li $s1, 1 
	
	div $a0, $s0 #a0/s0
	mfhi $s0	#s0=a0 % s0
	beq $s0, $zero, size_even
	beq $s0, $s1, size_odd 

	size_even:		#if(size == even)
		mflo $v0
		addi $v0, $v0, -1 #num = (size / 2) - 1;
		jr $ra
	
	size_odd:		#if(size == odd)
		mflo $v0	#num = (size / 2);
		jr $ra
		

		

