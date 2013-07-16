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
import com.ironmountain.pageobject.pageobjectrunner.utils.DownloadUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.InstallUtils;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.EnterRegisterationDetails;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.MyRoam;
import com.ironmountain.pageobject.webobjects.connected.actions.testrunner.agent.BackupRunner;
import com.ironmountain.pageobject.webobjects.connected.database.DataBase;
import com.ironmountain.pageobject.webobjects.connected.database.registry.AgentConfigurationTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.AccountManagementHomePage;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;
@SeleniumUITest(priority=1)

public class MyRoamHomeTest extends AccountManagementTest {
private static Logger  logger      = Logger.getLogger(MyRoamHomeTest.class.getName());
private static AgentConfigurationTable  agentConfigTable= null;
	
	String password = null;
	String email = null;
	
	String server = null;
    String commId = null;
    String DownloadLocation = null;
    String configName = null;
    String configId = null;
	@Parameters({"TechId","Password"})
	@BeforeMethod
	public void startTest(String TechId,String Password) throws Exception{
		
		logger.info("Initialising the tests");
		password = Password;
		super.initAccountManagementTest();
		agentConfigTable = new AgentConfigurationTable(DatabaseServer.PRIMARY_REGISTRY_SERVER);
		configName = TestDataProvider.getTestData("ConfigName");
		logger.info(configName);
		server = PropertyPool.getProperty("PrimaryDataCenterRegistryMachineName");
		logger.info(server);
		DownloadLocation = FileUtils.setDownloadLocationwithFileName("AgentSetupFile");
		logger.info(DownloadLocation);
		//Downloading msi from the default community which has the community id 1
		commId = "1";
		configId = agentConfigTable.getAgentConfigurationId(configName, commId);
		logger.info(configId);
		email = StringUtils.createNameVal()+"myroam@cb.com";
		logger.info("Generating dynamic email address");
		TestDataProvider.setTestDataToXmlFile(AccountManagementTest.TEST_DATA_XML_FILE, "Email", email);
		logger.info(email);
		logger.info(password);
		logger.info(Password);
		String registrationurl = TestDataProvider.getTestData("RegistrationURL");
		logger.info(registrationurl);
		DownloadAndInstallAfterRegistrationIfAccNotPresent(TechId,Password);
		BackupRunner.runBackup(3);
	}
	
	/** Tests to verify the MyRoam Home page
	 * @param Email
	 * @param Password
	 * @throws Exception
	 */
	@Test(enabled = true, groups= {"amws","mat", "MyRoam"})
	public void testMyRoamHome() throws Exception
			{	
				logger.info("Starting the test");
				AccountManagementLogin.login(email, password);
				AccountManagementLogin.logout();
				AccountManagementLogin.login(email, password);
				logger.info("View the MyRoam Page");
				myRoamPage = AccountManagementNavigation.viewMyRoamPage();
				Asserter.assertEquals(myRoamPage.verifyTitle(), true);
				logger.info("End test");
			}
	
	@Parameters({"TechId","Password"})
	public void DownloadAndInstallAfterRegistrationIfAccNotPresent(String TechId,String Password) throws Exception{
		AccountManagementHomePage accHome = AccountManagementLogin.login(email, password);
		System.out.println(accHome.getTitle());
		if(accHome.getTitle().contains("Account Summary")){
			int commId_int,configId_int;
			commId_int=Integer.parseInt(commId);
			configId_int=Integer.parseInt(configId);
			//Downloading the msi using Admin api
			InstallUtils.downloadAgentMSI_AdminAPI(TechId, Password, server, commId_int,configId_int , DownloadLocation);
			InstallUtils.installAgent("AgentSetupFile",email,Password); 
		} 
		else {
			int configId_int,commId_int;
			commId_int=Integer.parseInt(commId);
			configId_int=Integer.parseInt(configId);
			//Downloading the msi using Admin api
			InstallUtils.downloadAgentMSI_AdminAPI(TechId, Password, server, commId_int,configId_int , DownloadLocation);
			InstallUtils.installAgent("AgentSetupFile",email,Password);
		}
	}
	
	/**
	 * Closing all the database connections
	 */
	@AfterMethod(alwaysRun = true)
	public void closeDataBaseConnections(){
		if(!skipTest){
		DataBase.closeDatabaseConnections(agentConfigTable);
	}
	}
	@AfterMethod
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}


}
