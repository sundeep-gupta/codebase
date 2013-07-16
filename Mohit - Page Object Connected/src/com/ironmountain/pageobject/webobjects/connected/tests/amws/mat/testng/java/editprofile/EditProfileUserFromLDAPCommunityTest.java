package com.ironmountain.pageobject.webobjects.connected.tests.amws.mat.testng.java.editprofile;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest
public class EditProfileUserFromLDAPCommunityTest extends AccountManagementTest {

	
	@BeforeMethod (alwaysRun=true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
	}
	
	/**
	 * Test to verify the user cannot edit the profile information fields when he belongs to an LDAP community	 * 
	 * 
	 * @param email
	 * @param password
	 * @throws Exception
	 */
	@Parameters( {"email", "password"})
	@Test(enabled = true, groups= {"amws","mat", "editprofile"})
	public void testProfileInformationForLDAPCommunity(String email, String password) throws Exception
	{	
		accMgmtHomePage = AccountManagementLogin.login(email, password);
		accMgmtHomePage.isTextPresentFailOnNotFound("ViewProfileLinkText");
		editProfilePage = accMgmtHomePage.clickOnViewProfile();
		AccountManagementLogin.logout();
	}	
		
	@AfterMethod(alwaysRun=true)
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}

	
}
