import mail.Radix64;
import java.io.*;
public class TestRadix64{
	public static void main(String[] arg)throws Exception{
		FileInputStream fis = new FileInputStream("g:/riyazfreport2.doc");
		byte[] input = new byte[fis.available()];
		fis.read(input);
		input = new Radix64().encode(input);
		fis.close();
		
		FileOutputStream fos = new FileOutputStream("g:/abc.doc");
		fos.write( new Radix64().decode(input) );
		fos.close();
		
		fis = new FileInputStream("g:/abc.doc");
		input = new byte[fis.available()];
		fis.read(input);
		input = new Radix64().encode(input);
		fis.close();

		fos = new FileOutputStream("d:/sand.doc");
		fos.write(new Radix64().decode(input));
		fos.close();
		
	}
}