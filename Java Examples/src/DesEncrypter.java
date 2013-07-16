import javax.crypto.*;
import java.io.*;

public class DesEncrypter {
        Cipher ecipher;
        Cipher dcipher;
    
        DesEncrypter() {
		}

                
    
    
        public String encrypt(String str, SecretKey key) {
            try {
	            try {
				ecipher = Cipher.getInstance("DES");
				ecipher.init(Cipher.ENCRYPT_MODE, key);
		        } catch (javax.crypto.NoSuchPaddingException e) {
	            } catch (java.security.NoSuchAlgorithmException e) {
			    } catch (java.security.InvalidKeyException e) {
	            }
	        


                // Encode the string into bytes using utf-8
                byte[] utf8 = str.getBytes("UTF8");
    
                // Encrypt
                byte[] enc = ecipher.doFinal(utf8);
    
                // Encode bytes to base64 to get a string
                return new sun.misc.BASE64Encoder().encode(enc);
            } catch (javax.crypto.BadPaddingException e) {
            } catch (IllegalBlockSizeException e) {
            } catch (UnsupportedEncodingException e) {
            } catch (java.io.IOException e) {
            }
            return null;
        }
    
        public String decrypt(String str, SecretKey key) {
            try {
				try {
                dcipher = Cipher.getInstance("DES");
                dcipher.init(Cipher.DECRYPT_MODE, key);
					} catch (javax.crypto.NoSuchPaddingException e) {
		            } catch (java.security.NoSuchAlgorithmException e) {
				    } catch (java.security.InvalidKeyException e) {
		            }
		        

                // Decode base64 to get bytes
                byte[] dec = new sun.misc.BASE64Decoder().decodeBuffer(str);
    
                // Decrypt
                byte[] utf8 = dcipher.doFinal(dec);
    
                // Decode using utf-8
                return new String(utf8, "UTF8");
            } catch (javax.crypto.BadPaddingException e) {
            } catch (IllegalBlockSizeException e) {
            } catch (UnsupportedEncodingException e) {
            } catch (java.io.IOException e) {
            }
            return null;
        }

		public static void main(String[] args){
		try {
        // Generate a temporary key. In practice, you would save this key.
        // See also e464 Encrypting with DES Using a Pass Phrase.

		SecretKey key = KeyGenerator.getInstance("DES").generateKey();
		// Serialize to a file
        ObjectOutput out = new ObjectOutputStream(new FileOutputStream("filename.ser"));
        out.writeObject(key);
        out.close();

   
        // Create encrypter/decrypter class
        DesEncrypter encrypter = new DesEncrypter();

		String x = "Don't tell anybody!";
		System.out.println("Actual string : " + x);    

        // Encrypt
        String encrypted = encrypter.encrypt(x, key);
		System.out.println("Encrypted string : " + encrypted);

		key = null;

		ObjectInputStream ins = new ObjectInputStream(new FileInputStream("filename.ser"));
		SecretKey key123 = (SecretKey)ins.readObject();
    
        // Decrypt
        String decrypted = encrypter.decrypt(encrypted, key123);
		System.out.println("Decrypted string : " + decrypted);    
	    } catch (Exception e) {
		}

		}
}
