package com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium;


import org.apache.log4j.Logger;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.ie.InternetExplorerDriver;

import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestException;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;


/**
 * 
 * @author spozdnyakov
 *
 */

public class WebDriverTest {

	private static final Logger logger = Logger.getLogger("com.ironmountain.pageobject.pageobjectrunner.framework.WebDriverTest");
	public String applicationProtocol   = null;
	public String applicationHostname   = null;	
	public String appendUrl             = null;
	public String applicationUrl        = null;
	public String applicationPort       = null;
	public String browser               = null;
	public String pageURL				= null;
	private static WebDriver driver		= null;

	public String testName = null;	


	protected final void init(){
		logger.debug("Test In Execution is: " + testName);		
		if(!PropertyPool.isPropertiesLoaded)
		{
			PropertyPool.loadProperties();
			PropertyPool.isPropertiesLoaded = true;
		}		
	}

	/**
	 * Creates static WebDriver Object and load a new web page 
	 * in the browser. 
	 * 
	 * @param protocol
	 * @param hostname
	 * @param port
	 * @param appendUrl
	 * @param browser
	 */
	protected void initWebDriverTest(String protocol, String hostname, String port, String appendUrl, String browser){
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
				logger.debug("Launching Internet Explorer Driver ");
			}
			if (browser.equals("firefox")){
				driver = new FirefoxDriver();
				logger.debug("Launching Firefox Driver ");
			}
			if (browser.equals("chrome")){
				driver = new ChromeDriver();
				logger.debug("Launching Chrome Driver ");
			}
			driver.get(url);

		} catch (Exception e) {
			logger.error("Error occured while starting the WebDriver Test", e);
			throw new TestException(e.getMessage()+ " Check the Test Properties are correct!!!");
		}
	}

	/**
	 * Creates static WebDriver Object and load a new web page 
	 * in the browser. 
	 * 
	 * @param url - should be provided in testconfig.xml for 
	 * example:   {@code <url>http://www.google.com/</url> }
	 * @param browser - Ex: iexplore, firefox, chrome
	 */
	protected void initWebDriverTest(String url, String browser){
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
				logger.debug("Launching Internet Explorer Driver ");
			}
			if (browser.equals("firefox")){
				driver = new FirefoxDriver();
				logger.debug("Launching Firefox Driver ");
			}
			if (browser.equals("chrome")){
				driver = new ChromeDriver();
				logger.debug("Launching Chrome Driver ");
			}
			driver.get(pageURL);

		} catch (Exception e) {
			logger.error("Error occured while starting the WebDriver Test", e);
			throw new TestException(e.getMessage()+ " Check the Test Properties are correct!!!");
		}
	}



	/**
	 * Close the current window, quitting the browser if it's the 
	 * last window currently open. 
	 */
	public final void stopWebDriverTest(){
		logger.debug("Stop WebDriver Test");
		driver.close();
	}

	/**
	 * Close all open windows. 
	 */
	public final void stopAllWebDriverTest(){
		logger.debug("Quit All WebDriver Tests");
		driver.quit();
	}
	
	/**
	 * 
	 * @return WebDriver instance
	 */
	protected static WebDriver getDriver(){
		return WebDriverTest.driver;
	}
}
