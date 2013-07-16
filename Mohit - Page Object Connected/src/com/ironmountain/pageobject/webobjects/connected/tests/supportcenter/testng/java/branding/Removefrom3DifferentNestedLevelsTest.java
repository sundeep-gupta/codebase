package com.ironmountain.pageobject.webobjects.connected.tests.supportcenter.testng.java.branding;

import java.io.File;

import org.apache.log4j.Logger;
import org.testng.Reporter;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.ImageUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.CopyFromDC;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.SupportCenterLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.testrunner.ActionRunner;
import com.ironmountain.pageobject.webobjects.connected.database.registry.BrandTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.supportcenter.SupportCenterNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;

@SeleniumUITest
public class Removefrom3DifferentNestedLevelsTest extends SupportCenterTest{
	
	private static Logger  logger      = Logger.getLogger(Removefrom3DifferentNestedLevelsTest.class.getName());
	private static String commID = null;
	private static String subCommID = null;
	private static String parentCommID = null;
	
	BrandTable brandTable = null;
	String LoginImgName =null;
	String HeaderImgName =null;
	String MacImageName =null;
	String AgentProdImgName =null;
	String SplashImgName =null;
	String Installer82ImgName =null;
	String Installer84ImgName =null;
	String SSWSImgName=null;
	
	String logopath = "C:"+File.separator+"BrandingData"+File.separator;
	
	String ParentAgentProdImgName = null;
	String ParentSplashImgName = null;
	String ParentInstaller82ImgName = null;
	String ParentInstaller84ImgName = null;
	
	String SubAgentProdImgName =null;
	String SubSplashImgName =null;
	String SubInstaller82ImgName =null;
	String SubInstaller84ImgName =null;
	
	String BrandedMsg = "(Branded; to change, enter new image file)";

	
	@BeforeMethod(alwaysRun=true)
	public void startTest() throws Exception{
		logger.info(" Starting the Test...");
		super.initSupportCenterTest();	
		brandTable = new BrandTable(DatabaseServer.COMMON_SERVER);
		
		LoginImgName = TestDataProvider.getTestData("LoginImgName");
		HeaderImgName = TestDataProvider.getTestData("HeaderImgName");
		MacImageName = TestDataProvider.getTestData("MacImageName");
		AgentProdImgName = TestDataProvider.getTestData("AgentProdImgName");
		SplashImgName = TestDataProvider.getTestData("SplashImgName");
		Installer82ImgName = TestDataProvider.getTestData("Installer82ImgName");
		Installer84ImgName = TestDataProvider.getTestData("Installer84ImgName");
		SSWSImgName= TestDataProvider.getTestData("SSWSImgName");
		
		ParentAgentProdImgName = TestDataProvider.getTestData("ParentAgentProdImgName");
		ParentSplashImgName = TestDataProvider.getTestData("ParentSplashImgName");
		ParentInstaller82ImgName = TestDataProvider.getTestData("ParentInstaller82ImgName");
		ParentInstaller84ImgName = TestDataProvider.getTestData("ParentInstaller84ImgName");
		
		SubAgentProdImgName =  TestDataProvider.getTestData("SubAgentProdImgName");
		SubSplashImgName = TestDataProvider.getTestData("SubSplashImgName");
		SubInstaller82ImgName = TestDataProvider.getTestData("SubInstaller82ImgName");
		SubInstaller84ImgName = TestDataProvider.getTestData("SubInstaller84ImgName");
		logger.info(" Test Initialization Completed...");
	}
	
	@Parameters( {"TechnicianId", "Password"})
	@BeforeMethod (alwaysRun=true, dependsOnMethods = {"startTest"})
	public void createCommunityHierarchy(String TechnicianId, String Password) throws Exception{
		logger.info("Creating Test Setup");
		parentCommID = TestDataProvider.getTestData("CommunityID");
		subCommID = TestDataProvider.getTestData("ChildCommunityID");
		commID = TestDataProvider.getTestData("SubCommunityID");
		logger.debug(parentCommID);
		logger.debug(subCommID);
		logger.debug(commID);
		logger.info(" Completed Test Setup");
	}
	
	@Parameters( {"TechnicianId", "Password"})
	@Test(enabled = true, groups= {"sc","branding", "apply branding page "})
	public void testResetBranding(String TechnicianId, String Password) throws Exception{
		logger.info(" Logging into SupportCenter");
		SupportCenterLogin.login(TechnicianId, Password);
		logger.info("Navigating to the Grand Child Community");
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(commID);
		supportCenterHomePage.clickOnToolsLink();
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		Reporter.log("Step1: The Branding configuration page opens up in Support Center");
		logger.info("Resetting the branding to default branding");
		applyBrandingPage.clickOnResetBrandingBtn();
		Thread.sleep(10000);
		applyBrandingPage.selenium.keyPressNative(Integer.toString(java.awt.event.KeyEvent.VK_ENTER )+"");
		super.stopSeleniumTest();
		super.initSupportCenterTest();
		initialiseSCafterLogOut();
		SupportCenterLogin.login(TechnicianId, Password);
		Asserter.assertEquals(brandTable.getValueByColNameandCommunityID("*", commID), null);
		logger.info(" Verifying the images of the Grand child community");
		verifyImages(AgentProdImgName,SplashImgName,Installer82ImgName,Installer84ImgName,commID);
		//verifyInheritedImages(SubAgentProdImgName, SubSplashImgName, SubInstaller82ImgName, SubInstaller84ImgName,commID);
		//SupportCenterLogin.login(TechnicianId, Password);
		logger.info(" Navigating to the child community");
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(subCommID);
		supportCenterHomePage.clickOnToolsLink();
		logger.info(" Resetting the branding to default branding");
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		Reporter.log("Step1: The Branding configuration page opens up in Support Center");
		applyBrandingPage.clickOnResetBrandingBtn();
		Thread.sleep(10000);
		applyBrandingPage.selenium.keyPressNative(Integer.toString(java.awt.event.KeyEvent.VK_ENTER )+"");
		super.stopSeleniumTest();
		super.initSupportCenterTest();
		initialiseSCafterLogOut();
		SupportCenterLogin.login(TechnicianId, Password);
		Asserter.assertEquals(brandTable.getValueByColNameandCommunityID("*", subCommID), null);
		logger.info(" Verifying the images of the child community");
		verifyImages(SubAgentProdImgName, SubSplashImgName, SubInstaller82ImgName, SubInstaller84ImgName,subCommID);
		//verifyInheritedImages(ParentAgentProdImgName, ParentSplashImgName, ParentInstaller82ImgName, ParentInstaller84ImgName,subCommID);
	//	SupportCenterLogin.login(TechnicianId, Password);
		logger.info(" Navigating to the parent community");
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(parentCommID);
		supportCenterHomePage.clickOnToolsLink();
		logger.info(" Resetting the branding to default branding");
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		Reporter.log("Step1: The Branding configuration page opens up in Support Center");
		applyBrandingPage.clickOnResetBrandingBtn();
		Thread.sleep(10000);
		applyBrandingPage.selenium.keyPressNative(Integer.toString(java.awt.event.KeyEvent.VK_ENTER )+"");
		super.stopSeleniumTest();
		super.initSupportCenterTest();
		initialiseSCafterLogOut();
		SupportCenterLogin.login(TechnicianId, Password);
		logger.info(" Verifying the branding details of the parent community");
		Asserter.assertEquals(brandTable.checkResultSet("*", parentCommID), false);
		//verifyImages(ParentAgentProdImgName, ParentSplashImgName, ParentInstaller82ImgName, ParentInstaller84ImgName,parentCommID);
	}
	
	public void verifyImages(String AgentProdImgName, String SplashImgName, String Installer82ImgName, String Installer84ImgName, String commID) throws Exception{
		CopyFromDC.copyBrandingDirectoryFromDC();
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+LoginImgName, "C:/DCBrandingFiles/"+commID+"/SCLogin.gif"), false);
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+HeaderImgName, "C:/DCBrandingFiles/"+commID+"/HeaderLogo.gif"), false);
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+MacImageName, "C:/DCBrandingFiles/"+commID+"/macdataprotector_logo.png"), false);
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+AgentProdImgName, "C:/DCBrandingFiles/"+commID+"/pcdataprotector_logo.png"), false);
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+SplashImgName, "C:/DCBrandingFiles/"+commID+"/pcdataprotecotor_splashlogo.png"), false);
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+Installer82ImgName, "C:/DCBrandingFiles/"+commID+"/pcdataprotector_logo.jpg"), false);
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+Installer84ImgName, "C:/DCBrandingFiles/"+commID+"/pcdataprotector_logo_wise.jpg"), false);
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+SSWSImgName, "C:/DCBrandingFiles/"+commID+"/acntmgmt_siteheader.png"), false);		
	}
	
	public void verifyInheritedImages(String AgentProdImgName, String SplashImgName, String Installer82ImgName, String Installer84ImgName, String commID) throws Exception{
		CopyFromDC.copyBrandingDirectoryFromDC();;
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+LoginImgName, "C:/DCBrandingFiles/"+commID+"/SCLogin.gif"), true);
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+HeaderImgName, "C:/DCBrandingFiles/"+commID+"/HeaderLogo.gif"), true);
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+MacImageName, "C:/DCBrandingFiles/"+commID+"/macdataprotector_logo.png"), true);
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+AgentProdImgName, "C:/DCBrandingFiles/"+commID+"/pcdataprotector_logo.png"), true);
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+SplashImgName, "C:/DCBrandingFiles/"+commID+"/pcdataprotecotor_splashlogo.png"), true);
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+Installer82ImgName, "C:/DCBrandingFiles/"+commID+"/pcdataprotector_logo.jpg"), true);
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+Installer84ImgName, "C:/DCBrandingFiles/"+commID+"/pcdataprotector_logo_wise.jpg"), true);
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+SSWSImgName, "C:/DCBrandingFiles/"+commID+"/acntmgmt_siteheader.png"), true);		
	}
	
	public void initialiseSCafterLogOut(){
		if (!(seleniumPage.isTextPresent("Please Log In"))){
			seleniumPage.selectRelativeUpFrame();
			seleniumPage.selectRelativeUpFrame();
			seleniumPage.selectRelativeUpFrame();
			seleniumPage.selectFrame("AppHeader");
			seleniumPage.click("//a[contains(@onclick,'Logout')]");
			seleniumPage.close();	
		}
	}
	
	
	@AfterMethod(alwaysRun=true)
	public void stopTest() throws Exception{
		logger.info(" Stopping Test...");
		brandTable.closeDatabaseConnection();
		super.stopSeleniumTest();
	}

}
