

package com.ironmountain.pageobject.webobjects.connected.tests.supportcenter.testng.java.branding;

import java.io.File;

import org.apache.log4j.Logger;
import org.testng.Reporter;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.webobjects.connected.database.registry.BrandTable;
import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.ApplyBrandingAction;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.CopyFromDC;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.CreateCustomCommunity;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.SupportCenterLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.testrunner.ActionRunner;
import com.ironmountain.pageobject.webobjects.connected.navigations.supportcenter.SupportCenterNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;
import com.ironmountain.pageobject.pageobjectrunner.utils.ImageUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.LocatorUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;

@SeleniumUITest(priority=3)
public class InheritanceSubthroughchildTest extends SupportCenterTest{
	
	private static Logger  logger      = Logger.getLogger(InheritanceSubthroughchildTest.class.getName());
	private static String commID = null;
	private static String subCommID = null;
	private static String childCommID = null;
	
	BrandTable brandTable = null;
	String CommunityID = null;
	String LoginImgName =null;
	String HeaderImgName =null;
	String MacImageName =null;
	String AgentProdImgName =null;
	String SplashImgName =null;
	String Installer82ImgName =null;
	String Installer84ImgName =null;
	String SSWSImgName=null;
	String logopath = "C:"+File.separator+"BrandingData"+File.separator;
	
	
	String BrandedMsg = "(Branded; to change, enter new image file)";
	
	
	@BeforeMethod(alwaysRun=true)
	public void startTest() throws Exception{
		logger.info("Starting Test...");
		super.initSupportCenterTest();
		brandTable = new BrandTable(DatabaseServer.COMMON_SERVER);
		CommunityID = TestDataProvider.getTestData("CustomCommunityID");
		LoginImgName = TestDataProvider.getTestData("LoginImgName");
		HeaderImgName = TestDataProvider.getTestData("HeaderImgName");
		MacImageName = TestDataProvider.getTestData("MacImageName");
		AgentProdImgName = TestDataProvider.getTestData("AgentProdImgName");
		SplashImgName = TestDataProvider.getTestData("SplashImgName");
		Installer82ImgName = TestDataProvider.getTestData("Installer82ImgName");
		Installer84ImgName = TestDataProvider.getTestData("Installer84ImgName");
		SSWSImgName= TestDataProvider.getTestData("SSWSImgName");
		logger.info("Test initialization Completed...");
		
	}
	
	
	@Parameters( {"TechnicianId", "Password"})
	@BeforeMethod (alwaysRun=true, dependsOnMethods = {"startTest"})
	public void createSubCommunity(String TechnicianId, String Password) throws Exception{
		logger.info("Loging into Support Center");
		supportCenterHomePage = SupportCenterLogin.login(TechnicianId, Password);
		logger.info("Creating Parent Community");
		commID = CreateCustomCommunity.createCommunityAction();
		TestDataProvider.setTestDataToXmlFile(TEST_DATA_XML_FILE, "CommunityID", commID);
		logger.info("Creating community under the parent community");
		childCommID = CreateCustomCommunity.createCommunityUnderCommunity(TechnicianId, Password, commID);
		TestDataProvider.setTestDataToXmlFile(TEST_DATA_XML_FILE, "ChildCommunityID", childCommID);
		childCommID = TestDataProvider.getTestData("ChildCommunityID");
		logger.info("Creating the child community under the child community");
		subCommID = CreateCustomCommunity.createCommunityUnderCommunity(TechnicianId, Password, childCommID);
		TestDataProvider.setTestDataToXmlFile(TEST_DATA_XML_FILE, "SubCommunityID", subCommID);
		childCommID = TestDataProvider.getTestData("ChildCommunityID");
		subCommID = TestDataProvider.getTestData("SubCommunityID");
		logger.info("Completed Test Setup...");
		
	}
	
	@Parameters( {"TechnicianId", "Password", "shortProductName", "longProductName"})
	@Test(enabled = true, groups= {"sc","branding", "apply branding page "})
	public void testAllFields(String TechnicianId, String Password, String shortProductName, String longProductName) throws Exception{
		logger.info("Navigating to the Child community page");
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(childCommID);
		supportCenterHomePage.clickOnToolsLink();
		logger.info("Applying Branding to the Child community");
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		Asserter.assertEquals(applyBrandingPage.verifyInheritedMsg(), false);
		applyBrandingPage = ApplyBrandingAction.enterSelectedBrandingDetails(shortProductName, longProductName, SplashImgName, Installer82ImgName,Installer84ImgName);
		Thread.sleep(120000);
		//applyBrandingPage.selenium.close();
		super.stopSeleniumTest();
		super.initSupportCenterTest();
		//initialiseSCafterLogOut();
		SupportCenterLogin.login(TechnicianId, Password);
		logger.info("Navigating to the community under the child community");
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(subCommID);
		supportCenterHomePage.clickOnToolsLink();
		logger.info("Navigating to the Aplly Branding Page");
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		Asserter.assertEquals(applyBrandingPage.verifyInheritedMsg(), true);
		logger.info("Verifying the Branded Text Details");
		verifyBrandingDetails(shortProductName, longProductName);
		logger.info("Verifying the Branded Images from DC");
		verifyImages();
	}
	
	public void verifyBrandingDetails(String shortProductName, String longProductName){
		logger.info("Verifying that all the settings are inherited from the parent");
		Asserter.assertEquals(applyBrandingPage.verifyShowPoweredByIronMountainLogoCheckboxState(), "on");
		Asserter.assertEquals(applyBrandingPage.getMacAgentShortProductName(), shortProductName);
		Asserter.assertEquals(applyBrandingPage.getMacAgentLongProductName(), longProductName);
		Asserter.assertEquals(applyBrandingPage.getMacAgentProductImageInAgentApplication(), BrandedMsg);
		Asserter.assertEquals(brandTable.getValueByColNameandCommunityID("PoweredBy", childCommID), "1");
		
	}
	
	public void verifyImages() throws Exception{
		logger.info("Verifying the Branded Images from DC");
		CopyFromDC.copyBrandingDirectoryFromDC();
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+Installer82ImgName, "C:"+File.separator+"DCBrandingFiles"+File.separator+childCommID+File.separator+"pcdataprotector_logo.jpg.ibd"), true);
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+Installer84ImgName, "C:"+File.separator+"DCBrandingFiles"+File.separator+childCommID+File.separator+"pcdataprotector_logo_wise.jpg.ibd"), true);
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+SplashImgName, "C:"+File.separator+"DCBrandingFiles"+File.separator+childCommID+File.separator+"pcdataprotector_splashlogo.png"), true);
		
	}
	
	/*public void initialiseSCafterLogOut(){
		if (!(seleniumPage.isTextPresent("Please Log In"))){
			seleniumPage.selectRelativeUpFrame();
			seleniumPage.selectRelativeUpFrame();
			seleniumPage.selectRelativeUpFrame();
			seleniumPage.selectFrame("AppHeader");
			seleniumPage.click("//a[contains(@onclick,'Logout')]");
			seleniumPage.close();	
		}
	}*/


	@AfterMethod(alwaysRun=true)
	public void stopTest() throws Exception{
		logger.info("Stopping the Test...");
		brandTable.closeDatabaseConnection();
		super.stopSeleniumTest();
	}
	

}
