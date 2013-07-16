import com.ibm.staf.*;
import java.util.Properties;
import java.util.StringTokenizer;
import java.io.FileInputStream;
import java.io.IOException;

public class UnzipCSVs{
	public static void main(String[] args){

		String inFolder = null, inOutFolder = null, backupFolder = null, str = null, filesList[] = null;
		Properties prop = null;
		StringTokenizer strTknzr = null;
		STAFHandle staf = null;
		int numberOfFiles = 0;

		//	Reading the properties file and getting the needed information
		prop = new Properties(System.getProperties());
		try{
		prop.load(new FileInputStream("jmeter.properties"));
		
		inFolder = prop.getProperty("infolder");
		inOutFolder = prop.getProperty("inoutfolder");
		backupFolder = prop.getProperty("backupfolder");

		staf = new STAFHandle("UnzipCSVs");

		//	Listing the contents of the folder at that instance of time
		str = staf.submit("local", "fs", "list directory " + inFolder);

		if(str.equals("")){
			System.out.println("No files in the specified folder");
			System.exit(1);
		}

		strTknzr = new StringTokenizer(str, "\n\r");
		numberOfFiles = strTknzr.countTokens();
		filesList = new String[numberOfFiles];

		//	Unzipping each file, making the backup of each zip file by storing it in backupFolder and deleting the zip file from the actual folder
		for(int loopCount=0; loopCount < numberOfFiles; loopCount++){
			filesList[loopCount] = strTknzr.nextToken();
				str = staf.submit("local", "zip", "unzip zipfile " + inFolder + "\\\"" + filesList[loopCount] + "\" todirectory " + inOutFolder);
				str = staf.submit("local", "fs", "copy file " + inFolder + "\\\"" + filesList[loopCount] + "\" tofile " + backupFolder + "\\\"" + filesList[loopCount] + "\"");
				str = staf.submit("local", "fs", "delete entry " + inFolder + "\\\"" + filesList[loopCount] + "\" confirm");
		}

		}catch(STAFException e){
			System.out.println(e.getMessage());
		}catch(IOException ioe){
			ioe.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
