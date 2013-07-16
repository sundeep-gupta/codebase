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
import com.ironmountain.pageobject.webobjects.connected.database.registry.CdqTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;


@SeleniumUITest
public class LastCDsAndDVDsOrderHistoryTest extends AccountManagementTest {

	CdqTable cdqTable = null;
	String email=null;
	String password= null;
	
	@BeforeMethod (alwaysRun=true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		TestDataProvider.reloadTestData(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" );
		email = TestDataProvider.getTestData("Email");
		password = TestDataProvider.getTestData("Password");
		cdqTable = new CdqTable(DatabaseServer.COMMON_SERVER);
	}
	
	@Parameters( {"lastCDsAndDVDsOrderBackupSetsize", "numberOfMediaShipped"})
	@Test(enabled = true, groups= {"amws","mat", "ordermedia"})
	public void testLastCDsAndDVDsOrderHistory(String lastCDsAndDVDsOrderBackupSetsize, String numberOfMediaShipped)throws Exception{
		
		accMgmtHomePage = AccountManagementLogin.login(email, password);
		String accountNo = accMgmtHomePage.getAccountNumber();
		accountHistoryPage = AccountManagementNavigation.viewAccountHistoryPage();
		accountHistoryPage.isTitlePresentFailOnNotFound("ViewHistoryPageTitle");
		String accountNumber =StringUtils.getDbFormattedAccountNumber(accountNo);
		String lastCDsAndDVDsOrderDate = DateUtils.getaccountManagementBackupDateFormat(cdqTable.getLastMediaOrderDate(accountNumber));
		Asserter.assertEquals(accountHistoryPage.getLastCDsAndDVDsOrderDateCompleted(),lastCDsAndDVDsOrderDate );
		//Asserter.assertEquals(accountHistoryPage.getLastCDsAndDVDsOrderBackupSetsize(), lastCDsAndDVDsOrderBackupSetsize );
		Asserter.assertEquals(accountHistoryPage.getNumberOfMediaShipped(), numberOfMediaShipped);
		AccountManagementLogin.logout();
	}
		
	@AfterMethod(alwaysRun=true)
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}
	
}
