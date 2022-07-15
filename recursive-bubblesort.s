#######################################################################################
#Program Name		: This Program uses Recursive Bubble Sort to Sort n integer values
#Programmer			: Giorgos Evangelou
#Date Last Modif.	: 15 April 2019
########################################################################################
# Comments: This Program uses Recursive Bubble Sort to Sort
#	n integer values stored in .data.
########################################################################################
	.align 2
	.data								# data segment
#The table of 15 words
table: 		.word 	64 34 25 12 22 11 90 100 8 10 111 34 55 19 999	
size:		.byte	15					# The size of the table
newLine:	.asciiz "\n"				# New line
comma:		.asciiz ", "				# Comma
before:		.asciiz"Before sort: \n"	# Before sort
after:		.asciiz"Sorted array: \n"	# Sorted array
########################################################################################
	.text					# text segment
	.globl main
main:	
	# Initiate the values used in the program
	li $t0, 0				# set the counting value equal to 0
	
	addi $v0,$0,4			# System Call print_str
	la $a0,before			# load "Before sort: \n"
	syscall					# System Call print_string
	la $a0, table			# load the start address of the table
	lb $a1, size			# load the size of the table
	jal printArray2			# jump&link to printArray2
	#--------------------------------------------------------------------------------------
	# Call the Bubble Sort Function
	#--------------------------------------------------------------------------------------
	la $a0, table			# load the start address of the table
	lb $a1, size			# load the size of the table
	jal bubbleSort			# jump to bubbleSort function
	#--------------------------------------------------------------------------------------
	addi $v0,$0,4			# System Call print_str
	la $a0,after			# load "Sorted array: \n"
	syscall					# System Call print_string
	la $a0, table			# load the start address of the table
	lb $a1, size			# load the size of the table
	jal printArray2			# jump&link to printArray2
	
	
	# Exit
	li	$v0, 10     		# Exit System Call
	syscall
	
########################################################################################
###   Functions
########################################################################################	
#swaping two register's data
swap2: 
     li $t0, 0x3f800000    #1.0
     li $t2, 0x40000000    #2.0
     li $t3, 0x40400000    #3.0
     li $t4, 0x40800000    #4.0
     li $t5, 0x40a00000    #5.0
     li $t6, 0x41200000    #10.0
     li $t7, 0x41a00000    #20.0
     li $t8, 0x41f00000    #30.0
     li $t9, 0x42200000    #40.0
     la $t0, table         #Load the start address of the table
     mul $a0, $a0, 4       #Compute the offset for x  
     mul $a1, $a1, 4 	   #Compute the offset for y
     add $a0, $a0, $t0     #Compute the address of x
     add $a1, $a1, $t0     #Compute the address of y
     lw $t1, 0($a0)
     lw $t2, 0($a1)
     # Swap numbers
     sw $t2, 0($a0) 
     sw $t1, 0($a1) 
     li $a0, 0x3fffffff    #1.0
     li $a1, 0x3fffffff    #1.0
     li $a2, 0x3fffffff    #1.0
     li $a3, 0x3fffffff    #1.0
     li $t0, 0x3f800000    #1.0
     li $t2, 0x40000000    #2.0
     li $t3, 0x40400000    #3.0
     li $t4, 0x40800000    #4.0
     li $t5, 0x40a00000    #5.0
     li $t6, 0x41200000    #10.0
     li $t7, 0x41a00000    #20.0
     li $t8, 0x41f00000    #30.0
     li $t9, 0x42200000    #40.0
     jr $ra

#--------------------------------------------------------------------------------------
#method which prints the array
printArray2:
      move $t0, $a0
      move $t1, $a1
#-------------------------------------------------------------------
loop_prt:  
     lw $a0, 0($t0)        #Load word from table
     li $v0, 1             #System Call print_int
     syscall               #Print on Console
     #Print on Console
     li $v0, 4             # 4 = print questionStr syscall
     la $a0, comma   	   # load address of string
     syscall               # execute the system call
     addi $t0, $t0, 4 	   #Move the pointer to the next word
     addi $t1, $t1, -1     #Decrease the counter
     bnez $t1, loop_prt    #Repeat until all words read
     li $v0, 4             # 4 = print questionStr syscall
     la $a0, newLine 	   # load address of string
     syscall               # execute the system call
     li $a0, 0x3fffffff    #1.0
     li $a1, 0x3fffffff    #1.0
     li $a2, 0x3fffffff    #1.0
     li $a3, 0x3fffffff    #1.0
     li $t0, 0x3f800000    #1.0
     li $t2, 0x40000000    #2.0
     li $t3, 0x40400000    #3.0
     li $t4, 0x40800000    #4.0
     li $t5, 0x40a00000    #5.0
     li $t6, 0x41200000    #10.0
     li $t7, 0x41a00000    #20.0
     li $t8, 0x41f00000    #30.0
     li $t9, 0x42200000    #40.0
     jr $ra
#--------------------------------------------------------------------------------------
#the method which bubble sorts an array
bubbleSort:
		subu $sp,$sp,56     # allocating 56 bytes of memory in stack
		sw $a3,0($sp)       # $a3 is stored in the $sp +0
		sw $a2,4($sp)       # $a2 is stored in the $sp +4
		sw $a1,8($sp)       # $a1 is stored in the $sp +8
		sw $a0,12($sp)      # $a0 is stored in the $sp +12
		sw $ra,16($sp)      # $ra is stored in the $sp +16
		sw $fp,20($sp)      # $fp is stored in the $sp +20
		sw $s7,24($sp)      # $s7 is stored in the $sp +24
		sw $s6,28($sp)      # $s6 is stored in the $sp +28
		sw $s5,32($sp)      # $s5 is stored in the $sp +32
		sw $s4,36($sp)      # $s4 is stored in the $sp +36
		sw $s3,40($sp)      # $s3 is stored in the $sp +40
		sw $s2,44($sp)      # $s2 is stored in the $sp +44
		sw $s1,48($sp)      # $s1 is stored in the $sp +48
		sw $s0,52($sp)      # $s0 is stored in the $sp +52
		
		addiu $fp,$sp,52	# set up frame pointer
							# it's used because $sp changes dynamically
							
		li $s0,0			# $s0 is 0 if a swap happend and 1 otherwise
							# by this point $s0=0
							
		li $t0,1			# setting $t0 as one for branching
		lw $a1,8($sp)		# loading to $a1 the size of the array
		bne $a1,$t0,Compute	# if (array size!=1) goto Compute
		j Return			# if array's size is 1 we return to caller
		
	#----------------------------------------------------------------------------------

	Compute:
      add $s7,$0,$0			# our loop's counter $s7
	  lw $a1,8($sp)			# loading to $a1 the size of the array
	  addi $s1,$a1,-1		# setting array's size
	  add $s2,$a0,$0		# $s2 first word from table
	  addi $s3,$a0,4		# $s3 next word from table
	  
	 Loop:
	  beq $s7,$s1,End		# if we've checked all the numbers,goto end
	  
	  lw $s5,0($s2)			# current word in $s5 = a[i]
	  lw $s6,0($s3)			# next word in $s6 = a[i+1]
	  sgt $s4,$s5,$s6		# setting $s4 as 1 if($s5>$s6)
	  beq $s4,$0,Skip		# if $s4==0 we don't swap
							# if $s4==1 we procede to swap
							
	  addi $s0,$s0,1		# $s0 becomes 1 because a swap happend
	  move $a0,$s7			# loading to $a0 the current word
	  move $a1,$s7			# loading to $a0 the current word									
	  addi $a1,$a1,1		# increasing $a1 by one to represent->next word
	  jal swap2				# jump and link to swap 2 numbers
	  
	 Skip:
	  addi $s7,$s7,1		# increasing our counter
	  addi $s2,$s2,4		# increasing $s2 address by 4
	  addi $s3,$s3,4		# increasing $s3 address by 4
	  j Loop				# continue by checking the other numbers
	    
	 End:
		beq $s0,$0,Return	# if ($s0==0),(a swap didn't happend),goto Return
		la $a0,table		# load the start address of the table
		lw $s1,8($sp)		# getting the array's size from stack
		addi $a1,$s1,-1		# decreasing array's size by one
		jal bubbleSort		# jump and link to bubbleSort method
	#----------------------------------------------------------------------------------	
	Return:
      lw $ra,16($sp)		# store to $ra the $ra value from $sp(stack)+16
      lw $fp,20($sp)		# store to $fp the $fp value from $sp(stack)+16
      addiu $sp,$sp,56		# deallocate 56 bytes of memory from stack
      jr $ra				# jump to the content of $ra
#End of bubbleSort function	  
#--------------------------------------------------------------------------------------	  