package com.ironmountain.pageobject.pageobjectrunner.utils;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestException;

/**
 * @author Jinesh Devasia
 *
 */
public class PropertyFileCreator {

	
	public static void createPropertyFile(boolean creatNew, String propertyFileName)
	{
		boolean propertyFileExists = false;
		File configDir = new File(FileUtils.getConfigDirectory());	
		List<File> listOfFiles = FileUtils.getAllFilesFromDirectory(configDir);
		for(File file:listOfFiles){
			if(file.getName().endsWith(propertyFileName)){
				propertyFileExists = true;
				break;
			}				
		}	
		if(creatNew || !propertyFileExists){
			createPropertyFile(propertyFileName);
		}		 
	}
	
	public static void createPropertyFile(String propertyFileName)
	{
		HashMap<String, String> pool = (HashMap<String, String>) PropertyPool.getPropertyPool();
        FileOutputStream out = null;
		 PrintStream write = null;
		 try {
			out = new FileOutputStream(FileUtils.getConfigDirectory() + "\\" + propertyFileName);
			write = new PrintStream(out) ; 
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}		 
		Set<String> keys = pool.keySet();
		for(String key:keys){
			try{
				write.println(key + "=" + pool.get(key));			 
			}
			catch (Exception e) {
				e.printStackTrace();
				throw new TestException("Unable to create property file: " + e.getMessage());
			}
		}		 
	}
	
	public static void deletePropertyFile()
	{
		String propertyFileName = PropertyPool.getProperty("buildpropertyfile");
		File configDir = new File(FileUtils.getConfigDirectory());	
		List<File> listOfFiles = FileUtils.getAllFilesFromDirectory(configDir);
		for(File file:listOfFiles){
			if(file.getName().endsWith(propertyFileName)){
				file.delete();
				break;
			}				
		}	
	}
	
}
