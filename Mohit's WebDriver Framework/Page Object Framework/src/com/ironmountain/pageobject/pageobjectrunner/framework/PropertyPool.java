package com.ironmountain.pageobject.pageobjectrunner.framework;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.framework.utils.ConfigFileFilter;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.XMLUtils;

/**
 * @author Jinesh Devasia
 */
public class PropertyPool{

	private static final Logger logger = Logger.getLogger("com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool");
	private static final long serialVersionUID = 1L;
	
	private static HashMap<String, String> propertyPool= null;
	public static boolean isPropertiesLoaded = false;
	
	public static void createPropertyPool()
	{
		if(propertyPool==null)
		{
			propertyPool = new HashMap<String, String>();
		}
	}	
	
	public static Map<String, String> getPropertyPool()
	{
		return propertyPool;
	}
	
	public static void loadProperties()
	{
		if(!isPropertiesLoaded)
		{			
			createPropertyPool();
			ArrayList<String> propertyFilesList = (ArrayList<String>) ConfigFileFilter.getAllConfigFiles();
			if(propertyFilesList.isEmpty()){
				logger.error("Property file list is empty");
		    	throw new TestException("There are no config files found in " + FileUtils.getConfigDirectory()
		    			+ "\nPlease make sure that you place all your configuration files correctly");
		    }
			else{
				for(String propFile:propertyFilesList){
					try{
						logger.debug("Trying to load property file: " + propFile);
						loadConfigFile(propFile, propertyPool);
						logger.debug("Property File Loaded: " + propFile);
						
					}
					catch (Exception e) {
						throw new TestException("Could not load propertis from file "+ FileUtils.getConfigDirectory()+ "\\" +propFile
								+" Roolt Cause is: "+  e.getMessage()+ "Check the file path is correct");
					}
				} 	
				isPropertiesLoaded = true;
			}			
		}			
	}		

	public static void loadConfigFile(String document, Map<String, String>propertyPool) throws Exception
	{		
		propertyPool = (HashMap<String, String>)XMLUtils.parseXmlAsPropertiesAndAddToPool(document, propertyPool);;
	}
	
	public static void setProperty(String propertyName, String value)
	{		
		logger.debug("Settign property '" + propertyName + "' with value '" + value + "'");
		if(propertyPool != null)
		propertyPool.put(propertyName, value);
		else{
			propertyPool = new HashMap<String, String>();
			propertyPool.put(propertyName, value);
		}			
	}
	public static String getProperty(String propertyName)
	{		
		String property = null;
		if(propertyPool != null){
		    property = propertyPool.get(propertyName);
		}
		else {
			loadProperties();
			property = propertyPool.get(propertyName);
		}		
		logger.debug("Property found for '" + propertyName + "' and values is '" + property + "'");
		return property ;		
	}
	/**
	 * Overloaded version with a default value specified.
	 * 
	 * @param propertyName
	 * @param defaultValue
	 * @return property
	 */
	public static String getProperty(String propertyName, String defaultValue)
	{		
		String property = null;
		if(propertyPool != null){
		    property = propertyPool.get(propertyName);
		}
		else {
			loadProperties();
			property = propertyPool.get(propertyName);
		}
		if(StringUtils.isNullOrEmpty(property)){
			logger.debug("Property found for '" + propertyName + "' is null!! Returning defualt value '" + defaultValue + "'");
			return defaultValue;
		}			
		else{

			logger.debug("Property found for '" + propertyName + "' and values is '" + property + "'");
			return property;		
		}			
	}
		

	
	
}
