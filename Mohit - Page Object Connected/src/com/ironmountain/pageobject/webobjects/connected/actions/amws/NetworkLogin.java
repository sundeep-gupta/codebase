package com.ironmountain.pageobject.webobjects.connected.actions.amws;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.NetworkLogonPage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.RegistrationCompletePage;

/** Class Performs NetworkLogin Action
 * @author Princy James
 *
 */
public class NetworkLogin {

	

	/** Method to perform login operation on the network login page.
	 * @param LDAPId
	 * @param LDAPPass
	 * @return
	 * @throws Exception
	 */
	public static RegistrationCompletePage networklogin(String LDAPId, String LDAPPass) throws Exception
	{
		NetworkLogonPage accLoginPage = (NetworkLogonPage) PageFactory.getNewPage(NetworkLogonPage.class);
		accLoginPage.setNetworkID(LDAPId);
		accLoginPage.setNetworkPassword(LDAPPass);
		return (RegistrationCompletePage)accLoginPage.clickOnContinueBtn();		
	}

}
