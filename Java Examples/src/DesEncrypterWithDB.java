import javax.crypto.*;
import java.io.*;
import java.sql.*;

public class DesEncrypterWithDB {
        Cipher ecipher;
        Cipher dcipher;
    
        DesEncrypterWithDB() {
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

		Connection con = null;
		PreparedStatement pstmt = null;

		
		
		SecretKey key = KeyGenerator.getInstance("DES").generateKey();

		try{
			Class.forName("com.mysql.jdbc.Driver"). newInstance();
		}catch(java.lang.ClassNotFoundException e){
			e.printStackTrace();
		}
		
/*		// Serialize to a file
        ObjectOutput out = new ObjectOutputStream(new FileOutputStream("filename.ser"));
        out.writeObject(key);
        out.close();
*/

   
        // Create encrypter/decrypter class
        DesEncrypterWithDB encrypter = new DesEncrypterWithDB();

		String x = "praveen Applabs";
		System.out.println("Actual string : " + x);    

        // Encrypt
        String encrypted = encrypter.encrypt(x, key);
		System.out.println("Encrypted string : " + encrypted);

		ObjectOutput outDesktop = new ObjectOutputStream(System.out);
        outDesktop.writeObject(key);

		//	Import key and encrypted data into DB
		ByteArrayOutputStream outStream = new ByteArrayOutputStream();
		ObjectOutput out = new ObjectOutputStream(outStream);
		out.writeObject(key);
		out.close();
System.out.println("\nKey :" + outStream.toByteArray().toString());
		ByteArrayInputStream inStream1 = new ByteArrayInputStream(outStream.toByteArray());
		outStream.close();
System.out.println("Size of instream : " + inStream1.available());		

		out = null;
		outStream = null;

		outStream = new ByteArrayOutputStream();
		out = new ObjectOutputStream(outStream);
		out.writeObject(encrypted);
		out.close();

		ByteArrayInputStream inStream2 = new ByteArrayInputStream(outStream.toByteArray());
		outStream.flush();
		outStream.close();
System.out.println("Size of instream : " + inStream2.available());		

		try{
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/roughdb","root","password");
			pstmt = con.prepareStatement("insert into encrypt values(?, ?)");
			pstmt.setBinaryStream(1,inStream1,inStream1.available());
			pstmt.setBinaryStream(2,inStream2,inStream2.available());
			pstmt.executeUpdate();
			System.out.println("Successfully Uploaded");
			
		}catch(SQLException esql){
			esql.printStackTrace();
		}

		key = null;

/*		// Getting the data from the file (Deserializing)
		ObjectInputStream ins = new ObjectInputStream(new FileInputStream("filename.ser"));
		SecretKey key123 = (SecretKey)ins.readObject();
*/    

			
		ResultSet rs = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY).executeQuery("select * from encrypt");
			while(rs.next()){
				rs.last();
				ObjectInput in = new ObjectInputStream(rs.getBinaryStream(1));
				key = (SecretKey)in.readObject();
				ObjectInput in2 = new ObjectInputStream(rs.getBinaryStream(2));
				encrypted = (String)in2.readObject();
			}

        // Decrypt
        String decrypted = encrypter.decrypt(encrypted, key);
		System.out.println("Decrypted string : " + decrypted);    

	    } catch (Exception e) {
		}

		}
}
