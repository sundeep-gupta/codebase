package com.ironmountain.pageobject.webobjects.connected.pages.amws;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.thoughtworks.selenium.Selenium;

/**
 * @author Princy James
 *
 */
public class RegistrationLicensePage extends SeleniumPage {
	
	public RegistrationLicensePage(Selenium sel)
	{
		selenium = sel;
	}
	
	/** Get URL
	 * @return
	 */
	public boolean getUrl(){
		String url =  getLocation();
		return url.contains("/ssws/faces/welcome.jsp");
	}
	
	/** Get License Text
	 * @return
	 */
	public boolean getLicenseText(){
		String text = getText("LicensePage.LicenseText");
		return text.contains("Copyright © 2010 Iron Mountain Incorporated. All rights reserved.");
	}
	
	
	/** Verify Accept Button
	 * @return
	 */
	public boolean verifyAcceptBtn(){
		return isElementPresent("LicensePage.Accept");
	}
	
	
	/** Verify Decline Button
	 * @return
	 */
	public boolean verifyDeclineBtn(){
		return isElementPresent("LicensePage.Decline");
	}
	
	/** Method to click on decline button
	 * @return RegistrationDeclinedPage
	 */
	public RegistrationDeclinedPage clickOnDeclineBtn()throws Exception {
		
		click("LicensePage.Decline");
		return (RegistrationDeclinedPage) PageFactory.getNewPage(RegistrationDeclinedPage.class);
		
	}
	
	/** Method to click on Accept button 
	 * @return EnterRegistrationDetails
	 */
	public EnterRegistrationDetails clickOnAcceptBtn()throws Exception {
		
		click("eulaAcceptForm:accept");
		waitForSeconds(5);
		return (EnterRegistrationDetails) PageFactory.getNewPage(EnterRegistrationDetails.class);
		
	}
	
	/** Method to click on Accept button for LDAP community
	 * @return NetworkLogonPage
	 */
	public SeleniumPage clickOnAcceptBtn(boolean isLDAP)throws Exception {

		if (isLDAP){
			click("LicensePage.Accept");
			return (NetworkLogonPage) PageFactory.getNewPage(NetworkLogonPage.class);
		}
		else {
			return clickOnAcceptBtn();

		}
	}
}
