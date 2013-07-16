package com.ironmountain.pageobject.webobjects.connected.tests.amws.mat.testng.java.editprofile;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;


import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.Registration;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.PrivacyPolicyPage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.TermsAndConditionsPage;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest
public class EditProfilePageLinksNavigationTest extends AccountManagementTest {
	
	static String email=null;
	static String password=null;

	@BeforeMethod (alwaysRun=true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
	}
	/*@Parameters( {"email", "password"})
	@BeforeMethod (alwaysRun=true, dependsOnMethods = {"startTest"})
	public void registerAccountIfNotPresent(String email, String password) throws Exception{

		
		 * Create/Register the user if the user does not exist
		 
		Registration.registerUserIfNotPresent("Custom", "User", email,
				password, password, "E2010300");
	}*/

	@Parameters( {"employeeId"}) 
	@Test(enabled = true, groups= {"amws","mat", "editprofile"})
	public void testPageNavigationsFromEditProfile() throws Exception
	{	
		email = TestDataProvider.getTestData("Email");
		password = TestDataProvider.getTestData("Password");
		AccountManagementLogin.login(email, password);
		editProfilePage = AccountManagementNavigation.viewEditProfilePage();
		editProfilePage.isTitlePresentFailOnNotFound("EditProfilePageTitle");
		summaryPage = editProfilePage.clickOnCancelButton();
		summaryPage.isTitlePresentFailOnNotFound("SummaryPageTitle");
		changePasswordPage = AccountManagementNavigation.viewChagePasswordPage();
		changePasswordPage.isTextPresentFailOnNotFound("ChangePasswordPage.PageVerificationText");
		editProfilePage = changePasswordPage.clickOnCancelButton();
		editProfilePage.isTextPresentFailOnNotFound("EditProfilePage.ContactInfoText");
		TermsAndConditionsPage termsAndConditionsPage = editProfilePage.clickOnTermsAndConditions();
		termsAndConditionsPage.isTitlePresentFailOnNotFound("TermsAndConditionsPageTitle");
		editProfilePage = AccountManagementNavigation.viewEditProfilePage();
		editProfilePage.isTitlePresentFailOnNotFound("EditProfilePageTitle");
		PrivacyPolicyPage privacyPolicyPage = editProfilePage.clickOnPrivacyPolicy();
		privacyPolicyPage.isTitlePresentFailOnNotFound("PrivacyPolicyPageTitle");
		editProfilePage = AccountManagementNavigation.viewEditProfilePage();
		editProfilePage.isTitlePresentFailOnNotFound("EditProfilePageTitle");
//		HelpPage helpPage = editProfilePage.clickOnHelp();
//		System.out.println(helpPage.getTitle());
//		helpPage.closeHelp();			
//		AccountManagementLogin.logout();
	}
	
	@AfterMethod(alwaysRun=true)
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}

	
	
}
