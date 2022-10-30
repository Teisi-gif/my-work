#***************************************************************************************************************************
# @author: Teisi Makhala
# @Purpose: Printing the first ten reversible prime squares
# @Date: October 2022
# @contact: teisilydia@gmail.com
#****************************************************************************************************************************
# H I G H - L E V E L  M O D E L (C + +)
# // A function to check if the number is prime number
# bool isPrimeNumber(int number){
#    for (int i =2; i<number; i++){
#	    if (number % i==0)
#	        return false;
#	}
#	return true;
#}
#
#// A function to reverse the number
#int reverse(int n){
#	//returns reverse of n
#	double rev= 0; int r;
#	while(n>0){
#		r= n%10;
#		rev= rev*10+r;
#		n/=10;
#	} 
#	return rev;
#}
#
#// A function to check if the number is not floating point number
# bool isFloat(double n){
#	if (ceil(n)!= n)
#	    return false;
#	    
#	return true;
# }
#
#int main()
#{
#	cout<<"The list of the first ten reversible prime squares: \n";
#	for (double j=2; j<=10000; j++){
#	    bool isPrime = isPrimeNumber(j);
#	    if (isPrime){
#	    	double b = j*j;                          //Finds prime square
#               double m = reverse(b);                  //Reverses the prime square
#	    	double a = sqrt(m);                    //pow(m,(1/2));//Finds the square root of the reversed prime square
#	    	bool isPoint = isFloat(a);
#	    	if(isPoint)
#			    if (m!=b){                       //Checks if the numbers aren't palidromes
#	            bool isPrime = isPrimeNumber(a);//Checks if the square root of the reversed square is prime
#	    	        if (isPrime)
#	    	            cout<< b <<"\n" /*<< m*/ <<"\n";
#	    	}    
#		}
#	}
#	return 0;	
#	}
#********************************************************************************************************************************
# R E G I S T E R - V A R I A B L E  M A P P I N G
# $t0: i
# $a0: 10000
# $v0: return statement (return 1 if is prime else return 0)
# $t1: return statement (returns 1 if i < num)
# $t2:
# $t3: remainder when num % i
# $t4: return statement (returns 1 if remainder < 1 else return 0)
#*********************************************************************************************************************************
.data
    resultMsg: .asciiz "The list of the first ten reversible prime: \n"
.text
.globl main
    main:
        li $v0, 4
        la $a0, resultMsg  # Print result message on screen
        syscall
        
        li $t0, 12    # j = 13 because 13 is the first reversible prime
        addi $a2, $zero, 0  # rev = 0
        addi $t4, $zero, 10  # $t4 contains 10
        addi $t1, $zero, 2      # i = 2
        
        increment: 
            addi $t0, $t0, 1
            jal forLoop
        forLoop:
            bgt $t0, 10000, exit # loop over 10000 numbers only
            jal primeLoop
            beq $v0, 1, square
    
    primeLoop:
    	beq $t0, $t1, increment # increment if i is equal to number
    	div $t0, $t1           # number / i
    	mfhi $t3             # number%i
    	beqz $t3, primeLoopContinue   # if remainder is equal to zero go to primeLoopContinue
    	addi $v0, $zero, 1       # else set $v0 to 1 and jump the register
    	jr $ra
    	
    primeLoopContinue:
        addi $t1, $t1, 1    # i++
    	j primeLoop	
    
    square:        
       mult $t0, $t0 # Finds the prime square
       mfhi $s0      
       j reverse
    reverse:
       divu $s0,$t4   #  n/10
       mflo $s0       # quotient
       mfhi $s2       # remainder
       mul $a2, $a2, $t4   #  rev = rev* 10
       addu $a2, $a2, $s2  # rev = rev + n%10
       bnez $s0, reverse
       jal float
    	     
    float:
       mtc1 $a2, $f2  # move the value in $a2 into the coproccesor 1
       cvt.s.w $f4, $f2  # convert from word to float
       j sqrt
        
    sqrt:
       sqrt.s $f6, $f4
       cvt.w.s $f12, $f6   # convert from float to word
       mfc1 $t0, $f12      # move a float from coprocessor1 to $t0
       j primeLoop
       
    isSqrtPrime:
    	div $t0, $t1           # sqrt / i
    	mfhi $t3             # sqrt%i
    	beqz $t3, primeLoopContinue   # if remainder is equal to zero go to primeLoopContinue
    	addi $t5,$zero 1     # else set $v0 to 1 and jump the register
    	jal printReversedPrimeSquare
    	
    printReversedPrimeSquare:
    	li $v0, 1
    	addi $a0, $s0,0 # print reversed prime square
    	syscall
           
    exit:
       li $v0, 10 # exit the program
       syscall
