package com.ironmountain.kanawha.tests;

import java.io.File;

import org.apache.log4j.Logger;

import com.ironmountain.kanawha.pages.KanawhaHomePage;
import com.ironmountain.kanawha.pages.KanawhaLoginPage;
import com.ironmountain.kanawha.pages.MyRoamPage;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium.WebDriverTest;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;


/** Base TestClass for all Kanawha Tests
 * @author pjames
 *
 */
public class KanawhaTest extends WebDriverTest{
	
	private static final Logger logger = Logger.getLogger(KanawhaTest.class.getName());
	public static KanawhaLoginPage kanawhaLoginPage = null;
	public static KanawhaHomePage kanawhaHomePage = null;
	public static MyRoamPage myRoamPage = null;
	
	
	public static String HOME_PAGE_REF = "HomePage.";
	public static String LOGIN_PAGE_REF = "LoginPage."; 
	public static String url = null;
	
	public static String TEST_DATA_XML_FILE_PATH = FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("kanawhatestdatadir");
	public static String TEST_DATA_XML_FILE = TEST_DATA_XML_FILE_PATH + File.separator + "kanawhadataprovider.xml" ;	
	
	protected final void initKanawhaTest()throws Exception {
		initKanawhaTest("");
	}
	
	protected final void initKanawhaTest(String browser)throws Exception {
		super.init();
		KanawhaTest.loadKanawhaTestData();
		applicationProtocol = PropertyPool.getProperty("kanawhaprotocol");
		applicationHostname = PropertyPool.getProperty("kanawhaurl");
		applicationPort = PropertyPool.getProperty("kanawhaport");
		appendUrl = PropertyPool.getProperty("kanawhaappendurl");	
		url = applicationProtocol + "://" + applicationHostname + "/" + appendUrl;
		super.initWebDriverTest(url, browser);
	}
	
	public static void loadKanawhaTestData(){
		//TestDataProvider.loadTestData(TEST_DATA_XML_FILE_PATH);
	}
		
	
}
