package com.ironmountain.pageobject.pageobjectrunner.framework.webdriver.tests;

import java.util.Properties;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.testng.SkipException;
import org.testng.log4testng.Logger;

import com.ironmountain.pageobject.pageobjectrunner.framework.webdriver.drivers.CommonInternetExplorerDriver;
import com.ironmountain.pageobject.pageobjectrunner.framework.webdriver.utils.IConstants;
import com.ironmountain.pageobject.pageobjectrunner.framework.webdriver.utils.TestCaseUtils;
import com.ironmountain.pageobject.pageobjectrunner.framework.webdriver.tests.BaseWebDriverTest;

/**
 * 
 * @author Pradeep Kote
 *
 */
public abstract class BaseWebDriverTest {	
	private Properties configProperties = null;	
	private Logger log = Logger.getLogger(BaseWebDriverTest.class);
	private WebDriver webDriver = null;
	
	public BaseWebDriverTest () throws Exception {
		this.webDriver = getWebDriverFromConfig();
	}
	
	public BaseWebDriverTest (WebDriver webDriver) {
		this.webDriver = webDriver;
	}
		
	/**
	 * The subclass should provide the project folder name 
	 * @return
	 */
	protected abstract String getProjectFolder ();
		
	/**
	 * Initialize the webdriver test
	 * @throws Exception
	 */
	public final void initWebDriverTest() throws Exception {
		String url = generateURL(getConfigProperties().getProperty(IConstants.PROTOCOL),
				getConfigProperties().getProperty(IConstants.HOSTNAME),
				getConfigProperties().getProperty(IConstants.PORT), 
				getConfigProperties().getProperty(IConstants.APPEND_URL));		
		getWebDriver().get(url);
	}
	
	/**
	 * Generate the URL with given parameters
	 * @param protocol
	 * @param hostname
	 * @param port
	 * @param appendUrl
	 * @return
	 */
	private String generateURL (String protocol, String hostname, String port, String appendUrl) {
		StringBuilder strBuilder = new StringBuilder();
		
		strBuilder.append(protocol).append("://");
		strBuilder.append(hostname).append(":");
		strBuilder.append(port).append("/");
		strBuilder.append(appendUrl);
		
		return strBuilder.toString();
	}
	
	/**
	 * Gives the configuration properties files
	 * @return
	 * @throws Exception
	 */
	public Properties getConfigProperties () throws Exception {
		if (configProperties == null) {			
			setConfigProperties(TestCaseUtils.loadEnvFile(getProjectFolder()));			
		}
		return configProperties;
	}
	
	private WebDriver getWebDriverFromConfig () throws Exception {
		return getWebDriverForBrowser(getConfigProperties().getProperty(IConstants.BROWSER));
	}
	
	/**
	 * This will return appropriate WebDriver for given browser type string
	 * @param browserStr
	 * @return
	 * @throws Exception
	 */
	public static WebDriver getWebDriverForBrowser(String browserStr) throws Exception {
		if (IConstants.IE.equalsIgnoreCase(browserStr)) {
			return new CommonInternetExplorerDriver();
		} else if (IConstants.FF.equalsIgnoreCase(browserStr)) {
			return new FirefoxDriver();
		} else if (IConstants.CHROME.equalsIgnoreCase(browserStr)) {
			return new ChromeDriver();
		} else {
			throw new Exception ();
		}
	}
	
	/**
	 * Checks to see if the execute parameter supplied from the .xml file is true or false.
	 * If false, then skips this test by throwing a SkipException.
	 * @param doExecute
	 */
	public void checkExecution(boolean doExecute, String testName) throws SkipException {
		if(!doExecute) {
			log.info("TEST EXECUTION SKIPPED - Test name = "+ testName);
			throw new SkipException("Test name " + testName + " is skipped");
		}
	}
	
	/**
	 * This method will return the Testcase specific properties file by 
	 * combining it with common properties file
	 * @param commonPropFile
	 * @param testType
	 * @param tcPropFileName
	 * @return
	 * @throws Exception
	 */
	public Properties getTCPropertiesFile (Properties commonPropFile, String testType, String tcPropFileName) throws Exception {
		Properties combinedPropertiesFile = new Properties(commonPropFile);		 
		Properties tcPropFile = TestCaseUtils.getAllParameters(TestCaseUtils.getDefaultPrefix(getProjectFolder()), 
				testType, tcPropFileName, getProjectFolder());
		for (Object key : tcPropFile.keySet()) {
			combinedPropertiesFile.put(key.toString(), 
					tcPropFile.getProperty(key.toString()));
		}
		return combinedPropertiesFile;		
	}
	
	
	public void setConfigProperties (Properties prop) {
		this.configProperties = prop;
	}
	
	public WebDriver getWebDriver() {
		return webDriver;
	}
	
	public void setWebDriver(WebDriver webDriver) {
		this.webDriver = webDriver;
	}
}
