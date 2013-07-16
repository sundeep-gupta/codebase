package com.ironmountain.pageobject.webobjects.connected.tests.amws.mat.testng.java.editprofile;

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
import com.ironmountain.pageobject.webobjects.connected.actions.amws.ChangePassword;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.Registration;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;

@SeleniumUITest
public class EditProfileChangePasswordTest extends AccountManagementTest {

	String password = null;
	String email = null;
	
	@BeforeMethod (alwaysRun=true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		TestDataProvider.reloadTestData(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" );
		email = StringUtils.createNameVal()+"editprof@cb.com";
		TestDataProvider.setTestDataToXmlFile(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" , "Email", email);
		password = TestDataProvider.getTestData("Password");
		}
	
	@BeforeMethod (alwaysRun=true, dependsOnMethods = {"startTest"})
	public void registerAccountIfNotPresent() throws Exception{	
		 //CreateRegister the user if the user does not exist
		String registrationURL = TestDataProvider.getTestData("CustomRegistrationUrl");
		Registration.registerUserIfNotPresentWithCustomRegistrationURL(registrationURL, "Automation", "Tester", email,password, "2010100");
	}
	
	
	/**
	 * Test to verify the user can successfully change the password from Edit Profile Page	 * 
	 * 
	 * @param email
	 * @param password
	 * @param newPassword
	 * @throws Exception
	 */
	@Parameters( {"newPassword"})
	@Test(enabled = true, groups= {"amws","mat", "editprofile"})
	public void testPassword(String newPassword) throws Exception
	{	
		/*
		 * Login and verify the user navigates to Password change page.
		 * Edit the Password.
		 * Save the information and verify the update message.
		 * Logout from the application.
		 */
		AccountManagementLogin.login(email, password);
		changePasswordPage = AccountManagementNavigation.viewChagePasswordPage();
		changePasswordPage.isTextPresentFailOnNotFound("ChangePasswordPage.PageVerificationText");
		changePasswordPage = ChangePassword.chagePassword(password, newPassword, newPassword);
		changePasswordPage.isTextPresentFailOnNotFound("ChangePasswordPage.PasswordUpdateText");
		AccountManagementLogin.logout();
		
		/*
		 * Login again using the new password and verify login is successful.
		 */
		accMgmtHomePage = AccountManagementLogin.login(email, newPassword);
		accMgmtHomePage.isTitlePresentFailOnNotFound("SummaryPageTitle");
		AccountManagementLogin.logout();
	}	
	
	@Parameters( {"newPassword"})
	@AfterMethod 
	public void resetPasswordAfterTest(String newPassword) throws Exception{
        AccountManagementLogin.login(email, newPassword);
        ChangePassword.chagePassword(newPassword, password, password);
		AccountManagementLogin.logout();	
	}
		
	@AfterMethod(alwaysRun=true, dependsOnMethods={"resetPasswordAfterTest"})
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}

	
}
