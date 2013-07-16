package com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.pcagentrulesets;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.thoughtworks.selenium.Selenium;

public class PCAgentCreateRuleSetGeneralPage extends PCAgentRuleSetsPage{

	
	public PCAgentCreateRuleSetGeneralPage(Selenium sel) {
		selenium = sel;
	}
	
	public void typeRuleSetName(String name){
		type("name", name);
	}
	public void typeRuleSetDescription(String desc){
		type("description", desc);
	}
	public void typeDrivesToSkipDuringBackup(String drives){
		type("skipPathTx", drives);
	}
	
	public PCAgentCreateRuleSetRulesPage clickOnNextButton(){
		click("NextBtn");
		waitForSeconds(15);
		return (PCAgentCreateRuleSetRulesPage) PageFactory.getNewPage(PCAgentCreateRuleSetRulesPage.class);
	}
	public PCAgentCreateRuleSetRulesPage clickOnFinishRuleSetButton(){
		click("FinishBtn");
		waitForSeconds(5);
		return (PCAgentCreateRuleSetRulesPage) PageFactory.getNewPage(PCAgentCreateRuleSetRulesPage.class);
	}
	
	public void clickOnCancelButton(){
		click("CancelBtn");
		waitForSeconds(2);
	}

}
