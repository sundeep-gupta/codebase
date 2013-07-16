package com.ironmountain.pageobject.pageobjectrunner.framework;

import java.util.HashMap;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium.WebDriverSeleniumTest;
import com.ironmountain.pageobject.pageobjectrunner.utils.DateUtils;
import com.thoughtworks.selenium.Selenium;

/**
 * @author Jinesh Devasia
 *
 */
public class TestPool extends Thread{

	private static final Logger logger = Logger.getLogger("com.ironmountain.pageobject.pageobjectrunner.framework.TestPool");

	private static HashMap<String, SeleniumTest> testPool = null;
	private static HashMap<String, WebDriverSeleniumTest> testPoolWD = null;
	/**
	 * This variable represents the maximum execution time of a single test if a test exceeds this time
	 * we need come out of the test and release its resources.
	 * maxtestExecutionTime represents minutes
	 */
	private long maxTestExecTime = 1 ;
	private String testName = null;
	private SeleniumTest testClass = null;
	private WebDriverSeleniumTest testClasswd = null;
	private boolean testCompleted = false;
	private boolean testTerminated = false;
	
	public void setMaxTestExecutionTime()
	{
		this.maxTestExecTime = Integer.parseInt(PropertyPool.getProperty("maxexecutiontime"));
		logger.debug("Maximum execution time set is: " + maxTestExecTime);
	}
	
	public void setTestName(String testname)
	{
		logger.debug("Setting the test name: "+ testname);
		this.testName = testname;
	}
	public String getTestName()
	{
		logger.debug("Getting the test name: "+ this.testName);
		return this.testName;
	}
	public void setTestClass(SeleniumTest test)
	{
		logger.debug("Settign the test class: " + test);
		this.testClass = test;
	}	
	public static SeleniumTest getTestClass(String testName)
	{
		SeleniumTest  test = testPool.get(testName);
		logger.debug("Test Class found is: " + test);
		return test;
	}
	public void setNewTest(String testName, SeleniumTest testClass)
	{
		logger.debug("Adding a new test to the TestPool with test name '" + testName + "' and test class '" + testClass + "'" );
		if(testPool == null){
			testPool = new HashMap<String, SeleniumTest>();
		}	
		setTestName(testName);
		setTestClass(testClass);
		setMaxTestExecutionTime();
		testPool.put(this.testName, this.testClass);		
	}
	
	public void setTestCompleted(boolean state)	{
		logger.debug("Completing the test..!!");
		this.testCompleted = state;
	}
    public void setTestTerminated(boolean state)	{
    	this.testTerminated = state;
	}
    public boolean isTestCompleted()	{
		return this.testCompleted ;
	}
    public boolean isTestTerminated()	{
    	return this.testTerminated ;
	}
	
	public void startTestThread()
	{
		logger.debug("Strating the test thread..");
		this.start();
	}
	
	public void run()
	{	
		long startTime = DateUtils.getCurrentTimeInMillis();
		maxTestExecTime = (maxTestExecTime * 60)*1000 ;
		while(true)
		{
			if((DateUtils.getCurrentTimeInMillis() - startTime) >= maxTestExecTime) {
				testTerminated = true;
				logger.debug("Terminating the Test..");
				break;
			}
			else if(testCompleted) {
				logger.debug("Completing the Test..");
				break;
			}
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		releaseTestThread();		
	}

	public synchronized void releaseTestThread()
	{		
		logger.debug("Releasing the Test Thread..");
		Selenium selenium = PageFactory.getSelenium(this.testName);
		if(selenium !=null)
	    {
	        try{
	        	logger.debug("Closing the browser and ending the selenium session..");
	        	selenium.close();
	        	selenium.stop();
	        }
	        catch (Exception e) {
	            final String message = e.getMessage();
	            if (message != null && message.startsWith("Current Window")) {
	                throw new TestException("Could not close the browser" + e.getMessage(), e);
	            }
	            throw new TestException("Could not close the browser, " + e.getMessage(), e);
	         }
	         finally{	
	        	 if(selenium !=null){
	        		 selenium.stop();
	        	 }	
	        	 logger.debug("Ending the selenium session for the test '" +this.testName + "'");
	             PageFactory.setSelenium(this.testName, null);
	             PageFactory.flushPageFactory();
	         }
	     }
		 else{
			throw new TestException("Could not stop selenium, Selenium was already null in PageFactory!!" +
						"This can be a bug with the Test Framework");	
		 }	
	}
	
	/**
	 * 
	 * added by Sergey to support PageFactory functions for  WebDriverSeleniumTest
	 */
	
	public void setWebDriverTestClass(WebDriverSeleniumTest test)
	{
		logger.debug("Settign the test class: " + test);
		this.testClasswd = test;
	}
	
	/**
	 * 
	 * added by Sergey to support PageFactory functions for  WebDriverSeleniumTest
	 */
	
	public void setNewWebDriverTest(String testName, WebDriverSeleniumTest testClass)
	{
		logger.debug("Adding a new test to the TestPool with test name '" + testName + "' and test class '" + testClass + "'" );
		if(testPoolWD == null){
			testPoolWD = new HashMap<String, WebDriverSeleniumTest>();
		}	
		setTestName(testName);
		setWebDriverTestClass(testClass);
		setMaxTestExecutionTime();
		testPoolWD.put(this.testName, this.testClasswd);		
	}
	
	/**
	 * 
	 * added by Sergey to support PageFactory functions for  WebDriverSeleniumTest
	 */
	
	public static WebDriverSeleniumTest getWebDriverTestClass(String testName)
	{
		WebDriverSeleniumTest  test = testPoolWD.get(testName);
		logger.debug("Test Class found is: " + test);
		return test;
	}
		
	
	
	
}
