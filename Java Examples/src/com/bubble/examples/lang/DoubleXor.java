public class DoubleXor {
	public int calculate( int N ) {
	   
	    if ( N == 1 ) {
	    	return 1;
	    } else {
	    	return calculateDoubleXor(N, N-1);
	    }
	} 
	private int calculateDoubleXor (int A, int B) {  
	    while(B != 0) {
		    int[] a = split_digits(A);
		    int[] b = split_digits(B);
		    int diff = Math.abs(a.length - b.length);
		    int[] c = new int [ Math.max ( a.length, b.length ) ];
		    if ( a.length != b.length ) {
			
			if( a.length > b.length ) {
				for ( int i = 0; i < diff; i++ ) { 
					c[i] = a[i];
				}
				for (int i = diff; i < c.length; i++ ) {
					c[i] = ( a[i] ^ b[i - diff ] ) % 10;
				}
			} else {
				for (int i = 0; i < diff; i++ ) {
					c[i] = b[i];
				}
				for (int i = diff; i < c.length; i++ ) {
					c[i] = ( a[i - diff ] ^ b[i] ) % 10;
				}
			}
		    } else {
			for( int i = 0; i < c.length; i++) {
				c[i] = ( a[i] ^ b[i] ) % 10;
			}
		    }
		    
		int C = unify_digits(c);
		
		A = C; B = B - 1;
		
		    if (B == 0 ) {
			return C;
		    } 
		}
		return 0;
	}
	
	private int[] split_digits ( int number ) {
		int num_length = new Integer(number).toString().length();
		int[] digits = new int[num_length];
		int i = num_length - 1;
		while (number > 0 ) {
			digits[i] = number % 10;
			i--;
			number /= 10;
		}
		return digits;
	}
	private int unify_digits ( int[] digits ) {
		int num = 0;
		for ( int i = 0; i < digits.length; i++ ) {
			
			num = num * 10 + digits[i];
		}
		return num;
	} 

}
