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
         addi $a0, $zero, 10000  
        
        # Print the result message onscreen
        li $v0, 4
        la $a0, resultMsg
        syscall
        
        for:
            jal isPrime
            #bgt $t0, 10000, exit
            #jal isPrimeTest
            beq $v0, 1, square
             
            
            
        exit:
            end
            
        # Exit the program
        li $v0, 10
        syscall
        
 .globl isPrime      
    isPrime:
        addi $t0, $zero, 2                                      # int i = 2
        j isPrimeTest
        
    isPrimeTest:
        slt $t1, $t0, $a0                                     # if (i<num)
        bne $t1, $zero, isPrimeLoop                                # go to isPrimeLoop
        addi $v0, $zero, 1                                   # It's prime!
        jr $ra                                                    # return 1
                                                           # else
    isPrimeLoop:
        div $a0, $t0
        mfhi $t3                                       # c = (num % i)
        slti $t4, $t3, 1
        beq $t4, $zero, isPrimeLoopContinue            # if (c == 0)
        add $v0, $zero, $zero                                 #it's not prime
        jr $ra                                                    # return 0
        
    isPrimeLoopContinue:
        addi $t0, $t0, 1                           # x++
        j isPrimeTest                              # continue the loop
        
    reverse:
        
        j float
    square:
        mult $t0,$t0
        mfhi $s0
        j reverse
        
    float:
        mtc1 $t1, $f1  # $t1 contain in which we have to find it's square root
        cvt.w.s $f1, $f1
        j sqrt
        
    sqrt:
        sqrt.s $f1, $f1
        j isPrimeTest