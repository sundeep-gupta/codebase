package com.ironmountain.pageobject.webobjects.connected.tests.amws.mat.testng.java.registrationanddownload;

import java.io.File;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

/** Class that tests the required fields on the Enter Registration Details Page
 * @author Princy James
 *
 */
@SeleniumUITest
public class RegistrationDetailsRequiredFieldsTest extends AccountManagementTest {
	
	
	@BeforeMethod
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		TestDataProvider.reloadTestData(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" );
		}
	
	/** Tests to verify the  required fields on the Enter Registration Details page.
	 * @throws Exception
	 */
	@Test(enabled = true, groups= {"amws","mat", "RegistrationAndDownload"})	
	public void testRequiredFields() throws Exception{
		
		enterRegistrationDetailsPage = AccountManagementNavigation.viewEnterRegistrationDetails();
		enterRegistrationDetailsPage.clickContinue();
		Asserter.assertEquals(enterRegistrationDetailsPage.verifyFirstNameRequiredMsg(), true);
		Asserter.assertEquals(enterRegistrationDetailsPage.verifyLastNameRequiredMsg(), true);
		Asserter.assertEquals(enterRegistrationDetailsPage.verifyEmailRequiredMsg(), true);
		Asserter.assertEquals(enterRegistrationDetailsPage.verifyPasswordRequiredMsg(), true);
		Asserter.assertEquals(enterRegistrationDetailsPage.verifyConfPassRequiredMsg(), true);
	}
	
	@AfterMethod
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}
}
