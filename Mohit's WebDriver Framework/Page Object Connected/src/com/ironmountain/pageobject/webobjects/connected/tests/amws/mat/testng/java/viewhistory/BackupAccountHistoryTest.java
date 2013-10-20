package com.ironmountain.pageobject.webobjects.connected.tests.amws.mat.testng.java.viewhistory;

import java.io.File;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.DateUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.database.registry.AccountBackupDatesTable;
import com.ironmountain.pageobject.webobjects.connected.database.registry.AccountProfileTable;
import com.ironmountain.pageobject.webobjects.connected.database.registry.CustomerTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;


@SeleniumUITest
public class BackupAccountHistoryTest extends AccountManagementTest {

	private AccountProfileTable accountProfileTable = null;
	private AccountBackupDatesTable bDatesTable = null;
	private CustomerTable customerTable;
	String email=null;
	String password= null;
	
	@BeforeMethod (alwaysRun=true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		TestDataProvider.reloadTestData(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" );
		email = TestDataProvider.getTestData("Email");
		password = TestDataProvider.getTestData("Password");
		accountProfileTable = new AccountProfileTable(DatabaseServer.COMMON_SERVER);
		bDatesTable = new AccountBackupDatesTable(DatabaseServer.COMMON_SERVER);	
		customerTable = new CustomerTable(DatabaseServer.COMMON_SERVER);
	}
	
	@Parameters( {"servicePlanStorageLimit"})
	@Test(enabled = true, groups= {"amws","mat", "ordermedia"})
	public void testBackupHistory(String servicePlanStorageLimit)throws Exception{
		
		AccountManagementLogin.login(email, password);
		accountHistoryPage = AccountManagementNavigation.viewAccountHistoryPage();
		accountHistoryPage.isTitlePresentFailOnNotFound("ViewHistoryPageTitle");
		String accountNumber = Integer.toString(customerTable.getAccountNumber(email));
		String accountNo = StringUtils.getUiFormattedAccountNumber(accountNumber);
		Asserter.assertEquals(accountHistoryPage.getAccountNumber(),accountNo);		
		String computerName = accountProfileTable.getNetworkComputerName(accountNumber);
		Asserter.assertEquals(accountHistoryPage.getComputerName(), computerName);
		String accountActivationDate = DateUtils.getaccountManagementBackupDateFormat(customerTable.getAccountStartDate(accountNumber));
		Asserter.assertEquals(accountHistoryPage.getAccountActivationDate(), accountActivationDate);
		Asserter.assertEquals(accountHistoryPage.getServicePlanStorageLimit(), servicePlanStorageLimit);
		String lastBackupDateCompleted = DateUtils.getaccountManagementBackupDateFormat(bDatesTable.getLastBackupDateCompleted(accountNumber));
		Asserter.assertEquals(accountHistoryPage.getLastBackupDateCompleted(),lastBackupDateCompleted);
		accountHistoryPage.isTextPresentFailOnNotFound("CopyRightText");
		AccountManagementLogin.logout();
	}
		
	@AfterMethod(alwaysRun=true)
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}
	
}
