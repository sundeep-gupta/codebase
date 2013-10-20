package com.ironmountain.pageobject.webobjects.connected.pages.amws;

import com.ironmountain.pageobject.pageobjectrunner.framework.LocatorPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.thoughtworks.selenium.Selenium;

/**
 * @author Jinesh Devasia
 *
 */
public class AccountManagementLoginPage extends SeleniumPage {

	private static final String loginPageTitle = LocatorPool.getLocator("LoginPageTitle");
	
	public AccountManagementLoginPage(Selenium sel)
	{
		selenium = sel;	
	}
	
	public boolean isRelogin(){
		if(getTitle().contains(loginPageTitle))
		    return true;
		else
			return false;
	}
	
	public void typeEmailAddress(String emailAddress)
	{
		type("loginForm:email", emailAddress);
	}
	public void typePassword(String password)
	{
		type("loginForm:password", password);
	}
	public AccountManagementHomePage clickOnLogOnButton() throws Exception
	{
		clickAndWaitForPageLoad("loginForm:submit");
		return (AccountManagementHomePage) PageFactory.getNewPage(AccountManagementHomePage.class);
	}
	public SeleniumPage clickOnLogOnButton(boolean isMultiAccount) throws Exception
	{
		clickAndWaitForPageLoad("loginForm:submit");
		if(isMultiAccount){
			return (SelectBackupAccountPage) PageFactory.getNewPage(SelectBackupAccountPage.class);
		}
		else{
			return (AccountManagementHomePage) PageFactory.getNewPage(AccountManagementHomePage.class);

		}
	}
	
}
