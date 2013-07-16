import java.util.*;
import java.io.*;
import com.ibm.staf.*;

public class CopyTime{
	public static void main(String[] args) throws Exception{
		try{
/*		//	Reading the properties file to get the name of the folder
		Properties prop = new Properties(System.getProperties());

		prop.load(new FileInputStream("jmeter.properties"));
		StringBuffer folder = new StringBuffer(prop.getProperty("user.dir"));

*/
//		Date date = new Date();
		GregorianCalendar calendar = new GregorianCalendar();


		STAFHandle staf = new STAFHandle("hai");

		System.out.println(calendar.get(Calendar.HOUR_OF_DAY) + ":" + calendar.get(Calendar.MINUTE) + ":" + calendar.get(Calendar.SECOND));


		String str = staf.submit("local", "zip", "zip add zipfile d:\\new\\junk\\new.zip file d:\\new\\junk\\junk.dat" );
		System.out.print("Zipping Completed\t");
		calendar = new GregorianCalendar();
		System.out.println(calendar.get(Calendar.HOUR_OF_DAY) + ":" + calendar.get(Calendar.MINUTE) + ":" + calendar.get(Calendar.SECOND));


		str = staf.submit("local", "fs", "copy file d:\\new\\junk\\new.zip tofile c:\\tempFolder\\new.zip tomachine pvijay");
		System.out.print("Zipped transfer completed\t");
		calendar = new GregorianCalendar();
		System.out.println(calendar.get(Calendar.HOUR_OF_DAY) + ":" + calendar.get(Calendar.MINUTE) + ":" + calendar.get(Calendar.SECOND));

		str = staf.submit("pvijay", "fs", "delete entry c:\\tempFolder\\new.zip confirm");
		System.out.print("Zipfile deletion Completed\t");
		calendar = new GregorianCalendar();
		System.out.println(calendar.get(Calendar.HOUR_OF_DAY) + ":" + calendar.get(Calendar.MINUTE) + ":" + calendar.get(Calendar.SECOND));

		str = staf.submit("local", "fs", "copy file d:\\new\\junk\\junk.dat tofile d:\\new\\junk\\junk1.dat tomachine pvijay");
		System.out.print("File transfer completed\t");
		calendar = new GregorianCalendar();
		System.out.println(calendar.get(Calendar.HOUR_OF_DAY) + ":" + calendar.get(Calendar.MINUTE) + ":" + calendar.get(Calendar.SECOND));

		}catch(STAFException e){
			System.out.println("Error Occurred\n" + e.getMessage());
		}
		
	}
}
