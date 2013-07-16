package com.ironmountain.pageobject.webobjects.connected.tests.amws.mat.testng.java.editprofile;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.EditProfile;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.Registration;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest
public class EditProfileContactInformationFieldsTest extends AccountManagementTest {

	
	static String email=null;
	static String password= null;
	
	@BeforeMethod (alwaysRun=true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
	}
	/*@Parameters( {"email", "password"})
	@BeforeMethod (alwaysRun=true, dependsOnMethods = {"startTest"})
	public void registerAccountIfNotPresent(String email, String password) throws Exception{

		
		 * Create/Register the user if the user does not exist
		 
		Registration.registerUserIfNotPresent("Automation", "Tester", email,
				password, password, "2010100");
	}*/
	
	/**
	 * Test to verify the user can successfully edit the contact information fields from Edit Profile	 * 
	 * 
	 * @param email
	 * @param password
	 * @param company
	 * @param country
	 * @param addressLine1
	 * @param city
	 * @param state
	 * @param zipCode
	 * @param phone
	 * @throws Exception
	 */
	@Parameters( {"company", "country", "addressLine1", "city","state", "zipCode", "phone"})
	@Test(enabled = true, groups= {"amws","mat", "editprofile"})
	public void testContactInformationFields(String company, String country, String addressLine1, String city, String state, String zipCode, String phone) throws Exception
	{	
		/*
		 * Login and verify the user navigates to edit Profile page.
		 * Edit the contact information fields.
		 * Save the information and verify the update message.
		 * Logout from the application.
		 */
		email = TestDataProvider.getTestData("Email");
		password = TestDataProvider.getTestData("Password");
		AccountManagementLogin.login(email, password);
		editProfilePage = AccountManagementNavigation.viewEditProfilePage();
		editProfilePage.isTextPresentFailOnNotFound("EditProfilePage.ContactInfoText");
		EditProfile.enterContactInformationsAndSave(company, country, addressLine1, "", "", city, state, zipCode, phone);
		editProfilePage.isTextPresentFailOnNotFound("EditProfilePage.ProfileUpdateText");
		AccountManagementLogin.logout();
		
		/*
		 * Login again using the new email address is successful.
		 * Verify the update email address is displayed.
		 */
		AccountManagementLogin.login(email, password);
		editProfilePage = AccountManagementNavigation.viewEditProfilePage();
		Asserter.assertEquals(editProfilePage.getCompany(),company);
		Asserter.assertEquals(editProfilePage.getSelectedCountry(),country);
		Asserter.assertEquals(editProfilePage.getAddressLine("1"),addressLine1);
		Asserter.assertEquals(editProfilePage.getCity(),city);
		Asserter.assertEquals(editProfilePage.getSelectedState(),state);
		Asserter.assertEquals(editProfilePage.getZipCode(),zipCode);
		Asserter.assertEquals(editProfilePage.getPhoneNumber(),phone);
		AccountManagementLogin.logout();
	}	
	
	@AfterMethod 
	public void resetContactInformationsAfterTest() throws Exception{
		AccountManagementLogin.login(email, password);
		EditProfile.updateContactInformations("", "United States", "", "", "", "", "California", "", "");
		AccountManagementLogin.logout();
		
	}
		
	@AfterMethod(alwaysRun=true, dependsOnMethods={"resetContactInformationsAfterTest"})
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}

	
}
