package com.ironmountain.pageobject.webobjects.connected.pages.supportcenter;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.thoughtworks.selenium.Selenium;

/**PC Agent Configuration Summary Page Object
 * @author pjames
 *
 */
public class PCAgentConfigSummaryPage extends SeleniumPage {
	

	public PCAgentConfigSummaryPage(Selenium sel)
	{
		selenium =sel;
		setSpeed("2000");
	}
	
	public void clickOnSummary(){
		click("PCAgentSummaryPage.Summary");
		
	}
	
	public boolean verifyNodeHeader(){
		String res = getText("PCConfigurationPage.NodeHeader");
		if (res.contains("Default\\PC CONFIGURATIONS")){
			return true;
		} else {
			return false;
		}
	}
	
	public void clickOnEditConfigOptions(){
		click("PCAgentSummaryPage.EditConfigOptionLink");
	}
	
	public void unCheckUseInheritedConfig(){
		//String loc = getLocator("PCAgentConfigSummaryPage.UseDefaultSettings");
		//selenium.uncheck(loc);
		/*
		 * This is to enable the button
		 */
		check("PCAgentConfigSummaryPage.UseDefaultSettings");
		unCheck("PCAgentConfigSummaryPage.UseDefaultSettings");
		//refreshPage();
	}
	public void clickOnSaveAndDeployBtn(){
		click("PCAgentConfigSummaryPage.SaveAndDeployBtn");
		//refreshPage();
	}
	public SupportCenterHomePage clickOnOKBtn(){
	try {
		click("PCAgentConfigSummary.OKBtn");
		}
		catch (Exception e){
			System.out.println(e);
		}
		waitForSecond();
		return (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);		
	}
	
	public PCAgentConfigCreatePage clickOnCreateLink(){
		click("PCAgentSummaryPage.Create");
		return (PCAgentConfigCreatePage) PageFactory.getNewPage(PCAgentConfigCreatePage.class);	
	}

}
