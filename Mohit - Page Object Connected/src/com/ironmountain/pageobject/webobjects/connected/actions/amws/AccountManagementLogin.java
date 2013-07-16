package com.ironmountain.pageobject.webobjects.connected.actions.amws;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.AccountManagementHomePage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.AccountManagementLoginPage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.SelectBackupAccountPage;


public class AccountManagementLogin {

	public static AccountManagementHomePage login(String email, String password) throws Exception
	{
		AccountManagementLoginPage accLoginPage = (AccountManagementLoginPage) PageFactory.getNewPage(AccountManagementLoginPage.class);
		if(! accLoginPage.isRelogin()){
			accLoginPage.open(PropertyPool.getProperty("accountmanagementappendurl"));
		}
		accLoginPage.typeEmailAddress(email);
		accLoginPage.typePassword(password);
		return (AccountManagementHomePage)accLoginPage.clickOnLogOnButton();		
	}
	public static SeleniumPage login(String email, String password, Boolean isMultiAccount) throws Exception
	{
		AccountManagementLoginPage accLoginPage = (AccountManagementLoginPage) PageFactory.getNewPage(AccountManagementLoginPage.class);
		if(! accLoginPage.isRelogin()){
			accLoginPage.open(PropertyPool.getProperty("accountmanagementappendurl"));
		}
		accLoginPage.typeEmailAddress(email);
		accLoginPage.typePassword(password);
		if(isMultiAccount)
		{
			return (SelectBackupAccountPage)accLoginPage.clickOnLogOnButton(isMultiAccount);
		}
		else{
			return (AccountManagementHomePage)accLoginPage.clickOnLogOnButton();
		}				
	}
	
	public static AccountManagementLoginPage logout() throws Exception
	{
		AccountManagementHomePage accMgmtHomePage = (AccountManagementHomePage) PageFactory.getNewPage(AccountManagementHomePage.class);
		return (AccountManagementLoginPage) accMgmtHomePage.clickOnLogOff();
	}	
	
	
}
