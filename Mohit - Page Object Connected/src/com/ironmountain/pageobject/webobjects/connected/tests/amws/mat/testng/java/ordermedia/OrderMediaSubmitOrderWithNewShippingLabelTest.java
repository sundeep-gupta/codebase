package com.ironmountain.pageobject.webobjects.connected.tests.amws.mat.testng.java.ordermedia;

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
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.BackupData;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.OrderMedia;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.Registration;
import com.ironmountain.pageobject.webobjects.connected.database.registry.CdqTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest
public class OrderMediaSubmitOrderWithNewShippingLabelTest extends AccountManagementTest {

	CdqTable cdqTable = null;
	static String email =null;
	static String password=null;
	
	@BeforeMethod (alwaysRun=true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		TestDataProvider.reloadTestData(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" );
		email = TestDataProvider.getTestData("Email");
		password = TestDataProvider.getTestData("Password");
		cdqTable = new CdqTable(DatabaseServer.COMMON_SERVER);
	}
	/*@Parameters( {"email", "password"})
	@BeforeMethod (alwaysRun=true, dependsOnMethods = {"startTest"})
	public void createBackupDates(String email, String password) throws Exception{
		
		 * Create/Register the user if the user does not exist
		 
		Registration.registerUserIfNotPresent("Automation", "Tester", email,
				password, password, "2010100");		
		
		 * Install Agent for the user and do the backups
		 
		AccountManagementLogin.login(email, password);
		BackupData.reinstallAgentAndBackupDataIfNoBackupDatePresent(3);
		AccountManagementLogin.logout();
	}*/	
	/**
	 * Clearing the CDQ table before test so that test never fails because of unnecessary data and the table will not be flooded with data.
	 * 
	 * @throws Exception
	 */
	@BeforeMethod (alwaysRun=true, dependsOnMethods = {"startTest"})
	public void cleanCDQTable() throws Exception{
		cdqTable.clearTable();
	}
	
	/**
	 * Test to verify the user can successfully create a media order using a new shipping address,	 * 
	 * 
	 * @param email
	 * @param password
	 * @param optionIndex 
	 * @param verificationTexts 
	 * @param defaultAddress 
	 * @param newPassword
	 * @throws Exception
	 */
	@Parameters( { "mediaPassword", "newAddress"})
	@Test(enabled = true, groups= {"amws","mat", "ordermedia"})
	public void testSubmitOrderWithNewShippingLabel(String mediaPassword, String newAddress) throws Exception
	{
		AccountManagementLogin.login(email, password);
		orderCdorDvdForm1Page = AccountManagementNavigation.viewOrderCdOrDvdsPage();
		orderCdorDvdForm1Page.selectBackupDate("1");
		String backupDate = orderCdorDvdForm1Page.getSelectedBackupdate();
		orderCdOrDvdConfirmationPage = OrderMedia.createDvdOrderWithShippingAddress("1", mediaPassword, newAddress);		
		orderCdOrDvdConfirmationPage.isTextPresentFailOnNotFound("OrderCdOrDvdConfirmationPage.ConfirmationText");
		orderCdOrDvdConfirmationPage.isTextPresentFailOnNotFound(backupDate);
		orderCdOrDvdConfirmationPage.isTextPresentFailOnNotFound(newAddress);	
		summaryPage = AccountManagementNavigation.viewAccountSummaryPage();
		String accountNo = summaryPage.getAccountNumber();
		accountNo = accountNo.replaceAll("-\\d", "");
		AccountManagementLogin.logout();		
		
		/*
		 * Go the database and Verify the CDQ table data
		 * MediaType 1 = DVD		 * 
		 */
		verifyCDQTableForOrderMediaGeneration(accountNo, 1, newAddress);		
	}	
	
	public void verifyCDQTableForOrderMediaGeneration(String accountNo, int mediaType, String shippingLabel){

		Asserter.assertEquals(Integer.toString(cdqTable.getAccountNumber()), accountNo);
		Asserter.assertEquals(cdqTable.getMediaType(), mediaType);
		Asserter.assertEquals(cdqTable.getShippingLabel(), shippingLabel);
		cdqTable.closeQueryExecutor();
		cdqTable.closeDatabaseConnection();
	}
		
	@AfterMethod(alwaysRun=true)
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}
	
	
}
