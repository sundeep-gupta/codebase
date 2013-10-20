package com.ironmountain.pageobject.webobjects.connected.pages.amws;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.thoughtworks.selenium.Selenium;

/**
 * Page class to map the Change Password page
 * 
 * @author Jinesh Devasia
 *
 */
public class ChangePasswordPage extends SeleniumPage {

	private static final String PAGE_NAME_REF = "ChangePasswordPage.";
	
	public ChangePasswordPage(Selenium sel){
		selenium = sel;
	}
		
	/**
	 * Type in to the old password field
	 * 
	 * @param oldPassword
	 */
	public void typeOldPassword(String oldPassword){
		type(PAGE_NAME_REF + "OldPasswordField", oldPassword);
	}
    /**
     * Type in to the new password field
     * 
     * @param newPassword
     */
    public void typeNewPassword(String newPassword){
    	type(PAGE_NAME_REF + "NewPasswordField", newPassword);
	}
    /**
     * Type in to the confirm password field 
     * 
     * @param confirmNewPassword
     */
    public void typeConfirmNewPassword(String confirmNewPassword){
    	type(PAGE_NAME_REF + "ConfirmNewPasswordField", confirmNewPassword);
    }	
    /**
     * Click on save button
     * 
     * @return
     */
    public ChangePasswordPage clickOnSaveButton(){
    	clickAndWaitForPageLoad(PAGE_NAME_REF + "SaveButton");
    	return this;
    }
    /**
     * Click on cancel button and return to editProfile page
     * 
     * @return
     */
    public EditProfilePage clickOnCancelButton(){
    	clickAndWaitForPageLoad(PAGE_NAME_REF + "CancelButton");
    	return (EditProfilePage) PageFactory.getNewPage(EditProfilePage.class);
    }
	
}
