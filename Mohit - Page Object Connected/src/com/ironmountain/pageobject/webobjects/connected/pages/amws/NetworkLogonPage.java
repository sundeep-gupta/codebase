package com.ironmountain.pageobject.webobjects.connected.pages.amws;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.thoughtworks.selenium.Selenium;

/** Page Object Class for the Network Logon Page
 * @author Princy James
 *
 */
public class NetworkLogonPage extends SeleniumPage {
	
	public NetworkLogonPage(Selenium sel)
	{
		selenium = sel;
	}
	
	/** Method to type the NetworkID
	 * @param LDAPId
	 */
	public void setNetworkID(String LDAPId)
	{
		type("NetworkPage.Id", LDAPId);
	}
	
	/**Method to type the Network Password
	 * @param LDAPPass
	 */
	public void setNetworkPassword(String LDAPPass)
	{
		type("NetworkPage.Password", LDAPPass);
	}
	
	/**Method to verify title
	 * @return
	 */
	public boolean verifyTitle(){
		String res= getTitle();
		String val = getLocator("NetworkPageTitle");
		if (res.contains(val)){
			return true;
		} else {
			return false;
		}
	}
	
	/**Method to verify ContactSupportLink
	 * @return
	 */
	public boolean verifyContactSupportLink(){
		return isElementPresent("NetworkPage.ContactSupport");
	}
	
	/** Method to click on continue and return the next page object
	 * @return
	 * @throws Exception
	 */
	public RegistrationCompletePage clickOnContinueBtn()throws Exception {
		
		click("NetworkPage.Continue");
		return (RegistrationCompletePage) PageFactory.getNewPage(RegistrationCompletePage.class);
		
	}

}
