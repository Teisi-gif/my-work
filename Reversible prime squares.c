/****************************************************************
/ @author: Teisi Makhala
/ @purpose: Printing the first 10 revesible prime squares
/ @date: October 2022
/ @contact: teisilydia@gmail.com
/****************************************************************/

#include <stdio.h>
#include <stdbool.h>
#include <math.h>


// A function to check if the number is prime number
bool isPrimeNumber(int number){
    for (int i =2; i<number; i++){
	    if (number % i==0)
	        return false;
	}
	return true;
}

// A function to reverse the number
int reverse(int n){
	//returns reverse of n
	double rev= 0; int r;
	while(n>0){
		r= n%10;
		rev= rev*10+r;
		n/=10;
	} 
	return rev;
}

// A function to check if the number is not floating point number
bool isFloat(double n){
	if (ceil(n)!= n)
	    return false;
	    
	return true;
}

int main()
{
	printf("%s" ,"The list of the first ten reversible prime squares: \n");
	for (double j=2; j<=10000; j++){
	    bool isPrime = isPrimeNumber(j);
	    if (isPrime){
	    	int b = j*j;                                      //Finds prime square
	    	double m = reverse(b);                           //Reverses the prime square
	    	double a = sqrt(m);                             //Finds the square root of the reversed prime square
	    	bool isPoint = isFloat(a);                     // Checks if the square root is not a floating point number
	    	if(isPoint)
			    if (m!=b){                                // Checks if the numbers aren't palidromes
	                bool isPrime = isPrimeNumber(a);     // Checks if the square root of the reversed square is prime
	    	        if (isPrime)
	    	            printf( "%d\n\n",b);
		}						
	}
	
}

	return 0;	
	}
	
