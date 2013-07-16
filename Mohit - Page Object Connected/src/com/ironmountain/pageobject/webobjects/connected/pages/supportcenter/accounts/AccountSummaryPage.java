package com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.accounts;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.AccountManagementLoginPage;
import com.thoughtworks.selenium.Selenium;

public class AccountSummaryPage extends AccountsHeaderPage {

	public AccountSummaryPage(Selenium sel){
		selenium = sel;
	}

	public ChangeAccountStatusPage clickOnAccountStatusLink(){
		click("//u");
		waitForSeconds(2);
		return (ChangeAccountStatusPage) PageFactory.getNewPage(ChangeAccountStatusPage.class);
	}
	
	public AccountManagementLoginPage clickOnAccessUsersAccountOnlineLink(){
		//click("//a[contains(@onclick, 'javascript:top.document.SSWSWindow')]");		
		//waitForPopUp("SSWS");
		click("//td[3]/a/u");
		try {
			Thread.sleep(30000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		selectWindow("SSWS");
		return (AccountManagementLoginPage) PageFactory.getNewPage(AccountManagementLoginPage.class);
	}
	
}
