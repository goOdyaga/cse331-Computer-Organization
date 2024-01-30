#
#
#								C OMPUTER ORGANIZATION - PROJECT1
#
#
#	Hamza KONAÇ - 210104004202
#
#
#
# 		Version3 of bomberman game's assembly implemantation is at the below
#
#	At The end of the implemantation you can check the C code of the game as well
#



				.data
StrRow:		.asciiz "Please enter  size of row : "
StrCol:		.asciiz "Please enter  size of column : "
StrStep:	.asciiz "Please enter  count of step : "
Str1:		.asciiz "Please enter the board  : "

directions: 	.byte -1,0,1,0,0,-1,0,1   # Directions array
                       #
.text


#  $s0 -> holds the content of the row
#  $s1 -> holds the content of the COL
#  $s2 -> holds the adress of the user ýnput
#  $s3 -> holds the adress of the game board
#  $s7 -> holds the content of the step
#  $s4 -> holds  'o' to create game board


#  Mission of Main function
#
# Take row , clumn and step number from user
# Allocate memory for user input
# Initialize game board
Main:
	#print screen to read Row message
	la $a0, StrRow
	li $v0, 4
	syscall
	
	#read row
	li $v0,5
	syscall
	
	#save row to s0
	move $s0,$v0
	
	#print screen to read Column message
	la $a0, StrCol
	li $v0, 4
	syscall
	
	#read col
	li $v0,5
	syscall
	
	#save col to s1
	move $s1,$v0
	
	#print screen to read Step message
	la $a0, StrStep
	li $v0, 4
	syscall
	
	#read col
	li $v0,5
	syscall
	
	#save step to s1
	move $s7,$v0
	
	#compute total memory size
	mul $t0,$s0,$s1
	add $t0,$t0,1
	
	#allocate memory for user input
	move $a0,$t0
	li $v0,9
	syscall
	
	move $s2,$v0
	
	#allocate memory for game board
	move $a0,$t0
	li $v0,9
	syscall
	
	#save memory
	move $s3,$v0
	
	#print screen to message
	la $a0, Str1
	li $v0, 4
	syscall
	 
	#Take game board from user as one line
	move $a0,$s2
	move $a1,$t0
	li $v0,8
	syscall
	
	#save string to memory
	move $s2,$a0
	
	#print newline
	li $a0,10
	li $v0,11
	syscall
	
	#
	li $s4, 111
	
	
	add $t0,$zero,$zero
	
	#j=0
	add $t1,$zero,$zero
	
	#t2 take adress of the board
	move $t3,$s2
	
	
	#i<row
	Loop1_:	beq $t0,$s0,Control_game
	
	#j<col
	Loop2_:		beq $t1,$s1,increase_loop_1_
			# $t2 -> i*row+j
			mul $t2,$t0,$s0
			add $t2,$t2,$t1
			
			# $t4 -> board[i*row+j]
			add $t3,$s2,$t2	
			lb $t4,0($t3)
			
			
			#if(board[i*row+j]!='o'
			bne  $t4,$s4,changeTo0
			
			#contents of the index that is loacated in board with 1 if index's content equal to 'o' 
			
			add $t3,$s3,$t2
			li $t5,1
			sb $t5,0($t3)
			
			sub $t3,$t3,$t2
			addi $t1,$t1,1
			
			j Loop2_
	

changeTo0:
#contents of the index that is loacated in board with 1 if index's content equal to '.' 
#To change content of the game board I add index number to base address pf the board and change this content to correct value
#Then I substract index from current address

	#adding index
	add $t3,$s3,$t2		
	
	#change value
	li $t5,0
	sb $t5,0($t3)
	
	#substract index
	sub $t3,$t3,$t2
	addi $t1,$t1,1
	j Loop2_
	
increase_loop_1_:

	add $t1,$zero,$zero
	addi $t0,$t0,1
	j Loop1_
	

#  Mission of Control_game function
#
# perform the bomberman tasks step by step
Control_game:
	
	#i=0
	li $t8,0
	
	Loop_Control:
			#i<step
			beq $t8,$s7,Print_board
			
			# $t9->i%3
			div $t9, $t8,3

    			# The remainder is stored in $t9
    			mfhi $t9
    			#i+=1
    			addi $t8,$t8,1
    			
    			
    			#if $t9 == 1
    			beq $t9,1,  GamePlant
    			
    			#if $t9 == 2
    			beq $t9,2,  Bombdone
 			
 			
    			j Loop_Control

	
#  Mission of Print_board function
#
# Print game board to console
Print_board:
	#i=0
	add $t0,$zero,$zero
	
	#j=0
	add $t1,$zero,$zero
	
	#t2 take adress of the board
	la $t2,0($s3)
	
	#i<row
	Loop1:	beq $t0,$s0,Exit
	
	#j<col
	Loop2:		beq $t1,$s0,increase_loop_1
	
			#i*row+j
			mul $t3,$t0,$s0
			add $t3,$t3,$t1
			
			#board[i*row+j]
			add $t4,$t2,$t3	
			lb $t5,0($t4)
			
			#if(board[i*row+j]!=1
			bne  $t5,0,printO
			#printf(".")
			li $a0,46
			li $v0,11
			syscall
			addi $t1,$t1,1
			j Loop2
		
printO:
	#print capital o (O) to screen		
	li $a0,79
	li $v0,11
	syscall
	#increment j for inner loop
	addi $t1,$t1,1
	j Loop2
			
increase_loop_1:
	
	#assign 0 to J
	add $t1,$zero,$zero
	
	#increment i
	addi $t0,$t0,1
	
	#print newLine
	li $a0,10
	li $v0,11
	syscall
	
	j Loop1		
	
	
#  Mission of Initialize game boardfunction
#
#	bomberman traverse each index of the game board and add 1 to each index's contents
GamePlant:


	#check the prodram steps
	
	
	add $t0,$zero,$zero
	
	#j=0
	add $t1,$zero,$zero
	
	#t2 take adress of the board
	la $t2,0($s3)
	
	#i<row
	Loop1_g:	beq $t0,$s0,Loop_Control
	
	#j<col
	Loop2_g:		beq $t1,$s1,increase_loop_1_g
	
			#i*row+j
			mul $t3,$t0,$s0
			add $t3,$t3,$t1
			
			#board[i*row+j]
			add $t4,$t2,$t3	
			
			
			#add 1 to content of the index
			lb $t5,0($t4)
			#increment value
			addi $t5,$t5,1
			#change old value to new value
			sb $t5,0($t4)
			addi $t1,$t1,1
			j Loop2_g

increase_loop_1_g:

	add $t1,$zero,$zero
	addi $t0,$t0,1
	j Loop1_g

#  Mission of Bombdone function
#
# If bombs are ready for detonate then funciton detonate them

Bombdone:
#check the prodram steps
	
	
	
	#i=0
	add $t0,$zero,$zero
	
	#j=0
	add $t1,$zero,$zero
	
	#t2 take adress of the board
	la $t2,0($s3)
	
	#i<row
	Loop1_b:	beq $t0,$s0,Loop_Control
	
	#j<col
	Loop2_b:		beq $t1,$s1,increase_loop_1_b
	
			#i*row+j
			mul $t3,$t0,$s0
			add $t3,$t3,$t1
			
			#board[i*row+j]
			add $t3,$t3,$t2	
			lb $t4,0($t3)
			
			addi $t1,$t1,1
			
			
			#if(board[i*row+j]!=1
			bne  $t4,2,Loop2_b
				li $t5,0
		
				sb $t5,0($t3)
				
				#la $t3, directions      # Load address of directions array into $t0

   				 # Loop through the array
   				 li $t4, 0               # Initialize loop counter
   				 Loop_start: beq $t4,4,Loop2_b
   				 	la $t3, directions 	

    				# Calculate the base address of the current row (directions[t2])
   				 mul   $t5,$t4,2     # Calculate the offset (2 words per row)
   				 add $t5,$t3,$t5       # Calculate the base address of the current row
		
   				 # Accessing directions[t2][0]
   				 lb $s5,0($t5)          # Load directions[t2][0] into $s0

   				 # Accessing directions[t2][1]
   				 lb $s6,1($t5) 
   				          # Load directions[t2][1] into $s1
   					 # Now $s0 and $s1 contain the values from the array for the current row
   				

   				 # Your code here

   				 # Increment loop counter
   				 addi $t4, $t4, 1


    				# Now $t8 and $t9 contain the values from the array for the current row

   				add $t3 ,$t0,$s5#newRow
				add $t5 ,$t1,$s6#newCol
				
				sub $t5,$t5,1
				
				
				# Check condition: !(newRow >= 0)=> newRow<0
    				blt $t3,$zero,Loop_start

    				# Check condition: !(newRow < row) => newRow>=row
   				bge  $t3,$s0,Loop_start

   				# Check condition: newCol >= 0
    				blt $t5,$zero,Loop_start

    				# Check condition: newCol < col
    				bge $t5,$s1,Loop_start
   				
   				
				
				#i*row+j
					mul $t3,$s0,$t3
					add $t3,$t3,$t5
			
					#board[i*row+j]
					
					add $t3,$t2,$t3	
					li $t5,0
					sb $t5,0($t3)
				
   				 
				 j Loop_start
increase_loop_1_b:

	add $t1,$zero,$zero
	addi $t0,$t0,1
	j Loop1_b
	

	

Exit:

#   #include<stdio.h>
#   
#   
#   int row,col;
#   int directions[][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
#   void GamePlant(char board[])
#   {
#       for(int i=0;i<row;i++)
#           {
#               for(int j=0;j<col;j++)
#               {
#                       board[i*row+j]+=1;
#               }
#           }
#   }
#   
#   void BombDone(char board[])
#   {
#       for(int i=0;i<row;i++)
#       {
#           for(int j=0;j<col;j++)
#           {
#               if(board[i*row+j]==2)
#               {
#                   board[i*row+j]=0;
#                   for (int k = 0; k < 4; k++) 
#                   {
#                       int newRow = i + directions[k][0];
#                       int newCol = j + directions[k][1];
#   
#                       if (newRow >= 0 && newRow < row && newCol >= 0 && newCol < col) 
#                       {
#                               board[row * newRow + newCol] = 0; 
#                       }
#                           
#                       
#                   }
#               }
#           }
#       }
#   }
#   void Print_board(char board[])
#   {
#       for(int i=0;i<row;i++)
#       {
#           for(int j=0;j<col;j++)
#           {
#               if(board[i*row+j]==0)
#                   printf(".");
#               else
#                   printf("O");
#           }
#               
#           printf("\n");
#   
#       }
#   }
#   
#   
#   
#   int main()
#   {
#   
#       int step;
#       printf("Enter Row number of board : ");
#       scanf("%d",&row);
#       printf("Enter Col number of board : ");
#       scanf("%d",&col);
#       printf("Enter Col number of step : ");
#       scanf("%d",&step);
#   
#   
#       const int row_c=row;
#       const int col_c=col;
#   
#       char boardI[row_c*col_c+1];
#       char board[row_c*col_c+1];
#   
#       
#       printf("Enter the board : ");
#       scanf("%s",boardI);
#   
#       for(int i=0;i<row;i++)
#       {
#           for(int j=0;j<col;j++)
#           {
#               if(boardI[i*row+j]=='.')
#                   board[i*row+j]=0;
#               else
#                   board[i*row+j]=1;
#           }
#   
#       }
#   
#   
#       int count=0;
#       
#       while(count!=step)
#       {
#        
#           if(count%3==1)
#               GamePlant(board);
#           else if (count%3==2)
#               BombDone(board);
#           count+=1;
#       }
#       Print_board(board);
#   
#   }
