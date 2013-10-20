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
public class RegistrationDetailsPageTest extends AccountManagementTest {
	

	@BeforeMethod
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		TestDataProvider.reloadTestData(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" );
		}
	
	
	/** Tests to verify the edit fields on the Enter Registration Details page.
	 * @throws Exception
	 */
	@Test(enabled = true, groups= {"amws","mat", "RegistrationAndDownload"})	
	public void testEnterDetailsPage() throws Exception{
		
		//Navigate to Enter details page
		enterRegistrationDetailsPage = AccountManagementNavigation.viewEnterRegistrationDetails();
		Assert.assertEquals(enterRegistrationDetailsPage.isFirstNameEditable(), true);
		Assert.assertEquals(enterRegistrationDetailsPage.isLastNameEditable(), true);
		Assert.assertEquals(enterRegistrationDetailsPage.isMiddleNameEditable(), true);
		Assert.assertEquals(enterRegistrationDetailsPage.isEmailEditable(), true);
		Assert.assertEquals(enterRegistrationDetailsPage.isPasswordEditable(), true);
		Assert.assertEquals(enterRegistrationDetailsPage.isConfirmPasswordEditable(), true);
		Assert.assertEquals(enterRegistrationDetailsPage.isCompanyEditable(), true);
		Assert.assertEquals(enterRegistrationDetailsPage.isCountryEditable(), true);
		Assert.assertEquals(enterRegistrationDetailsPage.isAddressLine1Editable(), true);
		Assert.assertEquals(enterRegistrationDetailsPage.isAddressLine2Editable(), true);
		Assert.assertEquals(enterRegistrationDetailsPage.isCityEditable(), true);
		Assert.assertEquals(enterRegistrationDetailsPage.isStateEditable(), true);
		Assert.assertEquals(enterRegistrationDetailsPage.isZipCodeEditable(), true);
		Assert.assertEquals(enterRegistrationDetailsPage.isPhoneNumberEditable(), true);
	}	
		
	@AfterMethod
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}	
}
