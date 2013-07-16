package com.ironmountain.pageobject.webobjects.connected.tests.amws.mat.testng.java.registrationanddownload;

import java.io.File;

import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
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
public class RegistrationDeclineReturnTest extends AccountManagementTest {
	
	
	@BeforeMethod
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		TestDataProvider.reloadTestData(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" );
		}
	
	/** Test to verify the cancel functionality on the Decline page.
	 * @throws Exception
	 */
	@Test(enabled = true, groups= {"amws","mat", "RegistrationAndDownload"})
	public void testReturn() throws Exception{
		
		 registrationDeclinepage = AccountManagementNavigation.viewRegistrationDeclinePage();		 
		 registrationLicensePage = registrationDeclinepage.ClickOnReturnBtn();
		 Assert.assertEquals(registrationLicensePage.verifyAcceptBtn(), true);
	}
	
	@AfterMethod
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}

}
