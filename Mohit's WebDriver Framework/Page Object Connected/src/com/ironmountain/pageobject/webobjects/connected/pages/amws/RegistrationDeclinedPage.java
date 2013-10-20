package com.ironmountain.pageobject.webobjects.connected.pages.amws;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.thoughtworks.selenium.Selenium;

/**
 * @author pjames
 *
 */
public class RegistrationDeclinedPage extends SeleniumPage {
	
	public RegistrationDeclinedPage(Selenium sel)
	{
		selenium = sel;
	}
	
	
	public RegistrationPage ClickOnCancelregistrationBtn()throws Exception {		
		click("DeclinePage.CancelRegistration");
		return (RegistrationPage) PageFactory.getNewPage(RegistrationPage.class);		
	}
	
	public RegistrationLicensePage ClickOnReturnBtn()throws Exception {
		click("DeclinePage.Return");
		return (RegistrationLicensePage) PageFactory.getNewPage(RegistrationLicensePage.class);		
	}
}
