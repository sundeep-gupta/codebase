package com.ironmountain.pageobject.webobjects.connected.pages.supportcenter;

import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.thoughtworks.selenium.Selenium;

public class ConfigurationStatusPage extends SeleniumPage {
	
	public ConfigurationStatusPage (Selenium sel)
	{
		selenium =sel;
		setSpeed("1000");
	}
	
	public void clickOnStatusLink(){
		click("ConfigurationStatusPage.StatusLink");
	}

}
