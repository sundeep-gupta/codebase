package com.ironmountain.pageobject.webobjects.connected.tests.amws.mat.testng.java.registrationanddownload;

import java.io.File;

import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.DownloadUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.webobjects.connected.actions.InstallUtils;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.EnterRegisterationDetails;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.NetworkLogin;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.NetworkLogonPage;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

/**
 * @author Princy James
 *
 */
@SeleniumUITest
public class RegisterCustomCommunityTest extends AccountManagementTest {
	
	
	@BeforeMethod
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		TestDataProvider.reloadTestData(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" );
			}
	
	/**Tests the register and download feature on a LDAP community.
	 * @param LDAPId
	 * @param LDAPPass
	 * @throws Exception
	 */
	@Parameters( {"FirstName", "MiddleName", "LastName","Email","Password", "ConfirmPassword"})
	@Test(enabled = true, groups= {"amws","mat", "RegistrationAndDownload"})
	public void testEnterDetailsandDownload(String FirstName, String MiddleName, String LastName, String Email, String Password, String ConfirmPassword) throws Exception{
		
		registrationPage = AccountManagementNavigation.viewRegistrationPage();
		registrationLicensePage = registrationPage.ClickOnRegisterAndDownloadBtn();
		enterRegistrationDetailsPage = registrationLicensePage.clickOnAcceptBtn();
		registrationCompletePage = EnterRegisterationDetails.enterFields(FirstName, LastName, Email, Password, ConfirmPassword);
		Assert.assertEquals(registrationCompletePage.verifyAccNumExists(), true);
		Assert.assertEquals(registrationCompletePage.getName(), (FirstName +" "+ LastName));
		Assert.assertEquals(registrationCompletePage.getEmailAdd(), Email);
		Assert.assertEquals(registrationCompletePage.verifyDownloadSoftwareBtn(), true);
		Assert.assertEquals(registrationCompletePage.verifyPrintBtn(), true);
		registrationCompletePage.clickOnDownloadSoftware();
		registrationCompletePage.clickOnBeginDownload();
		
		// Downloading the Agent using the Autoit acripts
		DownloadUtils.handleDownloadDialog("File Download - Security Warning","AgentSetupFile");
		registrationCompletePage.waitForSeconds(20);
		InstallUtils.installAgent("AgentSetupFile",Email, Password);
		
	}

	@AfterMethod
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}	
}

