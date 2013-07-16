package com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.accounts;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.thoughtworks.selenium.Selenium;

public class ChangeAccountStatusPage extends AccountsHeaderPage {

	public ChangeAccountStatusPage(Selenium sel){
		selenium =sel;
	}
	
	public void checkActiveRadioButton(){
		check("//input[@value='A']");
	}
	public void checkCanceledRadioButton(){
		check("//input[@value='C']");
	}
	public void checkObHoldRadioButton(){
		check("//input[@value='H']");
	}
	public void selectDisplayMessage(String message){
		if(! getSelectedLabel("chosenmessage").equalsIgnoreCase(message)){
			select("chosenmessage", "label=" + message);
		}
	}
	public void typeJustificationMessage(String message){
		type("justification", message);
	}	
	public AccountSummaryPage clickOnChangeStatusNowButton(){
		click("ChangeStstusButton");
		waitForSecond();
		return (AccountSummaryPage) PageFactory.getNewPage(AccountSummaryPage.class);
	}
	
}
