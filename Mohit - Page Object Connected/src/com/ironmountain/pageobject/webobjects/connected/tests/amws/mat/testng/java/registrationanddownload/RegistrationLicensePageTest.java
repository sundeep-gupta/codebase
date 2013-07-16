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
public class RegistrationLicensePageTest extends AccountManagementTest {
	
	
	@BeforeMethod
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		TestDataProvider.reloadTestData(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" );
		}
	
	/** Tests to verify the license page.
	 * @throws Exception
	 */
	@Test(enabled = true, groups= {"amws","mat", "RegistrationAndDownload"})
	public void testRegistrationLicensePage() throws Exception{
		
		 registrationPage = AccountManagementNavigation.viewRegistrationPage();
		 registrationLicensePage = registrationPage.ClickOnRegisterAndDownloadBtn();
		 Assert.assertEquals(registrationLicensePage.getUrl(), true);
		 Assert.assertEquals(registrationLicensePage.getLicenseText(), true);
		 Assert.assertEquals(registrationLicensePage.verifyAcceptBtn(), true);
		 Assert.assertEquals(registrationLicensePage.verifyDeclineBtn(), true);
}

	@AfterMethod
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}
}
