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
public class EditProfileNameFieldsTest extends AccountManagementTest {
	
	static String email =null;
	static String password=null;
	
	@BeforeMethod(alwaysRun=true)
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
	@Parameters( {"firstnameNew", "middlenameNew", "lastnameNew"})
	@Test(enabled = true, groups= {"amws","mat", "editprofile"})
	public void testEditNameFields(String firstname, String middlename, String lastname) throws Exception
	{	
		/*
		 * Login and verify the user navigates to edit Profile page.
		 * Edit the first name, middle name and last name fields.
		 * Save the information and verify the update message.
		 * Logout from the application.
		 */
		AccountManagementLogin.login(email, password);
		editProfilePage = AccountManagementNavigation.viewEditProfilePage();
		EditProfile.enterNameFieldsAndSave(firstname, middlename, lastname);
		editProfilePage.isTextPresentFailOnNotFound("EditProfilePage.ProfileUpdateText");
		AccountManagementLogin.logout();
		
		/*
		 * Login again and verify the update name field information is displayed.
		 */
		AccountManagementLogin.login(email, password);
		editProfilePage = AccountManagementNavigation.viewEditProfilePage();
		Asserter.assertEquals(editProfilePage.getFirstName(), firstname);
		Asserter.assertEquals(editProfilePage.getLastName(),lastname);
		Asserter.assertEquals(editProfilePage.getMiddleName(),middlename);
		AccountManagementLogin.logout();
	}	
	@Parameters( {"firstname", "middlename", "lastname"})
	@AfterMethod
	public void resetNameFieldsAfterTest(String firstname, String middlename, String lastname) throws Exception{
		
		AccountManagementLogin.login(email, password);
		AccountManagementNavigation.viewEditProfilePage();
		EditProfile.enterNameFieldsAndSave(firstname, middlename, lastname);
		AccountManagementLogin.logout();
	}	
	
	@AfterMethod (alwaysRun=true, dependsOnMethods={"resetNameFieldsAfterTest"})
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}

	
	
	

}
