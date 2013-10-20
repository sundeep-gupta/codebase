package com.ironmountain.connected.supportcenter.tests;

import java.io.File;

import org.apache.log4j.Logger;

import com.ironmountain.connected.supportcenter.pages.SCLoginPage;
import com.ironmountain.kanawha.pages.KanawhaHomePage;
import com.ironmountain.kanawha.pages.KanawhaLoginPage;
import com.ironmountain.kanawha.pages.MyRoamPage;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium.WebDriverTest;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;


/** Base TestClass for all SupportCenter8x Tests
 * @author mohit
 *
 */
public class SupportCenter8xTest extends WebDriverTest{
	
	private static final Logger logger = Logger.getLogger(SupportCenter8xTest.class.getName());
	public static SCLoginPage scLoginPage = null;
	public static KanawhaHomePage kanawhaHomePage = null;
	public static MyRoamPage myRoamPage = null;
	
	
	public static String HOME_PAGE_REF = "HomePage.";
	public static String LOGIN_PAGE_REF = "LoginPage."; 
	public static String url = null;
	
	public static String TEST_DATA_XML_FILE_PATH = FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("sctestdatadir");
	public static String TEST_DATA_XML_FILE = TEST_DATA_XML_FILE_PATH + File.separator + "scdataprovider.xml" ;	
	
	protected final void initSupportCenter8xTest()throws Exception {
		initSupportCenter8xTest("");
	}
	
	protected final void initSupportCenter8xTest(String browser)throws Exception {
		super.init();
		SupportCenter8xTest.loadSCTestData();
		applicationProtocol = PropertyPool.getProperty("scprotocol");
		applicationHostname = PropertyPool.getProperty("schost");
		applicationPort = PropertyPool.getProperty("scport");
		appendUrl = PropertyPool.getProperty("scappendurl");	
		url = applicationProtocol + "://" + applicationHostname + "/" + appendUrl;
		super.initWebDriverTest(url, browser);
	}
	
	public static void loadSCTestData(){
		//TestDataProvider.loadTestData(TEST_DATA_XML_FILE_PATH);
	}
		
	
}

