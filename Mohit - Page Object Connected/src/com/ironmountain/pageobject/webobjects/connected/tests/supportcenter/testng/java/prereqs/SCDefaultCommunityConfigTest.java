package com.ironmountain.pageobject.webobjects.connected.tests.supportcenter.testng.java.prereqs;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.BeforeSuite;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.LocatorUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.CreateSettings;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.SupportCenterLogin;
import com.ironmountain.pageobject.webobjects.connected.navigations.supportcenter.SupportCenterNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;


/** Creates Default Community Configuration and Populates the registration URL to the account management locator file.
 * @author pjames
 *
 */
@SeleniumUITest
public class SCDefaultCommunityConfigTest extends SupportCenterTest{
	
	String SupportCenterURL = PropertyPool.getProperty("supportcenterurl");
	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		super.initSupportCenterTest();
	}
	

	@Parameters( {"ConfigDesc", "TechnicianId", "Password", "AgentVersionName", "AgentSettingsName"})
	@Test(groups={"samples", "all", "sc"})
	public void testCreateCommunity(String ConfigDesc, String TechnicianId, String Password, String AgentVersionName, String AgentSettingsName) throws Exception
	{
		
		supportCenterHomePage = SupportCenterLogin.login(TechnicianId, Password);
		Asserter.assertEquals(supportCenterHomePage.verifyTitle(), true);
		supportCenterHomePage.refreshPage();
		SupportCenterNavigation.viewCustomPCConfigurationPage("1");
		CreateSettings.unCheckInheritedConfigSettings();
		supportCenterHomePage = SupportCenterNavigation.viewDefaultCommunityPage();
		pcAgentConfigSummaryPage = SupportCenterNavigation.viewPCinDefaultCommunityPage();
		Asserter.assertEquals(pcAgentConfigSummaryPage.verifyNodeHeader(), true);
		pcAgentConfigSummaryPage.clickOnSummary();
		pcAgentConfigCreatePage = SupportCenterNavigation.viewDefaultPCConfigurationCreatePage();
		String ConfigName = StringUtils.createNameVal();
		TestDataProvider.setTestDataToXmlFile(AccountManagementTest.TEST_DATA_XML_FILE, "Config_Register", ConfigName);
		CreateSettings.createPCConfiguration(ConfigName, ConfigDesc, AgentVersionName, AgentSettingsName);
		supportCenterHomePage.refreshPage();
		supportCenterHomePage.selectAppBodyNodeViewNodeDetailsFrame();
		String RegistrationURL = pcAgentConfigCreatePage.getRegURL();
		TestDataProvider.setTestDataToXmlFile(TEST_DATA_XML_FILE, "RegistrationURL", RegistrationURL);
		//LocatorUtils.setLocatorValue("amws_locators.xml", "RegistrationURL", RegistrationURL);
		supportCenterHomePage.waitForSeconds(5);
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.refreshPage();
		supportCenterHomePage.clickOnLogOff();
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		super.stopSeleniumTest();
	}	
	
}

