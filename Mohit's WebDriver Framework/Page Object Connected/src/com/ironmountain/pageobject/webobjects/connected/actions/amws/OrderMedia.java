package com.ironmountain.pageobject.webobjects.connected.actions.amws;

import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.OrderCdOrDvdConfirmationPage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.OrderCdOrDvdForm1Page;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.OrderCdOrDvdForm2Page;

public class OrderMedia {

	/**
	 * This method will select a backup date and navigates to next page.
	 * 
	 * @param optionIndex
	 * @param backupDate
	 * @return
	 * @throws Exception
	 */
	public static OrderCdOrDvdForm2Page selectAndGoToSubmitOrderPage(String optionIndex) throws Exception
	{
		OrderCdOrDvdForm1Page orderCdorDvdForm1Page = AccountManagementNavigation.viewOrderCdOrDvdsPage();
		orderCdorDvdForm1Page.selectBackupDate(optionIndex);
		return (OrderCdOrDvdForm2Page) orderCdorDvdForm1Page.clickOnNextButton();
	}
	/**
	 * This method will create a DVD order and ship to default address
	 * 
	 * @param backupDateOptionIndex
	 * @param mediaPassword
	 * @return
	 * @throws Exception
	 */
	public static OrderCdOrDvdConfirmationPage createDvdOrder(String backupDateOptionIndex, String mediaPassword) throws Exception
	{
		OrderCdOrDvdForm1Page orderCdorDvdForm1Page = AccountManagementNavigation.viewOrderCdOrDvdsPage();
		orderCdorDvdForm1Page.selectBackupDate(backupDateOptionIndex);
		OrderCdOrDvdForm2Page orderCdOrDvdForm2Page = orderCdorDvdForm1Page.clickOnNextButton();
		orderCdOrDvdForm2Page.checkDVDsRadioButton();
		orderCdOrDvdForm2Page.typeMediaPassword(mediaPassword);
		orderCdOrDvdForm2Page.typeConfirmMediaPassword(mediaPassword);
		return orderCdOrDvdForm2Page.clickOnSubmitOrderButton();		
	}
	/**
	 * Overloaded version of order DVD with a shipping address specified
	 * 
	 * @param backupDateOptionIndex
	 * @param mediaPassword
	 * @param shippingLabel
	 * @return
	 * @throws Exception
	 */
	public static OrderCdOrDvdConfirmationPage createDvdOrderWithShippingAddress(String backupDateOptionIndex, String mediaPassword, String shippingLabel) throws Exception
	{
		OrderCdOrDvdForm1Page orderCdorDvdForm1Page = AccountManagementNavigation.viewOrderCdOrDvdsPage();
		orderCdorDvdForm1Page.selectBackupDate(backupDateOptionIndex);
		OrderCdOrDvdForm2Page orderCdOrDvdForm2Page = orderCdorDvdForm1Page.clickOnNextButton();
		orderCdOrDvdForm2Page.checkDVDsRadioButton();
		orderCdOrDvdForm2Page.typeMediaPassword(mediaPassword);
		orderCdOrDvdForm2Page.typeConfirmMediaPassword(mediaPassword);
		orderCdOrDvdForm2Page.checkShipToAnotherAddressRadioButton();
		orderCdOrDvdForm2Page.typeInAddressField("1", shippingLabel);
		return orderCdOrDvdForm2Page.clickOnSubmitOrderButton();		
	}
	

}
