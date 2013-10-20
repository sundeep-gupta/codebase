package com.ironmountain.connected.supportcenter.pages;

import org.apache.log4j.Logger;
import org.openqa.selenium.By;

import com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium.WebDriverPage;

public class CommunityStatusPage extends WebDriverPage{
	private static final Logger logger = Logger.getLogger(CommunityStatusPage.class.getName());
		
	public CommunityStatusPage () throws Exception {
		super();
	}
	
	public void waitForPageLoad() throws Exception {
		logger.info("Waiting for Community Status title...");
		waitForElementPresent("xpath://th[text()='Community Status']", 1, 20);
		logger.info("Waiting for Community Status title complete.");
	}
	public void typeCommunityName(String communityName) {
		findElement(getDriver(), By.name("communityname")).clear();
		findElement(getDriver(), By.name("communityname")).sendKeys(communityName);
	}

	public void clickSave() {
		findElement(getDriver(), By.name("204")).click();
	}
}
