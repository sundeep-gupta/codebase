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
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.BackupData;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.EditProfile;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.OrderMedia;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.Registration;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;
import com.ironmountain.pageobject.webobjects.connected.tests.VerifyUtils;

@SeleniumUITest
public class OrderMediaSubmitOrderWithDefaultShippingLabelTest extends AccountManagementTest {

	static String email =null;
	static String password=null;
	
	@BeforeMethod (alwaysRun=true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		TestDataProvider.reloadTestData(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" );
		email = TestDataProvider.getTestData("Email");
		password = TestDataProvider.getTestData("Password");
	}
	/*@Parameters( {"email", "password", "defaultAddress"})
	@BeforeMethod (alwaysRun=true, dependsOnMethods = {"startTest"})
	public void createBackupDates(String email, String password, String defaultAddress) throws Exception{
		
		 * Create/Register the user if the user does not exist
		 
		Registration.registerUserIfNotPresent("DefaultAddress", null, "Tester", email, password, password, null, 
				null, "E2010201", null, null, defaultAddress, null, null, null, null, null, null);
		
		AccountManagementLogin.login(email, password);
		EditProfile.updateContactInformationsIgnoreBlankValues(null, null, defaultAddress, null, null, null, null, null, null);
		AccountManagementLogin.logout();
		
		 * Install Agent for the user and do the backups
		 
		AccountManagementLogin.login(email, password);
		BackupData.reinstallAgentAndBackupDataIfNoBackupDatePresent(3);
		AccountManagementLogin.logout();
	}	*/
	/**
	 * Test to verify the user can successfully change the password from Edit Profile Page	 * 
	 * 
	 * @param email
	 * @param password
	 * @param optionIndex 
	 * @param defaultAddress 
	 * @param newPassword
	 * @throws Exception
	 */
	@Parameters( {"mediaPassword", "defaultAddress", "orderConfirmationVerificationTexts"})
	@Test(enabled = true, groups= {"amws","mat", "editprofile"})
	public void testSubmitOrderWithDefaultShippingLabel(String mediaPassword, String defaultAddress, String orderConfirmationVerificationTexts) throws Exception
	{
		AccountManagementLogin.login(email, password);
		orderCdorDvdForm1Page = AccountManagementNavigation.viewOrderCdOrDvdsPage();
		orderCdorDvdForm1Page.selectBackupDate("1");
		String backupDate = orderCdorDvdForm1Page.getSelectedBackupdate();
		orderCdOrDvdConfirmationPage = OrderMedia.createDvdOrder("1", mediaPassword);		
		orderCdOrDvdConfirmationPage.isTextPresentFailOnNotFound(backupDate);
		orderCdOrDvdConfirmationPage.isTextPresentFailOnNotFound("OrderCdOrDvdConfirmationPage.ConfirmationText");
		orderCdOrDvdConfirmationPage.isTextPresentFailOnNotFound(defaultAddress);		
		VerifyUtils.verifyTextsInPage(orderCdOrDvdConfirmationPage, orderConfirmationVerificationTexts);
		AccountManagementLogin.logout();
	}		
		
	@AfterMethod(alwaysRun=true)
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}
	
	
}
