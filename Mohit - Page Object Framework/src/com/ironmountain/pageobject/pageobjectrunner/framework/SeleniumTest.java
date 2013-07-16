package com.ironmountain.pageobject.pageobjectrunner.framework;


import org.apache.log4j.Logger;
import org.testng.SkipException;
import com.ironmountain.pageobject.pageobjectrunner.framework.utils.ClassUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.thoughtworks.selenium.DefaultSelenium;
import com.thoughtworks.selenium.Selenium;

/**
 * @author Jinesh Devasia
 */
public class SeleniumTest {
	
	private static final Logger logger = Logger.getLogger(SeleniumTest.class);
	public static String SKIP_ALL_TESTS = "SkipAllTests";
	public static String SKIP_CAUSER = "SkipCauser";
	
	public Selenium testSelenium = null;
	public SeleniumPage seleniumPage = null;
	
	public String seleniumServerHost    = null;
	public int seleniumServerPort       = 4444;
	public String applicationProtocol   = null;
	public String applicationHostname   = null;	
	public String appendUrl             = null;
	public String applicationUrl        = null;
	public String applicationPort       = null;
	public String browser               = null;
	
	public static final String IE  = "iexplore";
	public static final String FIREFOX  = "firefox";
	public static final String SAFARI = "safari";
	
	public String testName = null;	
	public SeleniumTest testObject = null;
	private TestPool testThread = null;	
	
	protected String skipMessage = "None";
	protected boolean skipTest = false;
	protected boolean skipTestsIfFail = false;
	protected boolean resetSkipTests = false;
	protected boolean isTestPassed = false;
	
	/**
	 * This method will initialize all the resources and other properties to the system
	 * All sub-Tests should call this method in their corresponding initTests() as first statement;
	 * 
	 */
	protected final void init()
	{
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
		/*
		 * Get the SkipTest attributes for the Test
		 */
		setSkipTestsAttributes();
	}	
	
	/**
	 * This is the base method for all the tests different tests can extend the base class and provide
	 * the information based on the requirements.
	 * 
	 * @param hostname
	 * @param appendUrl
	 * @param browser "Use the constants defined in this class IE,FF
	 * @throws Exception
	 */
	protected void initSeleniumTest(String protocol, String hostname, String port, String appendUrl, String browser)
	{		
		init();		
		/*
		 * Get the skipTest Value from File and skip the test if its true.
		 */
		if(!resetSkipTests){
			logger.info("This test is not specified to reset the skipping. Note that if you want to run the test individually" +
					"You may need to set the attribute resetSkipAllTestsIfFail=true in @SeleniumUITest Annotation");
		}
		if(!skipTest){
			skipTest = getSkipTestsIfFailedProperty();
		}
		else{
			skipTest(skipMessage);
		}
		logger.info("SkipValue is: " + skipTest + " This test will be skipped");
		if(skipTest){			
			logger.info("TEST EXECUTION SKIPPED - Test name = "+ testName);
			throw new SkipException("Test name " + testName + " is skipped!! " +
					"This was cuased by the failure of a dependent Test: " + TestDataProvider.getTestData(SKIP_CAUSER)
					+ "\nThis test is not specified to reset the skipping. Note that if you want to run the test individually" +
					"\nYou may need to set the attribute resetSkipAllTestsIfFail=true in @SeleniumUITest Annotation" +
					"\nDont forget to remove the annotation after individual Test Execution, else the test will not be skipped even if you have a Test you depend");
		}
		seleniumServerHost = PropertyPool.getProperty("seleniumserverhost");
		logger.debug("Selenium Server Host is: " + seleniumServerHost);
		seleniumServerPort = Integer.parseInt(PropertyPool.getProperty("seleniumserverport"));
		logger.debug("Selenium Server Port is: " + seleniumServerPort);
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
		if(! StringUtils.isNullOrEmpty(browser)){
			this.browser = browser;
			logger.debug("Browser is: " + this.browser);
		}
		else{
			this.browser = "*" + PropertyPool.getProperty("browser", IE);
			logger.debug("Browser is: " + this.browser);
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
		String url =  applicationProtocol + "://" + applicationHostname + ":" + applicationPort;
		logger.debug("The Primary URL Generated for Test is: " + url);
		try {
			testSelenium = new DefaultSelenium(seleniumServerHost, seleniumServerPort, this.browser, url);
			testSelenium.start();
			logger.debug("Selenium Session started: " + testSelenium);
			
		} catch (Exception e) {
			logger.error("Error occured while starting the Selenium Test", e);
			throw new TestException(e.getMessage()+ " Check the Test Properties are correct!!!");
		}
		try{
		seleniumPage = new SeleniumPage();
		seleniumPage.setSelenium(testSelenium);
		PageFactory.setSelenium(testName, testSelenium);		
		testSelenium.open("/"  + this.appendUrl);		
		applicationUrl = url + "/" + this.appendUrl;		
		logger.debug("The Application URL Generated for Test is: " + applicationUrl);
		}
		catch (Exception e) {
			System.out.println(e);
		}
		testThread = new TestPool();
		testThread.setNewTest(testName, testObject);		
		testThread.startTestThread();
	}	

	public void stopSeleniumTest() throws Exception
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
	public void stopSeleniumTestEnableSkipTest(String... dataProvider) throws Exception
	{	
		for (String dataFile : dataProvider) {
			setSkipTestsFeature(dataFile);
		}		
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
			logger.info("Test was not even initialized!! May the Test Skipped due to Skip test Feature..");
	}

	private final void waitForTestComplete()
	{
		try {
			testThread.join(6000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
	
	
	@SuppressWarnings("unchecked")
	public void setSkipTestsAttributes(){
		Class testClass = ClassUtils.getTestClass();
		SeleniumUITest anno = (SeleniumUITest) testClass.getAnnotation(SeleniumUITest.class);
		resetSkipTests = anno.resetSkipAllTestsIfFail();
		logger.info("Reset Skip is: " + resetSkipTests + " So the skiptest will be reset to false");
		skipTestsIfFail = anno.skipAllTestsIfFail();
		logger.info("SkipTestsIfFail is: " + skipTestsIfFail + " If 'true' the skiptest will enabled if the test fails");
	}
	
	public void resetSkipTestsIfFailedInTestDataProvider(String... dataProviders){
		logger.info("Resetting the skiptest will be reset to false");
		for (String dataProvider : dataProviders) {
			setSkipTestsIfFailedInTestDataProvider(dataProvider, false);
		}		
	}	
	
	/**
	 * Set the property in the Test Data Provider File, once the value set to 'true" the following tests will be skipped
	 * 
	 * @param dataProvider
	 * @param skipValue
	 */
	public void setSkipTestsIfFailedInTestDataProvider(String dataProvider, boolean skipValue){
		logger.info("Resetting the skiptest value to " + skipValue);
		if(skipValue){
			TestDataProvider.setTestDataToXmlFile(dataProvider, SKIP_ALL_TESTS, "true");
			TestDataProvider.setTestDataToXmlFile(dataProvider, SKIP_CAUSER, testName);
		}else{
			TestDataProvider.setTestDataToXmlFile(dataProvider, SKIP_ALL_TESTS, "false");
			TestDataProvider.setTestDataToXmlFile(dataProvider, SKIP_CAUSER, testName);
		}
	}
	
	/**
	 * Set the property in the Test Data Provider File, once the value set to 'true" the following tests will be skipped.
	 * This method will be called once the skipTestsIFail is true.
	 * 
	 * @param dataProvider
	 */
	public void setSkipTestsFeature(String dataProvider){

		if(!isTestPassed && skipTestsIfFail){
			logger.info("Setting the skiptest to true, so the rest of the test cases in the suite will be skipped.");
			setSkipTestsIfFailedInTestDataProvider(dataProvider, true);
		}
	}
	
	/**
	 * Get the skipTest property from Test Data Provider file
	 * 
	 * @return
	 */
	public boolean getSkipTestsIfFailedProperty(){
		String isSkip = TestDataProvider.getTestData(SKIP_ALL_TESTS);
		if(isSkip != null){
			if(isSkip.trim().equalsIgnoreCase("true"))
				return true;
			else
				return false;
		}
		return false;
	}
	
	public void skipTest(String message){
		logger.info("Skipping test:: " + message);
		throw new SkipException("Test name " + testName + " is skipped!! "
				+ "\n" + message );
	}
	
	public void notifySetupTestComplete(){
		isTestPassed = true;
	}
	
}
