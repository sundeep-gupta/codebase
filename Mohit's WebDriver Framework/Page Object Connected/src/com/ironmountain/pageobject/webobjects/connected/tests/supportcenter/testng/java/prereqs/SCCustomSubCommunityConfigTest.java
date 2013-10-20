package com.ironmountain.pageobject.webobjects.connected.tests.supportcenter.testng.java.prereqs;

import java.io.File;

import org.testng.Reporter;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.LocatorUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.CreateCustomCommunity;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.CreateSettings;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.SupportCenterLogin;
import com.ironmountain.pageobject.webobjects.connected.database.registry.CommunityTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.supportcenter.SupportCenterNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;

/** Creates a subcommunity under the custom community and populates the registration url into the account management locator file.
 * @author pjames
 *
 */
@SeleniumUITest
public class SCCustomSubCommunityConfigTest extends SupportCenterTest{
	CommunityTable communityTable = null;
	static String commID = null;
	String SupportInfo = "<p>You can contact Support using one of the following methods:</p>"
		+ "\n<ul>"
		+ "\n<li>Email: support@automation.com,</li>"
		+ "\n<li>Phone: 100-200-3000</li>"
		+ "\n</ul>"
		+ "\n<p>Technical Support representatives are available to help you Monday through Friday, 9:00 AM to 8:00 PM.</p>";


	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		super.initSupportCenterTest();
		communityTable = new CommunityTable(DatabaseServer.COMMON_SERVER);	
	}
	
	@Parameters( {"ConfigName","ConfigDesc", "TechnicianId", "Password", 
				"ProfileName", "Description", "VersionName", "AgentSettingsName","CustomLabel", "DefValue",
				"CompDefValue", "LocDefValue","EmplDefValue","AgentRuleSettingsName", "AgentVersion"})
	@Test(groups={"samples", "all", "sc"})
	public void testCreateSubCommunity(String ConfigName, String ConfigDesc, String TechnicianId, String Password, String ProfileName, String Description, String VersionName, String AgentSettingsName, 
										String CustomLabel, String DefValue, String CompDefValue, String LocDefValue, String EmplDefValue,String AgentRuleSettingsName, String AgentVersion) throws Exception
	{
		supportCenterHomePage = SupportCenterLogin.login(TechnicianId, Password);
		commID = CreateCustomCommunity.createCommunityAction();
		TestDataProvider.setTestDataToXmlFile(AccountManagementTest.TEST_DATA_XML_FILE, "CommunityId_OrderMedia", commID);
		//commID = createSubComm(TechnicianId, Password);
		SupportCenterNavigation.viewDefaultCommunityPage();
		supportCenterHomePage.refreshPage();
		//SupportCenterNavigation.viewPCAgentCreateRuleSetsPage(commID);
		//CreateSettings.createEmptyPCAgentRuleSettings(AgentRuleSettingsName, "");
		supportCenterHomePage.refreshPage();
		profileAndWebSiteSettingsPage = SupportCenterNavigation.viewCustomProfileAndWebSiteSettingsPage(commID);
		profileAndWebSiteSettingsPage.refreshPage();
		CreateSettings.createProfileAndWebSiteSettingswithCustomValues(ProfileName, Description, SupportInfo, CustomLabel, DefValue,CompDefValue, LocDefValue, EmplDefValue);
		SupportCenterNavigation.viewCustomAgentVersionsPage(commID);
		supportCenterHomePage.refreshPage();
		supportCenterHomePage = CreateSettings.createAgentVersions(VersionName, Description, AgentVersion);
		SupportCenterNavigation.viewCustomAgentSettingsPage(commID);
		supportCenterHomePage.refreshPage();
		CreateSettings.createAgentSettings(AgentSettingsName, Description);
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		SupportCenterNavigation.viewCustomPCConfigurationPage(commID);
		supportCenterHomePage.refreshPage();
		CreateSettings.unCheckInheritedConfigSettings();
		SupportCenterNavigation.viewCustomPCConfigurationCreatePage(commID);
		supportCenterHomePage.refreshPage();
		//CreateSettings.createPCConfiguration(ConfigName, ConfigDesc, VersionName, AgentSettingsName);
		CreateSettings.createPCConfiguration(ConfigName, ConfigDesc, VersionName, AgentSettingsName, ProfileName, AgentRuleSettingsName);
		supportCenterHomePage = SupportCenterNavigation.viewCustomConfigurationPage(commID);
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectAppBodyNodeViewNodeDetailsFrame();
		String RegistrationURL = supportCenterHomePage.getRegURL();
		TestDataProvider.setTestDataToXmlFile(TEST_DATA_XML_FILE, "CustomRegistrationUrl", RegistrationURL);
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.clickOnLogOff();	
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		super.stopSeleniumTest();
	}	
	

}
