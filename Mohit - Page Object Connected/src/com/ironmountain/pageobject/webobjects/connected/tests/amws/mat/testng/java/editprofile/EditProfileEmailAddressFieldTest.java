package com.ironmountain.pageobject.webobjects.connected.tests.amws.mat.testng.java.editprofile;

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
import com.ironmountain.pageobject.webobjects.connected.actions.amws.EditProfile;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.Registration;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest
public class EditProfileEmailAddressFieldTest extends AccountManagementTest {

	static String email=null;
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
	public void registerAccountIfNotPresent(String email, String password) throws Exception{

		
		 * Create/Register the user if the user does not exist
		 
		Registration.registerUserIfNotPresent("Automation", "Tester", email,
				password, password, "2010100");
	}*/
	/**
	 * Test to verify the user can successfully edit the name fields from Edit Profile	 * 
	 * 
	 * @param email
	 * @param password
	 * @param editProfileTitle
	 * @param firstname
	 * @param middlename
	 * @param lastname
	 * @throws Exception
	 */
	@Parameters( {"newEmailAddress"})
	@Test(enabled = true, groups= {"amws","mat", "editprofile"})
	public void testEmailAddressField(String newEmailAddress) throws Exception
	{			
		/*
		 * Login and verify the user navigates to edit Profile page.
		 * Edit the first name, middle name and last name fields.
		 * Save the information and verify the update message.
		 * Logout from the application.
		 */
		AccountManagementLogin.login(email, password);
		editProfilePage = AccountManagementNavigation.viewEditProfilePage();
		editProfilePage.isTextPresentFailOnNotFound("EditProfilePage.LogonInfoText");
		EditProfile.enterEmailAddressAndSave(newEmailAddress);
		editProfilePage.isTextPresentFailOnNotFound("EditProfilePage.ProfileUpdateText");
		AccountManagementLogin.logout();
		
		/*
		 * Login again using the new email address is successful.
		 * Verify the update email address is displayed.
		 */
		AccountManagementLogin.login(newEmailAddress, password);
		editProfilePage = AccountManagementNavigation.viewEditProfilePage();
		Asserter.assertEquals(editProfilePage.getEmailAddress(), newEmailAddress);
		AccountManagementLogin.logout();
	}	
	
	@Parameters( {"newEmailAddress"})
	@AfterMethod 
	public void resetEmailAddressAfterTest(String newEmailAddress) throws Exception{
		AccountManagementLogin.login(newEmailAddress, password);
		EditProfile.updateEmailAddress(email);
		AccountManagementLogin.logout();		
	}
		
	@AfterMethod(alwaysRun=true, dependsOnMethods={"resetEmailAddressAfterTest"})
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}

	
}
