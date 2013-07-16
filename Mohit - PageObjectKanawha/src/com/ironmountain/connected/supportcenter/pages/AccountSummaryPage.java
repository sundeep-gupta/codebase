package com.ironmountain.connected.supportcenter.pages;

import org.openqa.selenium.By;

import com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium.WebDriverPage;

/** Kanawha Login Page
 * @author pjames
 *
 */
public class AccountSummaryPage extends WebDriverPage{
	
	protected String ACSUMMARY_PAGE_REF = "AcSummaryPage.";
	
	public AccountSummaryPage () throws Exception {
		super();
	}
	public String getAccountStatus() throws InterruptedException {
		String loc = getLocator(ACSUMMARY_PAGE_REF+"AccountStatusValue");
		waitForElementPresent("xpath:"+getLocator(ACSUMMARY_PAGE_REF+"AccountStatusValue"),1,20);
		return findElement(getDriver(),By.xpath(loc)).getText();
	}
}

