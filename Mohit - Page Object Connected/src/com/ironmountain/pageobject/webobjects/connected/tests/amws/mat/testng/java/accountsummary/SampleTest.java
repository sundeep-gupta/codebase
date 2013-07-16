package com.ironmountain.pageobject.webobjects.connected.tests.amws.mat.testng.java.accountsummary;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.framework.utils.ClassUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.Registration;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;


@SeleniumUITest
public class SampleTest extends AccountManagementTest{

	
	@BeforeMethod
	public void startTest() throws Exception {
		super.initAccountManagementTest();
	}

	/**
	 * Tests to verify the summary page
	 * 
	 * @param Email
	 * @param Password
	 * @throws Exception
	 */
	@Test(enabled = true, groups = { "amws", "mat", "accountsummary" })
	public void testSummaryPage() throws Exception {
		String dataFolder = FileUtils.getBaseDirectory() + "\\" + PropertyPool.getProperty("accountmanagementtestdatadir") + "\\amwsdataprovider.xml";
		System.out.println(dataFolder);
		TestDataProvider.setTestDataToXmlFile(dataFolder, "RegistrationURl", "https:\\xyz.com");
		TestDataProvider.setTestDataToXmlFile(dataFolder, "RegistrationURl2", "https:\\xyz.co78484m");
		TestDataProvider.setTestDataToXmlFile(dataFolder, "RegistrationURl3", "https:\\xyz.com487");

	}

	@AfterMethod
	public void stopTest() throws Exception {
		super.stopSeleniumTest();
	}
	
	
}


