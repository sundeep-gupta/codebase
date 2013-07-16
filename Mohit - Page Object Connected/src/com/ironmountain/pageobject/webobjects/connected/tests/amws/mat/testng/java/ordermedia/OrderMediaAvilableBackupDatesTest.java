package com.ironmountain.pageobject.webobjects.connected.tests.amws.mat.testng.java.ordermedia;

import java.io.File;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.DateUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.BackupData;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.Registration;
import com.ironmountain.pageobject.webobjects.connected.database.registry.AccountBackupDatesTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;
import com.ironmountain.pageobject.webobjects.connected.tests.amws.OrderMediaVerifyUtils;

@SeleniumUITest
public class OrderMediaAvilableBackupDatesTest extends AccountManagementTest {

	String backupDates = "";
	String backupDateSeparator = "'";
	AccountBackupDatesTable bDatesTable = null;
	static String email =null;
	static String password=null;
	
	@BeforeMethod (alwaysRun=true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		TestDataProvider.reloadTestData(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" );
		email = TestDataProvider.getTestData("Email");
		password = TestDataProvider.getTestData("Password");
		bDatesTable = new AccountBackupDatesTable(DatabaseServer.COMMON_SERVER);		
	}	
	
	/*@Parameters( {"email", "password"})
	@BeforeMethod (alwaysRun=true, dependsOnMethods = {"startTest"})
	public void registerAccountIfNotPresent(String email, String password) throws Exception{

		
		 * Create/Register the user if the user does not exist
		 
		Registration.registerUserIfNotPresent("Automation", "Tester", email,
				password, password, "2010100");
	}*/
	/**
	 * Test to verify the user can successfully change the password from Edit Profile Page	 * 
	 * 
	 * @param email
	 * @param password
	 * @param backupDateSeparator 
	 * @param newPassword
	 * @throws Exception
	 */
	@Test(enabled = true, groups= {"amws","mat", "ordermedia"})
	public void testAvilableBackupDates() throws Exception
	{		
		accMgmtHomePage = AccountManagementLogin.login(email, password);
		String accountNumber = accMgmtHomePage.getAccountNumber();
		//BackupData.reinstallAgentAndBackupDataIfNoBackupDatePresent(3);
		//AccountManagementLogin.logout();	
		backupDates = getBackupDatesForTest(accountNumber);
		
		AccountManagementLogin.login(email, password);
		orderCdorDvdForm1Page = AccountManagementNavigation.viewOrderCdOrDvdsPage();		
		orderCdorDvdForm1Page.isTitlePresentFailOnNotFound("OrderCDsorDVDsPageTitle");
		orderCdorDvdForm1Page.isTextPresentFailOnNotFound("OrderCdOrDvdForm1Page.VerificationText1");
		orderCdorDvdForm1Page.isTextPresentFailOnNotFound("OrderCdOrDvdForm1Page.VerificationText2");
		orderCdorDvdForm1Page.isTextPresentFailOnNotFound("OrderCdOrDvdForm1Page.VerificationText3");
		orderCdorDvdForm1Page.isTextPresentFailOnNotFound("OrderCdOrDvdForm1Page.HideIncompleteCheckboxText");
		OrderMediaVerifyUtils.verifyAvailableBackupDates(StringUtils.toStringArrayList(backupDates, backupDateSeparator), false);
		AccountManagementLogin.logout();
	}	 
	       
	public String getBackupDatesForTest(String accountNumber){
		accountNumber = bDatesTable.getDbFormattedAccountNumber(accountNumber);
		String[] dates = bDatesTable.getBackupDates(accountNumber);
		for (int i = 0; i < dates.length; i++) {
			if(StringUtils.isEmpty(backupDates)){
			    backupDates  = backupDates + DateUtils.getaccountManagementBackupDateFormat(dates[i]) + " (complete)";
			}
			else{
				backupDates  = backupDates + "'" +DateUtils.getaccountManagementBackupDateFormat(dates[i]) + " (complete)";
			}				
		}	
		return backupDates;
	}
	
	@AfterMethod(alwaysRun=true)
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}
	
	
}
