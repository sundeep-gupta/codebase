package com.ironmountain.connected.supportcenter.pages;

import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.support.PageFactory;

import com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium.WebDriverPage;

public class ApplyBrandingResultPage extends WebDriverPage{
	private static final Logger logger = Logger.getLogger(ApplyBrandingResultPage.class.getName());
		
	public ApplyBrandingResultPage () throws Exception {
		super();
	}
	
	public void waitForPageLoad() throws Exception {
		logger.info("Waiting for OK button");
		waitForElementPresent("id:okbutton", 1, 180);
		logger.info("Wait for OK button complete."+isElementPresent(getDriver(),By.id("okbutton")));
	}
	
	public String getApplyBrandingResultMessage() throws Exception {
		logger.info(findElement(getDriver(),By.xpath("//td[2]")).getText());
		return findElement(getDriver(),By.xpath("//td[2]")).getText();
	}
	
	public void clickOK() {
		findElement(getDriver(), By.id("okbutton")).click();
	}
	
	public String getResetBrandingResultMessage() throws Exception {
		logger.info(findElement(getDriver(),By.xpath("//td[2]")).getText());
		return findElement(getDriver(),By.xpath("//td[2]")).getText();
	}
}
