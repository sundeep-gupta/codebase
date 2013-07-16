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

/**
 * @author Jinesh Devasia
 *
 */
@SeleniumUITest
public class EditProfileReadOnlyFieldTest extends AccountManagementTest {

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
	public void registerAccountIfNotPresent(String email, String password) throws Exception{

		
		 * Create/Register the user if the user does not exist
		 
		Registration.registerUserIfNotPresent("Custom", "User", email,
				password, password, "E2010300");
	}*/
	/**
	 * Test to verify the read only profile information configures is displaying in edit profile
	 * Verify user cannot update the read only information.
	 * 
	 * @param email
	 * @param password
	 * @param company
	 * @throws Exception
	 */
	@Parameters( {"company"})
	@Test(enabled = true, groups= {"amws","mat", "editprofile"})
	public void testReadOnlyField( String company) throws Exception
	{	
		/*
		 * Login and verify the user navigates to edit Profile page.
		 * Verify the company field which is read only value configured.
		 * Verify the field is disabled
		 * Logout from the application.
		 */
		AccountManagementLogin.login(email, password);
		editProfilePage = AccountManagementNavigation.viewEditProfilePage();
		Asserter.assertEquals(editProfilePage.getCompany(), company);
		Asserter.assertFalse(editProfilePage.isCompanyEditable(), "Company field is editbale which supposed to be read only");
		AccountManagementLogin.logout();
	}	
	
	@AfterMethod(alwaysRun=true)
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}

	
}
