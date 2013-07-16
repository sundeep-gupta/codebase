package mail;
import java.security.MessageDigest;
import java.math.BigInteger;
import java.io.IOException;
import java.io.InputStream;
import java.security.NoSuchAlgorithmException;

public class SecureHash{
	byte[] message,hashValue;
	private SecureHash(byte[] message)throws NoSuchAlgorithmException,IOException{
		this.message = message;
		MessageDigest md = MessageDigest.getInstance("SHA");
		md.update(message);
		hashValue = md.digest(message);
	}
	public static SecureHash generateSecureHash(java.io.InputStream messageStream)
												throws VeryBigMessageException,
												 	 NoSuchAlgorithmException,
													 IOException{
		if(messageStream.available() > 1024*1024*10)
			throw new VeryBigMessageException("Cannot send message greater than 10 MB");
		byte[] message = new byte[messageStream.available()];	
		return new SecureHash(message);
	}
	public static SecureHash generateSecureHash(byte[] message)throws VeryBigMessageException,
											NoSuchAlgorithmException,
											IOException{
		if(message.length > 1024*1024*10)
			throw new VeryBigMessageException("Cannot send message greater than 10 MB");
		return new SecureHash(message);
	}
	public byte[] getHashValue(){
		return hashValue;		
	}
	public static void main(String[] arg)throws Exception{
		java.io.FileInputStream fis = new java.io.FileInputStream("c:/j2sdk1.4/src.zip");
		if(fis.available() < 1024*1024*10){
			byte[] message = new byte[fis.available()];
			MessageDigest md = MessageDigest.getInstance("SHA");
			System.out.println("Length of the file"+fis.available());
			int len;
			System.out.println("Please wait...");
			while((len=fis.read(message)) != -1){
				 md.update(message,0,len);
				System.out.println("Len is :"+len);
			}
			 byte[] hash = md.digest(message);
			System.out.println("Message Digest is : " + new BigInteger(1,hash).toString(16)); 
		}else
			System.out.println("Cannot encrypt message greater than 10MB");
	}
}