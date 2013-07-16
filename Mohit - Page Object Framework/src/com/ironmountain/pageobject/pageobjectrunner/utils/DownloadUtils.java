package com.ironmountain.pageobject.pageobjectrunner.utils;

//import java.io.File;
//import java.net.MalformedURLException;
//import java.net.URL;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;

import org.apache.log4j.Logger;



//import SSWSAPIService_pkg.SSWSAPIServiceLocator;
//import SSWSAPIService_pkg.SSWSAPIServiceSoapStub;

import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.utils.Executor;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;

/** This Class executes the executables that are created through Autoit to 
 *  handle Download Dialog from IE or Firefox and install the Agent. 
 *  @author pjames
private static Logger  logger      = Logger.getLogger("com.ironmountain.pageobject.pageobjectrunner.utils.DownloadUtils");
 *
 */
public class DownloadUtils {
	
	
	private static Logger logger = Logger.getLogger(DownloadUtils.class.getName());
	
	public static String Browser = PropertyPool.getProperty("browser");
	public static String DownloadLocation = null;
	public static String OS = PropertyPool.getProperty("OS");
	public static String DownloadOpt = PropertyPool.getProperty("DownloadOpt");
	public static String ExeName;
	public static String[] dialog;
	public static Executor exec;
	public static String ExeLoc;
	public static String uninstallermsiloc = null;
	//private static SSWSAPIServiceSoapStub sswsService = null;
	
	
	/**This method would work on the Download dialog from IE and Firefox 
	 * and do the necessary actions to perform a download.
	 * @throws Exception
	 */
	public static void handleDownloadDialog(String DialogTitle, String FileName) throws Exception {
		DownloadLocation = FileUtils.setDownloadLocationwithFileName(FileName);
		if(OS.contains("win")){    	
			if(Browser.contains("iexplore")){
				logger.info("Internet Explorer Borwser Found...Using IE AutoIT Script For download..");
				ExeName = "Download_Dialog_IE.exe";	
				ExeLoc = FileUtils.getExeCannonicalPath(ExeName);
				dialog =  new String[]{ExeLoc,DialogTitle,"Save", DownloadLocation };
				Executor.executeProcess(dialog, 600);
			}
			if(Browser.contains("firefox")){
				logger.info("Firefox Borwser Found...Using FF AutoIT Script For download..");				
				ExeName = "Download_Dialog_FF.exe";
				ExeLoc = FileUtils.getExeCannonicalPath(ExeName);
				logger.info("AutoIT exe file path is: " + ExeLoc);
				String FFDialogTitle = "Enter name of file to save to…";
				dialog = new String[] { ExeLoc, FFDialogTitle ,"Save", DownloadLocation };
				Executor.executeProcess(dialog, 600);
			}
		}
		else
			if(OS.contains("mac")){
				
			}
		}
	
	/** This method helps choose the autoit script for Choose File Windows dialog.
	 * @param FilePath
	 * @throws Exception
	 */
	public static void handleChooseFileDialog(String FilePath) throws Exception {
		ExeName = "Choose_File_Dialog.exe";
		ExeLoc = FileUtils.getExeCannonicalPath(ExeName);
		dialog = new String[] { ExeLoc,FilePath };
		Executor.executeProcess(dialog, 120);
	}
	
	/** This method will download a file to specified location
	 * @param url
	 * @param location
	 */
	public static void downloadFileFromURL(String downloadUrl, String location) throws Exception {
	     try 
	     {
	        /*
	         * Get a connection to the URL and start up
	         * a buffered reader.
	         */
	        long startTime = System.currentTimeMillis();
	 
	        logger.info("Connecting to Outflow ...\n");
	 
	        URL url = new URL(downloadUrl);
	        url.openConnection();
	        InputStream reader = url.openStream();
	 
	        /*
	         * Setup a buffered file writer to write
	         * out what we read from the server.
	         */
	        FileOutputStream writer = new FileOutputStream(location);
	        int blockSize = 512000;
	        byte[] buffer = new byte[blockSize];
	        int totalBytesRead = 0;
	        int bytesRead = 0;
	 
	        logger.info("Reading ZIP file 500KB blocks at a time.\n");
	 
	        while ((bytesRead = reader.read(buffer)) > 0)
	        {  
	           writer.write(buffer, 0, bytesRead);
	           buffer = new byte[blockSize];
	           totalBytesRead += bytesRead;
	        }
	 
	        long endTime = System.currentTimeMillis();
	 
	        logger.info("Done. " + (new Integer(totalBytesRead).toString()) + " bytes read (" + (new Long(endTime - startTime).toString()) + " milliseconds).\n");
	        writer.close();
	        reader.close();
	     } 
	     catch (MalformedURLException e) 
	     {
	        e.printStackTrace();
	     }
	     catch (IOException e)
	     {
	        e.printStackTrace();
	     } 
	}
}