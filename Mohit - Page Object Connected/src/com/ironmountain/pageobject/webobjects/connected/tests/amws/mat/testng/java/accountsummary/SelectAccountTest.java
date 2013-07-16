package com.ironmountain.pageobject.webobjects.connected.tests.amws.mat.testng.java.accountsummary;

import java.io.File;

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
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.Registration;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.SelectBackupAccountPage;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

/**
 * @author Jinesh Devasia
 *
 */
@SeleniumUITest
public class SelectAccountTest extends AccountManagementTest {

	
	String password = null;
	String email = null;
	
	@BeforeMethod (alwaysRun=true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		TestDataProvider.reloadTestData(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" );		
	}
	
	
	@Parameters( {"accountRow"})
	@Test(enabled = true, groups= {"amws","mat", "accountsummary"})
	public void testSelectAccount(String accountRow)throws Exception{
		email = StringUtils.createNameVal()+"accsum@cb.com";
		TestDataProvider.setTestDataToXmlFile(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" , "Email", email);
		password = TestDataProvider.getTestData("Password");
		 selectBackupAccountPage = (SelectBackupAccountPage) AccountManagementLogin.login(email, password, true);
		 if(! selectBackupAccountPage.isTextPresent("The following backup accounts are linked to you")){
			 registerForMultiAccount(2);	
			 selectBackupAccountPage = (SelectBackupAccountPage) AccountManagementLogin.login(email, password, true);
		 }
		 Asserter.assertEquals(selectBackupAccountPage.verfiryTitle(), true);
		// selectBackupAccountPage.isTitlePresentFailOnNotFound("SelectBackupAccountAccountPageTitle");
		 /*
		  * Note that Account number's row and selectAccount link's row can be different 
		  * Here Account number's row is 1 and selectAccount link's row is "0" 
		  */
		 String accountno = selectBackupAccountPage.getAccountNumber(accountRow+1);
		 accMgmtHomePage = selectBackupAccountPage.clickOnSelectAccount(accountRow);
		 accMgmtHomePage.isTitlePresent("SummaryPageTitle");
		 Asserter.assertEquals(accMgmtHomePage.getAccountNumber(), accountno);
		 AccountManagementLogin.logout();
	}
	
	public void registerForMultiAccount(int noOfRegistration) throws Exception{
		for (int i = 0; i < noOfRegistration; i++) {
			//Registration.registerAnAccount("Multi", "Tester", email, password, password, "2010101");
			Registration.registerAnAccount("Multi", "Tester", email, password, password);
			
		}
	}
	@AfterMethod(alwaysRun=true)
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}
	
	
	
}
