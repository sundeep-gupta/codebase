package com.ironmountain.pageobject.pageobjectrunner.framework;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.framework.utils.LocatorFileFilter;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.XMLUtils;

/**
 * @author Jinesh Devasia
 *
 */
public class LocatorPool {

	private static final Logger logger = Logger.getLogger("com.ironmountain.pageobject.pageobjectrunner.framework.LocatorPool");
	
	private static HashMap<String, String> locatorPool= null;
	public static boolean isLocatorsLoaded = false;
	
	public static void createLocatorPool()
	{
		if(locatorPool==null)
		{
			locatorPool = new HashMap<String, String>();
		}
	}		
	
	public static void loadLocators()
	{
		if(!isLocatorsLoaded)
		{
			createLocatorPool();
			ArrayList<String> locatorFilesList = (ArrayList<String>) LocatorFileFilter.getAllLocatorFiles();
			if(locatorFilesList.isEmpty()){
				logger.error("locator file list is empty");
		    	throw new TestException("There are no locator files found in " + FileUtils.getPageBaseDirectory()
		    			+ "\nand its sub-directories. Please make sure that the base loactor directory specified in framework.config file is correct and \n" +
		    					"all locator files are placed correctly");
		    }
			for(String locatorFile:locatorFilesList){				
				try{
					logger.debug("Trying to load Locator File: " +locatorFile);
					loadLocatorFiles(locatorFile, locatorPool);
					logger.debug("Locator File loaded: " + locatorFile);
				}
				catch (Exception e) {
					logger.error("Failed to load locators from file: " + locatorFile, e);
					throw new TestException("Could not load locators from file "+ locatorFile
							+" Roolt Cause is: "+  e.getMessage()+ "Check the file path is correct");
				}
			} 	
			isLocatorsLoaded = true;
		}			
	}		

	public static void loadLocatorFiles(String document, Map<String, String> pool) throws Exception
	{
		locatorPool = (HashMap<String, String>)XMLUtils.parseXmlAsPropertiesAndAddToPool(document, pool);;
	}
	
	public static void setLlocator(String locatorName, String value)
	{		
		if(locatorPool != null)
		locatorPool.put(locatorName, value);
		else{
			locatorPool = new HashMap<String, String>();
			locatorPool.put(locatorName, value);
		}			
	}
	public static String getLocator(String locatorName)
	{		
		String locator = null;
		if(locatorPool != null){
		    locator = locatorPool.get(locatorName);
		}
		else{
			loadLocators();
			locator = locatorPool.get(locatorName);
		}
		logger.debug("Locator found for '" + locatorName + "' is: " + locator);
		return locator ;		
	}
	/**
	 * get the locator by the locator name, if no locator found then return the defaultLocator
	 * 
	 * @param locatorName
	 * @param defaultLocator
	 * @return
	 */
	public static String getLocator(String locatorName, String defaultLocator)
	{		
		String locator = null;
		if(locatorPool != null){
		    locator = locatorPool.get(locatorName);
		}
		else{
			loadLocators();
			locator = locatorPool.get(locatorName);
		}
		if(StringUtils.isNullOrEmpty(locator)){
			locator = defaultLocator;
		}
		logger.debug("Locator found for '" + locatorName + "' is: " + locator);
		return locator ;		
	}


}
