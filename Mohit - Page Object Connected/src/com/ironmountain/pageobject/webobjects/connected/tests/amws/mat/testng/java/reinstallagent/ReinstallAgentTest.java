package com.ironmountain.pageobject.webobjects.connected.tests.amws.mat.testng.java.reinstallagent;

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
import com.ironmountain.pageobject.pageobjectrunner.utils.Executor;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.webobjects.connected.actions.InstallUtils;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.Registration;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;


/**
 * @author pjames
 *
 */
@SeleniumUITest
public class ReinstallAgentTest extends AccountManagementTest {
	
	public static String[] dialog;
	String email =null;
	String password=null;
	
	@BeforeMethod
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		TestDataProvider.reloadTestData(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" );
		email = StringUtils.createNameVal()+"reinstall@cb.com";
		TestDataProvider.setTestDataToXmlFile(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" , "Email", email);
		password = TestDataProvider.getTestData("Password");
	}
	
	@Parameters( {"FirstName", "LastName"})
	@BeforeMethod (alwaysRun=true, dependsOnMethods = {"startTest"})
	public void configureUser(String FirstName, String LastName) throws Exception{
		String registrationUrl = TestDataProvider.getTestData("RegistrationURL");
		Registration.registerUserIfNotPresentWithRegistrationUrl(registrationUrl, FirstName, LastName, email, password, password);
	}
	
	/** Tests to verify the Reinstall Agent feature
	 * @param Email
	 * @param Password
	 * @throws Exception
	 */
	@Test(enabled = true, groups= {"amws","mat", "RegistrationAndDownload"})
	public void testReInstallAgent() throws Exception
			{
				AccountManagementLogin.login(email, password);
				reinstallAgentPage = AccountManagementNavigation.viewReinstallAgentPage();
				reinstallAgentPage.waitForSeconds(5);
				Asserter.assertEquals(reinstallAgentPage.verifyTitle(),true);
				reinstallAgentPage.clickOnDownloadSoftwareButton();
				reinstallAgentPage.clickOnBeginDownloadButton();
				// Downloading the Agent using the Autoit acripts
				DownloadUtils.handleDownloadDialog("File Download - Security Warning","AgentSetupFile");
				reinstallAgentPage.waitForSeconds(20);
				InstallUtils.installAgent("AgentSetupFile",email, password);
			}
	
	@AfterMethod
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}
}
