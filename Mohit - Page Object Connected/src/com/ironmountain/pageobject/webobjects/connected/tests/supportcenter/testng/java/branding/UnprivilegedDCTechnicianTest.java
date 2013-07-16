package com.ironmountain.pageobject.webobjects.connected.tests.supportcenter.testng.java.branding;

import java.io.File;

import org.apache.log4j.Logger;
import org.testng.annotations.AfterTest;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.SupportCenterLogin;
import com.ironmountain.pageobject.webobjects.connected.database.registry.BrandTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.supportcenter.SupportCenterNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;

@SeleniumUITest
public class UnprivilegedDCTechnicianTest extends SupportCenterTest{
	
	private static Logger  logger      = Logger.getLogger(UnprivilegedDCTechnicianTest.class.getName());
	private static String commID = null;
	private static String TechID = null;
	private static String parentCommID = null;
	
	String LoginImgName =null;
	String HeaderImgName =null;
	String SSWSImgName=null;
	String logopath = "C:"+File.separator+"BrandingData"+File.separator;
	String defaultCommunityID = "-1";
	String DC_NAME = StringUtils.extractDCNamefromMachineName();
	
	
	@BeforeMethod(alwaysRun=true)
	public void startTest() throws Exception{
		logger.info("Starting Test...");
		super.initSupportCenterTest();	
		LoginImgName = TestDataProvider.getTestData("LoginImgName");
		HeaderImgName = TestDataProvider.getTestData("HeaderImgName");
		SSWSImgName = TestDataProvider.getTestData("SSWSImgName");
		TechID = "Tech"+StringUtils.createNameVal();
		logger.info("Test initialization completed.");
	}
	
	
	@Parameters( {"TechnicianId", "Password", "NewPassword"})
	@Test(enabled = true, groups= {"sc","branding", "apply branding page "})
	public void testAllFields(String TechnicianId, String Password, String NewPassword) throws Exception{
		logger.info("Opening Support Center");
		SupportCenterLogin.login(TechnicianId, Password);
		techniciansPage = SupportCenterNavigation.viewTechniciansPage(defaultCommunityID);
		Thread.sleep(10000);
		logger.info("Creating Technician");
		techniciansPage.typeTechID(TechID);
		techniciansPage.typePassword(Password);
		techniciansPage.typeConfirmPassword(Password);
		techniciansPage.clickOnAddTechnicianBtn();
		techniciansPage.selectRelativeUpFrame();
		techniciansPage.selectRelativeUpFrame();
		techniciansPage.selectRelativeUpFrame();
		techniciansPage.clickOnLogOff();
		super.stopSeleniumTest();
		super.initSupportCenterTest();
		//initialiseSCafterLogOut();
		logger.info("Login as the new technician");
		supportCenterHomePage = SupportCenterLogin.loginAndChangePassword(TechID, Password, NewPassword, DC_NAME);
		Asserter.assertEquals(supportCenterHomePage.verifyTitle(), true);
		Asserter.assertEquals(supportCenterHomePage.verifyTitle(), true);
		supportCenterHomePage.clickOnToolsLink();
		String applybrandinglink = supportCenterHomePage.getLocator("SupportCenterPage.ApplyBrandingMenu");
		logger.info("Verifying that the technician does not have rights to Apply Branding");
		Asserter.assertEquals(supportCenterHomePage.selenium.isElementPresent(applybrandinglink), false);
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.clickOnLogOff();	
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
	
	@AfterTest(alwaysRun=true)
	public void stopTest() throws Exception{
		logger.info("Stopping Test...");
		super.stopSeleniumTest();
	}

}
