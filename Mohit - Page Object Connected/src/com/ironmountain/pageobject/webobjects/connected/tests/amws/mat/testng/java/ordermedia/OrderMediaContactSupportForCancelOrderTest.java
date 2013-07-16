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
import com.ironmountain.pageobject.webobjects.connected.actions.amws.OrderMedia;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.Registration;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;
import com.ironmountain.pageobject.webobjects.connected.tests.VerifyUtils;

@SeleniumUITest
public class OrderMediaContactSupportForCancelOrderTest extends AccountManagementTest {

	static String email =null;
	static String password=null;
	
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
		
		 * Create/Register the user if the user does not exist
		 
		Registration.registerUserIfNotPresent("Automation", "Tester", email,
				password, password, "2010100");
		
		 * Install Agent for the user and do the backups
		 
		AccountManagementLogin.login(email, password);
		BackupData.reinstallAgentAndBackupDataIfNoBackupDatePresent(3);
		AccountManagementLogin.logout();
	}*/	
	/**
	 * Test to verify when the user click on contact support link to cancel a Media Order
	 * It will take to contact support page.	
	 * * 
	 * @param email
	 * @param password
	 * @param backupDateOptionIndex
	 * @param verificationTexts
	 * @throws Exception
	 */
	@Parameters( {"backupDateOptionIndex", "verificationTexts"})
	@Test(enabled = true, groups= {"amws","mat", "ordermedia"})
	public void testCancelOrderContactSupportLinkForCancelOrder(String backupDateOptionIndex, String verificationTexts) throws Exception
	{	
		AccountManagementLogin.login(email, password);
		orderCdOrDvdConfirmationPage = OrderMedia.createDvdOrder(backupDateOptionIndex, password);		
		contactSupportPage = orderCdOrDvdConfirmationPage.clickOnContactSupportLinkForCancel();
		contactSupportPage.isTitlePresentFailOnNotFound("ContactSupportPageTitle");
		VerifyUtils.verifyTextsInPage(contactSupportPage, verificationTexts);
		AccountManagementLogin.logout();		
	}	
		
	@AfterMethod(alwaysRun=true)
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}
	
	
}
