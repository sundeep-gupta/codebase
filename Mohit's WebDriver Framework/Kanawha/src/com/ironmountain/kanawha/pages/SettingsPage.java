package com.ironmountain.kanawha.pages;

import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.support.PageFactory;

import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium.WebDriverPage;

/** Settings Page
 * @author msompura
 *
 */
public class SettingsPage extends WebDriverPage {
	
	private static final Logger logger = Logger.getLogger(SettingsPage.class.getName());

	String loc = null;
	
	
	public SettingsPage() throws Exception {
		super();
		driver = getDriver();
	}

	public SettingsPage refreshPage() {
		this.refresh();
		return (SettingsPage) PageFactory.initElements(getDriver(), SettingsPage.class);
	}
	
	public String getDialupSettingsTitle() {
		return findElement(getDriver(),By.xpath(getLocator("SettingsPage.DialupSettingsTitle"))).getText();
	}
	
	public String getTaskbarSettingsTitle() {
		return findElement(getDriver(),By.xpath(getLocator("SettingsPage.TaskbarSettingsTitle"))).getText();
	}
	
	public String getSettingsTabTitle() {
		return findElement(getDriver(),By.xpath(getLocator("SettingsPage.SettingsTabTitle"))).getText();
	}
	
	public boolean getBackupOverDialupOptionStatus() {
		return findElement(getDriver(),By.id(getLocator("SettingsPage.BackupOverDialupOption"))).isSelected();
	}
	
	public boolean getManualBackupOverDialupOptionStatus() {
		return findElement(getDriver(),By.id(getLocator("SettingsPage.ManualBackupOverDialupOption"))).isSelected();
	}
	
	public boolean getShowTaskbarIconOptionStatus() {
		return findElement(getDriver(),By.id(getLocator("SettingsPage.ShowTaskbarIconOption"))).isSelected();
	}
	
	public void clickBackupOverDialupOption() {
		findElement(getDriver(),By.id(getLocator("SettingsPage.BackupOverDialupOption"))).click();
	}
	
	public void clickManualBackupOverDialupOption() {
		findElement(getDriver(),By.id(getLocator("SettingsPage.ManualBackupOverDialupOption"))).click();
	}
	
	public void clickShowTaskbarIconOption() {
		findElement(getDriver(),By.id(getLocator("SettingsPage.ShowTaskbarIconOption"))).click();
	}
	
	public void waitForPageLoad() throws InterruptedException {
		logger.info("Waiting for Settings Tab Title on Settings Page");
		waitForElementPresent("xpath:"+getLocator("SettingsPage.SettingsTabTitle"),1,20);
	}
	
	public String getStatusDialogMessage() {
		return findElement(getDriver(),By.xpath(getLocator("SettingsPage.StatusDialogMessage"))).getText();
	}
	
	public void clickOKOnStatusDialog() {
		findElement(getDriver(),By.xpath(getLocator("SettingsPage.StatusDialogOKButton"))).click();
	}
	
	public void clickSaveButton() {
		findElement(getDriver(),By.xpath(getLocator("SettingsPage.SaveButton"))).click();
	}
	
	public KanawhaLoginPage logoff() {
		//clickAndWaitForPageLoad(findElement(getDriver(),By.linkText("Logout")),20);
		String logoffUrl = PropertyPool.getProperty("kanawhaprotocol") + "://" + PropertyPool.getProperty("kanawhaurl") +"/"+ PropertyPool.getProperty("kanawhalogoffurl");
		logger.info("Opening logoff URL - " + logoffUrl);
		getDriver().get(logoffUrl);
		return (KanawhaLoginPage) PageFactory.initElements(getDriver(), KanawhaLoginPage.class);
	}
	
	public KanawhaHomePage gotoHomePage() {
		findElement(getDriver(),By.xpath(getLocator("SettingsPage.HomeLink"))).click();
		return (KanawhaHomePage) PageFactory.initElements(getDriver(), KanawhaHomePage.class);
	}
}
