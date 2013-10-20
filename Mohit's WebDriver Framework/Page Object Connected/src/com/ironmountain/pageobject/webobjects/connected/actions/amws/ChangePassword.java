package com.ironmountain.pageobject.webobjects.connected.actions.amws;

import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.ChangePasswordPage;

public class ChangePassword {

	/**
	 * Change the password to a new password.
	 * 
	 * @param emailAddress
	 * @param oldPassword
	 * @param newPassword
	 * @param confirmNewPassword
	 * @return
	 * @throws Exception
	 */
	public static ChangePasswordPage chagePassword(String oldPassword, String newPassword, String confirmNewPassword) throws Exception{
		ChangePasswordPage changePasswordPage = AccountManagementNavigation.viewChagePasswordPage();
		changePasswordPage.typeOldPassword(oldPassword);
		changePasswordPage.typeNewPassword(newPassword);
		changePasswordPage.typeConfirmNewPassword(confirmNewPassword);
		return changePasswordPage.clickOnSaveButton();		
	}
	
	
}
