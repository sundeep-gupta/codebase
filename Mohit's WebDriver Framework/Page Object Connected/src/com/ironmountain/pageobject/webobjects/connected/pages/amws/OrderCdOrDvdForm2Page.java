package com.ironmountain.pageobject.webobjects.connected.pages.amws;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.thoughtworks.selenium.Selenium;

/**
 * After selecting a backup date user will click on next button which takes to order media page 2.
 * 
 * @author Jinesh Devasia
 *
 */
public class OrderCdOrDvdForm2Page extends AccountManagementHomePage {

	private static final String PAGE_NAME_REF = "OrderCdOrDvdForm2Page.";
	
	public OrderCdOrDvdForm2Page(Selenium sel){
		selenium = sel;
	}
	
	/**
	 * Select the media Type as CDs
	 */
	public void checkCDsRadioButton(){
		click(PAGE_NAME_REF + "MediaTypeCDCheckbox");
	}

	/**
	 * Select the media Type as DVDs
	 */
	public void checkDVDsRadioButton(){
		click(PAGE_NAME_REF + "MediaTypeDVDCheckbox");
	}

	/**
	 * Enter the password for the media
	 * 
	 * @param mediaPassword
	 */
	public void typeMediaPassword(String mediaPassword){
		type(PAGE_NAME_REF + "MediaPasswordTextfield", mediaPassword);
	}
	/**
	 * Enter the confirm password for the media
	 * 
	 * @param mediaPassword
	 */
	public void typeConfirmMediaPassword(String mediaPassword){
		type(PAGE_NAME_REF + "ConfirmMediaPasswordTextfield", mediaPassword);
	}
	
	/**
	 * Check the default shipping address radio (Default address from use rprofile.
	 */
	public void checkShipToTheFollowingAddressRadioButton(){
		click(PAGE_NAME_REF + "ShipToTheFollowingAddressRadioButton");
	}
	/**
	 * Check another shipping address radio
	 */
	public void checkShipToAnotherAddressRadioButton(){
		click(PAGE_NAME_REF + "ShipToAnotherAddressRadioButton");
	}
	
	/**
	 * Type address to the address fields, currently there are 5 text fields starting from 1-5
	 * 
	 * @param addressFieldIndex (Values from 1,2..5)
	 * @param address
	 */
	public void typeInAddressField(String addressFieldIndex, String address){
		type("order2form:address" + addressFieldIndex, address);
	}
	
	/**
	 * Click on the back button which navigates to OrderMediaSelectBackupDatePage.
	 * @return
	 */
	public OrderCdOrDvdForm1Page clickOnBackButton(){
		clickAndWaitForPageLoad(PAGE_NAME_REF + "BackButton");
		return (OrderCdOrDvdForm1Page) PageFactory.getNewPage(OrderCdOrDvdForm1Page.class);
	}
	
	/**
	 * Submit the media order, will take the user to a media order confirmation page.
	 */
	public OrderCdOrDvdConfirmationPage clickOnSubmitOrderButton(){
		clickAndWaitForPageLoad(PAGE_NAME_REF + "SubmitOrderButton");
		return (OrderCdOrDvdConfirmationPage) PageFactory.getNewPage(OrderCdOrDvdConfirmationPage.class);
	}
	
	public SummaryPage clickOnCancelButton(){
		clickAndWaitForPageLoad(PAGE_NAME_REF + "CancelButton");
		return (SummaryPage) PageFactory.getNewPage(SummaryPage.class);
	}
	
	
	
	
	
}
