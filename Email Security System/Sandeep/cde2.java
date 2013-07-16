package mail;
import java.util.zip.Inflater;
import java.util.zip.DataFormatException;
import java.io.*;
public class Decompress{
	public static byte[] decompress(byte[] message){
		Inflater in = new Inflater();
		in.setInput(message);
		byte[] result  = new byte[1024];
		ByteArrayOutputStream baos =new BytArrayOutputStream();
		do{
			size = in.inflate(result);
			System.out.println("Inflated to:"+(i++)+" "+size);
			baos.write(result,0,size);
		}while(size >0);

		return baos.toByteArray();
	}
	public static void main(String[] arg)throws Exception{
		FileInputStream fis = new FileInputStream("./Def.z");
		byte[] bio = new byte[fis.available()];
		fis.read(bio);	
		System.out.println("Initial bytes: "+bio.length);
		Inflater in = new Inflater();
		in.setInput(bio,0,bio.length);
		byte[] result  = new byte[1024];
		FileOutputStream fos =new FileOutputStream("./abc.dat");
		int size,i = 0;
		do{
			size = in.inflate(result);
			System.out.println("Inflated to:"+(i++)+" "+size);
			fos.write(result,0,size);
		}while(size >0);

		fos.close();
		fis.close();
	}
}
