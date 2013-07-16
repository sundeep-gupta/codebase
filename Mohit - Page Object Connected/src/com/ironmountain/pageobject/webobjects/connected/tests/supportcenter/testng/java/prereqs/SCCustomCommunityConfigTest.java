package com.ironmountain.pageobject.webobjects.connected.tests.supportcenter.testng.java.prereqs;

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
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;

/**Creates Custom Configuration and populates the registration URL into the account management locator file.
 * @author pjames
 *
 */
@SeleniumUITest
public class SCCustomCommunityConfigTest extends SupportCenterTest{
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
				"ProfileName", "Description", "VersionName", "AgentSettingsName", "AgentRuleSettingsName", "AgentVersion"})
	@Test(groups={"samples", "all", "sc"})
	public void testCreateCommunity(String ConfigName, String ConfigDesc, String TechnicianId, String Password, String ProfileName, String Description , String VersionName, String AgentSettingsName, String AgentRuleSettingsName, String AgentVersion) throws Exception
	{
		supportCenterHomePage = SupportCenterLogin.login(TechnicianId, Password);
		commID = CreateCustomCommunity.createCommunityAction();
		TestDataProvider.setTestDataToXmlFile(TEST_DATA_XML_FILE, "PrereqCustomCommunityID", commID);
		//LocatorUtils.setLocatorValue("supportcenter_locators.xml", "CustomCommunityID", commID);
		SupportCenterNavigation.viewPCAgentCreateRuleSetsPage(commID);
		CreateSettings.createEmptyPCAgentRuleSettings(AgentRuleSettingsName, "");
		supportCenterHomePage.refreshPage();
		profileAndWebSiteSettingsPage = SupportCenterNavigation.viewCustomProfileAndWebSiteSettingsPage(commID);
		CreateSettings.createProfileAndWebSiteSettings(ProfileName, Description, SupportInfo);
		profileAndWebSiteSettingsPage.refreshPage();
		SupportCenterNavigation.viewCustomAgentVersionsPage(commID);
		supportCenterHomePage = CreateSettings.createAgentVersions(VersionName, Description, AgentVersion);
		supportCenterHomePage.refreshPage();
		SupportCenterNavigation.viewCustomAgentSettingsPage(commID);
		CreateSettings.createAgentSettings(AgentSettingsName, Description);
		supportCenterHomePage.refreshPage();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		SupportCenterNavigation.viewCustomPCConfigurationPage(commID);
		CreateSettings.unCheckInheritedConfigSettings();
		SupportCenterNavigation.viewCustomPCConfigurationCreatePage(commID);
		//CreateSettings.createPCConfiguration(ConfigName, ConfigDesc, VersionName, AgentSettingsName);
		CreateSettings.createPCConfiguration(ConfigName, ConfigDesc, VersionName, AgentSettingsName, ProfileName, AgentRuleSettingsName);		
		supportCenterHomePage = SupportCenterNavigation.viewCustomConfigurationPage(commID);
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectAppBodyNodeViewNodeDetailsFrame();
		String RegistrationURL = supportCenterHomePage.getRegURL();
		TestDataProvider.setTestDataToXmlFile(TEST_DATA_XML_FILE, "RegistrationURL", RegistrationURL);
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.clickOnLogOff();
	}
	
	/*public String createComm(String TechnicianId, String Password) throws Exception{
		String CommunityName = StringUtils.createNameVal();
		Reporter.log("Login to SupportCenter");
		supportCenterHomePage = SupportCenterLogin.login(TechnicianId, Password);	
		Asserter.assertEquals(supportCenterHomePage.verifyTitle(), true);
		Reporter.log("Navigate to Default Community Page");
		supportCenterHomePage = SupportCenterNavigation.viewDefaultCommunityPage();
		supportCenterHomePage.clickOnToolsLink();
		supportCenterHomePage.selectRelativeUpFrame();
		addCommunityPage = supportCenterHomePage.clickOnAddCommunityLink();
		commID = CreateCustomCommunity.createCommunity(CommunityName); 
		return commID;
	}*/
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		super.stopSeleniumTest();
	}	
	
}
