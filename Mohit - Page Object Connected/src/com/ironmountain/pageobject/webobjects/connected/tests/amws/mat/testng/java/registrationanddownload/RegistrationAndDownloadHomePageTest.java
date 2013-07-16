package com.ironmountain.pageobject.webobjects.connected.tests.amws.mat.testng.java.registrationanddownload;

import java.io.File;

import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;


/** 
 * @author pjames
 * 
 */

@SeleniumUITest
public class RegistrationAndDownloadHomePageTest extends AccountManagementTest {
	
	
	@BeforeMethod
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		TestDataProvider.reloadTestData(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" );
		}
	
	/** Test to verify the Registration Home page
	 * @throws Exception
	 */
	@Test(enabled = true, groups= {"amws","mat", "RegistrationAndDownload"})
	public void testRegistrationUrlPage() throws Exception{
		 registrationPage = AccountManagementNavigation.viewRegistrationPage();
		 Assert.assertEquals(registrationPage.verifyWelcomeMsg(), true);
		 Assert.assertEquals(registrationPage.verifyBackupMsg(), true);
		 Assert.assertEquals(registrationPage.verifyRetrieveMsg(), true);
		 Assert.assertEquals(registrationPage.verifyLogOnLink(), true);
		 Assert.assertEquals(registrationPage.verifyRegisterAndDownloadBtn(), true);	
		 Assert.assertEquals(registrationPage.verifyRegisterLink(), true);	
	}

	@AfterMethod
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}	
}
