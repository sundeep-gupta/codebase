package com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium;

import org.apache.log4j.Logger;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebDriverBackedSelenium;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxProfile;
import org.openqa.selenium.firefox.internal.ProfilesIni;
import org.openqa.selenium.ie.InternetExplorerDriver;

import com.ironmountain.pageobject.pageobjectrunner.framework.LocatorPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestException;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.utils.ClassUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.thoughtworks.selenium.Selenium;

/**
 * 
 * @author spozdnyakov
 *
 */

public class WebDriverSeleniumTest{

	private static final Logger logger = Logger.getLogger("com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium.WebDriverSeleniumTest");

	public String applicationProtocol   = null;
	public String applicationHostname   = null;	
	public String appendUrl             = null;
	public String applicationUrl        = null;
	public String applicationPort       = null;
	public String browser               = null;
	public String firefoxProfile        = null;
	public WebDriver driver = null;
	public Selenium testSelenium = null;
	public SeleniumPage seleniumPage = null;
	public String pageURL				= null;
	public String testName = null;	
	public WebDriverSeleniumTest testObject = null;
	private TestPool testThread = null;	



	protected final void init(){
		testName = ClassUtils.getTestName();
		logger.debug("Test In Execution is: " + testName);		
		if(!PropertyPool.isPropertiesLoaded)
		{
			PropertyPool.loadProperties();
			PropertyPool.isPropertiesLoaded = true;
		}		
		if(!LocatorPool.isLocatorsLoaded)
		{
			LocatorPool.loadLocators();
			LocatorPool.isLocatorsLoaded = true;
		}
	}

	protected void initWebDriverSeleniumTest(String protocol, String hostname, String port, String appendUrl, String browser ){

		this.init();
		if(! StringUtils.isNullOrEmpty(hostname)) {
			applicationProtocol  =  protocol;
			logger.debug("Application Protocol is: " + applicationProtocol);
		}
		else{			
			applicationProtocol = PropertyPool.getProperty("protocol", "http");
			logger.debug("DefaultApplication Protocol is: " + applicationProtocol);
		}
		if(! StringUtils.isNullOrEmpty(hostname))	{
			applicationHostname  =  hostname;	
			logger.debug("Application Host name is: " + applicationHostname);
		}
		else{
			applicationHostname  =  PropertyPool.getProperty("hostname");
			logger.debug("Application Host name is: " + applicationHostname);
		}
		if(! StringUtils.isNullOrEmpty(appendUrl)){
			this.appendUrl = appendUrl;
			logger.debug("Append URL for application is: " + this.appendUrl);
		}
		else{
			this.appendUrl = PropertyPool.getProperty("appendurl");
			logger.debug("Append URL for application is: " + this.appendUrl);
		}	
		if(! StringUtils.isNullOrEmpty(port)){
			applicationPort = port;
			logger.debug("Application Port is: " + applicationPort);
		}
		else{
			applicationPort = PropertyPool.getProperty("port", "80");	
			logger.debug("Application Port is: " + applicationPort);
		}	
		if(! StringUtils.isNullOrEmpty(browser)){
			this.browser = browser;
			logger.debug("Browser is: " + this.browser);
		}
		else{
			browser = PropertyPool.getProperty("browser");
			logger.debug("Browser is: " + this.browser);
		}


		String url =  applicationProtocol + "://" + applicationHostname + ":" + applicationPort + "/" + appendUrl;
		logger.debug("The Primary URL Generated for Test is: " + url);

		try {
			if (browser.equals("iexplore")){
				driver = new InternetExplorerDriver();
				testSelenium = new WebDriverBackedSelenium(driver, url);
			}
			if (browser.equals("firefox")){

				/**
				 Use Existing FirefoxProfile
				 To find profile name see  "Name = " in  %APPDATA%\Mozilla\Firefox\profiles.ini
				 **/

				firefoxProfile = PropertyPool.getProperty("firefoxprofile");
				logger.debug("FireFox profile is set to: "  + this.firefoxProfile);	
				ProfilesIni allProfiles = new ProfilesIni();
				FirefoxProfile profile = allProfiles.getProfile(firefoxProfile);

				driver = new FirefoxDriver(profile);	
				testSelenium = new WebDriverBackedSelenium(driver, url);
			}

		} catch (Exception e) {
			logger.error("Error occured while starting the WebDriverSeleniumTest", e);
			throw new TestException(e.getMessage()+ " Check the Test Properties are correct!!!");
		}

		seleniumPage = new SeleniumPage();
		seleniumPage.setSelenium(testSelenium);
		PageFactory.setSelenium(testName, testSelenium);			
		testSelenium.open("/");		
		applicationUrl = url ;	
		logger.debug("The Application URL Generated for Test is: " + applicationUrl);
		testThread = new TestPool();
		testThread.setNewWebDriverTest(testName, testObject);		
		testThread.startTestThread();
	}
	
	protected void initWebDriverSeleniumTest(String url, String browser){
		this.init();
		if(! StringUtils.isNullOrEmpty(url))	{
			pageURL  =  url;	
			logger.debug("Application URL name is: " + pageURL);
		}
		else{
			pageURL  =  PropertyPool.getProperty("url");
			logger.debug("Application URL name is: " + pageURL);
		}

		if(! StringUtils.isNullOrEmpty(browser)){
			this.browser = browser;
			logger.debug("Browser is: " + this.browser);
		}
		else{
			browser = PropertyPool.getProperty("browser");
			logger.debug("Browser is: " + this.browser);
		}
		try {
			if (browser.equals("iexplore")){
				driver = new InternetExplorerDriver();
				testSelenium = new WebDriverBackedSelenium(driver, pageURL);
			}
			if (browser.equals("firefox")){

				/**
				 Use Existing FirefoxProfile
				 To find profile name see  "Name = " in  %APPDATA%\Mozilla\Firefox\profiles.ini
				 **/

				firefoxProfile = PropertyPool.getProperty("firefoxprofile");
				logger.debug("FireFox profile is set to: "  + this.firefoxProfile);	
				ProfilesIni allProfiles = new ProfilesIni();
				FirefoxProfile profile = allProfiles.getProfile(firefoxProfile);

				driver = new FirefoxDriver(profile);	
				testSelenium = new WebDriverBackedSelenium(driver, pageURL);
			}

		} catch (Exception e) {
			logger.error("Error occured while starting the WebDriverSeleniumTest", e);
			throw new TestException(e.getMessage()+ " Check the Test Properties are correct!!!");
		}

		seleniumPage = new SeleniumPage();
		seleniumPage.setSelenium(testSelenium);
		PageFactory.setSelenium(testName, testSelenium);			
		testSelenium.open("/");		
		testThread = new TestPool();
		testThread.setNewWebDriverTest(testName, testObject);		
		testThread.startTestThread();
	}


	public final void stopSeleniumTest() throws Exception
	{		
		if(testThread != null){
			if(testThread.isTestTerminated()){
				waitForTestComplete();
				throw new TestException("Test was removed from the TestPool!!its exceeding the maximum execution time limit."+ 
						"\nThis will make the subsequent teardown methods to fail..The probable root cause will be either the test executing for a longer time"+
				"\nthan the time specified in the testconfig.xml file or an error occured which makes the test to wait forever!!!");
			}	
			else{			
				seleniumPage.setSelenium(null);
				testThread.setTestCompleted(true);
				waitForTestComplete();
			}  
		}
		else
			throw new TestException("Test was not even initialized!! check the Selenium session started..");
	}


	private final void waitForTestComplete()
	{
		try {
			testThread.join(6000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
}
