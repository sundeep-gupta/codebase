package com.ironmountain.kanawha.tests.myroam;

import org.apache.log4j.Logger;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.kanawha.commons.CommonUtils;
import com.ironmountain.kanawha.pages.KanawhaHomePage;
import com.ironmountain.kanawha.pages.KanawhaLoginPage;
import com.ironmountain.kanawha.pages.MyRoamPage;
import com.ironmountain.kanawha.tests.KanawhaTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;

@SeleniumUITest
public class VerifyBackupDatesTest extends KanawhaTest{

	private static final Logger logger = Logger.getLogger(VerifyBackupDatesTest.class.getName());
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		logger.info("Started VerifyBackupDatesTest tests");
		super.initKanawhaTest("firefox");
	}

	/**
	 * Tests to verify the summary page
	 * 
	 * @param Username
	 * @param Password
	 * @throws Exception
	 */
	@Parameters( {"username", "password"})
	@Test(enabled = true)
	public void verifyBackupDatesAndAllData(String username, String password) throws Exception {
		logger.info("Started verifyBackupDatesAndAllData test");
		KanawhaHomePage homePage = KanawhaLoginPage.login(username, password);
		homePage.waitForPageLoad();
		MyRoamPage myRoamPage = homePage.goToMyRoamPage();
		myRoamPage.verifyBackupDatesList(username);
		
		String deviceName = CommonUtils.getDeviceName(username);
		//myRoamPage.selectDevice(deviceName);
		String selectedDevice = myRoamPage.getSelectedDevice();
		Assert.assertEquals(selectedDevice, deviceName, "Unexpected device selected");
		
		myRoamPage.selectDate("Most Recent");
		myRoamPage.verifyBackupData();
		myRoamPage.selectDate("All");
		myRoamPage.verifyBackupData();
	}

	@AfterMethod(alwaysRun= true)
	public void stopTest() throws Exception {
		super.stopWebDriverTest();
	}

}
