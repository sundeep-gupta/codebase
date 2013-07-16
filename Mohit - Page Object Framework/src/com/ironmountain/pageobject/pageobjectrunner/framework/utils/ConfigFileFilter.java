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
public class ConfigFileFilter {

	private static final Logger logger = Logger.getLogger("com.imd.connected.webuitest.framework.ConfigFileFilter");
	private static final String CONFIG_FILENAME_FILETER = "config.xml";
	
	public static List<String> getAllConfigFiles()
	{
		File configDir = new File(FileUtils.getConfigDirectory());
	    ArrayList<String> listOfConfigFiles = new ArrayList<String>();;
	    logger.debug("Trying to load locators from Config directory: " + configDir);
	    List<File> listOfFiles = FileUtils.getAllFilesFromDirectory(configDir);
		for(File file:listOfFiles){			
			if(file.getName().endsWith(CONFIG_FILENAME_FILETER)){
				logger.debug("Property File Found: " + file);
				listOfConfigFiles.add(file.getAbsolutePath());
			}				
		}	
		return listOfConfigFiles;
	}
}
