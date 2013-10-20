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
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.ApplyBrandingAction;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.CreateCustomCommunity;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.SupportCenterLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.testrunner.ActionRunner;
import com.ironmountain.pageobject.webobjects.connected.database.registry.BrandTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.supportcenter.SupportCenterNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;


/** SupportCenter Test
 * @author pjames
 *
 */
@SeleniumUITest
public class SSWSandSCImagesWPBIRMTest extends SupportCenterTest{
	
	private static Logger logger      = Logger.getLogger(SSWSandSCImagesWPBIRMTest.class.getName());
	private static String commID = null;
	private static String SSWSTechID = null;
	private static String parentCommID = null;
	String DC_NAME = null;
	
	
	
	String LoginImgName =null;
	String HeaderImgName =null;
	String SSWSImgName=null;
	String logopath = "C:"+File.separator+"BrandingData"+File.separator;
	String CommunityName = null;
	String TechID = null;
	
	
	@BeforeMethod(alwaysRun=true)
	public void startTest() throws Exception{
		logger.info(" Starting Test...");
		ActionRunner.run("CopyFile.xml");
		super.initSupportCenterTest();	
		LoginImgName = TestDataProvider.getTestData("LoginImgName");
		HeaderImgName = TestDataProvider.getTestData("HeaderImgName");
		SSWSImgName= TestDataProvider.getTestData("SSWSImgName");
		DC_NAME = (StringUtils.extractDCNamefromMachineName()).toUpperCase();
		TechID = "Tech"+StringUtils.createNameVal();
		logger.info(" Test Initialization Completed.");
	}
	
	@Parameters( {"TechnicianId", "Password"})
	@BeforeMethod (alwaysRun=true, dependsOnMethods = {"startTest"})
	public void createCommunityAndTechnician(String TechnicianId, String Password) throws Exception{
		logger.info(" Creating Test Setup");
		SupportCenterLogin.login(TechnicianId, Password);
		parentCommID = TestDataProvider.getTestData("SSWSCommunityID");
		CommunityName = TestDataProvider.getTestData("CommunityName");
		techniciansPage = SupportCenterNavigation.viewTechniciansPage(parentCommID);
		techniciansPage.typeTechID(TechID);
		techniciansPage.setTechnicianAsAdmin(DC_NAME);
		techniciansPage.typePassword(Password);
		techniciansPage.typeConfirmPassword(Password);
		techniciansPage.clickOnAddTechnicianBtn();
		logger.info(" Completed Test Setup");
	}
	
	@Parameters( {"TechnicianId", "Password", "NewPassword", "ChangedPwd"})
	@Test(enabled = true, groups= {"sc","branding", "apply branding page "})
	public void testAllFields(String TechnicianId, String Password, String NewPassword, String ChangedPwd) throws Exception{
		logger.info(" Navigating to the parent community");
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(parentCommID);
		supportCenterHomePage.clickOnToolsLink();
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		logger.info(" Applying Branding");
		applyBrandingPage.checkShowPoweredByIronMountainLogoCheckbox();
		ApplyBrandingAction.enterFewImageBrandingDetails(LoginImgName, HeaderImgName, SSWSImgName);
		Thread.sleep(10000);
		super.stopSeleniumTest();
		super.initSupportCenterTest();
		initialiseSCafterLogOut();
		SupportCenterLogin.login(TechnicianId, Password);
		logger.info(" Navigating to the parent community after applying branding");
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(parentCommID);
		supportCenterHomePage.clickOnToolsLink();
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		logger.info(" Validating that PB is off");
		Asserter.assertEquals(applyBrandingPage.verifyShowPoweredByIronMountainLogoCheckboxState(), "on");
		logger.info(" Getting the branded SC url");
		String brandedUrl = applyBrandingPage.getSCUrl();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.clickOnLogOff();
		super.stopSeleniumTest();
		super.initSupportCenterTest();
		logger.info(" Navigating to the SC Url");
		supportCenterLoginPage = SupportCenterNavigation.viewBrandedSupportCenterPage(brandedUrl);
		logger.info(" Validating the Product Image on login Screen");
		Asserter.assertEquals(supportCenterLoginPage.verifyProductImageOnLoginScreenwhileLogin(parentCommID), true);
		supportCenterHomePage = SupportCenterLogin.loginAndChangePassword(TechID, Password, NewPassword, CommunityName);
		Asserter.assertEquals(supportCenterHomePage.verifyTitle(), true);
		supportCenterHomePage.selectAppHeaderFrame();
		logger.info(" Validating that the PB is on");
		Asserter.assertEquals(supportCenterHomePage.verifyShowPoweredByIronMountainImage(), true);
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.clickOnLogOff();
		
	}
	
	public void initialiseSCafterLogOut() throws Exception{
		if (!(seleniumPage.isTextPresent("Please Log In"))){
			seleniumPage.selectRelativeUpFrame();
			seleniumPage.selectRelativeUpFrame();
			seleniumPage.selectRelativeUpFrame();
			seleniumPage.selectFrame("AppHeader");
			seleniumPage.click("//a[contains(@onclick,'Logout')]");
			seleniumPage.close();	
			super.initSupportCenterTest();
		} 
	}


	@AfterMethod(alwaysRun=true)
	public void stopTest() throws Exception{
		logger.info(" Stopping Test...");
		super.stopSeleniumTest();
	}
	
	
	

}
