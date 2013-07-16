package com.ironmountain.pageobject.webobjects.connected.tests.amws.mat.testng.java.ordermedia;

import java.io.File;

import org.apache.log4j.Logger;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.InstallUtils;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.BackupData;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.OrderMedia;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.Registration;
import com.ironmountain.pageobject.webobjects.connected.actions.testrunner.agent.BackupRunner;
import com.ironmountain.pageobject.webobjects.connected.database.DataBase;
import com.ironmountain.pageobject.webobjects.connected.database.registry.AgentConfigurationTable;
import com.ironmountain.pageobject.webobjects.connected.database.registry.CustomerTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.OrderCdOrDvdForm1Page;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.PrivacyPolicyPage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.TermsAndConditionsPage;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;
import com.ironmountain.pageobject.webobjects.connected.tests.amws.mat.testng.java.myroam.MyRoamHomeTest;
@SeleniumUITest(priority=1)
public class OrderMediaPageNavigationsTest extends AccountManagementTest {
	private static Logger  logger      = Logger.getLogger(OrderMedia.class.getName());
	static String email =null;
	static String password=null;
	String server = null;
	 String DownloadLocation = null;
	 String commId = null;
	 String ConfigId = null;
	 String FileName = null;
	 String configId_str = null;
	 int Acct_no = 0;
	 private static AgentConfigurationTable  agentConfigTable= null;
	 private static CustomerTable custTable = null;
	
	@BeforeMethod (alwaysRun=true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		agentConfigTable = new AgentConfigurationTable(DatabaseServer.PRIMARY_REGISTRY_SERVER);
		custTable = new CustomerTable(DatabaseServer.PRIMARY_REGISTRY_SERVER);
		//Getting server info
		server = PropertyPool.getProperty("accountmanagementurl");
		logger.info(server);
		DownloadLocation = FileUtils.setDownloadLocationwithFileName("AgentSetupFile");
		logger.info(DownloadLocation);
		TestDataProvider.reloadTestData(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" );
		email = StringUtils.createNameVal()+"om@cb.com";
		logger.info(email);
		TestDataProvider.setTestDataToXmlFile(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" , "Email", email);
		password = TestDataProvider.getTestData("Password");
		logger.info(password);
	}
	
	@BeforeMethod (alwaysRun=true, dependsOnMethods = {"startTest"})
	@Parameters({"TechId","Password","ConfigName"})
	public void createBackupDates(String TechId, String Password, String ConfigName) throws Exception{
		
		/* * Create/Register the user if the user does not exist
		 
		//Registration.registerUserIfNotPresent("Automation", "Tester", email,
				password, password, "2010100");
		
		 * Install Agent for the user and do the backups*/
		 
		String registrationURL = TestDataProvider.getTestData("CustomRegistrationUrl");
		Registration.registerUserIfNotPresentWithCustomRegistrationURL(registrationURL, "Automation", "Tester", email,password, "2010100");
		AccountManagementLogin.login(email, password);
		commId = TestDataProvider.getTestData("CommunityId_OrderMedia");
		logger.info(commId);
		logger.info(ConfigName);
		//Getting the configuration id from the configuration name and community id
		configId_str = agentConfigTable.getAgentConfigurationId(ConfigName, commId);
		logger.info(configId_str);
		//converting commId which was in string format to integer format
		int commId_int = Integer.parseInt(commId);
		logger.info(commId_int);
		//converting configId which was in string format to integer format
		int configId_int = Integer.parseInt(configId_str);
		logger.info(configId_int);
		FileName = "AgentSetupFile";
		logger.info(FileName);
		//Getting account number in nine digit format
		Acct_no = custTable.getAccountNumber(email);
		logger.info(Acct_no);
		//Converting account number from integer to string
		 String s = new Integer(Acct_no).toString();
		//Converting account number from nine digit format to ten digit format
		 String Acct2 = custTable.getUiFormattedAccountNumber(s);
		 logger.info(Acct2);
		OrderCdOrDvdForm1Page orderCdorDvdForm1Page = AccountManagementNavigation.viewOrderCdOrDvdsPage();
		if(! orderCdorDvdForm1Page.isBackupDatesPresent()){
			InstallUtils.lgenerateAgentSetup_SSWSAPI(commId_int, Acct2,Password, server);
			InstallUtils.installAgent(FileName, email, Password);
			BackupRunner.runBackup(3);	
		}
		AccountManagementLogin.logout();
	}	
	/**
	 * Test to verify the user can successfully change the password from Edit Profile Page	 * 
	 * 
	 * @param email
	 * @param password
	 * @param optionIndex 
	 * @param verificationTexts 
	 * @param defaultAddress 
	 * @param newPassword
	 * @throws Exception
	 */
	@Parameters( {"optionIndex"})
	@Test(enabled = true, groups= {"amws","mat", "ordermedia"})
	public void testPageNavigations(String optionIndex) throws Exception
	{
		AccountManagementLogin.login(email, password);
		orderCdorDvdForm1Page = AccountManagementNavigation.viewOrderCdOrDvdsPage();
		orderCdorDvdForm1Page.isTitlePresentFailOnNotFound("OrderCDsorDVDsPageTitle");
		//orderCdorDvdForm1Page.isTextPresentFailOnNotFound("CopyRightText");
		summaryPage = orderCdorDvdForm1Page.clickOnCancelButton();
		summaryPage.isTitlePresentFailOnNotFound("SummaryPageTitle");
		orderCdorDvdForm2Page = OrderMedia.selectAndGoToSubmitOrderPage(optionIndex);
		orderCdorDvdForm1Page =orderCdorDvdForm2Page.clickOnBackButton();
		orderCdorDvdForm1Page.isTextPresentFailOnNotFound("OrderCdOrDvdForm1Page.VerificationText1");
		orderCdorDvdForm1Page.isTextPresentFailOnNotFound("OrderCdOrDvdForm1Page.VerificationText2");
		TermsAndConditionsPage termsAndConditionsPage = orderCdorDvdForm1Page.clickOnTermsAndConditions();
		termsAndConditionsPage.isTitlePresentFailOnNotFound("TermsAndConditionsPageTitle");
		orderCdorDvdForm2Page = OrderMedia.selectAndGoToSubmitOrderPage(optionIndex);
		termsAndConditionsPage = orderCdorDvdForm2Page.clickOnTermsAndConditions();
		termsAndConditionsPage.isTitlePresentFailOnNotFound("TermsAndConditionsPageTitle");
		orderCdorDvdForm1Page = AccountManagementNavigation.viewOrderCdOrDvdsPage();
		PrivacyPolicyPage privacyPolicyPage = orderCdorDvdForm1Page.clickOnPrivacyPolicy();
		privacyPolicyPage.isTitlePresentFailOnNotFound("PrivacyPolicyPageTitle");
		orderCdorDvdForm2Page = OrderMedia.selectAndGoToSubmitOrderPage(optionIndex);
		privacyPolicyPage = orderCdorDvdForm2Page.clickOnPrivacyPolicy();
		privacyPolicyPage.isTitlePresentFailOnNotFound("PrivacyPolicyPageTitle");	
		orderCdorDvdForm2Page = OrderMedia.selectAndGoToSubmitOrderPage(optionIndex);
		orderCdorDvdForm2Page.isTextPresentFailOnNotFound("CopyRightText");
		AccountManagementLogin.logout();	
	}	
	
	/**
	 * Closing all the database connections
	 */
	@AfterMethod(alwaysRun = true)
	public void closeDataBaseConnections(){
		if(!skipTest){
		DataBase.closeDatabaseConnections(agentConfigTable);
		DataBase.closeDatabaseConnections(custTable);
	}
	}
	
	@AfterMethod(alwaysRun=true)
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}
	
	
	
}



