
package com.ironmountain.pageobject.webobjects.connected.tests.supportcenter.testng.java.branding;

import java.io.File;

import org.apache.log4j.Logger;
import org.testng.Reporter;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
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
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.SupportCenterLoginPage;
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;

/** Support Center Test
 * @author pjames
 *
 */
@SeleniumUITest
public class SSWSandSCImagesWoPBIRMTest extends SupportCenterTest{
	
	private static Logger logger      = Logger.getLogger(SSWSandSCImagesWoPBIRMTest.class.getName());
	private static String commID = null;
	private static String TechID = null;
	private static String parentCommID = null;
	
	
	String LoginImgName =null;
	String HeaderImgName =null;
	String SSWSImgName=null;
	String logopath = "C:"+File.separator+"BrandingData"+File.separator;
	String CommunityName = null;
	String DC_NAME = null;
	
	
	@BeforeMethod(alwaysRun=true)
	public void startTest() throws Exception{
		logger.info(" Starting Test...");
		ActionRunner.run("CopyFile.xml");
		super.initSupportCenterTest();	
		LoginImgName = TestDataProvider.getTestData("LoginImgName");
		HeaderImgName = TestDataProvider.getTestData("HeaderImgName");
		SSWSImgName= TestDataProvider.getTestData("SSWSImgName");
		DC_NAME = (StringUtils.extractDCNamefromMachineName()).toUpperCase();
		logger.info(" Test initialization completed");
	}
	
	@Parameters( {"TechnicianId", "Password", "TechID"})
	@BeforeMethod (alwaysRun=true, dependsOnMethods = {"startTest"})
	public void createCommunityAndTechnician(String TechnicianId, String Password, String TechID) throws Exception{
		logger.info(" Creating Test Setup");
		SupportCenterLogin.login(TechnicianId, Password);
		parentCommID = CreateCustomCommunity.createCommunityAction();
		TestDataProvider.setTestDataToXmlFile(TEST_DATA_XML_FILE, "SSWSCommunityID", parentCommID);
		parentCommID = TestDataProvider.getTestData("SSWSCommunityID");
		CommunityName = TestDataProvider.getTestData("CommunityName");
		techniciansPage = SupportCenterNavigation.viewTechniciansPage(parentCommID);
		techniciansPage.typeTechID(TechID);
		techniciansPage.setTechnicianAsAdmin(DC_NAME);
		techniciansPage.typePassword(Password);
		techniciansPage.typeConfirmPassword(Password);
		techniciansPage.clickOnAddTechnicianBtn();
		logger.info(" Completed test setup");
	}
	
	@Parameters( {"TechnicianId", "Password", "NewPassword", "TechID", "ChangedPwd"})
	@Test(enabled = true, groups= {"sc","branding", "apply branding page "})
	public void testAllFields(String TechnicianId, String Password, String NewPassword, String TechID, String ChangedPwd) throws Exception{
		logger.info(" Navigating to the created community");
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(parentCommID);
		supportCenterHomePage.clickOnToolsLink();
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		logger.info("Openning the Apply Branding Page");
		applyBrandingPage.unCheckShowPoweredByIronMountainLogoCheckbox();
		logger.info(" Applying Branding");
		ApplyBrandingAction.enterFewImageBrandingDetails(LoginImgName, HeaderImgName, SSWSImgName);
		Thread.sleep(10000);
		super.stopSeleniumTest();
		super.initSupportCenterTest();
		initialiseSCafterLogOut();
		SupportCenterLogin.login(TechnicianId, Password);
		logger.info(" Navigating to the parent community");
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(parentCommID);
		supportCenterHomePage.clickOnToolsLink();
		logger.info(" Navigating to the Apply Branding Page");
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		Asserter.assertEquals(applyBrandingPage.verifyShowPoweredByIronMountainLogoCheckboxState(), "off");
		logger.info(" Getting the Support center branded url from the apply branding page");
		String brandedUrl = applyBrandingPage.getSCUrl();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.clickOnLogOff();
		super.stopSeleniumTest();
		super.initSupportCenterTest();
		logger.info(" Accessing the branded Url");
		supportCenterLoginPage = SupportCenterNavigation.viewBrandedSupportCenterPage(brandedUrl);
		logger.info(" Verifying the product image on the login screen");
		Asserter.assertEquals(supportCenterLoginPage.verifyProductImageOnLoginScreenwhileLogin(parentCommID), true);
		logger.info(" Entering Support Center as a new technician");
		supportCenterHomePage = SupportCenterLogin.loginAndChangePassword(TechID, Password, NewPassword, CommunityName);
		Asserter.assertEquals(supportCenterHomePage.verifyTitle(), true);
		supportCenterHomePage.selectAppHeaderFrame();
		logger.info(" Verifying the powered by Logo on login");
		Asserter.assertEquals(supportCenterHomePage.verifyShowPoweredByIronMountainElement(), false);
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.clickOnLogOff();	
		super.stopSeleniumTest();
		super.initSupportCenterTest();
		logger.info(" Login as the Admin technician");
		SupportCenterLogin.login(TechnicianId, Password);
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(parentCommID);
		supportCenterHomePage.clickOnToolsLink();
		logger.info(" Applying new branding settings");
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		logger.info("The Branding configuration page opens up in Support Center");
		applyBrandingPage.checkShowPoweredByIronMountainLogoCheckbox();
		applyBrandingPage.clickOnApplyButton();
		applyBrandingPage.waitForSeconds(5);
		applyBrandingPage.selenium.keyPressNative(Integer.toString(java.awt.event.KeyEvent.VK_ENTER )+"");
		super.stopSeleniumTest();
		super.initSupportCenterTest();
		logger.info(" Accessing the branded Url as the new technician");
		supportCenterLoginPage = SupportCenterNavigation.viewBrandedSupportCenterPage(brandedUrl);
		supportCenterHomePage = SupportCenterLogin.login(TechID, NewPassword,CommunityName);
		Asserter.assertEquals(supportCenterHomePage.verifyTitle(), true);
		supportCenterHomePage.selectAppHeaderFrame();
		logger.info(" Verifying the Powered By Image");
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
		logger.info(" Stopping Test....");
		super.stopSeleniumTest();
		
	}
	
}
