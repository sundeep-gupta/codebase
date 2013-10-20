package com.ironmountain.pageobject.webobjects.connected.tests.amws.mat.testng.java.registrationanddownload;

import java.io.File;

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
import com.ironmountain.pageobject.webobjects.connected.actions.amws.NetworkLogin;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.NetworkLogonPage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.SelectBackupAccountPage;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

/**
 * @author Princy James
 *
 */
@SeleniumUITest
public class RegisterLDAPTest extends AccountManagementTest {
	
	String registrationUrl=null;
	String accountRow="0";
	
	@BeforeMethod
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		TestDataProvider.reloadTestData(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" );
		registrationUrl = TestDataProvider.getTestData("LDAPRegistrationURL");
		System.out.println(registrationUrl);
		}
	
	/**Tests the register and download feature on a LDAP community.
	 * @param LDAPId
	 * @param LDAPPass
	 * @throws Exception
	 */
	@Parameters( {"LDAPId", "LDAPPass"})
	@Test(enabled = true, groups= {"amws","mat", "RegistrationAndDownload"})
	public void testEnterDetailsandDownload(String LDAPId, String LDAPPass) throws Exception{
		
		//Enter the details and navigate to complete page
		registrationPage = AccountManagementNavigation.viewRegistrationPage(registrationUrl);
		Asserter.assertEquals(registrationPage.verifyWelcomeMsg(), true);
		Asserter.assertEquals(registrationPage.verifyBackupMsg(), true);
		Asserter.assertEquals(registrationPage.verifyRetrieveMsg(), true);
		Asserter.assertEquals(registrationPage.verifyLogOnLink(), true);
		Asserter.assertEquals(registrationPage.verifyRegisterAndDownloadBtn(), true);	
		Asserter.assertEquals(registrationPage.verifyRegisterLink(), true);	
		registrationLicensePage = registrationPage.ClickOnRegisterAndDownloadBtn();
		networkLogonPage = (NetworkLogonPage) registrationLicensePage.clickOnAcceptBtn(true);
		//Asserter.assertEquals(networkLogonPage.verifyTitle(), true);
		registrationCompletePage = NetworkLogin.networklogin(LDAPId, LDAPPass);
		//Asserter.assertEquals(registrationCompletePage.verifyTitle(), true);
		registrationCompletePage.waitForSeconds(5);
		registrationCompletePage.clickOnDownloadSoftware();
		registrationCompletePage.waitForSeconds(30);
		registrationCompletePage.clickOnBeginDownload();
		// Downloading the Agent using the Autoit acripts
		DownloadUtils.handleDownloadDialog("File Download - Security Warning","AgentSetupFile");
		registrationCompletePage.waitForSeconds(20);
		//InstallUtils.installAgent("AgentSetupFile", Email, Password);
		registrationCompletePage.waitForSeconds(20); 
		/*selectBackupAccountPage = (SelectBackupAccountPage) AccountManagementLogin.login(LDAPId, LDAPPass, true);
		if(selectBackupAccountPage.isTextPresent("The following backup accounts are linked to you")){
			 String accountno = selectBackupAccountPage.getAccountNumber(accountRow+1);
			 accMgmtHomePage = selectBackupAccountPage.clickOnSelectAccount(accountRow);
			 accMgmtHomePage.isTitlePresent("SummaryPageTitle");
			 accMgmtHomePage.isTextPresentFailOnNotFound("ViewProfileLinkText");
			 editProfilePage = accMgmtHomePage.clickOnViewProfile();
		} else
		{
		AccountManagementLogin.login(LDAPId, LDAPPass);
		accMgmtHomePage.isTextPresentFailOnNotFound("ViewProfileLinkText");
		editProfilePage = accMgmtHomePage.clickOnViewProfile();
		}
		AccountManagementLogin.logout();*/
		
	}

	@AfterMethod
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}	
}

