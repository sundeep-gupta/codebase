import java.util.*;
import java.io.*;
import com.ibm.staf.*;

public class ControllerActions{
	
	GregorianCalendar calendar = null;
	String appName, fromFolder = null, toMachine = null, toFolder = null, zipFileName = null, filesList[] = null;
	StringTokenizer strTknzr = null;
	int numberOfFiles;
	STAFHandle staf;

	public ControllerActions(String appName){
	try{

		java.net.URL url = ControllerActions.class.getResource("ControllerActions"); //let javaloader find the complete class path of this class first 
		StringBuffer propertiesPath = new StringBuffer(url.getFile()); 
		propertiesPath.delete(0,1);
		propertiesPath.delete(propertiesPath.lastIndexOf("/") + 1, propertiesPath.length());


		Properties prop = new Properties();
		prop.load(new FileInputStream(propertiesPath.toString() + "\\jmeter.properties"));

		fromFolder = prop.getProperty("user.dir");
		toMachine = prop.getProperty("tomachine");
		toFolder = prop.getProperty("tofolder");

		this.appName = appName;
	}catch(IOException ioe){
		System.out.println("\nError Occured");
		ioe.printStackTrace();
		System.exit(1);
	}


	}

	public void doAllActions(){
		try{
		staf = new STAFHandle(appName);

		//	Listing the files in the folder that are present at that instant
		String str = staf.submit("local", "fs", "list directory " + fromFolder);

		if(str.equals("")){
			System.out.println("Sorry, the specified folder is empty");
			System.exit(1);
		}

		strTknzr = new StringTokenizer(str, "\n\r");
		numberOfFiles = strTknzr.countTokens();
		filesList = new String[numberOfFiles];

		calendar = new GregorianCalendar();
		zipFileName = "zipFile" + calendar.get(Calendar.HOUR_OF_DAY) + "_" + calendar.get(Calendar.MINUTE) + "_" + calendar.get(Calendar.SECOND) + ".zip";

		calendar = new GregorianCalendar();
		System.out.println("Actual work started");
		System.out.println(calendar.get(Calendar.HOUR_OF_DAY) + ":" + calendar.get(Calendar.MINUTE) + ":" + calendar.get(Calendar.SECOND));

		//	Zipping the files found
		for(int loopCount=0; loopCount < numberOfFiles; loopCount++){
			filesList[loopCount] = strTknzr.nextToken();
			if(staf.submit("local", "fs", "get entry " + fromFolder + "\\\"" + filesList[loopCount] + "\" type").trim() .equalsIgnoreCase("f")){
				str = staf.submit("local", "zip", "zip add zipfile D:\\" + zipFileName + " file " + fromFolder + "\\\"" + filesList[loopCount]  + "\" relativeto " + fromFolder);
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

		
		//	Deleting the zip file which is placed in a temporary folder
		str = staf.submit("local", "fs", "delete entry D:\\" + zipFileName + " confirm");
		System.out.print("Zipfile deletion completed\t");
		calendar = new GregorianCalendar();
		System.out.println(calendar.get(Calendar.HOUR_OF_DAY) + ":" + calendar.get(Calendar.MINUTE) + ":" + calendar.get(Calendar.SECOND));

		System.out.println("All the actions are completed");

		}catch(STAFException e){
			System.out.println("\nError Occurred\n" + e.getMessage());
		}catch(Exception e){
					System.out.println("\nError Occured");
					e.printStackTrace();
		}

	}

	public static void main(String[] args){
	try{
		ControllerActions ctrlActions = new ControllerActions("ControllerActions");
		ctrlActions.doAllActions();
	}catch(Exception ioe){
		System.out.println("Exception");
		System.out.print(ioe.getMessage());
	}
	}

}