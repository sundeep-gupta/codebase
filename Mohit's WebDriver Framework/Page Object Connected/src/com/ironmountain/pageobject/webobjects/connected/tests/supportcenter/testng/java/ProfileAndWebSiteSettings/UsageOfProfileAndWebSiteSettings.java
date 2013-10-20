package com.ironmountain.pageobject.webobjects.connected.tests.supportcenter.testng.java.ProfileAndWebSiteSettings;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.CreateCustomCommunity;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.SupportCenterLogin;
import com.ironmountain.pageobject.webobjects.connected.database.registry.AgentConfigurationTable;
import com.ironmountain.pageobject.webobjects.connected.database.registry.AgentWebSiteSettingsTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.supportcenter.SupportCenterNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;

@SeleniumUITest(priority=6)
public class UsageOfProfileAndWebSiteSettings extends SupportCenterTest{

	AgentWebSiteSettingsTable agentWebSiteSettingsTable = null;
	AgentConfigurationTable agentConfigurationTable = null;
	String commID = null;
	String subcommID = null;
	String ProfileName = null;
	String profileID = null;
	String fieldname = null;
	String displaystatuscode = null;
	String DBVerificationText = null;
	String dbval = null;
	String value = null;
	
	@Parameters( {"TechnicianId", "Password"})
	@BeforeMethod(alwaysRun=true)
	public void startTest(String TechnicianId, String Password) throws Exception{
		super.initSupportCenterTest();
		SupportCenterLogin.login(TechnicianId, Password);
		agentWebSiteSettingsTable = new AgentWebSiteSettingsTable(DatabaseServer.COMMON_SERVER);
		agentConfigurationTable = new AgentConfigurationTable(DatabaseServer.COMMON_SERVER);
		commID = TestDataProvider.getTestData("PWSCommunityID");
		subcommID = TestDataProvider.getTestData("PWSSubCommunity");
		subcommID = CreateCustomCommunity.createCommunityUnderCommunity(TechnicianId, Password, commID);
		TestDataProvider.setTestDataToXmlFile(TEST_DATA_XML_FILE, "PWSSubCommunity", subcommID);
		ProfileName = TestDataProvider.getTestData("ProfileName");
		profileID = agentWebSiteSettingsTable.getValueByColNameandCommunityID("ID", commID);
		}
	
	@Parameters( {"TechnicianId", "Password", "PCProfileName", "MacProfileName"})
	@Test(enabled = true, groups= {"sc","ProfileAndWebSiteSettings", "Default Profile And WebSite Settings"})
	public void testUsage(String TechnicianId, String Password, String PCProfileName, String MacProfileName) throws Exception{
		profileAndWebSiteSettingsPage = SupportCenterNavigation.viewCustomProfileAndWebSiteSettingsConfigPage(commID);
		profileAndWebSiteSettingsPage.clickOnUsageMenu();
		/*profileAndWebSiteSettingsPage.selectRelativeUpFrame();
		profileAndWebSiteSettingsPage.selectRelativeUpFrame();
		profileAndWebSiteSettingsPage.selectRelativeUpFrame();
		profileAndWebSiteSettingsPage.selectAppBodyNodeViewNodeDetailsFrame();
		Asserter.assertEquals(profileAndWebSiteSettingsPage.isTextPresent("The selected item is not used"), true);
		*/String whereclause = ("AgentWebSiteSettingsID = " + profileID);
		Asserter.assertEquals(agentConfigurationTable.getValueByColNameandWhereClause("COUNT(*)", whereclause), "0");
		pcAgentConfigCreatePage = SupportCenterNavigation.viewCustomPCConfigurationCreatePage(subcommID);
		pcAgentConfigCreatePage.typeName(PCProfileName);
		pcAgentConfigCreatePage.selectProfileAndWebSettings(ProfileName);
		supportCenterHomePage = pcAgentConfigCreatePage.clickOnCreateBtn();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		pcAgentConfigCreatePage = SupportCenterNavigation.viewCustomMACConfigurationCreatePage(subcommID);
		pcAgentConfigCreatePage.typeName(MacProfileName);
		pcAgentConfigCreatePage.selectProfileAndWebSettings(ProfileName);
		supportCenterHomePage = pcAgentConfigCreatePage.clickOnCreateBtn();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		profileAndWebSiteSettingsPage = SupportCenterNavigation.viewCustomProfileAndWebSiteSettingsConfigPage(commID);
		profileAndWebSiteSettingsPage.clickOnUsageMenu();
		profileAndWebSiteSettingsPage.selectRelativeUpFrame();
		profileAndWebSiteSettingsPage.selectRelativeUpFrame();
		profileAndWebSiteSettingsPage.selectRelativeUpFrame();
		profileAndWebSiteSettingsPage.selectAppBodyNodeViewNodeDetailsFrame();
		Asserter.assertEquals(profileAndWebSiteSettingsPage.isTextPresent(PCProfileName), true);
		Asserter.assertEquals(agentConfigurationTable.getValueByColNameandWhereClause("COUNT(*)", whereclause), "2");
		Asserter.assertEquals(profileAndWebSiteSettingsPage.isTextPresent(MacProfileName), true);
		
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
