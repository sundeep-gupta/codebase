package com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam;


import org.apache.log4j.Logger;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.testrunner.ActionRunner;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;


@SeleniumUITest(priority=34, HPQCID="5993")
public class AccessMyRoamDuringBackupTest extends AccountManagementTest{

	BackupRunnerThread bT = null;
	private static Logger  logger      = Logger.getLogger(AccessMyRoamDuringBackupTest.class);
		
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		logger.info("Startign the Test, Now in startTest method");
		bT = new BackupRunnerThread("MyRoamRegressionDummyBackup.xml");
		bT.start();		
		Thread.sleep(15000);
		super.initAccountManagementTest();
	}
	
	@Parameters({"emailid", "password"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testCancelRetriveButtonInMyRoamPage(String emailid, String password) throws Exception
	{		
		logger.info("Starting the actual Test method");
		logger.info("Trying to login to account management while the backup is doing");
		accMgmtHomePage =AccountManagementLogin.login(emailid, password);
		logger.info("Login to Account Management, and now tryign to navigate to MyRoamPage");
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();		
		AccountManagementLogin.logout();
		logger.info("Logged out and waiting for backup to complete");
		bT.join();
		logger.info("Test is successfull..");
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		logger.info("Test completed now stopping the session..");
		super.stopSeleniumTest();
		logger.info("Test is completed..");
	}	
}

class BackupRunnerThread extends Thread{
	private static Logger  logger      = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam.BackupRunnerThread");
	private String runnerFile = null;
	public BackupRunnerThread(String file) {
		logger.info("Starting a backup Thread ..");
		runnerFile = file ;
	}
	public void run(){
		ActionRunner.run(runnerFile );
	}
	
}
