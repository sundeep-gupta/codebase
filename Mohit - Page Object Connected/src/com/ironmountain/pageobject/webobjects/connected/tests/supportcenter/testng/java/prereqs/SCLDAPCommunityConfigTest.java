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


/**Creates LDAP Community Configuration and populates the registration URL into the account management locator file.
 * @author pjames
 *
 */
@SeleniumUITest
public class SCLDAPCommunityConfigTest extends SupportCenterTest{
	CommunityTable communityTable = null;
	static String commID = null;

	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		super.initSupportCenterTest();
		communityTable = new CommunityTable(DatabaseServer.COMMON_SERVER);	
	}
	
	@Parameters( {"LDAPUrl","LogonDN", "TechnicianId", "Password", 
				"ConnPassword", "UserClass", "LoginID", "UniqueID", "Email", "LDAPConfigName", "LDAPConfigDesc", "LDAPVersionName", "LDAPAgentSettingsName"})
	@Test(groups={"samples", "all", "sc"})
	public void testLDAPCommunity(String LDAPUrl, String LogonDN, String TechnicianId, String Password, 
									String ConnPassword, String UserClass, String LoginID, String UniqueID,
									String Email, String LDAPConfigName, String  LDAPConfigDesc, String  LDAPVersionName, String  LDAPAgentSettingsName ) throws Exception
	{
		SupportCenterLogin.login(TechnicianId, Password);
		commID = CreateCustomCommunity.createCommunityAction();
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(commID);
		supportCenterHomePage.clickOnEnterpriseDirectoryLink();
	    supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectAppBodyNodeViewNodeDetailsFrame();
		CreateSettings.configureLDAP(LDAPUrl, LogonDN, ConnPassword, UserClass, LoginID, UniqueID, Email);
		Reporter.log("Confiured the LDAP Community");
		//supportCenterHomePage.refreshPage();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		Reporter.log("Navigate to the PC Confguration Page");
		SupportCenterNavigation.viewCustomPCConfigurationPage(commID);
		CreateSettings.unCheckInheritedConfigSettings();
		SupportCenterNavigation.viewCustomPCConfigurationCreatePage(commID);
		CreateSettings.createPCConfiguration(LDAPConfigName, LDAPConfigDesc, LDAPVersionName, LDAPAgentSettingsName);
		supportCenterHomePage = SupportCenterNavigation.viewCustomConfigurationPage(commID);
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectAppBodyNodeViewNodeDetailsFrame();
		String RegistrationURL = supportCenterHomePage.getRegURL();
		TestDataProvider.setTestDataToXmlFile(TEST_DATA_XML_FILE, "LDAPRegistrationURL", RegistrationURL);
		//LocatorUtils.setLocatorValue("amws_locators.xml", "LDAPRegistrationURL", RegistrationURL);
		Reporter.log("Populated the LDAPRegistrationURL in the locator file");
		supportCenterHomePage.waitForSeconds(5);
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		Reporter.log("Logging Off");
		supportCenterHomePage.clickOnLogOff();
	}
	
	public String createComm(String TechnicianId, String Password) throws Exception{
		String CommunityName = StringUtils.createNameVal();
		Reporter.log("Login to SupportCenter");
		CommunityName = CommunityName + "LDAP";
		supportCenterHomePage = SupportCenterLogin.login(TechnicianId, Password);	
		Asserter.assertEquals(supportCenterHomePage.verifyTitle(), true);
		Reporter.log("Navigate to Default Community Page");
		supportCenterHomePage = SupportCenterNavigation.viewDefaultCommunityPage();
		supportCenterHomePage.clickOnToolsLink();
		supportCenterHomePage.selectRelativeUpFrame();
		addCommunityPage = supportCenterHomePage.clickOnAddCommunityLink();
		commID = CreateCustomCommunity.createCommunity(CommunityName); 
		Reporter.log("Created a new LDAP Community");
		return commID;
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		super.stopSeleniumTest();
	}	
}
