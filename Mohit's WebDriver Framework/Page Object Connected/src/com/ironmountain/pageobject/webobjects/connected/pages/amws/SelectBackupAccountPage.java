package com.ironmountain.pageobject.webobjects.connected.pages.amws;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.thoughtworks.selenium.Selenium;

/**
 * @author Jinesh Devasia
 *
 */
public class SelectBackupAccountPage extends SeleniumPage {

	public SelectBackupAccountPage(Selenium sel)
	{
		selenium =sel;
	}
	public AccountManagementHomePage clickOnSelectAccount(String accountRowId)
	{
		clickAndWaitForPageLoad("selectAccountForm:accountTable:"+ accountRowId +":_idJsp36");
		return (AccountManagementHomePage) PageFactory.getNewPage(AccountManagementHomePage.class);
	}
	
	public String getAccountNumber(String accountRow){
		return getText("//tbody[@id='selectAccountForm:accountTable:tbody_element']/tr[" + accountRow + "]/td[2]");
	}
	
	public boolean verfiryTitle(){
		String title = getLocator("SelectBackupAccountAccountPageTitle");
		String res = getTitle();
		if (res.contains(title)){
			return true;
		} else return false;
		
	}
}
