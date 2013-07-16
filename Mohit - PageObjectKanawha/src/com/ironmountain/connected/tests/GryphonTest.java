package com.ironmountain.connected.tests;

import java.io.File;

import org.apache.log4j.Logger;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.pagefactory.AjaxElementLocator;
import org.openqa.selenium.support.pagefactory.AjaxElementLocatorFactory;


import com.ironmountain.connected.pages.GryphonHomePage;
import com.ironmountain.connected.pages.GryphonLoginPage;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium.WebDriverSeleniumTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium.WebDriverTest;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;

@SeleniumUITest
public class GryphonTest extends WebDriverTest{
	
	private static final Logger logger = Logger.getLogger(GryphonTest.class.getName());
	public static GryphonLoginPage gryLoginPage = null;
	public static GryphonHomePage gryHomePage = null;
	
	//public static String TEST_DATA_XML_FILE_PATH = FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("gryphontestdatadir");
	//public static String TEST_DATA_XML_FILE = TEST_DATA_XML_FILE_PATH + File.separator + "gryphondataprovider.xml" ;	
	
	protected final void initGryphonTest()throws Exception {
		initGryphonTest("");
	}
	
	protected final void initGryphonTest(String browser)throws Exception {
		super.init();
		applicationProtocol = PropertyPool.getProperty("gryphonprotocol");
		applicationHostname = PropertyPool.getProperty("gryphonurl");
		applicationPort = PropertyPool.getProperty("gryphonport");
		appendUrl = PropertyPool.getProperty("gryphonappendurl");	
		loadDataCenterInfo();
		super.initWebDriverTest("https://aut-gryphon-dc.qa.englab.local/webconsole/Login.aspx", browser);
	}
	
	public static boolean isDCMirrored = false;
	public static boolean isDCClustered = false;
	public static String customerFolderLocation = null;
	public static String primaryDataCenterRegistryMachineName = null;
	public static String secondaryDataCenterRegistryMachineName = null;
	public static String primaryDataCenterDirectoryMachineName = null;
	public static String secondaryDataCenterDirectoryMachineName = null;
	
	public static void loadDataCenterInfo(){
		
		if(PropertyPool.getProperty("DataCenterMirrored").equalsIgnoreCase("yes") ){
			isDCMirrored = true;
		}
		if(PropertyPool.getProperty("DataCenterClustered").equalsIgnoreCase("yes") ){
			isDCClustered = true;
		}
		customerFolderLocation = PropertyPool.getProperty("CustomerFolderLocation");
		primaryDataCenterRegistryMachineName = PropertyPool.getProperty("PrimaryDataCenterRegistryMachineName");
		secondaryDataCenterRegistryMachineName = PropertyPool.getProperty("SecondaryDataCenterRegistryMachineName");
		primaryDataCenterDirectoryMachineName = PropertyPool.getProperty("PrimaryDataCenterDirectoryMachineName");
		secondaryDataCenterDirectoryMachineName = PropertyPool.getProperty("SecondaryDataCenterDirectoryMachineName");
	}
	


}
