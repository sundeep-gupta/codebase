package com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam;


import org.apache.log4j.Logger;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.CreateSettings;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.SupportCenterLogin;
import com.ironmountain.pageobject.webobjects.connected.database.registry.AgentConfigurationTable;
import com.ironmountain.pageobject.webobjects.connected.database.registry.AgentRulesTable;
import com.ironmountain.pageobject.webobjects.connected.database.registry.CommunityTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.supportcenter.SupportCenterNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;

@SeleniumUITest(priority=1, skipAllTestsIfFail= true, resetSkipAllTestsIfFail=true)
public class SetupsInSupportCenterForMyRoamTests extends SupportCenterTest{

	private static Logger  logger      = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam.SetupsInSupportCenterForMyRoamTests");
	
	private static CommunityTable communityTable = null;
	private static AgentRulesTable agentRulesTable = null;
	private static AgentConfigurationTable  agentConfigTable= null;
	
	private static String communityId = null;
	private static final String SUPPORT_INFO = "<p>You can contact Support using one of the following methods:</p>"
							+ "\n<ul>"
							+ "\n<li>Email: support@automation.com,</li>"
							+ "\n<li>Phone: 100-200-3000</li>"
							+ "\n</ul>"
							+ "\n<p>Technical Support representatives are available to help you Monday through Friday, 9:00 AM to 8:00 PM.</p>";
	private String profileName = "MyRoamRegression Profile";
	private String agentVersionName = "MyRoamRegression AgentVersion";
	private String agentRuleSettingsName = "MyRoamRegression RuleSettings";
	private String agentSettingsName = "MyRoamRegression AgentSettings";
	private String agentConfigName = "MyRoamRegression PCAgent";
	private String registrationURL = null;
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
		communityTable = new CommunityTable(DatabaseServer.PRIMARY_REGISTRY_SERVER);
		agentRulesTable = new AgentRulesTable(DatabaseServer.PRIMARY_REGISTRY_SERVER);	
		agentConfigTable = new AgentConfigurationTable(DatabaseServer.PRIMARY_REGISTRY_SERVER);
		logger.info("Test initialization is completed");
	}
	
	@Parameters( {"myroamcommunity", "technicianid", "technicianPassword" , "backedupDrive", "backedupFolder", "versionName"})
	@Test(groups = { "amws", "myroamsetup" })
	public void setupSupportCenterForMyRoamRegressionTests(String myroamcommunity,String technicianid,
			String technicianPassword, String backedupDrive, String backedupFolder, String versionName) throws Exception {	
		logger.info("Starting actual Test Method..Creating Test Community");
		createCommunity(myroamcommunity,technicianid,
				technicianPassword );
		logger.info("Generating Registration URL..");
		generateRegistrationUrlInAgentConfiguration(versionName);
		logger.info("Trying to set rule for this community using DB");
		String ruleDetails = ruleDetails1 + backedupDrive + backedupFolder + ruleDetails2 ;
		logger.info("Setting rule details..");
		agentRulesTable.setAgentRuleDetails(communityId, agentRuleSettingsName, ruleDetails  );
		logger.info("Setting True name for this rule..");
		agentRulesTable.setAgentRuleTrueName(communityId, agentRuleSettingsName, ruleTrueName);
		logger.info("Test Completed successfully...");
		notifySetupTestComplete();
	}

	public void createCommunity(String communityName, String technicianid,
			String technicianPassword)
			throws Exception {
		supportCenterHomePage = SupportCenterLogin.login(technicianid, technicianPassword);
		logger.info("Trying to creating a community with Name.." + communityName);
		if (!communityTable.isCommunityExist(communityName)) {		
			logger.info("Community is not existing, creating a new one..");
			supportCenterHomePage = SupportCenterNavigation.viewDefaultCommunityPage();
			supportCenterHomePage.clickOnToolsLink();
			supportCenterHomePage.selectRelativeUpFrame();
			addCommunityPage = supportCenterHomePage.clickOnAddCommunityLink();
			addCommunityPage.typeCommunityName(communityName);
			addCommunityPage.clickOnSaveBtn();
			addCommunityPage.waitForSeconds(5);
			addCommunityPage.clickOnHistoryLink();
			addCommunityPage.selectRelativeUpFrame();
			addCommunityPage.selectRelativeUpFrame();
			addCommunityPage.selectRelativeUpFrame();
			logger.info("Community Created...");
		}
		else{
			logger.info("Community with name '" + communityName + "' already exists");
		}
		communityId = communityTable.getCommunityIDbyCommunityName(communityName);
		logger.info("Community id for " + communityName + " is " + communityId);
		TestDataProvider.setTestDataToXmlFile(AccountManagementTest.TEST_DATA_XML_FILE, "MyRoamRegressionTestsCommunityId", communityId);
		logger.info("Community id set to TestData File..");
	}
	public void generateRegistrationUrlInAgentConfiguration(String versionName) throws Exception{
		logger.info( "Agent Configuration Present: " + agentConfigTable.isAgentConfigurationExist(agentConfigName, communityId));
		logger.info("Current Registration URL: " + TestDataProvider.getTestData("MyRoamRegressionTestRegistrationUrl"));
		if (! agentConfigTable.isAgentConfigurationExist(agentConfigName, communityId) || StringUtils.isNullOrEmpty(TestDataProvider.getTestData("MyRoamRegressionTestRegistrationUrl"))) {
			logger.info("Agent Configuration is not existing,, Trying to create one..");
			supportCenterHomePage = SupportCenterNavigation.viewCustomConfigurationPage(communityId);
			logger.info("Navigated to Configuration Page..");
			SupportCenterNavigation.viewCustomProfileAndWebSiteSettingsPage(communityId);
			logger.info("Navigated to Profile and Web settings Page..");
			CreateSettings.createDefaultProfileAndWebSiteSettings(profileName ,SUPPORT_INFO);
			logger.info("Profile settings created with name: "+  profileName);
			supportCenterHomePage.refreshPage();
			logger.info("Navigating to Agent Version Page");
			SupportCenterNavigation.viewCustomAgentVersionsPage(communityId);
			logger.info("Creating Agent Version..");
			CreateSettings.createAgentVersions(agentVersionName, "", versionName);
			supportCenterHomePage.refreshPage();
			SupportCenterNavigation.viewPCAgentCreateRuleSetsPage(communityId);
			logger.info("creating An Empty Agent Rule with name.."+ agentRuleSettingsName);
			CreateSettings.createEmptyPCAgentRuleSettings(agentRuleSettingsName, "");
			supportCenterHomePage.refreshPage();
			logger.info("Navigating to Agent Settings Page");
			SupportCenterNavigation.viewCustomAgentSettingsPage(communityId);
			logger.info("Creating an Agent Settings");
			CreateSettings.createAgentSettings(agentSettingsName, "");
			supportCenterHomePage.refreshPage();
			logger.info("Navigating to PC Agent Configuration page..");
			SupportCenterNavigation.viewCustomPCConfigurationPage(communityId);
			logger.info("Unchecking Inherited Seetings..");
			CreateSettings.unCheckInheritedConfigSettings();
			logger.info("Navigatign to PC Agent Configuration Creation Page..");
			SupportCenterNavigation.viewCustomPCConfigurationCreatePage(communityId);
			logger.info("Creatign a PC Agent Configuration..");
			CreateSettings.createPCConfiguration(agentConfigName, "",
					agentVersionName, agentSettingsName, profileName, agentRuleSettingsName);
			logger.info("");
			supportCenterHomePage = SupportCenterNavigation.viewCustomConfigurationPage(communityId);
			supportCenterHomePage.selectRelativeUpFrame();
			supportCenterHomePage.selectAppBodyNodeViewNodeDetailsFrame();
			logger.info("Retrieving the Registration URL..");
			registrationURL  = supportCenterHomePage.getRegURL();
			logger.info("Registration URL generated is.." + registrationURL);
			logger.info("Setting the Registration URL to DataProvider File..");
			TestDataProvider.setTestDataToXmlFile(AccountManagementTest.TEST_DATA_XML_FILE, "MyRoamRegressionTestRegistrationUrl", registrationURL);
			supportCenterHomePage.selectRelativeUpFrame();
			supportCenterHomePage.selectRelativeUpFrame();
			supportCenterHomePage.selectRelativeUpFrame();
			logger.info("Logging out..");
			supportCenterHomePage.clickOnLogOff();
			logger.info("Configuration is created..");
		}
		else
		{
			logger.info("Configuration is already existing in this support center..");
			String configId = agentConfigTable.getAgentConfigurationId(agentConfigName, communityId);
			pcAgentConfigCreatePage = SupportCenterNavigation.viewPCAgentConfigurationPage(communityId, configId );
			supportCenterHomePage.selectRelativeUpFrame();
			supportCenterHomePage.selectAppBodyNodeViewNodeDetailsFrame();
			logger.info("Retrieving the Registration URL..");
			registrationURL  = pcAgentConfigCreatePage.getRegURL();	
			logger.info("Registration URL generated is.." + registrationURL);
			logger.info("Setting the Registration URL to DataProvider File..");
			TestDataProvider.setTestDataToXmlFile(AccountManagementTest.TEST_DATA_XML_FILE, "MyRoamRegressionTestRegistrationUrl", registrationURL);
			supportCenterHomePage.selectRelativeUpFrame();
			supportCenterHomePage.selectRelativeUpFrame();
			supportCenterHomePage.selectRelativeUpFrame();
			logger.info("Logging out..");
			supportCenterHomePage.clickOnLogOff();
		}
	}
	
	/**
	 * Closing all the database connections
	 */
	public void closeDataBaseConnections(){
		if(communityTable !=null){
			try {
				communityTable.closeDatabaseConnection();
			} catch (Exception e) {
				e.printStackTrace();
			}
			finally{
				communityTable.closeDatabaseConnection();
			}
		}
		if(agentRulesTable != null){
			try {
				agentRulesTable.closeDatabaseConnection();
			} catch (Exception e) {
				e.printStackTrace();
			}
			finally{
				agentRulesTable.closeDatabaseConnection();
			}
		}
		if(agentConfigTable != null){
			
			try {
				agentConfigTable.closeDatabaseConnection();
			} catch (Exception e) {
				e.printStackTrace();
			}
			finally{
				agentConfigTable.closeDatabaseConnection();
			}
		}
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		closeDataBaseConnections();
		logger.info("Stoptest is called after test..");
		super.stopSeleniumTest();
		logger.info("Selenium session Ended..");
	}
	
}
