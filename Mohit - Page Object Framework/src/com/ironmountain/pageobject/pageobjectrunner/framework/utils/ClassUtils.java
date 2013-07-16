package com.ironmountain.pageobject.pageobjectrunner.framework.utils;

import org.apache.log4j.Logger;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestException;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;


/**
 * @author Jinesh Devasia
 *
 */
public class ClassUtils extends SecurityManager{
	
	private static final Logger logger = Logger.getLogger("com.imd.connected.webuitest.framework.utils.ClassUtils");
	
	@SuppressWarnings("unchecked")
	private static Class[] getClassExecutionStack(){
		
		ClassUtils classUtils = new ClassUtils();
		return classUtils.getClassContext();
	}
	@SuppressWarnings("unchecked")
	public static Class getClassByName(String classNameStartsWith)
	{
		Class currentClass = null;
		Class[] classesInExecution = getClassExecutionStack();		
		for(int i=0; i<classesInExecution.length; i++)
		{
			currentClass = classesInExecution[i].getClass();
			if(currentClass.getSimpleName().startsWith(classNameStartsWith))
			{				
				logger.debug("class name is: " + currentClass);
				return currentClass;
			}			
		}
		if(currentClass ==null)
			throw new TestException("Please check your class name, System couldnot find such a class");
		return currentClass;
	}
	
	@SuppressWarnings("unchecked")
	public static SeleniumTest getTestClassObject()
	{
		SeleniumTest testClass = null;
		Class[] classesInExecution = getClassExecutionStack();		
		for(int i=0; i<classesInExecution.length; i++)
		{
			if(classesInExecution[i].isAnnotationPresent(SeleniumUITest.class))
			{
				try{					
					testClass = (SeleniumTest)classesInExecution[i].newInstance();
					logger.debug("SeleniumTest Class found: " + testClass);
				}
				catch (Exception e) {
					throw new TestException("This is not a Test!!!, Your test calsses must extended from SeleniumTest or its subclasses" +
							"Please check your test is it actually extending from SeleniumTest??!!", e);				
				}	
				break;
			}			
		}
		if(testClass != null){
			return testClass;			
		}
		else{
			throw new TestException("Please check your test name, it should end with Test. \nYou should use @SeleniumUITest to make it as a SeleniumTest");	
		}		
	}
		
	@SuppressWarnings("unchecked")
	public static String getTestName()
	{
		String testName = null;
		Class[] classesInExecution = getClassExecutionStack();		
		for(int i=0; i<classesInExecution.length; i++)
		{
			if(classesInExecution[i].isAnnotationPresent(SeleniumUITest.class))
			{
				testName = classesInExecution[i].getSimpleName();
				logger.debug("SeleniumTest name is: " + testName);
			}

		}
		if(! StringUtils.isNullOrEmpty(testName))
			return testName;
		else{
			throw new TestException("Please check your test, it's not a Selenium Test. \nYou should use @SeleniumUITest to make it as a SeleniumTest");	
		}			
	}
	
	@SuppressWarnings("unchecked")
	public static String getTestNameWithPackage()
	{
		String testName = null;
		Class[] classesInExecution = getClassExecutionStack();		
		for(int i=0; i<classesInExecution.length; i++)
		{
			if(classesInExecution[i].isAnnotationPresent(SeleniumUITest.class))
			{
				testName = classesInExecution[i].getCanonicalName();
				logger.debug("SeleniumTest name with package is: " + testName);
			}

		}
		if(! StringUtils.isNullOrEmpty(testName))
			return testName;
		else{
			throw new TestException("Please check your test, it's not a Selenium Test. \nYou should use @SeleniumUITest to make it as a SeleniumTest");	
		}
	}
	@SuppressWarnings("unchecked")
	public static Class getTestType()
	{
		Class testClass = null;
		Class[] classesInExecution = getClassExecutionStack();		
		for(int i=0; i<classesInExecution.length; i++)
		{
			if(classesInExecution[i].isAnnotationPresent(SeleniumUITest.class))
			{
				testClass = classesInExecution[i].getSuperclass();
				logger.debug("Test Class Type is: " + testClass);
			}
		}
		return testClass;
	}
	@SuppressWarnings("unchecked")
	public static Class getTestClass()
	{
		Class testClass = null;
		Class[] classesInExecution = getClassExecutionStack();		
		for(int i=0; i<classesInExecution.length; i++)
		{
			if(classesInExecution[i].isAnnotationPresent(SeleniumUITest.class))
			{
				testClass = classesInExecution[i];
				logger.debug("Test Class is: " + testClass);
				System.out.println("Test Class is: " + testClass);
			}
		}
		return testClass;
	}
	
	public static String getTestPackageAsFolderStructure()
	{
		String testName = getTestName();
		String fullPath = getTestNameWithPackage();
		fullPath = fullPath.replace('.', ',');
		String packageName = fullPath.replaceAll("." + testName, "");
		packageName = packageName.replaceAll(",", "//");
		logger.debug("SeleniumTest package name is: " + packageName);
		return packageName;
	}

	
}
