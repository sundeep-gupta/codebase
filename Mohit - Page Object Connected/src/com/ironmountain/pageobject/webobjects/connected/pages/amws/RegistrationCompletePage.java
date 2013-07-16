package com.ironmountain.pageobject.webobjects.connected.pages.amws;

import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.thoughtworks.selenium.Selenium;

/**
 * @author Princy James
 *
 */
public class RegistrationCompletePage extends SeleniumPage {
	
	public RegistrationCompletePage(Selenium sel)
	{
		selenium = sel;
	}
	/** Method to get the Account Number
	 * @return
	 */
	public String getAccountNum(){
		return getText("CompletePage.AccountNumber");	
	}
	
	/** Method to verify if account num exists
	 * @return
	 */
	public boolean verifyAccNumExists(){
		String res = getAccountNum();
		boolean exists = false;
		if ((res.contains("0"))||(res.contains("1"))||(res.contains("2"))||(res.contains("3"))||(res.contains("4"))
			||(res.contains("5"))||(res.contains("6"))||(res.contains("7"))||(res.contains("8"))||(res.contains("9"))){
			exists = true;
		}
		return exists;
	}
	
	
	/** Method to verify Title
	 * @return
	 */
	public boolean verifyTitle(){
		String res = getTitle();
		String val = getLocator("CompletePageTitle");
		if (res.contains(val)){
			return true;
		} else {
			return false;
		}
	}
	
	/** Method to get Name
	 * @return
	 */
	public String getName(){
		return getText("CompletePage.Name");
	}
	
	/** Method to get EmailAddress
	 * @return
	 */
	public String getEmailAdd(){
		return getText("CompletePage.Email");
	}
	
	/** Method to verify Print Button
	 * @return
	 */
	public boolean verifyPrintBtn(){
		return isElementPresent("CompletePage.Print");
	}
	
	/** Method to verify DownloadSoftware Button
	 * @return
	 */
	public boolean verifyDownloadSoftwareBtn(){
		return isElementPresent("CompletePage.DownloadSoftware");
	}
	
	/** Method to click DownloadSoftware Button
	 * @return
	 */
	public void clickOnDownloadSoftware(){
		click("CompletePage.DownloadSoftware");
		isTextPresent("Download Instructions");
	}

	/** Method to click BeginDownload Button
	 * @return RegistrationCompletePage
	 */
	public RegistrationCompletePage clickOnBeginDownload()
	{		
		//click("CompletePage.download_button");
		String browser = getEval("navigator.appName");		
		if(browser.equalsIgnoreCase("Microsoft Internet Explorer")){
			click("CompletePage.download_button");
		}
		else if(browser.equalsIgnoreCase("Netscape")){
			click("instructionsIE6SP1Form:download_button");
		}
		return this;
	}
}

