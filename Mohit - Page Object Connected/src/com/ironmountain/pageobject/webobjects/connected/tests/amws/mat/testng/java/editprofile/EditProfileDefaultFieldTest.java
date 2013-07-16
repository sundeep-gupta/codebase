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
public class EditProfileDefaultFieldTest extends AccountManagementTest {

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
		 
		Registration.registerUserIfNotPresent("Custom", "User", email,
				password, password, "E2010300");
	}*/
	/**
	 * Test to verify the user default profile information configures is displaying in edit profile
	 * Verify user can update the default information.
	 * 
	 * @param email
	 * @param password
	 * @param location
	 * @param newLocation
	 * @throws Exception
	 */
	@Parameters( {"location", "newLocation"})
	@Test(enabled = true, groups= {"amws","mat", "editprofile"})
	public void testDefaultValueField(String location, String newLocation) throws Exception
	{	
		/*
		 * Login and verify the user navigates to edit Profile page.
		 * Verify the field which has a default value configured.
		 * Update the default value to a blank value
		 * Save the information and verify the update message.
		 * Logout and login again verify the default value is again displayed instead or blank value
		 * Update the value to a new value.
		 * Logout and login again verify the new value is displayed now.
		 * Update the new value to a blank value.
		 * Logout and login again verify the default value is again displayed
		 * 
		 */
		setAndVerifyLocation(location, "" , location);	
		setAndVerifyLocation(location, newLocation, newLocation);	
		setAndVerifyLocation(newLocation, "", location);
	}	
	
	public void setAndVerifyLocation(String currentLocation, String newLocation, String defaultLocation) throws Exception{
		
		AccountManagementLogin.login(email, password);
		editProfilePage = AccountManagementNavigation.viewEditProfilePage();
		Asserter.assertEquals(editProfilePage.getLocation(), currentLocation);
		editProfilePage.typeLocation(newLocation);
		editProfilePage = editProfilePage.clickOnSaveButton();
		editProfilePage.isTextPresentFailOnNotFound("EditProfilePage.ProfileUpdateText");
		AccountManagementLogin.logout();
		
		AccountManagementLogin.login(email, password);
		editProfilePage = AccountManagementNavigation.viewEditProfilePage();
		if(! StringUtils.isEmpty(newLocation)){
			Asserter.assertEquals(editProfilePage.getLocation(), newLocation);
		}
		else{
			Asserter.assertEquals(editProfilePage.getLocation(),defaultLocation);
		}		
		AccountManagementLogin.logout();
	}
	
	
	@Parameters( { "location"})
	@AfterMethod 
	public void resetLocationAfterTest(String location) throws Exception{
		AccountManagementLogin.login(email, password);
		editProfilePage = AccountManagementNavigation.viewEditProfilePage();
		editProfilePage.typeLocation(location);
		editProfilePage = editProfilePage.clickOnSaveButton();
		AccountManagementLogin.logout();		
	}
		
	@AfterMethod(alwaysRun=true, dependsOnMethods={"resetLocationAfterTest"})
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}

	
}
