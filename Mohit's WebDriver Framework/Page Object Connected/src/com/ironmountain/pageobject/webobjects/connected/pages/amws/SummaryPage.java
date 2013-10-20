package com.ironmountain.pageobject.webobjects.connected.pages.amws;


import com.thoughtworks.selenium.Selenium;

/** Summary Page Object
 * @author pjames
 *
 */
public class SummaryPage extends AccountManagementHomePage {

	public SummaryPage(Selenium sel) {
		selenium = sel;
	}
	
	public boolean verifyTitle(){
		String res = getTitle();
		String val = getLocator("SummaryPageTitle");
		if (res.contains(val)){
			return true;
		} else {
			return false;
		}
	}
	
	public boolean verifyAccountStatus(){
	 return isTextPresent("SummaryPage.AccountStatusText");
	}
	
	public boolean verifyLastBackup(){
		 return isTextPresent("SummaryPage.LastBackupText");
		}
	
	public boolean verifyAccRegisterDate(){
		 return isTextPresent("SummaryPage.AccRegisterDateText");
		}
	
	public boolean verifyViewHistoryTitle(){
		String res = getTitle();
		String val = getLocator("ViewHistoryPageTitle");
		if (res.contains(val)){
			return true;
		} else {
			return false;
		}
	}
	public boolean verifyMyRoamTitle(){
		String res = getTitle();
		String val = getLocator("MyRoamPageTitle");
		if (res.contains(val)){
			return true;
		} else {
			return false;
		}
	}
	public boolean verifyOrderMediaTitle(){
		String res = getTitle();
		String val = getLocator("OrderMediaPageTitle");
		if (res.contains(val)){
			return true;
		} else {
			return false;
		}
	}
	public boolean verifyEditProfileTitle(){
		String res = getTitle();
		String val = getLocator("EditProfilePageTitle");
		if (res.contains(val)){
			return true;
		} else {
			return false;
		}
	}
	public boolean verifyReInstallAgentTitle(){
		String res = getTitle();
		String val = getLocator("ReinstallAgentPageTitle");
		if (res.contains(val)){
			return true;
		} else {
			return false;
		}
	}
	public void clickOnViewHistoryLink(){
		click("SummaryPage.ViewHistoryLink");
		waitForPageLoad("30000");
	}
	public void clickOnMyRoamLink(){
		click("SummaryPage.MyRoamLink");
		waitForPageLoad("30000");
	}
	public void clickOnOrderMediaLink(){
		click("SummaryPage.OrderMediaLink");
		waitForPageLoad("30000");
	}
	public void clickOnEditProfileLink(){
		click("SummaryPage.EditprofileLink");
		waitForPageLoad("30000");
	}
	public void clickOnReInstallAgentLink(){
		click("SummaryPage.ReInstallAgentLink");
		waitForPageLoad("30000");
	}
	public void clickOnSummaryLink(){
		click("SummaryLink");
		waitForPageLoad("30000");
	}
	
	public void clickOnBackToSummaryLink(){
		click("MyRoamPage.BackToSummary");
		waitForPageLoad("30000");
	}
	
}
