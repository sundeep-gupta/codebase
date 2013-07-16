package com.ironmountain.pageobject.webobjects.connected.pages.amws;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.thoughtworks.selenium.Selenium;

/**
 * @author pjames
 *
 */
public class EnterRegistrationDetails extends SeleniumPage {
	
	public EnterRegistrationDetails(Selenium sel)
	{
		selenium = sel;
	}
	
	public boolean isFirstNameEditable(){
		return isEditable("DetailsPage.FirstNameEdit");
	}
	
	public boolean isMiddleNameEditable(){
		return isEditable("DetailsPage.MiddleNameEdit");
	}
	public boolean isLastNameEditable(){
		return isEditable("DetailsPage.LastNameEdit");
	}
	public boolean isEmailEditable(){
		return isEditable("DetailsPage.EmailEdit");
	}
	public boolean isPasswordEditable(){
		return isEditable("DetailsPage.PasswordEdit");
	}
	public boolean isConfirmPasswordEditable(){
		return isEditable("DetailsPage.ConfirmPasswordEdit");
	}
	public boolean isCompanyEditable(){
		return isEditable("DetailsPage.CompanyEdit");
	}
	public boolean isCountryEditable(){
		return isEditable("DetailsPage.CountryEdit");
	}
	public boolean isAddressLine1Editable(){
		return isEditable("DetailsPage.AddressLine1Edit");
	}
	public boolean isAddressLine2Editable(){
		return isEditable("DetailsPage.AddressLine2Edit");
	}
	
	public boolean isCityEditable(){
		return isEditable("DetailsPage.CityEdit");
	}
	public boolean isStateEditable(){
		return isEditable("DetailsPage.StateEdit");
	}
	public boolean isZipCodeEditable(){
		return isEditable("DetailsPage.ZipCodeEdit");
	}
	public boolean isPhoneNumberEditable(){
		return isEditable("DetailsPage.PhoneNumberEdit");
	}
	
	public void setFirstName(String FirstName)
	{
		type("DetailsPage.FirstNameEdit", FirstName);
	}
	
	public void getFirstName(String locator){
		//getText(locator);
	}

	public void setMiddleName(String MiddleName)
	{
		type("DetailsPage.MiddleNameEdit", MiddleName);
	}
	public void getMiddleName(String locator){
		//getText(locator);
	}
	public void setLastName(String LastName)
	{
		type("DetailsPage.LastNameEdit", LastName);
	}
	public void getLastName(String locator){
		//getText(locator);
	}
	
	public void setEmail(String Email)
	{
		type("DetailsPage.EmailEdit", Email);
	}
	public void getEmail(String locator){
		//getText(locator);
	}
	
	public void setPassword(String Password)
	{
		type("DetailsPage.PasswordEdit", Password);
	}
	public void getPassword(String locator){
		//getText(locator);
	}
	
	public void setConfirmPassword(String ConfirmPassword)
	{
		type("DetailsPage.ConfirmPasswordEdit", ConfirmPassword);
	}
	
	public void setCompany(String Company)
	{
		type("DetailsPage.CompanyEdit", Company);
	}
	public void getCompany(String locator){
		//getText(locator);
	}	
	public void setCountry(String Country)
	{
		select("DetailsPage.CountryEdit", Country);
	}
	public void getCountry(String locator){
		//getText(locator);
	}	
	public void setAddressLine1(String AddressLine1)
	{
		type("DetailsPage.AddressLine1Edit", AddressLine1);
	}
	
	public void setAddressLine2(String AddressLine2)
	{
		type("DetailsPage.AddressLine2Edit", AddressLine2);
	}
	public void setAddressLine3(String AddressLine3)
	{
		type("DetailsPage.AddressLine3Edit", AddressLine3);
	}
	
	public void setCity(String City)
	{
		type("DetailsPage.CityEdit", City);
	}
	
	public void setState(String State)
	{
		type("DetailsPage.StateEdit", State);
	}
	
	public void setZipCode(String ZipCode)
	{
		type("DetailsPage.ZipCodeEdit", ZipCode);
	}
	
	public boolean verifyFirstNameRequiredMsg(){
		return isTextPresent("DetailsPage.FNReqFieldText");
	}
	public boolean verifyLastNameRequiredMsg(){
		return isTextPresent("DetailsPage.LNReqFieldText");
	}
	public boolean verifyEmailRequiredMsg(){
		return isTextPresent("DetailsPage.EmailReqFieldText");
	}
	public boolean verifyPasswordRequiredMsg(){
		return isTextPresent("DetailsPage.PassReqFieldText");
	}
	public boolean verifyConfPassRequiredMsg(){
		return isTextPresent("DetailsPage.ConfPassReqFieldText");
	}
	
	
	public void setPhoneNumber(String PhoneNumber)
	{
		type("DetailsPage.PhoneNumberEdit", PhoneNumber);
	}
	public RegistrationCompletePage clickContinue()throws Exception {
		
		clickAndWaitForPageLoad("DetailsPage.Continue");
		return (RegistrationCompletePage) PageFactory.getNewPage(RegistrationCompletePage.class);
		
	}	
	public void typeEmployeeId(String employeeId){
		type("DetailsPage.EmployeeIdTextfield", employeeId);
	}
	public void typeLocation(String location){
		type("DetailsPage.LocationTextfield", location);
	}
	public void typeCustomFiled(String customfiled){
		type("DetailsPage.CustomTextfield", customfiled);
	}
	

}
