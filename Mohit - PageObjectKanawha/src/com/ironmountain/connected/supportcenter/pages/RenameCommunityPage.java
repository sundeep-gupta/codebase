package com.ironmountain.connected.supportcenter.pages;

import org.apache.log4j.Logger;
import org.openqa.selenium.By;

import com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium.WebDriverPage;

public class RenameCommunityPage extends WebDriverPage{
	private static final Logger logger = Logger.getLogger(RenameCommunityPage.class.getName());
		
	public RenameCommunityPage () throws Exception {
		super();
	}
	
	public void waitForPageLoad() throws Exception {
		waitForElementPresent("name:204", 1, 20);
	}
	public void typeCommunityName(String communityName) {
		findElement(getDriver(), By.name("communityname")).clear();
		findElement(getDriver(), By.name("communityname")).sendKeys(communityName);
	}

	public void clickSave() {
		findElement(getDriver(), By.name("204")).click();
	}
}
