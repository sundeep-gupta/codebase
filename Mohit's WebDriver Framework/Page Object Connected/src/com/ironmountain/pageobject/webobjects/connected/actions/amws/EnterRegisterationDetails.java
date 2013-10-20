package com.ironmountain.pageobject.webobjects.connected.actions.amws;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.EnterRegistrationDetails;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.RegistrationCompletePage;

/**
 * @author pjames
 *
 */
public class EnterRegisterationDetails {
	
	//static EnterRegistrationDetails enterRegistrationDetailsPage = (EnterRegistrationDetails) PageFactory.getNewPage(EnterRegistrationDetails.class);
	
	/**
	 * The common action method to enter all the registration details
	 * If we don't want to enter data in any field leave the value as blank or pass null
	 * 
	 * @param firstName
	 * @param middleName
	 * @param lastName
	 * @param email
	 * @param password
	 * @param confirmPassword
	 * @param company
	 * @param location
	 * @param employeeId
	 * @param customField
	 * @param country
	 * @param addressLine1
	 * @param addressLine2
	 * @param addressLine3
	 * @param city
	 * @param state
	 * @param zipCode
	 * @param phoneNumber
	 * @return
	 * @throws Exception
	 */
	public static RegistrationCompletePage enterAllFields(String firstName, String middleName, String lastName, String email, String password, String confirmPassword, 
			String company, String location, String employeeId, String customField, String country, String addressLine1,String addressLine2, String addressLine3,
			String city, String state, String zipCode, String phoneNumber ) throws Exception{
		EnterRegistrationDetails enterRegistrationDetailsPage = (EnterRegistrationDetails) PageFactory.getNewPage(EnterRegistrationDetails.class);
		
		if(! StringUtils.isNullOrEmpty(firstName)){
			enterRegistrationDetailsPage.setFirstName(firstName);
		}
		if(! StringUtils.isNullOrEmpty(middleName)){
			enterRegistrationDetailsPage.setMiddleName(middleName);
		}
		if(! StringUtils.isNullOrEmpty(lastName)){
			enterRegistrationDetailsPage.setLastName(lastName);
		}
		if(! StringUtils.isNullOrEmpty(email)){
			enterRegistrationDetailsPage.setEmail(email);
		}
		if(! StringUtils.isNullOrEmpty(password)){
			enterRegistrationDetailsPage.setPassword(password);
		}
		if(! StringUtils.isNullOrEmpty(confirmPassword)){
			enterRegistrationDetailsPage.setConfirmPassword(confirmPassword);
		}
		if(! StringUtils.isNullOrEmpty(company)){
			enterRegistrationDetailsPage.setCompany(company);
		}
		if(! StringUtils.isNullOrEmpty(employeeId)){
			enterRegistrationDetailsPage.typeEmployeeId(employeeId);
		}
		if(! StringUtils.isNullOrEmpty(location)){
			enterRegistrationDetailsPage.typeLocation(location);
		}
		if(! StringUtils.isNullOrEmpty(customField)){
			enterRegistrationDetailsPage.typeCustomFiled(customField);	
		}
		if(! StringUtils.isNullOrEmpty(country)){
			enterRegistrationDetailsPage.setCountry(country);
		}
		if(! StringUtils.isNullOrEmpty(addressLine1)){
			enterRegistrationDetailsPage.setAddressLine1(addressLine1);
		}
		if(! StringUtils.isNullOrEmpty(addressLine2)){
			enterRegistrationDetailsPage.setAddressLine2(addressLine2);
		}
		if(! StringUtils.isNullOrEmpty(addressLine3)){
			enterRegistrationDetailsPage.setAddressLine3(addressLine3);
		}
		if(! StringUtils.isNullOrEmpty(city)){
			enterRegistrationDetailsPage.setCity(city);
		}
		if(! StringUtils.isNullOrEmpty(state)){
			enterRegistrationDetailsPage.setState(state);
		}
		if(! StringUtils.isNullOrEmpty(zipCode)){
			enterRegistrationDetailsPage.setZipCode(zipCode);
		}
		if(! StringUtils.isNullOrEmpty(phoneNumber)){
			enterRegistrationDetailsPage.setPhoneNumber(phoneNumber);	
		}
		return enterRegistrationDetailsPage.clickContinue();
	}
	
	public static RegistrationCompletePage enterAllFields(String FirstName, String MiddleName, String LastName, String Email, String Password, String ConfirmPassword, 
			String Company, String Country, String AddressLine1,String AddressLine2,String AddressLine3,
			String City, String State, String ZipCode, String PhoneNumber ) throws Exception{
		EnterRegistrationDetails enterRegistrationDetailsPage = (EnterRegistrationDetails) PageFactory.getNewPage(EnterRegistrationDetails.class);
		enterRegistrationDetailsPage.setFirstName(FirstName);
		enterRegistrationDetailsPage.setMiddleName(MiddleName);
		enterRegistrationDetailsPage.setLastName(LastName);
		enterRegistrationDetailsPage.setEmail(Email);
		enterRegistrationDetailsPage.setPassword(Password);
		enterRegistrationDetailsPage.setConfirmPassword(ConfirmPassword);
		enterRegistrationDetailsPage.setCompany(Company);
		enterRegistrationDetailsPage.setCountry(Country);
		enterRegistrationDetailsPage.setAddressLine1(AddressLine1);
		enterRegistrationDetailsPage.setAddressLine2(AddressLine2);
		enterRegistrationDetailsPage.setAddressLine3(AddressLine3);
		enterRegistrationDetailsPage.setCity(City);
		enterRegistrationDetailsPage.setState(State);
		enterRegistrationDetailsPage.setZipCode(ZipCode);
		enterRegistrationDetailsPage.setPhoneNumber(PhoneNumber);	
		return enterRegistrationDetailsPage.clickContinue();
	}
	
	/**
	 * Overloaded method for specific fields
	 * 
	 * @param FirstName
	 * @param LastName
	 * @param Email
	 * @param Password
	 * @param ConfirmPassword
	 * @param employeeId
	 * @return
	 * @throws Exception
	 */
	public static RegistrationCompletePage enterFields(String FirstName, String LastName, String Email, String Password, String ConfirmPassword, 
			String employeeId) throws Exception{
		EnterRegistrationDetails enterRegistrationDetailsPage = (EnterRegistrationDetails) PageFactory.getNewPage(EnterRegistrationDetails.class);
		enterRegistrationDetailsPage.setFirstName(FirstName);
		enterRegistrationDetailsPage.setLastName(LastName);
		enterRegistrationDetailsPage.setEmail(Email);
		enterRegistrationDetailsPage.setPassword(Password);
		enterRegistrationDetailsPage.setConfirmPassword(ConfirmPassword);
		enterRegistrationDetailsPage.typeEmployeeId(employeeId);
		return enterRegistrationDetailsPage.clickContinue();
	}
	
	/**
	 * Overloaded method for only the default required fields
	 * 
	 * @param FirstName
	 * @param LastName
	 * @param Email
	 * @param Password
	 * @param ConfirmPassword
	 * @return
	 * @throws Exception
	 */
	public static RegistrationCompletePage enterFields(String FirstName, String LastName, String Email, String Password, String ConfirmPassword) throws Exception{
		EnterRegistrationDetails enterRegistrationDetailsPage = (EnterRegistrationDetails) PageFactory.getNewPage(EnterRegistrationDetails.class);
		enterRegistrationDetailsPage.waitForSeconds(5);
		enterRegistrationDetailsPage.setFirstName(FirstName);
		enterRegistrationDetailsPage.setLastName(LastName);
		enterRegistrationDetailsPage.setEmail(Email);
		enterRegistrationDetailsPage.setPassword(Password);
		enterRegistrationDetailsPage.setConfirmPassword(ConfirmPassword);
		return enterRegistrationDetailsPage.clickContinue();
	}
	
	
}

