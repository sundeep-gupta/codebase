import java.util.*;
import java.io.*;
import com.ibm.staf.*;

/*
		reading in/out/inout foldernames from the properties file
		unzipping the zip files in in folder ------> inout folder (csv files)
		transforming the files in inout folder ------>out folder


*/

public class ControllerActions{
	public static void main(String[] args) throws Exception{

		GregorianCalendar calendar = null;
		String fromFolder = null, toMachine = null, toFolder = null, zipFileName = null, filesList[] = null;
		StringTokenizer strTknzr = null;
		int numberOfFiles = 0;
		Properties prop = null;

		//	Reading the properties file to get the name of the source folder
		prop = new Properties(System.getProperties());
		try{
		prop.load(new FileInputStream("jmeter.properties"));
		
		fromFolder = prop.getProperty("user.dir");
		toMachine = prop.getProperty("tomachine");
		toFolder = prop.getProperty("tofolder");


		STAFHandle staf = new STAFHandle("hai");

		//	Listing the files in the folder
		String str = staf.submit("local", "fs", "list directory " + fromFolder);
		strTknzr = new StringTokenizer(str, "\n\r");
		numberOfFiles = strTknzr.countTokens();
		filesList = new String[numberOfFiles];

		calendar = new GregorianCalendar();
		zipFileName = "zipFile" + calendar.get(Calendar.HOUR_OF_DAY) + "_" + calendar.get(Calendar.MINUTE) + "_" + calendar.get(Calendar.SECOND) + ".zip";

		//	Zipping the files found at that instance of time
		for(int loopCount=0; loopCount < numberOfFiles; loopCount++){
			filesList[loopCount] = strTknzr.nextToken();
			if(staf.submit("local", "fs", "get entry " + fromFolder + "\\\"" + filesList[loopCount] + "\" type").trim() .equalsIgnoreCase("f")){
				str = staf.submit("local", "zip", "zip add zipfile D:\\" + zipFileName + " file " + fromFolder + "\\\"" + filesList[loopCount]  + "\"");
			}
		}
		System.out.print("Zipping Completed\t");
		calendar = new GregorianCalendar();
		System.out.println(calendar.get(Calendar.HOUR_OF_DAY) + ":" + calendar.get(Calendar.MINUTE) + ":" + calendar.get(Calendar.SECOND));


		//	Transferring the zip file
		str = staf.submit("local", "fs", "copy file D:\\" + zipFileName + " tofile " + toFolder + "\\" + zipFileName + " tomachine " + toMachine);
		System.out.print("Transfer completed\t");
		calendar = new GregorianCalendar();
		System.out.println(calendar.get(Calendar.HOUR_OF_DAY) + ":" + calendar.get(Calendar.MINUTE) + ":" + calendar.get(Calendar.SECOND));

		//	Deleting the zipped files (not the zip file)
		for(int loopCount = 0; loopCount < filesList.length; loopCount++){
			if(staf.submit("local", "fs", "get entry " + fromFolder + "\\\"" + filesList[loopCount] + "\" type").trim() .equalsIgnoreCase("f")){
				str = staf.submit("local", "fs", "delete entry " + fromFolder + "\\\"" + filesList[loopCount] + "\" confirm");
			}
		}
		System.out.print("Deletion of zipped files completed\t");
		calendar = new GregorianCalendar();
		System.out.println(calendar.get(Calendar.HOUR_OF_DAY) + ":" + calendar.get(Calendar.MINUTE) + ":" + calendar.get(Calendar.SECOND));

		
		//	Deleting the zip file
		str = staf.submit("local", "fs", "delete entry D:\\" + zipFileName + " confirm");
		System.out.print("Zipfile deletion completed\t");
		calendar = new GregorianCalendar();
		System.out.println(calendar.get(Calendar.HOUR_OF_DAY) + ":" + calendar.get(Calendar.MINUTE) + ":" + calendar.get(Calendar.SECOND));

		System.out.println("All the actions are completed");

		}catch(STAFException e){
			System.out.println("Error Occurred\n" + e.getMessage());
		}
		
	}
}
