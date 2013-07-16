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

@SeleniumUITest(priority=5)
public class NoInheritance3DifferentNestedLevelsTest extends SupportCenterTest{
	
	private static Logger  logger      = Logger.getLogger(NoInheritance3DifferentNestedLevelsTest.class.getName());
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
		logger.info("Starting Test...");
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
		logger.info("Test Initialization Completed...");
	}
	
	@Parameters( {"TechnicianId", "Password"})
	@BeforeMethod (alwaysRun=true, dependsOnMethods = {"startTest"})
	public void createCommunityHierarchy(String TechnicianId, String Password) throws Exception{
		logger.info("Test Setup: Creating three levels of communities");
		parentCommID = TestDataProvider.getTestData("CommunityID");
		subCommID = TestDataProvider.getTestData("ChildCommunityID");
		commID = TestDataProvider.getTestData("SubCommunityID");
		logger.debug(parentCommID);
		logger.debug(subCommID);
		logger.debug(commID);
		logger.info("Test setup completed");
	}
	
	@Parameters( {"TechnicianId", "Password", "shortProductName","longProductName"})
	@Test(enabled = true, groups= {"sc","branding", "apply branding page "})
	public void testMainCommunityBranding(String TechnicianId, String Password, String shortProductName, String longProductName) throws Exception{
		logger.info("Logging into Support Center");
		SupportCenterLogin.login(TechnicianId, Password);
		logger.info("Navigating to the Custom Community Page");
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(parentCommID);
		supportCenterHomePage.clickOnToolsLink();
		logger.info("Navigating to the Apply Branding Page");
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		Reporter.log("The Branding configuration page opens up in Support Center");
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Apply Branding"), true);
		logger.info("Applying Branding for Parent Community");
		applyBrandingPage.typeMacAgentShortProductName(shortProductName);
		Reporter.log("Step2: new text is entered into the field.");
		applyBrandingPage.typeMacAgentLongProductName(longProductName);
		Reporter.log("Step3: Path to the file is now in the field.");
		applyBrandingPage.typePcAgentProductImageOnSplashScreen(logopath+ParentSplashImgName);
		Reporter.log("Step4: Path to the file is now in the field.");
		applyBrandingPage.typePcAgentVersion8to8_2_2InstallerProducImage(logopath+ParentInstaller82ImgName);
		Reporter.log("Step5: Path to the file is now in the field.");
		applyBrandingPage.typePcAgentVersion8_4AndLaterInstallerProducImage(logopath+ParentInstaller84ImgName);
		Reporter.log("Step6: Path to the file is now in the field.");
		applyBrandingPage = applyBrandingPage.clickOnApplyButton();
		applyBrandingPage.selenium.keyPressNative(Integer.toString(java.awt.event.KeyEvent.VK_ENTER )+"");
		Thread.sleep(10000);
		super.stopSeleniumTest();
		super.initSupportCenterTest();
		initialiseSCafterLogOut();
		SupportCenterLogin.login(TechnicianId, Password);
		
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(parentCommID);
		supportCenterHomePage.clickOnToolsLink();
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		logger.info("Verifying the Branding Info");
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Apply Branding"), true);
		Asserter.assertEquals(applyBrandingPage.verifyInheritedMsg(), false);
		logger.info("Verifying the Branding Details like shortproductname, longproductname");
		verifyBrandingDetails(shortProductName, longProductName, parentCommID);
		verifyImages(ParentSplashImgName, ParentInstaller82ImgName, ParentInstaller84ImgName,parentCommID);
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		logger.info("Navigating to the child community page");
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(subCommID);
		supportCenterHomePage.clickOnToolsLink();
		logger.info("Navigating to the Apply Branding Page");
		SupportCenterNavigation.viewApplyBrandingPage();
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Apply Branding"), true);
		applyBrandingPage.selectRelativeUpFrame();
		applyBrandingPage.selectRelativeUpFrame();
		applyBrandingPage.selectRelativeUpFrame();
		applyBrandingPage.selectAppBodyNodeViewNodeDetailsFrame();
		logger.info("Applying Branding with few details");
		//applyBrandingPage = ApplyBrandingAction.enterSelectedBrandingDetails(shortProductName, longProductName, SubSplashImgName, SubInstaller82ImgName,SubInstaller84ImgName);
		applyBrandingPage.typeMacAgentShortProductName(shortProductName);
		applyBrandingPage.typeMacAgentLongProductName(longProductName);
		applyBrandingPage.typePcAgentProductImageOnSplashScreen(logopath+SubSplashImgName);
		applyBrandingPage.typePcAgentVersion8to8_2_2InstallerProducImage(logopath+SubInstaller82ImgName);
		applyBrandingPage.typePcAgentVersion8_4AndLaterInstallerProducImage(logopath+SubInstaller84ImgName);
		applyBrandingPage = applyBrandingPage.clickOnApplyButton();
		Thread.sleep(20000);
		applyBrandingPage.selenium.keyPressNative(Integer.toString(java.awt.event.KeyEvent.VK_ENTER )+"");
		
		super.stopSeleniumTest();
		super.initSupportCenterTest();
		initialiseSCafterLogOut();
		SupportCenterLogin.login(TechnicianId, Password);
		logger.info("Navigating to the Apply Branding Page of the child community");
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(subCommID);
		supportCenterHomePage.clickOnToolsLink();
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Apply Branding"), true);
		verifyBrandingDetails(shortProductName, longProductName, subCommID);
		verifyImages(SubSplashImgName, SubInstaller82ImgName, SubInstaller84ImgName,subCommID);
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		logger.info("Navigating to the grand child community");
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(commID);
		supportCenterHomePage.clickOnToolsLink();
		logger.info("Navigating to the Apply Branding Page of the grand child community");
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Apply Branding"), true);
		applyBrandingPage.selectRelativeUpFrame();
		applyBrandingPage.selectRelativeUpFrame();
		applyBrandingPage.selectRelativeUpFrame();
		applyBrandingPage.selectAppBodyNodeViewNodeDetailsFrame();
		applyBrandingPage.unCheckShowPoweredByIronMountainLogoCheckbox();
		applyBrandingPage.typeMacAgentShortProductName(shortProductName);
		applyBrandingPage.typeMacAgentLongProductName(longProductName);
		applyBrandingPage.typePcAgentProductImageOnSplashScreen(logopath+SplashImgName);
		applyBrandingPage.typePcAgentVersion8to8_2_2InstallerProducImage(logopath+Installer82ImgName);
		applyBrandingPage.typePcAgentVersion8_4AndLaterInstallerProducImage(logopath+Installer84ImgName);
		applyBrandingPage = applyBrandingPage.clickOnApplyButton();
		Thread.sleep(20000);
		applyBrandingPage.selenium.keyPressNative(Integer.toString(java.awt.event.KeyEvent.VK_ENTER )+"");
		super.stopSeleniumTest();
		super.initSupportCenterTest();
		initialiseSCafterLogOut();
	SupportCenterLogin.login(TechnicianId, Password);
		logger.info("Navigating to the the grand child community");
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(commID);
		supportCenterHomePage.clickOnToolsLink();
		logger.info("Navigating to the Apply Branding Page of the grand child community");
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		Reporter.log("The Branding configuration page opens up in Support Center without the inherited from Parent message");
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Apply Branding"), true);
		Asserter.assertEquals(applyBrandingPage.verifyShowPoweredByIronMountainLogoCheckboxState(), "off");
		Asserter.assertEquals(applyBrandingPage.getMacAgentShortProductName(), shortProductName);
		Asserter.assertEquals(applyBrandingPage.getMacAgentLongProductName(), longProductName);
		Asserter.assertEquals(brandTable.getValueByColNameandCommunityID("MacProductName", commID), shortProductName);
		Asserter.assertEquals(brandTable.getValueByColNameandCommunityID("MacLongProductName", commID), longProductName);
		Asserter.assertEquals(brandTable.getValueByColNameandCommunityID("PoweredBy", commID), "0");
		logger.info("Verifying Branding details for all the communities");
		
		
		verifyImages(SplashImgName,Installer82ImgName,Installer84ImgName,commID);	
	}
	
		
	public void verifyBrandingDetails(String shortProductName, String longProductName, String commID){
		logger.info(" Verifying that all the settings are inherited from the parent");
		Asserter.assertEquals(applyBrandingPage.verifyShowPoweredByIronMountainLogoCheckboxState(), "on");
		Asserter.assertEquals(applyBrandingPage.getMacAgentShortProductName(), shortProductName);
		Asserter.assertEquals(applyBrandingPage.getMacAgentLongProductName(), longProductName);
		Asserter.assertEquals(brandTable.getValueByColNameandCommunityID("MacProductName", commID), shortProductName);
		Asserter.assertEquals(brandTable.getValueByColNameandCommunityID("MacLongProductName", commID), longProductName);
		Asserter.assertEquals(brandTable.getValueByColNameandCommunityID("PoweredBy", commID), "1");
		
	}
	
	public void verifyImages(String SplashImgName, String Installer82ImgName, String Installer84ImgName, String commID) throws Exception{
		logger.info(" Verifying that all the images that are inherited");
		CopyFromDC.copyBrandingDirectoryFromDC();
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+SplashImgName, "C:"+File.separator+"DCBrandingFiles"+File.separator+commID+File.separator+"pcdataprotector_splashlogo.png"), true);
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+Installer82ImgName, "C:"+File.separator+"DCBrandingFiles"+File.separator+commID+File.separator+"pcdataprotector_logo.jpg.ibd"), true);
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+Installer84ImgName, "C:"+File.separator+"DCBrandingFiles"+File.separator+commID+File.separator+"pcdataprotector_logo_wise.jpg.ibd"), true);
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
		logger.info(" Stopping the Test...");
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.clickOnLogOff();	
		brandTable.closeDatabaseConnection();
		super.stopSeleniumTest();
	}
	

}
