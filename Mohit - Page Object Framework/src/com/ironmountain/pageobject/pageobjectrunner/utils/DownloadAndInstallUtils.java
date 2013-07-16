package com.ironmountain.pageobject.pageobjectrunner.utils;



import java.io.File;
import java.io.FilenameFilter;
/*import java.io.InputStream;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;*/

import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.utils.Executor;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;

/** This Class executes the executables that are created through Autoit to 
 *  handle Download Dialog from IE or Firefox and install the Agent. 
 *  @author pjames
 *
 */
public class DownloadAndInstallUtils {

	
	public static String Browser = PropertyPool.getProperty("browser");
	public static String DownloadLocation = FileUtils.getBaseDirectory() + "\\" + PropertyPool.getProperty("downloadsdir") + "\\"+ PropertyPool.getProperty("AgentSetupFile");
	public static String OS = PropertyPool.getProperty("OS");
	public static String DownloadOpt = PropertyPool.getProperty("DownloadOpt");
	public static String ExeName;
	public static String[] dialog;
	public static FileUtils fileutil;
	public static Executor exec;
	public static String ExeLoc;
	
	
	/** This method creates a runtime process builder instance and executes the command. 
	 * @param dialog
	 * This method can further be updated.
	 
	public static void exec(String[] dialog){
		try{		
		ProcessBuilder proc = new ProcessBuilder(dialog);
		Process p = proc.start();
		BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));           
		BufferedReader stdError = new BufferedReader(new InputStreamReader(p.getErrorStream()));           
		// read the output from the command           
		String s = null;          
		System.out.println("Here is the standard output of the command:\n");          
		while ((s = stdInput.readLine()) != null) {              
			System.out.println(s);          }           
		// read any errors from the attempted command           
		System.out.println("Here is the standard error of the command (if any):\n");          
		while ((s = stdError.readLine()) != null) {              
			System.out.println(s);          }		
		System.out.println("I am In try");	  }  	
		catch(Exception e){ 
			e.printStackTrace();
			System.out.println("I am In catch");			
			}
	}*/
	
	/** Searches for files with exe extn and returns the actual path of the Exe along with the exename.
	 * @param ExeName
	 * @return
	 * @throws Exception
	 */
	public static String getExeCannonicalPath(String ExeName)throws Exception{
		File directory = new File(".");
		FilenameFilter filter = new FilenameFilter() { 
	           public boolean accept(File dir, String name) { 
	                return name.endsWith(".exe"); 
	            } 
		}; 
	    File[] allMatchingFiles = FileUtils.listFilesAsArray(directory, filter, true);
	    for (File f : allMatchingFiles) {
	    	 System.out.println(f.getName());
	    	if (f.getName().equalsIgnoreCase(ExeName)){
	    		ExeLoc = f.getCanonicalPath();
	    	}else { System.out.println("dint find");}
	         
	      }
		return ExeLoc;
	}
	
	/**This method would work on the Download dialog from IE and Firefox 
	 * and do the necessary actions to perform a download.
	 * @throws Exception
	 */
	public static void handleDownloadAgentDialog() throws Exception {
		System.out.println(OS);
		if(OS.contains("win")){    	
			if(Browser.contains("iexplore")){
				ExeName = "Download_Dialog_IE.exe";	
				ExeLoc = getExeCannonicalPath(ExeName);
				System.out.println(ExeLoc);
				System.out.println(DownloadLocation);
				dialog =  new String[]{ExeLoc,"Download","Save", DownloadLocation };
				Executor.executeProcess(dialog, 240);
			}
			if(Browser.contains("firefox")){
				ExeName = "Download_Dialog_FF.exe";
				ExeLoc = getExeCannonicalPath(ExeName);
				dialog = new String[] { ExeLoc,"Opening AgentSetup.msi","Save", DownloadLocation };
				Executor.executeProcess(dialog, 240);
			}
		}
		else
			if(OS.contains("mac")){
				
			}
		}	

	
	/**This method would invoke the msi and install the agent on the Client box where the script is run.
	 * @throws Exception
	 */
	public static void installAgent() throws Exception {
		if(OS.contains("win")){
			ExeName = "Install_Agent.exe";
			ExeLoc = getExeCannonicalPath(ExeName);
			System.out.println(ExeName);
			dialog =  new String[]{ ExeLoc, DownloadLocation };
			Executor.executeProcess(dialog, 600);
			}
	}

}