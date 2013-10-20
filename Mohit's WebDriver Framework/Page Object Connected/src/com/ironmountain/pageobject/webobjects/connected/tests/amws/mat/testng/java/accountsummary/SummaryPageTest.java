package com.ironmountain.pageobject.webobjects.connected.tests.amws.mat.testng.java.accountsummary;

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

/**
 * Test to verify the Summary Page
 * 
 * @author pjames
 * @author Jinesh Devasia updated the test with dynamic test user creation
 * 
 */
@SeleniumUITest
public class SummaryPageTest extends AccountManagementTest {
	
	String password = null;
	String email = null;

	@BeforeMethod
	public void startTest() throws Exception {
		super.initAccountManagementTest();
		TestDataProvider.reloadTestData(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" );
		
	}

	/**
	 * Tests to verify the summary page
	 * 
	 * @param Email
	 * @param Password
	 * @throws Exception
	 */
	@Parameters( {"FirstName" , "LastName", "ConfirmPassword"})
	@Test(enabled = true, groups = { "amws", "mat", "accountsummary" })
	public void testSummaryPage(String FirstName, String LastName, String ConfirmPassword ) throws Exception {
		email = StringUtils.createNameVal()+"accsum@cb.com";
		TestDataProvider.setTestDataToXmlFile(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" , "Email", email);
		password = TestDataProvider.getTestData("Password");
		String registrationurl = TestDataProvider.getTestData("RegistrationURL");
		Registration.registerUserIfNotPresentWithRegistrationUrl(registrationurl, FirstName, LastName, email, password, ConfirmPassword);
		AccountManagementLogin.login(email, password);
		summaryPage = AccountManagementNavigation.viewAccountSummaryPage();
		Asserter.assertEquals(summaryPage.verifyTitle(), true);
		Asserter.assertEquals(summaryPage.verifyAccountStatus(), true);
		Asserter.assertEquals(summaryPage.verifyLastBackup(), true);
		Asserter.assertEquals(summaryPage.verifyAccRegisterDate(), true);
		summaryPage.clickOnEditProfile();
		Asserter.assertEquals(summaryPage.verifyEditProfileTitle(), true);
		summaryPage.clickOnSummaryLink();
		summaryPage.clickOnViewHistoryLink();
		Asserter.assertEquals(summaryPage.verifyViewHistoryTitle(), true);
		summaryPage.clickOnSummaryLink();
		summaryPage.clickOnMyRoamLink();
		Asserter.assertEquals(summaryPage.verifyMyRoamTitle(), true);
		summaryPage.clickOnBackToSummaryLink();
		summaryPage.clickOnOrderMediaLink();
		Asserter.assertEquals(summaryPage.verifyOrderMediaTitle(), true);
		summaryPage.clickOnSummaryLink();
		summaryPage.clickOnReInstallAgentLink();
		Asserter.assertEquals(summaryPage.verifyReInstallAgentTitle(), true);
		summaryPage.clickOnSummaryLink();
	}

	@AfterMethod
	public void stopTest() throws Exception {
		super.stopSeleniumTest();
	}

}
