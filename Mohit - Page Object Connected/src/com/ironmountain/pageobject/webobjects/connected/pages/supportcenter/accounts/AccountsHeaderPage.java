package com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.accounts;

import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.thoughtworks.selenium.Selenium;

/**
 * @author jinesh devasia
 * 
 * Super class for all pages in the accounts section. This is to get access to the toolbar/header tab 
 * which will be displayed with all the pages in the accounts section.
 *
 */
public class AccountsHeaderPage extends SeleniumPage {

	public AccountsHeaderPage() {
	}
	public AccountsHeaderPage(Selenium sel) {
		selenium =sel;
	}

	public void clickOnTools(){
		click("2");
	}
	public void clickOnChangeStatus(){
		selectFrame("NodeDetails");
		clickAndWaitForPageLoad("HM_Item2_3");
	}
}
