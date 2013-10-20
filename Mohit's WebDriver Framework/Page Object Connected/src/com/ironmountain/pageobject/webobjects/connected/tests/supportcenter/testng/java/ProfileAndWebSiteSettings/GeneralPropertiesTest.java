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
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.CreateSettings;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.SupportCenterLogin;
import com.ironmountain.pageobject.webobjects.connected.database.registry.AgentWebSiteSettingsTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.supportcenter.SupportCenterNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;

@SeleniumUITest(priority=2)
public class GeneralPropertiesTest extends SupportCenterTest{
	
	AgentWebSiteSettingsTable agentWebSiteSettingsTable = new AgentWebSiteSettingsTable(DatabaseServer.COMMON_SERVER);
	String commID = null;
	String supportInfo = "<p>You can contact Support using one of the following methods:</p>"
        +"\n<ul>www.ironmountain.com"
        +"\n<li>Email: tester@ironmountain.com</li>"
        +"\n<li>Phone: 508-123-1234</li>"
        +"\n</ul>"
        +"\n<p>Technical Support representatives are available to help you Monday through Friday, 08:30 AM to 05:30 PM.</p>";
	String errorText = "You have not entered information in all required fields. Make sure you enter the necessary information and try again.";
	String supportInfoVerificationText = "Technical Support representatives are available to help you Monday through Friday";	
	@BeforeMethod(alwaysRun=true)
	public void startTest() throws Exception{
		super.initSupportCenterTest();
		commID = TestDataProvider.getTestData("PWSCommunityID");
	}

	@Parameters( {"TechnicianId", "Password", "ProfileName", "CustomLogonURL"})
	@Test(enabled = true, groups= {"sc","ProfileAndWebSiteSettings", "Default Profile And WebSite Settings"})
	public void testGeneralPropertiesPage(String TechnicianId, String Password, String ProfileName, String CustomLogonURL) throws Exception{
		supportCenterHomePage = SupportCenterLogin.login(TechnicianId, Password);	
		profileAndWebSiteSettingsPage = SupportCenterNavigation.viewCustomProfileAndWebSiteSettingsPage(commID);
		profileAndWebSiteSettingsPage.typeSupportInfo(supportInfo);
		profileAndWebSiteSettingsPage.clickOnFinishBtn();
		String alertText = profileAndWebSiteSettingsPage.getAlert();
		Asserter.assertEquals(alertText, errorText);
		CreateSettings.createProfileAndWebSiteSettingsWithCustomLogon(ProfileName, supportInfo, CustomLogonURL);
		profileAndWebSiteSettingsPage.refreshPage();
		String profileID = agentWebSiteSettingsTable.getValueByColNameandCommunityID("ID", commID);
		String whereclause = " ID="+profileID;
		String dbval = agentWebSiteSettingsTable.getValueByColNameandCommunityID("SETTINGDETAILS", commID, whereclause);
		Asserter.assertEquals(dbval.contains(CustomLogonURL), true);
		dbval = agentWebSiteSettingsTable.getValueByColNameandCommunityID("UsesDefaultSSWS", commID, whereclause);
		Asserter.assertEquals(dbval, "0");
		TestDataProvider.setTestDataToXmlFile(TEST_DATA_XML_FILE, "ProfileName", ProfileName);
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
