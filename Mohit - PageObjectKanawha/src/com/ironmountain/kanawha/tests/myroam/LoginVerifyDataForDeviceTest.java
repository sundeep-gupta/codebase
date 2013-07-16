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
public class LoginVerifyDataForDeviceTest extends KanawhaTest{
	private static final Logger logger = Logger.getLogger(LoginVerifyDataForDeviceTest.class.getName());
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
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
	public void loginVerifyDataForDevice(String username, String password) throws Exception {		
		KanawhaHomePage homePage = KanawhaLoginPage.login(username, password);
		homePage.waitForPageLoad();
		MyRoamPage myRoamPage = homePage.goToMyRoamPage();
		
		String deviceName = CommonUtils.getDeviceName(username);
		waitForDevice(myRoamPage, deviceName, 20);
		String selectedDevice = myRoamPage.getSelectedDevice();
		Assert.assertEquals(selectedDevice, deviceName, "Unexpected device selected");
		
		myRoamPage.verifyBackupDatesList(username);
		myRoamPage.verifyBackupData();
	}

	@AfterMethod(alwaysRun= true)
	public void stopTest() throws Exception {
		super.stopWebDriverTest();
	}
	
	private void waitForDevice(MyRoamPage myRoamPage, String device, int iterations) throws Exception {
		logger.info("Waiting for device="+device);
		for(int i = 0 ; i < iterations ; i++) {
			if(myRoamPage.getSelectedDevice().equals(device)) {
				return;
			}
			Thread.sleep(1000);
		}
	}
}
