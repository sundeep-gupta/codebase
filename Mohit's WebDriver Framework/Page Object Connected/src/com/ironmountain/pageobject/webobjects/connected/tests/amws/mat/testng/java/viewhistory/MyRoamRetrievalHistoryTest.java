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
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest
public class MyRoamRetrievalHistoryTest extends AccountManagementTest {

	String email=null;
	String password= null;
	
	@BeforeMethod (alwaysRun=true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		TestDataProvider.reloadTestData(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" );
		email = TestDataProvider.getTestData("Email");
		password = TestDataProvider.getTestData("Password");
		
	}
	
	@Test(enabled = true, groups= {"amws","mat", "ordermedia"})
	public void testMyRoamRetrievalHistory()throws Exception{
		
		AccountManagementLogin.login(email, password);
		accountHistoryPage = AccountManagementNavigation.viewAccountHistoryPage();
		accountHistoryPage.isTitlePresentFailOnNotFound("ViewHistoryPageTitle");
		Asserter.assertEquals(accountHistoryPage.getLastMyRoamRetrievalDateCompleted(),TestDataProvider.getTestData("LastMyRoamRetrievalDateCompleted"));
		Asserter.assertEquals(accountHistoryPage.getNumberOfFilesRetrieved(), TestDataProvider.getTestData("NumberOfFilesRetrieved"));
		Asserter.assertEquals(accountHistoryPage.getTotalAmountOfDataRestored(), TestDataProvider.getTestData("TotalAmountOfDataRestored"));
		AccountManagementLogin.logout();
	}
		
	@AfterMethod(alwaysRun=true)
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}
	
}
