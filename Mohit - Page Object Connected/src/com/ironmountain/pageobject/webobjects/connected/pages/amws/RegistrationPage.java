package com.ironmountain.pageobject.webobjects.connected.pages.amws;

import com.thoughtworks.selenium.Selenium;
import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.thoughtworks.selenium.Selenium;
/** Registration Page Object
 * @author pjames
 *  
 */
public class RegistrationPage extends SeleniumPage {
	
	public RegistrationPage(Selenium sel)
	{
		selenium = sel;
	}
	
	/** Method to verify title
	 * @return
	 */
	public boolean verifyTitle(){
		String res = getTitle();
		if (res.contains("RegistrationPageTitle")){
			return true;
		} else {
			return false;
		}
	}
	
	/** Method to verify WelcomeMsg
	 * @return
	 */
	public boolean verifyWelcomeMsg(){
		return isTextPresent("This Website gives you access to backup software and tools for managing your backup account. By using this software, you can securely protect your data from loss or damage.");
	}
	
	
	/** Method to verify BackupMsg
	 * @return
	 */
	public boolean verifyBackupMsg(){
		return isTextPresent("The backup software that runs on your computer, called the Agent, automatically backs up your computer's information. It encrypts your data and transmits it safely over the Internet to a secure Data Center.");
	}
	
	
	/** Method to verify RetrieveMsg
	 * @return
	 */
	public boolean verifyRetrieveMsg(){
		return isTextPresent("All your backed-up information is available to you whenever you need it.");
	}
	
	
	/** Method to verify RegisterLink
	 * @return
	 */
	public boolean verifyRegisterLink(){
		return isElementPresent("RegistrationPage.RegisterLink");
	}
	
	/** Method to verify LogOnLink
	 * @return
	 */
	public boolean verifyLogOnLink(){
		return isElementPresent("RegistrationPage.LogOnLink");
	}
	
	
	/** Method to verify RegisterAndDownloadBtn
	 * @return
	 */
	public boolean verifyRegisterAndDownloadBtn(){
		return isElementPresent("RegistrationPage.RegisterAndDownload");
	}
	
	/** Method to Click On RegisterAndDownload Btn 
	 * @return RegistrationLicensePage
	 */
	public RegistrationLicensePage ClickOnRegisterAndDownloadBtn()throws Exception {
		
		click("RegistrationPage.RegisterAndDownload");
		waitForSeconds(5);
		return (RegistrationLicensePage) PageFactory.getNewPage(RegistrationLicensePage.class);		
	}
	
	
}
