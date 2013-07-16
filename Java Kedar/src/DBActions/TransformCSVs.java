import com.ibm.staf.*;
import java.util.Properties;
import java.util.StringTokenizer;
import java.util.GregorianCalendar;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.File;

public class TransformCSVs{
	public static void main(String[] args){

		String inOutFolder = null, outFolder = null, str = null, filesList[] = null;
		Properties prop = null;
		StringTokenizer strTknzr = null;
		Runtime r = Runtime.getRuntime();
		STAFHandle staf = null;
		int numberOfFiles = 0;

		BufferedReader br = null;
		PrintWriter pw = null;
		String line = "";
		char buffer[] = new char[1024];
		StringBuffer temp = null;
		boolean html = false, endHtml = false;
		int toBeReplaced=0, comma = 0, quoteMark = 0, htmlIndex = 0, endHtmlIndex = 0, x = 0;


		r.gc();

		//	Reading the properties file and getting the needed information
		prop = new Properties(System.getProperties());
		try{
		prop.load(new FileInputStream("jmeter.properties"));
		
		inOutFolder = prop.getProperty("inoutfolder");
		outFolder = prop.getProperty("outfolder");

		staf = new STAFHandle("TransformCSVs");

		//	Listing the contents of the folder at that instance of time
		str = staf.submit("local", "fs", "list directory " + inOutFolder);

		if(str.equals("")){
			System.out.println("No files in the specified folder");
			System.exit(1);
		}

		strTknzr = new StringTokenizer(str, "\n\r");
		numberOfFiles = strTknzr.countTokens();
		filesList = new String[numberOfFiles];

		//	Transforming each file and placing it in the out folder and deleting from the current folder
		for(int loopCount=0; loopCount < numberOfFiles; loopCount++){
			filesList[loopCount] = strTknzr.nextToken();

		//	Transforming the csv file
			try{
			r.gc();

			br = new BufferedReader(new FileReader(inOutFolder + "\\" + filesList[loopCount]));
			pw = new PrintWriter(new FileWriter(outFolder + "\\" + filesList[loopCount]));

			long t1 = new GregorianCalendar().getTimeInMillis();
			r.gc();
			while((line = br.readLine())!= null){

				temp = new StringBuffer(line);
			
				htmlIndex = temp.indexOf("expected to contain:");
				endHtmlIndex = temp.indexOf("</html>");

				if((htmlIndex != -1) && (!html)){
					html = true;
				}
				if(endHtmlIndex != -1){
					endHtml = true;
				}
	
				if(htmlIndex == -1)	htmlIndex = 0;
				if(endHtmlIndex == -1)	endHtmlIndex = 0;
	
				if(((!html) && (!endHtml)) ){
					pw.write(temp.toString().trim());
					temp = null;
					continue;
				}

				if(html && !endHtml){
					quoteMark = htmlIndex;
					while((toBeReplaced  = temp.indexOf("\"", quoteMark))!= -1){
						temp.replace(toBeReplaced, toBeReplaced+1, "\\\"");
						quoteMark = toBeReplaced + 2;
					}

					comma = htmlIndex;
					while((toBeReplaced  = temp.indexOf(",", comma))> htmlIndex){
						temp.replace(toBeReplaced, toBeReplaced+1, "\\,");
						comma = toBeReplaced + 2;
					}

					pw.write(temp.toString().trim());
					temp = null;
					continue;
				}

				if(html && endHtml){
				
					quoteMark = 0;
					while((toBeReplaced = temp.indexOf("\"", quoteMark)) < endHtmlIndex){
						if(toBeReplaced == -1)	break;
						temp.replace(toBeReplaced, toBeReplaced+1, "\\\"");
						quoteMark = toBeReplaced + 2;
					}

					comma = htmlIndex;
					while((toBeReplaced  = temp.indexOf(",", comma))< endHtmlIndex){
						if(toBeReplaced == -1)	break;
						temp.replace(toBeReplaced, toBeReplaced+1, "\\,");
						comma = toBeReplaced + 2;
					}
	
					pw.write(temp.toString().trim());
					temp = null;
					html = endHtml = false;
		
				}
				r.gc();
					
			}
			
			pw.flush();
			br.close();
			pw.close();
			br = null;
			pw= null;
			r.gc();

			long t2 = new GregorianCalendar().getTimeInMillis();
			System.out.println("Transformation time : " + String.valueOf(t2 - t1));
			}catch(IOException ioe){
				System.out.println("err");
				pw.close();
				br.close();
				str = staf.submit("local", "fs", "delete entry " + outFolder + "\\\"" + filesList[loopCount] + "\" confirm");
				ioe.getCause();
				
			}

		//	Deleting the source csv file after transformation
			str = staf.submit("local", "fs", "delete entry " + inOutFolder + "\\\"" + filesList[loopCount] + "\" confirm");
		}

		}catch(IOException ioe){
			ioe.printStackTrace();
			System.out.println("\n");
			ioe.getCause();
		}catch(STAFException e){
			System.out.println(e.getMessage());
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
