package com.ironmountain.pageobject.webobjects.connected.actions.amws;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.EditProfilePage;

public class EditProfile {

	/**
	 * To enter the values for the name fields in the edit profile page. 
	 * Note that this version may not be save the page after entering the values.
	 * 
	 * @param firstname
	 * @param middlename
	 * @param lastname
	 */
	public static void enterNameFields(String firstname, String middlename, String lastname){
		EditProfilePage editProfilePage = (EditProfilePage) PageFactory.getNewPage(EditProfilePage.class);
		editProfilePage.typeFirstName(firstname);
		editProfilePage.typeMiddleName(middlename);
		editProfilePage.typeLastName(lastname);
	}
	/**
	 * To enter the values for the name fields in the edit profile page and save the page. 
	 * 
	 * @param firstname
	 * @param middlename
	 * @param lastname
	 */
	public static EditProfilePage enterNameFieldsAndSave(String firstname, String middlename, String lastname){
		enterNameFields(firstname, middlename, lastname);
		EditProfilePage editProfilePage = (EditProfilePage) PageFactory.getNewPage(EditProfilePage.class);
		return editProfilePage.clickOnSaveButton();
	}
	/**
	 * Method to change the email address field to a new value
	 * This method will do the action if the user is already in EditPRofilePage
	 * 
	 * @param emailAddress
	 * @return
	 * @throws Exception 
	 */
	public static EditProfilePage enterEmailAddressAndSave(String emailAddress) throws Exception{
		EditProfilePage editProfilePage = (EditProfilePage) PageFactory.getNewPage(EditProfilePage.class);
		editProfilePage.typeEmailAddress(emailAddress);
		return editProfilePage.clickOnSaveButton();
	}
	/**
	 * Method to change the email address field to a new value
	 * 
	 * @param emailAddress
	 * @return
	 * @throws Exception 
	 */
	public static EditProfilePage updateEmailAddress(String emailAddress) throws Exception{
		EditProfilePage editProfilePage = AccountManagementNavigation.viewEditProfilePage();
		editProfilePage.typeEmailAddress(emailAddress);
		return editProfilePage.clickOnSaveButton();
	}
	
	/**
	 * This action method will update all the contact information fields.
	 * 
	 * @param company
	 * @param country
	 * @param addressLine1
	 * @param addressLine2
	 * @param addressLine3
	 * @param city
	 * @param state
	 * @param zipCode
	 * @param phone
	 */
	public static void enterContactInformations(String company, String country, String addressLine1, String addressLine2, String addressLine3, String city, String state, String zipCode, String phone){
		EditProfilePage editProfilePage = (EditProfilePage) PageFactory.getNewPage(EditProfilePage.class);
		editProfilePage.typeCompany(company);
		editProfilePage.selectCountry(country);
		editProfilePage.typeAddressLine("1", addressLine1);
		editProfilePage.typeAddressLine("2", addressLine2);
		editProfilePage.typeAddressLine("3", addressLine3);
		editProfilePage.typeCity(city);
		editProfilePage.selectState(state);
		editProfilePage.typeZipCode(zipCode);
		editProfilePage.typePhoneNumber(phone);		
	}
	/**
	 * This action method will update all the contact information fields and saves the information.
	 * 
	 * @param company
	 * @param country
	 * @param addressLine1
	 * @param addressLine2
	 * @param addressLine3
	 * @param city
	 * @param state
	 * @param zipCode
	 * @param phone
	 * @return
	 */
	public static EditProfilePage enterContactInformationsAndSave(String company, String country, String addressLine1, String addressLine2, String addressLine3, String city, String state, String zipCode, String phone){
		enterContactInformations(company, country, addressLine1, addressLine2, addressLine3, city, state, zipCode, phone);	
		EditProfilePage editProfilePage = (EditProfilePage) PageFactory.getNewPage(EditProfilePage.class);
		return editProfilePage.clickOnSaveButton();
	}
	/**
	 * This method will navigate to the Profile Page and update the information	 * 
	 * 
	 * @param company
	 * @param country
	 * @param addressLine1
	 * @param addressLine2
	 * @param addressLine3
	 * @param city
	 * @param state
	 * @param zipCode
	 * @param phone
	 * @return
	 * @throws Exception
	 */
	public static EditProfilePage updateContactInformations(String company, String country, String addressLine1, String addressLine2, String addressLine3, String city, String state, String zipCode, String phone) throws Exception{
		EditProfilePage editProfilePage = AccountManagementNavigation.viewEditProfilePage();
		enterContactInformations(company, country, addressLine1, addressLine2, addressLine3, city, state, zipCode, phone);	
		return editProfilePage.clickOnSaveButton();
	}
	/**
	 * This method will enter the field only if the value is not empty, useful in situations where the user need to enter only a sub-set of values.
	 * 
	 * @param company
	 * @param country
	 * @param addressLine1
	 * @param addressLine2
	 * @param addressLine3
	 * @param city
	 * @param state
	 * @param zipCode
	 * @param phone
	 * @return
	 * @throws Exception
	 */
	public static EditProfilePage updateContactInformationsIgnoreBlankValues(String company, String country, String addressLine1, String addressLine2, String addressLine3, String city, String state, String zipCode, String phone) throws Exception{
		EditProfilePage editProfilePage = AccountManagementNavigation.viewEditProfilePage();
		if(! StringUtils.isNullOrEmpty(company)){
			editProfilePage.typeCompany(company);
		}
		if(! StringUtils.isNullOrEmpty(country)){
			editProfilePage.selectCountry(country);
		}
		if(! StringUtils.isNullOrEmpty(addressLine1)){
			editProfilePage.typeAddressLine("1", addressLine1);
		}			
		if(! StringUtils.isNullOrEmpty(addressLine2)){
			editProfilePage.typeAddressLine("2", addressLine2);
		}
		if(! StringUtils.isNullOrEmpty(addressLine3)){
			editProfilePage.typeAddressLine("3", addressLine3);
		}
		if(! StringUtils.isNullOrEmpty(city)){
			editProfilePage.typeCity(city);
		}
		if(! StringUtils.isNullOrEmpty(state)){
			editProfilePage.selectState(state);
		}
		if(! StringUtils.isNullOrEmpty(zipCode)){
			editProfilePage.typeZipCode(zipCode);
		}
		if(! StringUtils.isNullOrEmpty(phone)){
			editProfilePage.typePhoneNumber(phone);
		}		
        return editProfilePage.clickOnSaveButton();
	}
	
	
	
	
	
}
