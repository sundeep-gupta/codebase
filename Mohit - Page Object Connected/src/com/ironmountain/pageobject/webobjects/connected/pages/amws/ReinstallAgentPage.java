package com.ironmountain.pageobject.webobjects.connected.pages.amws;

import com.thoughtworks.selenium.Selenium;

/**
 * @author Princy James
 *
 */
public class ReinstallAgentPage extends AccountManagementHomePage{

	private static final String PAGE_NAME_REF = "ReinstallAgentPage.";
	
	public ReinstallAgentPage(Selenium sel) {
		selenium =sel;
	}
	
	public boolean verifyTitle(){
		String res = getTitle();
		String val = getLocator("ReinstallAgentPageTitle");
		if ( res.contains(val)){
			System.out.println("true");
			return true;
		} else {
			return false;
		}
		
	}
	
	public void clickOnDownloadSoftwareButton()
	{
		setSpeed("2000");
		click(PAGE_NAME_REF + "DownloadSoftwareButton");
		waitForSeconds(50);
		for(int i=0; i<= 5 ; i++){
			if(isTextPresent("Download Instructions")){
				break;
			}
		}
	}
	public ReinstallAgentPage clickOnBeginDownloadButton()
	{		
		String browser = getEval("navigator.appName");		
		if(browser.equalsIgnoreCase("Microsoft Internet Explorer")){
			click(PAGE_NAME_REF + "BeginDownloadButton");
		}
		else if(browser.equalsIgnoreCase("Netscape")){
			click("instruct_IE6SP1_reinstall:download_button");
		}
		return this;
	}
	


}
