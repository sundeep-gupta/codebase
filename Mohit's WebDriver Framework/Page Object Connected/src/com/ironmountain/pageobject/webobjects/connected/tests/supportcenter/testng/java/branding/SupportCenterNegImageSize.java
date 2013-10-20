package com.ironmountain.pageobject.webobjects.connected.tests.supportcenter.testng.java.branding;

import java.io.File;

import org.apache.log4j.Logger;
import org.testng.Reporter;
import org.testng.annotations.AfterTest;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.framework.utils.TestDataFileFilter;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.ApplyBrandingAction;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.CreateCustomCommunity;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.SupportCenterLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.testrunner.ActionRunner;
import com.ironmountain.pageobject.webobjects.connected.database.registry.BrandTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.supportcenter.SupportCenterNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;

@SeleniumUITest
public class SupportCenterNegImageSize extends SupportCenterTest{
	private static String logopath = "C:"+File.separator+"BrandingData"+File.separator;
	private static Logger logger = Logger.getLogger(SupportCenterNegImageSize.class.getName());
	
	private static String commID = null;
	
	String LoginImgName ="Invalid_Login_SpiderManType.gif";
	String HeaderImgName ="Invalid_Header_SpiderManType.gif";
	String MacImageName ="Invalid_Spider_ManType.gif";
	String AgentProdImgName ="Invalid_AgentApplicationSpiderManType.png";
	String SplashImgName ="Invalid_ProductImageSplashSpidermamType.png";
	String Installer82ImgName ="Invalid_8.22InstallerType.jpg";
	String Installer84ImgName ="Invalid_8.4InstallerType.jpg";
	String SSWSImgName="Invalid_SiteImageHeaderSpiderManType.png";
	String BrandedMsg = "(Branded; to change, enter new image file)";
	

	String applyBrandingText = null;

	@BeforeMethod(alwaysRun=true)
	public void startTest() throws Exception{
		logger.info(" Starting Test...");
		ActionRunner.run("CopyFile.xml");
		super.initSupportCenterTest();
		logger.info(" Test Initialization Completed");
	}
	
	@Parameters( {"TechnicianId", "Password"})
	@BeforeMethod (alwaysRun=true, dependsOnMethods = {"startTest"})
	public void createCommunityHierarchy(String TechnicianId, String Password) throws Exception{
		logger.info(" Creating Test Setup");
		SupportCenterLogin.login(TechnicianId, Password);
		commID = CreateCustomCommunity.createCommunityAction();
		TestDataProvider.setTestDataToXmlFile(TEST_DATA_XML_FILE, "InvalidTestCommunity", commID);
		commID = TestDataProvider.getTestData("InvalidTestCommunity");
		logger.info(" Completed Test Setup");
		}
	
	@Parameters( {"TechnicianId", "Password"})
	@Test(enabled = true, groups= {"sc","branding", "apply branding page "})
	public void testAllFields(String TechnicianId, String Password)throws Exception{
		//supportCenterHomePage = SupportCenterLogin.login(TechnicianId, Password);	
		//Asserter.assertEquals(supportCenterHomePage.verifyTitle(), true);
		logger.info(" Opening Support Center");
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(commID);
		supportCenterHomePage.clickOnToolsLink();
		logger.info(" Navigating to Branding Page");
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Apply Branding"), true);
		logger.info(" Applying Branding with Invalid details");
		ApplyBrandingAction.enterInvalidImageBrandingDetails(LoginImgName, HeaderImgName, MacImageName, AgentProdImgName, SplashImgName, Installer82ImgName, Installer84ImgName, SSWSImgName);
		Thread.sleep(20000);
		super.stopSeleniumTest();
		super.initSupportCenterTest();
		initialiseSCafterLogOut();
		SupportCenterLogin.login(TechnicianId, Password);
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(commID);
		supportCenterHomePage.clickOnToolsLink();
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		//applyBrandingPage.selectAppBodyNodeViewNodeDetailsFrame();
		logger.info(" Verifying that Branding is not applied.");
		String val = applyBrandingPage.getLogoPathforProductImageOnLoginScreen();
		Asserter.assertEquals(val.contains(BrandedMsg), false);
		val = applyBrandingPage.getLogoPathforProductImageInHeader();
		Asserter.assertEquals(val.contains(BrandedMsg), false);
		val = applyBrandingPage.getMacAgentProductImageInAgentApplication();
		Asserter.assertEquals(val.contains(BrandedMsg), false);
		val = applyBrandingPage.getPcAgentVersion8to8_2_2InstallerProducImage();
		Asserter.assertEquals(val.contains(BrandedMsg), false);
		val = applyBrandingPage.getPcAgentVersion8_4AndLaterInstallerProducImage();
		Asserter.assertEquals(val.contains(BrandedMsg), false);
		val = applyBrandingPage.getAcountManagementSiteimageInHeader();
		Asserter.assertEquals(val.contains(BrandedMsg), false);
		//verifyErrorMessages();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.clickOnLogOff();	
	}
	
	public void verifyErrorMessages() throws Exception{
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Logo file incorrect size.The Product image on Longon page must be at most 170 pixels wide by 181 pixels high"), true);
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Logo file incorrect size.The Product image in header must be at most 159 pixels by 40 pixels high."), true);
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Logo file incorrect size.The Product image in Agent application must be at mos 330 pixels wide by 60 pixels high"), true);
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Logo file incorrect size.The Product image in Agent application must be at most 256 pixels wide by 40 pixels high."), true);
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Logo file incorrect size.The Product image on Splash screen must be at most 522 pixels wide by 74 pixels high."), true);
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Logo file incorrect size. The Product image in install program must be at most 500 pixels wide by 63 pixels high."), true);
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Logo file incorrect size. The installer product image must be at most 500 pixels wide by 63 pixels high."), true);
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Logo file incorrect size. The Product image in install program must be at most 500 pixels wide by 63 pixels high."), true);
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Logo file incorrect size. The Site logo must be at most 356 pixels by 69 pixels high."), true);
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
	
	
	@AfterTest(alwaysRun=true)
	public void stopTest() throws Exception{
		logger.info(" Stopping Test...");
		super.stopSeleniumTest();
	}
	
	
}
