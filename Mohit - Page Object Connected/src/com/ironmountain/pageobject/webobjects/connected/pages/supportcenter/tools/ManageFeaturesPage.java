package com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.tools;


import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.thoughtworks.selenium.Selenium;

public class ManageFeaturesPage extends SeleniumPage {

	public ManageFeaturesPage(Selenium sel) {
		selenium = sel;
	}
	
	public void clickOnMyRoamEnabledRadioButton(){
		click("PCMyRoamState");
	}
    public void clickOnMyRoamDisabledRadioButton(){
		click("//input[@name='PCMyRoamState' and @value='12']");
	}
    public void clickOnConnectedEmailOptimizerEnabledRadioButton(){
		click("PCEmailOptimizerState");
	}
    public void clickOnConnectedEmailOptimizerDisabledRadioButton(){
    	click("//input[@name='PCEmailOptimizerState' and @value='22']");
	}
    public ManageFeaturesPage clickOnSaveButton(){
    	clickAndWaitForPageLoad("//input[@value='Save']");
    	return (ManageFeaturesPage) PageFactory.getNewPage(ManageFeaturesPage.class);
    }
	
}
