package com.ironmountain.pageobject.pageobjectrunner.framework;

import java.lang.reflect.Constructor;
import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.framework.utils.ClassUtils;
import com.thoughtworks.selenium.Selenium;


/**
 * @author Jinesh Devasia
 *
 */
public class PageFactory {

	private static final Logger logger = Logger.getLogger("com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory");
	private static HashMap<String, Object> objectMap = new HashMap<String, Object>();
	

	@SuppressWarnings("unchecked")
	public static void setNewPage(Class pageClass)
	{
		getNewPage(pageClass);
	}	
		
	@SuppressWarnings("unchecked")
	public static Object getNewPage(Class pageClass)
	{
		if(objectMap == null){
			objectMap = new HashMap<String, Object>();
		}
		Object page = null;
		String testName = ClassUtils.getTestName();
		logger.debug("Test which is trying to create the Page object is: " + testName);
		String pageName = pageClass.getCanonicalName();
		logger.debug("Name of the page is: " + pageName);
		page = objectMap.get(testName + "_" + pageName);				
		if(page == null)
		{			
			Selenium selenium = getSelenium(testName);
			logger.debug("Selenium session from PageFactory: " + selenium);
			if(selenium == null) {
				throw new TestException("Could not get Selenium session, Selenium is null in PageFactory!!" +
						"Is the selenium session actually started??");
			}			
			try {	
				page = getSeleniumPageConstructor(pageClass).newInstance(selenium);
			} catch (Exception e) {
				throw new TestException("Could not create Page Object, ", e);
			}	
			objectMap.put(testName + "_" + pageName, page);
			logger.debug("Page Object created: " + page);
		}		
		return page;
	}
	
	
	public static void setSelenium(String testName,  Selenium sel)
	{
		logger.debug("Selenium session is setting up for: " + testName + " Selenium Session is: " + sel);
		if(objectMap == null){
			objectMap = new HashMap<String, Object>();
		}
		objectMap.put(testName + "_Selenium", sel);
	}

	public static Selenium getSelenium(String testName)
	{
		if(objectMap == null){
		    objectMap = new HashMap<String, Object>();
	    }
		return(Selenium) objectMap.get(testName + "_Selenium");		
	}	
	
	@SuppressWarnings("unchecked")
	public static Constructor getSeleniumPageConstructor(Class pageClass){
		
		Constructor constructList[] = pageClass.getDeclaredConstructors();
		Constructor seleniumPageConstructor= null;
		for(int i=0; i<constructList.length; i++){
			Class[]  cl = constructList[i].getParameterTypes();				
			for(int j=0; j<cl.length; j++){
				if(cl[j].getSimpleName().equalsIgnoreCase("Selenium")){
					seleniumPageConstructor = constructList[i];
				}
			}
		}
		logger.debug("The Selenium Constructof found for " +pageClass + " is: " + seleniumPageConstructor);
		if(seleniumPageConstructor==null){
			throw new TestException("No Constructors with selenium as a single argument defined in the PageClass. \n" +
					"Note that you should define a Constructor which has only one parameter of type Selenium and set it against your selenium object.");
		}
		return seleniumPageConstructor;		
	}
	
	public static void flushPageFactory(){
		objectMap = null;
	}
	
	
}
