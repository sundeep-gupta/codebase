package mail;
import java.math.BigInteger;
public class IDEA{
    private static final int BLOCK_SIZE = 8;
    private static final int NO_OF_ROUNDS = 8;
   
    public static final int PLAIN_TEXT = 0;
    public static final int CIPHER_TEXT =1 ;
    
    /*Store the 128 bit key */
    private byte[] key = new byte[16];
    
    /*Allocate memory for 52 subkeys used in the algorithm*/
    private byte[][] subkey = new byte[52][2];
    
    /*Variables to store plain text and cipher text */
    private byte[] plainText, cipherText;
    private int type;
    
    public IDEA(byte[] text, byte[] k){
        /*Store the data in private Variable */
        plainText = new byte[text.length];
        cipherText = new byte[text.length];
       
        System.arraycopy(text,0, plainText,0,text.length);
        System.arraycopy(text,0,cipherText, 0,text.length);
        
        /* store the primary key */
        System.arraycopy(k,0, key, 0, key.length);
        //key = k;
        
        /*Generate the subkeys from the main key */
        int j=0;
        for(int i = 0;i<52;i++){
            subkey[i][0] = key[j*2];
            subkey[i][1] = key[j*2+1];
            j++;
            j = (j%8)==0?0:j;
            /*after storing 8 subkeys circular shift the key value
             *by 25 bits */
            if(j==0){
                int carry=0,temp;
                for(int l =0;l<25;l++){
                    for(int m=0;m<key.length;m++){
                        temp = key[m]<<1;
                        key[m] = (byte)(temp+((m==0?0:carry)));
                        carry = (temp>>8)&0x00000001;
                    }
                    key[0] = (byte)(key[0]+carry);
                }
            }
        }
    }/* End of the constructor */
    public void encrypt(){
        byte[] block=new byte[8],cblock=new byte[8];
        for(int i = 0;i<plainText.length/BLOCK_SIZE;i++){
            for(int j =0;j<BLOCK_SIZE;j++)
                block[j] = plainText[i*BLOCK_SIZE +j];
            cblock=encryptBlock(block);
            for(int j=0;j<BLOCK_SIZE;j++)
                cipherText[i*BLOCK_SIZE+j] = cblock[j];
        }
    }
    public void decrypt(){
        byte[] block=new byte[8],cblock=new byte[8];
        for(int i = 0;i<cipherText.length/BLOCK_SIZE;i++){
            for(int j =0;j<BLOCK_SIZE;j++)
                block[j] = cipherText[i*BLOCK_SIZE +j];
            cblock=decryptBlock(block);
            for(int j=0;j<BLOCK_SIZE;j++)
                plainText[i*BLOCK_SIZE+j] = cblock[j];
        }
   }
      
   byte[] encryptBlock(byte[] text){
       byte[] a = new byte[2],b = new byte[2],c = new byte[2],d = new byte[2];
        byte[] cipher = new byte[text.length];
      
       a[0] = text[0];a[1] = text[1];
       b[0] = text[2];b[1] = text[3];
       c[0] = text[4];c[1] = text[5];
       d[0] = text[6];d[1] = text[7];
   
       for(int i = 0;i<NO_OF_ROUNDS;i++){
            a = mul(a,subkey[i*6+0]);
            b = add(b,subkey[i*6+1]);
            c = add(c,subkey[i*6+2]);
            d = mul(d,subkey[i*6+3]);
    
            byte[] t1 = exOr(a, c);
            byte[] t2 = exOr(b,d);
            byte[] t3 = mul(t1,subkey[i*6+4]);
            byte[] t4 = add(t2,t3);
            byte[] t5 = mul(t4,subkey[i*6+5]);     
            byte[] t6 = add(t5,t3);
            
            a = exOr(a,t5);
            b = exOr(b,t6);
            c = exOr(c,t5);
            d = exOr(d,t6);
            
            byte[] temp = c;
            c = b;
            b = temp;
       }
       a = mul(a, subkey[48]);
       b = add(b, subkey[49]);
       c = add(c, subkey[50]);
       d = mul(d, subkey[51]);
            
       cipher[0] = a[0]; cipher[1] = a[1];
       cipher[2] = b[0]; cipher[3] = b[1];
       cipher[4] = c[0]; cipher[5] = c[1];
       cipher[6] = d[0]; cipher[7] = d[1];
       return cipher;
   }
   byte[] decryptBlock(byte[] cipher){
       byte[] a = new byte[2],b = new byte[2],c = new byte[2],d = new byte[2];
       byte text[] = new byte[cipher.length];
       byte[][] dsubkey = new byte[52][2];
       a[0] = cipher[0];a[1] = cipher[1];
       b[0] = cipher[2];b[1] = cipher[3];
       c[0] = cipher[4];c[1] = cipher[5];
       d[0] = cipher[6];d[1] = cipher[7];
       /* generate subkeys for decryption using encryption keys */
       
       dsubkey[0] = subkey[48];
       dsubkey[1] = subkey[49];
       dsubkey[2] = subkey[50];
       dsubkey[3] = subkey[51];
       for(int in = 0;in<8;in++){
           dsubkey[in*6+4] = subkey[46-in*6];
           dsubkey[in*6+5] = subkey[47-in*6];
           dsubkey[in*6+6] = subkey[42-in*6];
           dsubkey[in*6+7] = subkey[43-in*6];
           dsubkey[in*6+8] = subkey[44-in*6];
           dsubkey[in*6+9] = subkey[45-in*6];
       }
       int i=0;
       
       a = div(a,dsubkey[i*6]);//49
       b = sub(b,dsubkey[i*6+1]);//50
       c = sub(c,dsubkey[i*6+2]);//51
       d = div(d,dsubkey[i*6+3]);//52 -i*6
                   
       for(i = 0;i<NO_OF_ROUNDS;i++){
            
            byte temp[] = c;
            c = b;
            b = temp;
            
            byte[] t1 = exOr(a, c);
            byte[] t2 = exOr(b, d);
            byte[] t3 = mul(t1, dsubkey[i*6+4]);
            byte[] t4 = add(t2, t3);
            byte[] t5 = mul(t4, dsubkey[i*6+5]); // x
            byte[] t6 = add(t5, t3);
            
            a = exOr(a, t5);
            b = exOr(b, t6);            
            c = exOr(c, t5);
            d = exOr(d, t6);
          
            a = div(a,dsubkey[i*6+6]);//49
            b = sub(b,dsubkey[i*6+7]);//50
            c = sub(c,dsubkey[i*6+8]);//51
            d = div(d,dsubkey[i*6+9]);//52 -i*6
            
       }
       text[0] = a[0]; text[1] = a[1];
       text[2] = b[0]; text[3] = b[1];
       text[4] = c[0]; text[5] = c[1];
       text[6] = d[0]; text[7] = d[1];
       return text;
    }
   byte[] exOr(byte[] op1,byte[] op2){
       byte[] temp = new byte[op1.length];
       for(int i =0;i<temp.length;i++)
           temp[i] = (byte) (op1[i]^op2[i]);
       return temp;
   }
  byte[] add(byte[] op1,byte[] op2){
       byte[] temp = new byte[op1.length];
       /* Do additive  Mod 2^16 */
       short i = new BigInteger(op1).add(new BigInteger(op2)).mod(new BigInteger("65536")).shortValue();
       temp[1] = (byte)i;
       temp[0] = (byte)(i>>8);
       return temp;
   }
   byte[] mul(byte[] op1,byte[] op2){
       byte[] temp = new byte[op1.length];
       /* Do multiplicative Mod 2^16 */
       short i = new BigInteger(1,op1).multiply(new BigInteger(1,op2)).mod(new BigInteger("65537")).shortValue();
       temp[1] = (byte)i;
       temp[0] = (byte)(i>>8);
       return temp;
       
   }
    byte[] sub(byte[] op1,byte[] op2){
       byte[] temp = new byte[op1.length];
       /* Do additive  Mod 2^16 */
       short i = new BigInteger(op1).subtract(new BigInteger(op2)).mod(new BigInteger("65536")).shortValue();
       temp[1] = (byte)i;
       temp[0] = (byte)(i>>8);
       return temp;
    }
    byte[] div(byte[] op1,byte[] op2){
       byte[] temp = new byte[op1.length];
       /* Do multiplicative Mod 2^16 */
       short i =new BigInteger(1,op2).modInverse(new BigInteger("65537")).multiply(new BigInteger(1,op1)).mod(new BigInteger("65537")).shortValue();
       temp[1] = (byte)(i&0x00ff);
       temp[0] = (byte)(i>>>8&0x00ff);
       return temp;
   }
   public byte[] getCipherText(){
       return cipherText;
   }
   public byte[] getPlainText(){
       return plainText;
   }
}
