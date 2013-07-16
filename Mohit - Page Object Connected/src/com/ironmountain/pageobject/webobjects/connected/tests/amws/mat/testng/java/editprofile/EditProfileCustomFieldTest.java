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
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.Registration;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest
public class EditProfileCustomFieldTest extends AccountManagementTest {

	static String email =null;
	static String password=null;
	
	@BeforeMethod (alwaysRun=true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		TEST_DATA_XML_FILE_PATH =  PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml";
		TestDataProvider.loadTestData(TEST_DATA_XML_FILE_PATH);
		email = StringUtils.createNameVal()+"custom@cb.com";
		TestDataProvider.setTestDataToXmlFile(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" , "Email", email);
		password = TestDataProvider.getTestData("Password");
	}
	
	@BeforeMethod (alwaysRun=true, dependsOnMethods = {"startTest"})
	public void registerAccountIfNotPresent() throws Exception{

		
		 //Create/Register the user if the user does not exist
		String registrationURL = TestDataProvider.getTestData("CustomRegistrationUrl");
		Registration.registerUserIfNotPresentWithCustomRegistrationURL(registrationURL, "Custom", "User", email,
				password, "E2010300");
	}
	/**
	 * Test to verify the custom field profile information configured is displaying in edit profile
	 * Verify user can update the custom field information.
	 * 
	 * @param email
	 * @param password
	 * @param customFieldLabel
	 * @param customFieldValue
	 * @throws Exception
	 */
	@Parameters( {"customFieldLabel", "customFieldValue"})
	@Test(enabled = true, groups= {"amws","mat", "editprofile"})
	public void testCustomField(String customFieldLabel, String customFieldValue) throws Exception
	{			
		/*
		 * Login and verify the user navigates to edit Profile page.
		 * Verify the  custom filed is displayed correctly
		 * Update the to a new value
		 * Save the information and verify the update message.
		 * Logout from the application.
		 */
		AccountManagementLogin.login(email, password);
		editProfilePage = AccountManagementNavigation.viewEditProfilePage();
		editProfilePage.isTextPresentFailOnNotFound(customFieldLabel);
		editProfilePage.typeCustomField(customFieldValue);
		editProfilePage = editProfilePage.clickOnSaveButton();
		editProfilePage.isTextPresentFailOnNotFound("EditProfilePage.ProfileUpdateText");
		AccountManagementLogin.logout();
		
		AccountManagementLogin.login(email, password);
		editProfilePage = AccountManagementNavigation.viewEditProfilePage();
		Asserter.assertEquals(editProfilePage.getCustomField(), customFieldValue);
		AccountManagementLogin.logout();			
	}	

	@AfterMethod(alwaysRun=true)
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}

	
}
