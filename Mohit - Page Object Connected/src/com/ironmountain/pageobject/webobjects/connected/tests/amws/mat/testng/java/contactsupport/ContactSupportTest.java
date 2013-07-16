package com.ironmountain.pageobject.webobjects.connected.tests.amws.mat.testng.java.contactsupport;

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
import com.ironmountain.pageobject.webobjects.connected.actions.amws.Registration;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;
import com.ironmountain.pageobject.webobjects.connected.tests.VerifyUtils;

@SeleniumUITest
public class ContactSupportTest extends AccountManagementTest {

	
	String password = null;
	String email = null;
	
	@BeforeMethod (alwaysRun=true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		TestDataProvider.reloadTestData(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" );
		email = StringUtils.createNameVal()+"consupp@cb.com";
		TestDataProvider.setTestDataToXmlFile(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" , "Email", email);
		password = TestDataProvider.getTestData("Password");
	}
	
	@Parameters( {"contactEmailText", "contactPhoneText", "verificationTexts", "FirstName", "LastName"})
	@Test(enabled = true, groups= {"amws","mat", "contactsupport"})
	public void testContactSupport(String contactEmailText, String contactPhoneText, String verificationTexts,String FirstName, String LastName )throws Exception{
		
		String registrationurl = TestDataProvider.getTestData("RegistrationURL");
		Registration.registerUserIfNotPresentWithRegistrationUrl(registrationurl, FirstName, LastName, email, password, password);
		AccountManagementLogin.login(email, password);
		contactSupportPage = AccountManagementNavigation.viewContactSupportPage();
		//contactSupportPage.isTitlePresentFailOnNotFound("ContactSupportPageTitle");
		contactSupportPage.isTextPresentFailOnNotFound(contactEmailText);
		contactSupportPage.isTextPresentFailOnNotFound(contactPhoneText);
		VerifyUtils.verifyTextsInPage(contactSupportPage, verificationTexts);
		contactSupportPage.isTextPresentFailOnNotFound("CopyRightText");
		AccountManagementLogin.logout();
	}
		
	@AfterMethod(alwaysRun=true)
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}
	
}
