import java.io.*;
import com.ibm.	staf.*;
import java.util.Properties;
import java.util.StringTokenizer;


public class ImportToDB {
	public static void main(String[] args){
				
		String outFolder = null, dbName = null, dbTableName = null, delimiter = null, optEnclChar = null, escChar = null, lineStart = null, lineEnd = null, str = null, filesList[] = null;
		Properties prop = null;
		StringTokenizer strTknzr = null;
		STAFHandle staf = null;
		int numberOfFiles = 0;

		//	Reading the properties file and getting the needed information
		prop = new Properties(System.getProperties());
		try{

		prop.load(new FileInputStream("jmeter.properties"));
		outFolder = prop.getProperty("outfolderforimporting");
		dbName = prop.getProperty("dbname");
		dbTableName = prop.getProperty("dbtablename");
		delimiter = prop.getProperty("delimiter");
		optEnclChar = prop.getProperty("optenclosingchar");
		escChar = prop.getProperty("escapechar");
		lineStart = prop.getProperty("linestart");
		lineEnd = prop.getProperty("lineend");

		staf = new STAFHandle("ImportToDB");

		str = staf.submit("local", "fs", "list directory " + outFolder);

		if(str.equals("")){
			System.out.println("No files in the specified folder");
			System.exit(1);
		}

		strTknzr = new StringTokenizer(str, "\n\r");
		numberOfFiles = strTknzr.countTokens();
		filesList = new String[numberOfFiles];

		PrintWriter pw = null;

		for(int loopCount=0; loopCount < numberOfFiles; loopCount++){
			filesList[loopCount] = strTknzr.nextToken();

			System.out.println(filesList[loopCount]);

		//		Constructing the batchfile with current file as the input to the database
			pw = new PrintWriter(new FileWriter("ActualBatch.bat"));

			pw.write("use " + dbName + ";\n");
			pw.write("load data infile \"" + outFolder + "\\\\" + filesList[loopCount] + "\" into table " + dbTableName + " fields terminated by \'" + delimiter + "\' optionally enclosed by \'" + optEnclChar + "\' escaped by \'" + escChar + "\' lines starting by \'" + lineStart + "\' terminated by \'" + lineEnd + "\';");

			pw.flush();
			pw.close();

			//		Executing the MainBatch.bat which inturn starts the ActualBatch.bat constructed in the previous step
			Process p = Runtime.getRuntime().exec("MainBatch.bat");
			p.waitFor();
//			Thread.sleep(15000);
			
			//		Deleting the csv file that has been imported into the database successfully
			//str = staf.submit("local", "fs", "delete entry " + outFolder + "\\\"" + filesList[loopCount] + "\" confirm");
		
		}

		Thread.sleep(30000);

		for(int loopCount=0; loopCount < numberOfFiles; loopCount++){
			str = staf.submit("local", "fs", "delete entry " + outFolder + "\\\"" + filesList[loopCount] + "\" confirm");
		}

		}catch(STAFException se){
			System.out.println(se.getMessage());
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
