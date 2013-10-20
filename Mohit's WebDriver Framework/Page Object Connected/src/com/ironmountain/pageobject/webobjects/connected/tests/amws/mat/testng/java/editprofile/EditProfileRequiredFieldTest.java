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
import com.ironmountain.pageobject.webobjects.connected.actions.amws.Registration;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest
public class EditProfileRequiredFieldTest extends AccountManagementTest {

	static String email =null;
	static String password=null;
	
	@BeforeMethod (alwaysRun=true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		TestDataProvider.reloadTestData(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" );
		email = TestDataProvider.getTestData("Email");
		password = TestDataProvider.getTestData("Password");
		
	}
	/*@Parameters( {"email", "password", "employeeId"})
	@BeforeMethod (alwaysRun=true, dependsOnMethods = {"startTest"})
	public void registerAccountIfNotPresent(String email, String password, String employeeId) throws Exception{

		
		 * Create/Register the user if the user does not exist
		 
		Registration.registerUserIfNotPresent("Custom", "User", email,
				password, password, employeeId);
	}*/
	/**
	 * Test to verify the required field(Employee ID") is works correctly in edit profile
	 * Verify user can update the information.
	 * 
	 * @param email
	 * @param password
	 * @param employeeId
	 * @throws Exception
	 */
	@Parameters( {"employeeId"})
	@Test(enabled = true, groups= {"amws","mat", "editprofile"})
	public void testRequiredField(String employeeId) throws Exception
	{			
		/*
		 * Login and verify the user navigates to edit Profile page.
		 * Verify the required field alert is generating if the value is empty.
		 * Update the value to a new value
		 * Save the information and verify the update message.
		 * Logout from the application.
		 */
		AccountManagementLogin.login(email, password);
		editProfilePage = AccountManagementNavigation.viewEditProfilePage();
		editProfilePage.typeEmployeeId("");
		editProfilePage = editProfilePage.clickOnSaveButton();
		editProfilePage.isTextPresentFailOnNotFound("EditProfilePage.FieldValidationAlertText");
		editProfilePage.isTextPresentFailOnNotFound("EditProfilePage.RequiredFieldAlertText", " ", "Employee ID");
		editProfilePage.typeEmployeeId(employeeId);
		editProfilePage = editProfilePage.clickOnSaveButton();
		editProfilePage.isTextPresentFailOnNotFound("EditProfilePage.ProfileUpdateText");
		AccountManagementLogin.logout();
		
		AccountManagementLogin.login(email, password);
		editProfilePage = AccountManagementNavigation.viewEditProfilePage();
		Asserter.assertEquals(editProfilePage.getEmployeeId(), employeeId);
		AccountManagementLogin.logout();		
	}
	
	@AfterMethod(alwaysRun=true)
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}

	
}
