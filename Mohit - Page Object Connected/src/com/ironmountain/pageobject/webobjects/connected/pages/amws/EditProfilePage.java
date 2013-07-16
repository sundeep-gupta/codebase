package com.ironmountain.pageobject.webobjects.connected.pages.amws;


import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.thoughtworks.selenium.Selenium;

/**
 * @author Jinesh Devasia
 *
 */
public class EditProfilePage extends AccountManagementHomePage {

	private static final String PAGE_NAME_REF = "EditProfilePage.";
	
	public EditProfilePage(Selenium sel) {
		selenium =sel;
	}
	
	public void typeFirstName(String firstName){
		type(PAGE_NAME_REF + "FirstnameTextfield", firstName);
	}
	public String getFirstName(){
		return getValue(PAGE_NAME_REF + "FirstnameTextfield");
	}
	public void typeMiddleName(String middleName){
		type(PAGE_NAME_REF + "MiddlenameTextfield", middleName);
	}
	public String getMiddleName(){
		return getValue(PAGE_NAME_REF + "MiddlenameTextfield");
	}
	public void typeLastName(String lastName){
		type(PAGE_NAME_REF + "LastnameTextfield", lastName);
	}
	public String getLastName(){
		return getValue(PAGE_NAME_REF + "LastnameTextfield");
	}
	public void typeEmailAddress(String emailAddress){
		type(PAGE_NAME_REF + "EmailAddressTextfield", emailAddress);
	}
	public String getEmailAddress(){
		return getValue(PAGE_NAME_REF + "EmailAddressTextfield");
	}
	
	public ChangePasswordPage clickOnChangePasswordButton(){
		clickAndWaitForPageLoad(PAGE_NAME_REF + "ChangePasswordButton");
		return (ChangePasswordPage) PageFactory.getNewPage(ChangePasswordPage.class);
	}
	
	public void typeCompany(String company){
		type(PAGE_NAME_REF + "CompanyTextfield", company);
	}
	public String getCompany(){
		return getValue(PAGE_NAME_REF + "CompanyTextfield");
	}
	/**
	 * Check the company field is disabled or not
	 * 
	 * @return
	 */
	public boolean isCompanyEditable(){
		return isEditable(PAGE_NAME_REF + "CompanyTextfield");
	}
	public void typeLocation(String location){
		type(PAGE_NAME_REF + "LocationTextfield", location);
	}
	public String getLocation(){
		return getValue(PAGE_NAME_REF + "LocationTextfield");
	}
	public void typeEmployeeId(String employeeId){
		type(PAGE_NAME_REF + "EmployeeIdTextfield", employeeId);
	}
	public String getEmployeeId(){
		return getValue(PAGE_NAME_REF + "EmployeeIdTextfield");
	}
	public void typeCustomField(String customFieldValue){
		type(PAGE_NAME_REF + "CustomTextfield", customFieldValue);
	}
	public String getCustomField(){
		return getValue(PAGE_NAME_REF + "CustomTextfield");
	}
	
	public void selectCountry(String country){
		select(PAGE_NAME_REF + "CountryList", country);
		waitForSeconds(3);
	}
	public String getSelectedCountry(){
		return getSelectedLabel(PAGE_NAME_REF + "CountryList");
	}
	
	/**
	 * To type in to the Address Line Fields based on the index, (1,2,3)
	 * 
	 * @param addreslineIndex values{1,2,3}
	 * @param addressLine
	 */
	public void typeAddressLine(String addreslineIndex, String addressLine){
		type("editProfileForm:address" + addreslineIndex + "Edit", addressLine);
	}
	public String getAddressLine(String addreslineIndex){
		return getValue("editProfileForm:address" + addreslineIndex + "Edit");
	}
	public void typeCity(String city){
		type(PAGE_NAME_REF + "CityTextfield", city);
	}
	public String getCity(){
		return getValue(PAGE_NAME_REF + "CityTextfield");
	}
	
	public void selectState(String state){
		select(PAGE_NAME_REF + "StateTextfield", "label=" + state);
	}
	public String getSelectedState(){
		return getSelectedLabel(PAGE_NAME_REF + "StateTextfield");
	}
	public void typeZipCode(String zipCode){
		type(PAGE_NAME_REF + "ZipTextfield", zipCode);
	}	
	public String getZipCode(){
		return getValue(PAGE_NAME_REF + "ZipTextfield");
	}
	public void typePhoneNumber(String phone){
		type(PAGE_NAME_REF + "PhoneTextfield", phone);
	}
	public String getPhoneNumber(){
		return getValue(PAGE_NAME_REF + "PhoneTextfield");
	}
	
	public EditProfilePage clickOnSaveButton(){
		clickAndWaitForPageLoad(PAGE_NAME_REF + "SaveButton");
		return this;
	}
	
	public SummaryPage clickOnCancelButton(){
		clickAndWaitForPageLoad("EditProfilePage.CancelButton");
		return (SummaryPage) PageFactory.getNewPage(SummaryPage.class);
	}
	
	

}
