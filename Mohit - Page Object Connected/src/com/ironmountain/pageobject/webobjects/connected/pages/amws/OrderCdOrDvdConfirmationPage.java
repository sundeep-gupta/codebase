package com.ironmountain.pageobject.webobjects.connected.pages.amws;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.thoughtworks.selenium.Selenium;

/**
 * After submitting the order user will get a Order confirmation Page..
 * 
 * @author  Jinesh Devasia
 *
 */
public class OrderCdOrDvdConfirmationPage extends AccountManagementHomePage {

	public OrderCdOrDvdConfirmationPage(Selenium sel){
		selenium =sel;
	}
	
	public ContactSupportPage clickOnContactSupportLinkForCancel(){
		clickAndWaitForPageLoad("OrderCdOrDvdConfirmationPage.ContactSupportLinkForCancel");
		return (ContactSupportPage) PageFactory.getNewPage(ContactSupportPage.class);
	}
}
