package com.ironmountain.kanawha.tests.settings;

import junit.framework.Assert;

import org.apache.log4j.Logger;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.kanawha.pages.KanawhaHomePage;
import com.ironmountain.kanawha.pages.KanawhaLoginPage;
import com.ironmountain.kanawha.pages.SettingsPage;
import com.ironmountain.kanawha.tests.KanawhaTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;

@SeleniumUITest
public class SettingsTest extends KanawhaTest{
	
	private static final Logger logger = Logger.getLogger(SettingsTest.class.getName());
		
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		logger.info("Starting Settings Tests");
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
	public void editAndVerifySettings(String username, String password) throws Exception {
		
		logger.info("Started verifySettings test");
		
		logger.info("Login and verify the default Settings and then set dialup to true and taskbar icon to false");
		super.initKanawhaTest("firefox");
		KanawhaHomePage homePage = KanawhaLoginPage.login(username, password);	
		homePage.waitForPageLoad();
		logger.info("Logged in to Webapp");
		Assert.assertEquals("Invalid text found or no text found under Settings link", true, homePage.isElementPresent("xpath:"+homePage.getLocator("HomePage.SettingsText")));
		SettingsPage settingsPage = homePage.gotoSettingsPage();
		settingsPage.waitForPageLoad();
		logger.info("On Settings Page");
		verifySettingsPageItems(settingsPage);
		verifySettings(settingsPage,false,false,true);
		clickSettings(settingsPage,true,false,true);
		saveAndVerifyDialogMessage(settingsPage);
		
		logger.info("Now verify if dialup option was set to true, taskbar icon was set to false and then set manual backup to true and save it");
		homePage = settingsPage.gotoHomePage();
		homePage.waitForPageLoad();
		settingsPage = homePage.gotoSettingsPage();
		settingsPage.waitForPageLoad();
		logger.info("On Settings Page");
		verifySettingsPageItems(settingsPage);
		verifySettings(settingsPage,true,false,false);
		clickSettings(settingsPage,false,true,false);
		saveAndVerifyDialogMessage(settingsPage);
		
		logger.info("Now verify if both dialup and manual backup over dialup option were set to true, taskbar icon is set to false and then set both dialup and manual backup to false, taskbar icon to true and save it");
		homePage = settingsPage.gotoHomePage();
		homePage.waitForPageLoad();
		settingsPage = homePage.gotoSettingsPage();
		settingsPage.waitForPageLoad();
		logger.info("On Settings Page");
		verifySettingsPageItems(settingsPage);
		verifySettings(settingsPage,true,true,false);
		clickSettings(settingsPage,true,true,true);
		saveAndVerifyDialogMessage(settingsPage);
		
		logger.info("Now verify if both dialup and manual backup over dialup option was set to false and showtaskbar icon is set to true");
		homePage = settingsPage.gotoHomePage();
		homePage.waitForPageLoad();
		settingsPage = homePage.gotoSettingsPage();
		settingsPage.waitForPageLoad();
		logger.info("On Settings Page");
		verifySettingsPageItems(settingsPage);
		verifySettings(settingsPage,false,false,true);
	}
	
	public void verifySettingsPageItems(SettingsPage settingsPage) {
		Assert.assertEquals("Invalid Settings Tab title found", "Settings", settingsPage.getSettingsTabTitle());
		Assert.assertEquals("Invalid Dialup Settings title found", "Dialup Options", settingsPage.getDialupSettingsTitle());
		Assert.assertEquals("Invalid Taskbar Settings title found", "Taskbar", settingsPage.getTaskbarSettingsTitle());
		Assert.assertEquals("Save Button not found", true, settingsPage.isElementPresent("xpath:"+settingsPage.getLocator("SettingsPage.SaveButton")));
		logger.info("Verified items on Settings Page");
	}
	
	public void verifySettings(SettingsPage settingsPage, Boolean dialupStatus, Boolean manOverDialupStatus, Boolean showTaskbarIconStatus) {
		logger.info("DialupOption="+settingsPage.getBackupOverDialupOptionStatus()+" MBoDUO="+settingsPage.getManualBackupOverDialupOptionStatus()+" ShowTaskbarOption="+settingsPage.getShowTaskbarIconOptionStatus());
		Assert.assertEquals("Invalid Dialup options status", dialupStatus.booleanValue(), settingsPage.getBackupOverDialupOptionStatus());
		Assert.assertEquals("Invalid Manual backup over dialup option status", manOverDialupStatus.booleanValue(), settingsPage.getManualBackupOverDialupOptionStatus());
		Assert.assertEquals("Invalid ShowTaskbarOption status", showTaskbarIconStatus.booleanValue(), settingsPage.getShowTaskbarIconOptionStatus());
	}
	
	public void clickSettings(SettingsPage settingsPage, Boolean dialupOption, Boolean manOverDialupOption, Boolean showTaskbarIconOption) {
		if(dialupOption) { logger.info("Click BackupOverDialupOption"); settingsPage.clickBackupOverDialupOption(); }
		if(manOverDialupOption) { logger.info("Click ManualBackupOverDialupOption"); settingsPage.clickManualBackupOverDialupOption(); }
		if(showTaskbarIconOption) { logger.info("Click ShowTaskbarIconOption");	settingsPage.clickShowTaskbarIconOption(); }
	}
	
	public void saveAndVerifyDialogMessage(SettingsPage settingsPage) throws InterruptedException {
		logger.info("clickSaveButton");
		settingsPage.clickSaveButton();
		Thread.sleep(2000);
		settingsPage.waitForElementPresent("xpath:"+settingsPage.getLocator("SettingsPage.StatusDialogOKButton"), 1, 10);
		Assert.assertEquals("Invalid Status Message", "All settings saved successfully.", settingsPage.getStatusDialogMessage());
		settingsPage.clickOKOnStatusDialog();
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception {
		super.stopWebDriverTest();
	}
	
	@AfterSuite(alwaysRun=true)
	@Parameters( {"username", "password"})
	public void stopSuite(String username, String password) throws Exception {
		//activateAccount(username, password);
	}

}
