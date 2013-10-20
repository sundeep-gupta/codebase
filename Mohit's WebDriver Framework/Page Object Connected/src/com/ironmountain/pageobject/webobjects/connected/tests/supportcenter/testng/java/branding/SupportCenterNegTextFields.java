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
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.ApplyBrandingAction;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.CreateCustomCommunity;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.SupportCenterLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.testrunner.ActionRunner;
import com.ironmountain.pageobject.webobjects.connected.database.registry.BrandTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.supportcenter.SupportCenterNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;

@SeleniumUITest
public class SupportCenterNegTextFields extends SupportCenterTest{
	private static String logopath = "C:"+File.separator+"BrandingData"+File.separator;
	private static Logger logger = Logger.getLogger(SupportCenterNegTextFields.class.getName());
	
	private static String commID = null;
	
	String shortProductName ="`~!@#$%^&*():;'<,>.?/|\1@connected*()/shortname";
	String longProductName ="`~!@#$%^&*():;'<,>.?/|\1@connected*()longname";
	String installationFolder ="`~!@#$%^&*():;'<,>.?/|\1@connected*()installfolder";
	String productName ="`~!@#$%^&*():;'<,>.?/|\1@connected*()prodname";
	String definstallationFolder ="`~!@#$%^&*():;'<,>.?/|\1@connected*()definstallfold";
	String desktopProductName ="`~!@#$%^&*():;'<,>.?/|\1@connected*()deskprodname";
	String programGroupLocation ="`~!@#$%^&*():;'<,>.?/|\1@connected*()proggrploc";
	String siteName="`~!@#$%^&*():;'<,>.?/|\1@connected*()sitename";
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
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(commID);
		supportCenterHomePage.clickOnToolsLink();
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		Reporter.log("The Branding configuration page opens up in Support Center");
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Apply Branding"), true);
		logger.info(" Applying branding with invalid details");
		ApplyBrandingAction.enterInvalidTextBrandingDetails(shortProductName, longProductName, installationFolder, productName,
							definstallationFolder, desktopProductName, programGroupLocation, siteName);
		super.stopSeleniumTest();
		super.initSupportCenterTest();
		initialiseSCafterLogOut();
		SupportCenterLogin.login(TechnicianId, Password);
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(commID);
		supportCenterHomePage.clickOnToolsLink();
		logger.info(" Verifying that branding is not applied");
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		//applyBrandingPage.selectAppBodyNodeViewNodeDetailsFrame();
		String val = applyBrandingPage.getMacAgentShortProductName();
		Asserter.assertEquals(val.contains(shortProductName), false);
		val = applyBrandingPage.getMacAgentLongProductName();
		Asserter.assertEquals(val.contains(longProductName), false);
		val = applyBrandingPage.getMacAgentDefaultInstallFolder();
		Asserter.assertEquals(val.contains(installationFolder), false);
		val = applyBrandingPage.getPcAgentDesktopProductName();
		Asserter.assertEquals(val.contains(productName), false);
		val = applyBrandingPage.getPcAgentDefaultInstallFolder();
		Asserter.assertEquals(val.contains(definstallationFolder), false);
		val = applyBrandingPage.getPcAgentDesktopProductName();
		Asserter.assertEquals(val.contains(desktopProductName), false);
		val = applyBrandingPage.getPcAgentProgramGroupLocation();
		Asserter.assertEquals(val.contains(programGroupLocation), false);
		val = applyBrandingPage.getAcountManagementSiteName();
		Asserter.assertEquals(val.contains(siteName), false);
		//verifyErrorMessages(shortProductName, longProductName, installationFolder, productName, definstallationFolder, desktopProductName, programGroupLocation, siteName);
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.clickOnLogOff();	
	}
	
	
	public void verifyErrorMessages(String shortProductName, String longProductName, 
			String installationFolder,String productName,String definstallationFolder, String desktopProductName,
			String programGroupLocation, String siteName) throws Exception{
		Asserter.assertEquals(applyBrandingPage.isTextPresent("The Short product name field is invalid. This field cannot contain any of the following characters:"+shortProductName), true);
		Asserter.assertEquals(applyBrandingPage.isTextPresent("The Short product name field is invalid. This field cannot contain any of the following characters:"+longProductName), true);
		Asserter.assertEquals(applyBrandingPage.isTextPresent("The Short product name field is invalid. This field cannot contain any of the following characters:"+installationFolder), true);
		Asserter.assertEquals(applyBrandingPage.isTextPresent("The Short product name field is invalid. This field cannot contain any of the following characters:"+productName), true);
		Asserter.assertEquals(applyBrandingPage.isTextPresent("The Short product name field is invalid. This field cannot contain any of the following characters:"+definstallationFolder), true);
		Asserter.assertEquals(applyBrandingPage.isTextPresent("The Short product name field is invalid. This field cannot contain any of the following characters:"+desktopProductName), true);
		Asserter.assertEquals(applyBrandingPage.isTextPresent("The Short product name field is invalid. This field cannot contain any of the following characters:"+programGroupLocation), true);
		Asserter.assertEquals(applyBrandingPage.isTextPresent("The Short product name field is invalid. This field cannot contain any of the following characters:"+siteName), true);
	
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
		super.stopSeleniumTest();
	}
	

}
