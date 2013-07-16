package com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.accounts;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.thoughtworks.selenium.Selenium;

public class AccountSearchPage extends SeleniumPage {

	public AccountSearchPage(Selenium sel) {
		selenium = sel;
	}

	public void typeSearchForText(String accountNo){
		type("SearchValue", accountNo);
	}
	public AccountSummaryPage clickOnSearchButton(){
		click("button1");
		waitForSeconds(4);
		selectMainWindow();		
		return (AccountSummaryPage) PageFactory.getNewPage(AccountSummaryPage.class);
	}
	
	public void clickOnAdvancedSearchButton(){
		click("AdvancedSearchExpand");
		waitForSecond();
	}
}
