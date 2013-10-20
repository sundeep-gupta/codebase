package com.ironmountain.pageobject.webobjects.connected.pages.supportcenter;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.thoughtworks.selenium.Selenium;

public class CreateAgentSettingsPage extends SeleniumPage {
	
	public CreateAgentSettingsPage(Selenium sel)
	{
		selenium =sel;
		setSpeed("2000");
	}
	public void typeName(String Name){
		type("SupportCenterPage.Name", Name);
	}
	public void typeDescription(String Description){
		type("SupportCenterPage.Desc", Description);
	}
	public void clickOnNextButton(){
		click("SupportCenterPage.NextBtn");
	}
	public void selectDataOnlyBackUp(){
		click("SupportCenterPage.DataOnlyBackUp");
	}
	public void selectPassiveMode(){
		click("SupportCenterPage.PassiveMode");
	}
	public void selectDisableFilterDrivers(){
		click("SupportCenterPage.DisableFilterDrivers");
	}
	public void selectDonotBackupAutomatically(){
		click("SupportCenterPage.DoNotBackUpAutomatically");
	}
	public SupportCenterHomePage clickOnFinishBtn(){
		click("CreateAgentSettings.FinishBtn");
		return (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
	}

}
