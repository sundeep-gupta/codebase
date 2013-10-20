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
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.ApplyBrandingAction;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.CreateCustomCommunity;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.SupportCenterLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.testrunner.ActionRunner;
import com.ironmountain.pageobject.webobjects.connected.database.registry.BrandTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.supportcenter.SupportCenterNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;

@SeleniumUITest
public class SupportCenterNegImageType extends SupportCenterTest{
	private static String logopath = "C:"+File.separator+"BrandingData"+File.separator;
	private static Logger logger = Logger.getLogger(SupportCenterNegImageType.class.getName());
	String BrandedMsg = "(Branded; to change, enter new image file)";
	private static String commID = null;
	
	String LoginImgName ="Invalid_Login_SpiderMan.gif";
	String HeaderImgName ="Invalid_Header_SpiderMan.gif";
	String MacImageName ="Invalid_Spider_Man.gif";
	String AgentProdImgName ="Invalid_AgentApplicationSpiderMan.gif";
	String SplashImgName ="Invalid_ProductImageSplashSpidermam.gif";
	String Installer82ImgName ="Invalid_8.22_InstallerSpiderMan.png";
	String Installer84ImgName ="Invalid_8.4InstallerSpiderMan.png";
	String SSWSImgName="Invalid_SiteImageHeaderSpiderMan.png";
	

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
		commID = TestDataProvider.getTestData("InvalidTestCommunity");
		logger.info(" Completed Test Setup");
		}
	
	@Parameters( {"TechnicianId", "Password"})
	@Test(enabled = true, groups= {"sc","branding", "apply branding page "})
	public void testAllFields(String TechnicianId, String Password)throws Exception{
		logger.info(" Opening Support Center");
		supportCenterHomePage = SupportCenterLogin.login(TechnicianId, Password);	
		Asserter.assertEquals(supportCenterHomePage.verifyTitle(), true);
		supportCenterHomePage =SupportCenterNavigation.viewCustomCommunityPage(commID);
		supportCenterHomePage.clickOnToolsLink();
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Apply Branding"), true);
		logger.info(" Applying Branding with Invalid details");
		ApplyBrandingAction.enterInvalidImageBrandingDetails(LoginImgName, HeaderImgName, MacImageName, AgentProdImgName, SplashImgName, Installer82ImgName, Installer84ImgName, SSWSImgName);
		Thread.sleep(20000);
		//verifyErrorMessages();
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
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Logo file incorrect format. The product image on Login page must be a GIF file."), true);
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Logo file incorrect format. The product image on Login page must be a GIF file."), true);
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Logo file incorrect format. The product image on Login page must be a PNG file."), true);
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Logo file incorrect format. The product image on Login page must be a PNG file."), true);
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Logo file incorrect format. The product image on Login page must be a PNG file."), true);
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Logo file incorrect format. The product image on Login page must be a JPEG file."), true);
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Logo file incorrect format. The product image on Login page must be a JPEG file."), true);
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Logo file incorrect format. The product image on Login page must be a PNG file."), true);
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
