package com.ironmountain.pageobject.webobjects.connected.tests.supportcenter.testng.java.ProfileAndWebSiteSettings;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.SupportCenterLogin;
import com.ironmountain.pageobject.webobjects.connected.database.registry.AgentWebSiteSettingsTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.supportcenter.SupportCenterNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;

@SeleniumUITest(priority=5)
public class OptionsTest extends SupportCenterTest{
	
	AgentWebSiteSettingsTable agentWebSiteSettingsTable = null;
	String commID = null;
	String ProfileName = null;
	String profileID = null;
	String fieldname = null;
	String displaystatuscode = null;
	String DBVerificationText = null;
	String dbval = null;
	String value = null;
		
	@BeforeMethod(alwaysRun=true)
	public void startTest() throws Exception{
		super.initSupportCenterTest();
		commID = TestDataProvider.getTestData("PWSCommunityID");
		ProfileName = TestDataProvider.getTestData("ProfileName");
		agentWebSiteSettingsTable = new AgentWebSiteSettingsTable(DatabaseServer.COMMON_SERVER);
		profileID = agentWebSiteSettingsTable.getValueByColNameandCommunityID("ID", commID);
		String whereclause = " ID="+profileID;
		dbval = agentWebSiteSettingsTable.getValueByColNameandCommunityID("SETTINGDETAILS", commID, whereclause);
		System.out.println(dbval);
	}
	
	@Parameters( {"TechnicianId", "Password"})
	@Test(enabled = true, groups= {"sc","ProfileAndWebSiteSettings", "Default Profile And WebSite Settings"})
	public void testOptionalFields(String TechnicianId, String Password) throws Exception{
		supportCenterHomePage = SupportCenterLogin.login(TechnicianId, Password);	
		profileAndWebSiteSettingsPage = SupportCenterNavigation.viewCustomProfileAndWebSiteSettingsConfigPage(commID);
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		profileAndWebSiteSettingsPage.checkAgentMenuOption();
		profileAndWebSiteSettingsPage.checkPermitUserAsianOption();
		profileAndWebSiteSettingsPage.uncheckAllowEditProfOption();
		profileAndWebSiteSettingsPage.checkRequireAuthenOption();
		profileAndWebSiteSettingsPage.uncheckProhibitDownloadOption();
		profileAndWebSiteSettingsPage.checkShowServiceLicenseOption();
		profileAndWebSiteSettingsPage.checkAllowOrderMediaOption();
		profileAndWebSiteSettingsPage.checkAllowRetrieveFilesOption();
		profileAndWebSiteSettingsPage.clickOnFinishBtn();
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyAgentMenuOption(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyPermitUserAsianOption(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyAllowEditProfOption(), false);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyRequireAuthenOption(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyProhibitDownloadOption(), false);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyShowServiceLicenseOption(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyAllowOrderMediaOption(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyAllowRetrieveFilesOption(), true);
		}
	
	@AfterMethod(alwaysRun=true)
	public void stopTest() throws Exception{
		profileAndWebSiteSettingsPage.selectRelativeUpFrame();
		profileAndWebSiteSettingsPage.selectRelativeUpFrame();
		profileAndWebSiteSettingsPage.selectRelativeUpFrame();
		profileAndWebSiteSettingsPage.clickOnLogOff();
		super.stopSeleniumTest();
	}
}
