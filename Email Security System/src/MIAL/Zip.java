package mail;
import java.util.zip.Inflater;
import java.util.zip.Deflater;
import java.util.zip.DataFormatException;
import java.io.*;
public class Zip{
	public static byte[] decompress(byte[] message)throws IOException,DataFormatException{
		Inflater in = new Inflater();
		in.setInput(message);
		byte[] result  = new byte[1024];
		ByteArrayOutputStream baos =new ByteArrayOutputStream();
		int size;
		do{
			size = in.inflate(result);
			baos.write(result,0,size);
		}while(size >0);
		byte[] retValue = baos.toByteArray();
		baos.close();
		return retValue;
	}
	public static byte[] compress(byte[] message)throws IOException,DataFormatException{

		Deflater d = new Deflater();
		d.setInput(message);
		d.finish();
		byte[] result = new byte[1024];

		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		int size;
		do{
			size = d.deflate(result);
			baos.write(result,0,size);
		}while(size >0);
		d.end();
		
		byte[] retValue = baos.toByteArray();
		baos.close();

		return retValue;
		
	}
	public static byte[] compress(InputStream messageStream)throws IOException,DataFormatException,VeryBigMessageException{
		if(messageStream.available() > 1024 * 1024 * 10)
			throw new VeryBigMessageException();


		byte[] b = new byte[messageStream.available()];
		byte[] result  = new byte[1024];

		messageStream.read(b);		
		
		return compress(b);
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
