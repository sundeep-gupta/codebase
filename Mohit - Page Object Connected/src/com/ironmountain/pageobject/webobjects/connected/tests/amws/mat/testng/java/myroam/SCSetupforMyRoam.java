package com.ironmountain.pageobject.webobjects.connected.tests.amws.mat.testng.java.myroam;

import java.io.File;

import org.apache.log4j.Logger;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.CreateSettings;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.SupportCenterLogin;
import com.ironmountain.pageobject.webobjects.connected.database.DataBase;
import com.ironmountain.pageobject.webobjects.connected.database.registry.AgentConfigurationTable;
import com.ironmountain.pageobject.webobjects.connected.database.registry.AgentRulesTable;
import com.ironmountain.pageobject.webobjects.connected.database.registry.CommunityTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.supportcenter.SupportCenterNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.PCAgentConfigCreatePage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.PCAgentConfigSummaryPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.SupportCenterHomePage;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;

@SeleniumUITest(priority=1,resetSkipAllTestsIfFail=true)
public class SCSetupforMyRoam extends SupportCenterTest{

	private static Logger  logger      = Logger.getLogger(SCSetupforMyRoam.class.getName());
	private static String dcCommunityID = "-1";
	String SupportCenterURL = PropertyPool.getProperty("supportcenterurl");
	private SupportCenterHomePage supportCenterHomePage;
	
	private static CommunityTable communityTable = null;
	private static AgentRulesTable agentRulesTable = null;
	private static AgentConfigurationTable  agentConfigTable= null;
	private String agentRuleSettingsName = "MyRoamAcceptanceRule";
	private String ruleDetails1 = "<Rules> <SkipRule><Skip><![CDATA[]]></Skip> </SkipRule> <Rule><Folder><![CDATA[*]]></Folder> <FileName><![CDATA[*]]></FileName>" +
			" <Extension><![CDATA[*]]></Extension> <FileType>3</FileType> <Name><![CDATA[ExcludeAll]]></Name> <Source>2</Source> <Recursive>1</Recursive> <Locked>1</Locked> " +
			"<Id>0</Id> </Rule><Rule><Folder><![CDATA[" ;
	private String ruleDetails2 = "]]></Folder> <FileName><![CDATA[*]]></FileName> <Extension><![CDATA[*]]></Extension>" +
			" <FileType>1</FileType> <Name><![CDATA[IncludeBackupFolder]]></Name> <Source>2</Source> <Recursive>1</Recursive> <Locked>1</Locked> <Id>0</Id> </Rule> </Rules>";
	private String ruleTrueName = "0x8371D28025A59A90";
	
	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		logger.info("Startign the Test...");
		logger.info("StartTest called...");
		super.initSupportCenterTest();
		TestDataProvider.reloadTestData(AccountManagementTest.TEST_DATA_XML_FILE_PATH);
		communityTable = new CommunityTable(DatabaseServer.COMMON_SERVER);
		agentRulesTable = new AgentRulesTable(DatabaseServer.COMMON_SERVER);	
		agentConfigTable = new AgentConfigurationTable(DatabaseServer.COMMON_SERVER);
	}
	
	@Parameters({"ConfigDesc", "TechnicianId", "Password", "AgentVersionName", "AgentSettingsName", "backedupDrive", "backedupFolder"})
	@Test(groups = { "amws", "myroamsetup" })
	public void createConfigForMyRoamTest(String ConfigDesc, String TechnicianId, String Password, String AgentVersionName, String AgentSettingsName,
			String backedupDrive, String backedupFolder) throws Exception
	{
		logger.info("Login to SupportCenter");
		supportCenterHomePage = SupportCenterLogin.login(TechnicianId, Password);
		Asserter.assertEquals(supportCenterHomePage.verifyTitle(), true);
		supportCenterHomePage.refreshPage();
		SupportCenterNavigation.viewPCAgentCreateRuleSetsPage("1");
		logger.info("creating An Empty Agent Rule with name.."+ agentRuleSettingsName);
		CreateSettings.createEmptyPCAgentRuleSettings(agentRuleSettingsName, "");
		supportCenterHomePage.refreshPage();
		logger.info("Setting rule for the Default community using DB");
		String ruleDetails = ruleDetails1 + backedupDrive + backedupFolder + ruleDetails2 ;
		logger.info("Setting rule details..");
		agentRulesTable.setAgentRuleDetails("1", agentRuleSettingsName, ruleDetails);
		logger.info("Setting True name for this rule..");
		agentRulesTable.setAgentRuleTrueName("1", agentRuleSettingsName, ruleTrueName);
		logger.info("Creating a config for this rule..");
		logger.info("Create a new PC Configuration");
		SupportCenterNavigation.viewCustomPCConfigurationPage("1");
		CreateSettings.unCheckInheritedConfigSettings();
		supportCenterHomePage = SupportCenterNavigation.viewDefaultCommunityPage();
		PCAgentConfigSummaryPage pcAgentConfigSummaryPage = SupportCenterNavigation.viewPCinDefaultCommunityPage();
		Asserter.assertEquals(pcAgentConfigSummaryPage.verifyNodeHeader(), true);
		pcAgentConfigSummaryPage.clickOnSummary();
		PCAgentConfigCreatePage pcAgentConfigCreatePage = SupportCenterNavigation.viewDefaultPCConfigurationCreatePage();
		String ConfigName = StringUtils.createNameVal();
		//TestDataProvider.reloadTestData(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" );
		//TestDataProvider.setTestDataToXmlFile(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" , "ConfigName", ConfigName);
		TestDataProvider.setTestDataToXmlFile(AccountManagementTest.TEST_DATA_XML_FILE, "ConfigName", ConfigName);
		CreateSettings.createPCConfiguration(ConfigName, ConfigDesc, AgentVersionName, AgentSettingsName, agentRuleSettingsName);
		supportCenterHomePage.refreshPage();
		supportCenterHomePage.selectAppBodyNodeViewNodeDetailsFrame();
		String RegistrationURL = pcAgentConfigCreatePage.getRegURL();
		logger.info("Set the registration URL into the testdata file");
		TestDataProvider.setTestDataToXmlFile(TEST_DATA_XML_FILE, "RegistrationURL", RegistrationURL);
		supportCenterHomePage.waitForSeconds(5);
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.refreshPage();
		logger.info("Exit SupportCenter");
		supportCenterHomePage.clickOnLogOff();
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		logger.info("Stoptest is called after test..");
		super.stopSeleniumTest();
		logger.info("Selenium session Ended..");
	}

}
