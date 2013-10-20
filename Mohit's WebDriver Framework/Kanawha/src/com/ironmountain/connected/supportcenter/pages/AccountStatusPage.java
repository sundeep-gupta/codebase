package com.ironmountain.connected.supportcenter.pages;

import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.support.PageFactory;

import com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium.WebDriverPage;

public class AccountStatusPage extends WebDriverPage{
	private static final Logger logger = Logger.getLogger(AccountStatusPage.class.getName());
	protected String ACSTATUS_PAGE_REF = "AcStatusPage.";
	
	public AccountStatusPage () throws Exception {
		super();
	}
	
	public AccountSummaryPage changeAccountStatus(String option, String message) throws Exception {
		clickStatusOption(option);
		typeJustificationMessage(message);
		Thread.sleep(500);
		AccountSummaryPage acSummaryPage = clickChangeStatus();
		return acSummaryPage;
	}
	public void clickStatusOption(String option) throws Exception {
		
		if(option.equals("Active")) {
			findElement(getDriver(),By.xpath(getLocator(ACSTATUS_PAGE_REF+"Active"))).click();
		}else if(option.equals("Canceled")) {
			findElement(getDriver(),By.xpath(getLocator(ACSTATUS_PAGE_REF+"Cancel"))).click();
		}else if(option.equals("On Hold")) {
			findElement(getDriver(),By.xpath(getLocator(ACSTATUS_PAGE_REF+"OnHold"))).click();
		}else {
			throw new Exception("Unrecognised Account Status option specified: " + option);
		}
	}
	
	public void typeJustificationMessage(String message) {
		String messageBox = getLocator(ACSTATUS_PAGE_REF+"JustificationMessageBox");
		findElement(getDriver(),By.xpath(messageBox)).sendKeys(message);
	}
	
	public AccountSummaryPage clickChangeStatus() {
		String ChangeStatusButton = getLocator(ACSTATUS_PAGE_REF+"ChangeStatusButton");
		clickAndWaitForPageLoad(getDriver().findElement(By.id(ChangeStatusButton)),5);
		return (AccountSummaryPage) PageFactory.initElements(getDriver(), AccountSummaryPage.class);
	}
}
