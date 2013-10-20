package com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam;


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
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.BackupData;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.Registration;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest(priority=2, skipAllTestsIfFail=true)
public class SetupAccountForMyRoamTests extends AccountManagementTest{

	private static Logger  logger      = Logger.getLogger(SetupAccountForMyRoamTests.class);

	private String firstName = "MyRoam Regression";
	private String lastName = "User";
	private String backupRunnerFile =  "MyRoamRegressionBackup.xml";

	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		logger.info("Startign the test...startTest Method called..");
		super.initAccountManagementTest();	
		logger.info("Deleting the existing Downloads directory and creating new one..");
		FileUtils.deleteDir(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("downloadsdir"));
		FileUtils.createDirectory(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("downloadsdir"));
		logger.info("Test init completed...");
	}
	
	@Parameters({"emailid", "password"})
	@Test(groups={"amws", "myroamsetup"})
	public void setupAccountForMyRoamTests(String emailid, String password) throws Exception
	{
		logger.info("Starting actual test method..");
		logger.info("Getting the Registration URL from testdata..");
		String registrationUrl = TestDataProvider.getTestData("MyRoamRegressionTestRegistrationUrl");
		logger.info("Registration url is.." + registrationUrl);
		logger.info("Registering the user if user is not yet registered...");
		Registration.registerUserIfNotPresentWithRegistrationUrl(registrationUrl, firstName, lastName, emailid, password, password);		
		logger.info("Logging with the registered user...");
		accMgmtHomePage = AccountManagementLogin.login(emailid, password);
		logger.info("Re-install and do the backup..");
		BackupData.installAgentAndBackupData(backupRunnerFile, emailid, password );
		logger.info("Loggin out from application...");
		AccountManagementLogin.logout();	
		logger.info("Test Completed Successfully...");
		notifySetupTestComplete();
	}

	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		logger.info("stopTest method is called after test..");
		super.stopSeleniumTest();
		logger.info("stopTest completed...");
	}
	
}
