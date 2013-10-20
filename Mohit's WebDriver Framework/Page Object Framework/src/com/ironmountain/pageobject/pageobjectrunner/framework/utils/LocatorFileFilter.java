package com.ironmountain.pageobject.pageobjectrunner.framework.utils;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;

/**
 * @author Jinesh Devasia
 *
 */
public class LocatorFileFilter {
	
	private static final Logger logger = Logger.getLogger("com.imd.connected.webuitest.framework.LocatorFileFilter");

	public static final String LOCATOR_FILENAME_FILTER = "locators.xml";
	
	public static List<String> getAllLocatorFiles(String pageDirectory)
	{
		List<String> locatorFilesList = new ArrayList<String>();
		File pageDir = new File(pageDirectory);
		List<File> listOfFiles = FileUtils.getAllFilesFromDirectory(pageDir);
		for(File file:listOfFiles){
			if(file.getName().endsWith(LOCATOR_FILENAME_FILTER)){
				logger.debug("Locator File found: " + file);
				locatorFilesList.add(file.getAbsolutePath());
			}				
		}		
		return locatorFilesList;
	}
	public static List<String> getAllLocatorFiles()
	{
		String pageDirectory = FileUtils.getPageBaseDirectory();
		return getAllLocatorFiles(pageDirectory);
	}	
	

	
}
