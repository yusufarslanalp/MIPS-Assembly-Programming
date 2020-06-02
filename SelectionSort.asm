	.data
		arr_size: .word 9
		#this array will be sorted. you can change array from here.
		#you also should change array size from above.
		arr: .word 13, 22, 3, 43, 123, 54, 32, 62, 1
		space: .asciiz " "
		message1: .asciiz "unsorted array: "
		message2: .asciiz "sorted array:   "


	.text
		main:

#which register correspond to which variable.
	#t0: min
	#t1: arr[j] , arr[j]
	#t6: j*4 , i*4
	#t2: j
	#t3: min_index
	#t4: i
	#t5: size
	#t7: temp_int
	#t8: size - 1;
	

	lw $t5, arr_size
	addi $t8, $t5, -1
	li $t4, 0
	

		#prints message1
		li $v0, 4 
		la $a0, message1
		syscall	
	
	
		#####prints arr#########
		li $t4, 0
		li $t6, 0
		while4:						#for(int i = 0; i < size; i++)
			li $v0, 1
			lw $t1, arr($t6)		#print arr[i]
			move $a0, $t1
			syscall
			
			#prints space
			li $v0, 4 
			la $a0, space 
			syscall			
			
		addi $t6, $t6, 4
		addi $t4, $t4, 1
		blt $t4 $t5 while4 

		#prints newline
		li $a0, 10 
		li $v0, 11 
		syscall			
	
	
		li $t4, 0
		
#######################################
	
		li $t4, 0
		while2:		#for(int i = 0; i < size-1; i++)
			move $t2, $t4	#j = i		these twoo line belogs to while loop
			mul $t6, $t2, 4 #t6 = j*4	but should be here.

			lw $t0, arr($t6)	#min = arr[i]; (i==j and t6==4*i)
			move $t3, $t4		#min_index = i;		
			
			while1:						#for(int j = i; j < size; j++)
				lw $t1, arr($t6)
				ble $t0, $t1, jump1		#if(min > arr[j]) min = arr[j];
				move $t0, $t1			#min = arr[j];	
				move $t3, $t2 			#min_index = j;
				jump1:	


			addi $t6, $t6, 4
			addi $t2, $t2, 1
			blt $t2 $t5 while1 		
			
			
			mul $t6, $t4, 4		#t6 = i*4		
			lw $t7, arr($t6)	#temp = arr[i];
			sw $t0, arr($t6)	#arr[i] = min;
			mul $t6, $t3, 4		#t6 = min_index * 4
			sw $t7, arr($t6)	#arr[min_index] = temp;


		addi $t4, $t4, 1
		blt $t4 $t8 while2

#######################################

		#prints message2
		li $v0, 4 
		la $a0, message2
		syscall

		#####prints arr#########
		li $t4, 0
		li $t6, 0
		while3:						#for(int i = 0; i < size; i++)
			li $v0, 1
			lw $t1, arr($t6)		#print arr[i]
			move $a0, $t1
			syscall
			
			#prints space
			li $v0, 4 
			la $a0, space 
			syscall
			
		addi $t6, $t6, 4
		addi $t4, $t4, 1
		blt $t4 $t5 while3 	
		
		#prints newline
		li $a0, 10 
		li $v0, 11 
		syscall	


	exit:
	li $v0, 10
	syscall


		

