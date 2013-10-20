package com.ironmountain.pageobject.webobjects.connected.tests.amws.mat.testng.java.ordermedia;

import java.io.File;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.BackupData;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;
import com.ironmountain.pageobject.webobjects.connected.tests.amws.OrderMediaVerifyUtils;

@SeleniumUITest
public class OrderMediaHideIncompleteBackupDatesTest extends AccountManagementTest {

	static String email =null;
	static String password=null;
	private String allBackupDatesList;
	private String completeBackupDatesList;
	private String incompleteBackupDatesList;

	@BeforeMethod (alwaysRun=true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		TestDataProvider.reloadTestData(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" );
		email = TestDataProvider.getTestData("Email");
		password = TestDataProvider.getTestData("Password");
	}
	
	/*@Parameters( {"email", "password"})
	@BeforeMethod (alwaysRun=true, dependsOnMethods = {"startTest"})
	public void createBackupDates(String email, String password) throws Exception{
		AccountManagementLogin.login(email, password);
		BackupData.reinstallAgentAndBackupDataIfNoBackupDatePresent(3);
		AccountManagementLogin.logout();
	}	*/
	/**
	 * Test to verify the user can successfully change the password from Edit Profile Page	 * 
	 * This test is disabled because currently we don't have an efficient way to do the in complete backup
	 * 
	 * @param email
	 * @param password
	 * @param newPassword
	 * @throws Exception
	 */
	//@Test(enabled = true, groups= {"amws","mat", "ordermedia"})
	public void testHideIncompleteBackupDates(String email, String password) throws Exception
	{
		AccountManagementLogin.login(email, password);
		orderCdorDvdForm1Page = AccountManagementNavigation.viewOrderCdOrDvdsPage();		
		orderCdorDvdForm1Page.isTitlePresentFailOnNotFound("OrderCDsorDVDsPageTitle");
		orderCdorDvdForm1Page.isTextPresentFailOnNotFound("OrderCdOrDvdForm1Page.VerificationText1");
		orderCdorDvdForm1Page.isTextPresentFailOnNotFound("OrderCdOrDvdForm1Page.VerificationText2");
		orderCdorDvdForm1Page.isTextPresentFailOnNotFound("OrderCdOrDvdForm1Page.VerificationText3");
		orderCdorDvdForm1Page.isTextPresentFailOnNotFound("OrderCdOrDvdForm1Page.HideIncompleteCheckboxText");
		OrderMediaVerifyUtils.verifyAvailableBackupDates(StringUtils.toStringArrayList(allBackupDatesList, "'"), false);
		orderCdorDvdForm1Page.checkHideIncompleteBackupDatesCheckbox();
		OrderMediaVerifyUtils.verifyAvailableBackupDates(StringUtils.toStringArrayList(completeBackupDatesList, "'"), false);
		OrderMediaVerifyUtils.verifyAvailableBackupDates(StringUtils.toStringArrayList(incompleteBackupDatesList, "'"), false, false);
		orderCdorDvdForm1Page.unCheckHideIncompleteBackupDatesCheckbox();
		OrderMediaVerifyUtils.verifyAvailableBackupDates(StringUtils.toStringArrayList(allBackupDatesList, "'"), false);
		AccountManagementLogin.logout();
	}	
	
		
	@AfterMethod(alwaysRun=true)
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}
	
	
}
