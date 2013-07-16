package interfaces;
import java.math.BigInteger;
import java.io.*;
public class Radix64{
/*
** Translation Table as described in RFC1113
*/
	static final byte CB64[]="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".getBytes();

/*
** Translation Table to decode (created by author)
*/
	static final byte CD64[]="|$$$}rstuvwxyz{$$$$$$$>?@ABCDEFGHIJKLMNOPQRSTUVW$$$$$$XYZ[\\]^_`abcdefghijklmnopq".getBytes();
	
/*
** encodeblock
**
** encode 3 8-bit binary bytes as 4 '6-bit' characters
*/

protected byte[] encodeblock( byte in[], int len ){
    byte[] out = new byte[4];

    out[0] = (byte) CB64[( in[0] & 0xff )>>> 2 ];
    out[1] = (byte) CB64[ ((in[0] & 0x03) << 4) | ((in[1] & 0xf0) >>> 4) ];
    out[2] = (byte) (len > 1 ? CB64[ ((in[1] & 0x0f) << 2) | ((in[2] & 0xc0) >>> 6) ] : '=');
    out[3] = (byte) (len > 2 ? CB64[ in[2] & 0x3f ] : '=');
    return out;
}

/*
** encode
**
** base64 encode a stream adding padding and line breaks as per spec.
*/
public byte[] encode( byte[] binary ){
    
    byte[] base64 =new byte[ (binary.length + 2) / 3  * 4 ] ;
    
    byte in[] = new byte[3], out[] = new byte[4];
    
    int i, len, blocksout = 0,k=0;

    for(int j = 0;j<binary.length;){
        len = 0;
        for( i = 0; i < 3; i++ ) {
            if( j < binary.length ) {
		    in[i] = binary[j]; j++;
	          len++;
            }
            else {
                in[i] = 0;
            }
        }
        if( len > 0 ) {
          out =  encodeblock( in, len );
            for( i = 0; i < 4; i++ ) {
			base64[k] = out[i]; k++;
            }
            blocksout++;
        }
    } /* End of loop */
return base64;
}



/*
** decodeblock
**
** decode 4 '6-bit' characters into 3 8-bit binary bytes
*/
protected byte[] decodeblock( byte in[] ){   
    byte[] out = new byte[3];
    out[ 0 ] = ( byte ) (in[0] << 2 | in[1] >>> 4);
    out[ 1 ] = ( byte ) (in[1] << 4 | in[2] >>> 2);
    out[ 2 ] = ( byte ) (((in[2] << 6) & 0xc0) | in[3]);
    return out;
}

/*
** decode
**
** decode a base64 encoded stream discarding padding, line breaks and noise
*/
public byte[] decode( byte[] base64 ){
    byte binary[] = new byte[ base64.length / 4 * 3];

    byte[] in = new byte[4], out = new byte[3];
    byte v;
    int i, len=0, k = 0;

    for(int j = 0 ;j < base64.length;){
        for( len = 0, i = 0; i < 4 && j < base64.length ; i++ ) {
            v = 0;
            while( j < base64.length  && v == 0 ) {
                v = (byte) base64[j++]; 
                v = (byte) ((v < 43 || v > 122) ? 0 : CD64[ v - 43 ]);
                if( v > 0 ) {
                    v = (byte) ((v == '$') ? 0 : v - 61);
                }
            }
            if( j < base64.length || v > 0 ) {
					
                len++;
                if( v > 0 ) {
                    in[ i ] = (byte) (v - 1);
                }
            }
            else {
                in[i] = 0;
            }
        }
        if( len > 0 ) {
            out = decodeblock( in );
            for( i = 0; i < len - 1; i++ ) {
			binary[k] = out[i]; k++;
            }
        }
    }
byte[] bin = new byte[binary.length - (4 - len)];
System.arraycopy(binary,0,bin,0,bin.length);
return bin;
}

public static void main(String[] arg)throws FileNotFoundException,IOException{
	Radix64 radix64 = new Radix64();
	FileInputStream fis = new FileInputStream("h:\\Email Security\\test.dat");
	byte[] binary = new byte[fis.available()];
	fis.read(binary);
	byte[] t = {(byte)0x81,(byte)0x00,(byte)0xb2};
	binary =t ;
	System.out.println(new BigInteger(1,binary).toString(16));
	System.out.println("Length of binary:"+binary.length);
	byte[] base64 = radix64.encode(binary);
	System.out.println(new String(base64));
	System.out.println("Length of base64 is"+base64.length);
	byte[] bin = radix64.decode("PwCy".getBytes());
	System.out.println(new BigInteger(1,bin).toString(16));
	if(new String(binary).equals(new String(bin,0,binary.length)))
		System.out.println("is correct"+ bin.length +"Vs"+binary.length);
	else
		System.out.println("Error decoding"+ bin.length +"Vs"+binary.length);
}
}
