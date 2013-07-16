package com.ironmountain.pageobject.webobjects.connected.pages.amws;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.thoughtworks.selenium.Selenium;

public class AccountManagementHomePage extends SeleniumPage{

	public AccountManagementHomePage(){}
	public AccountManagementHomePage(Selenium sel)
	{
		selenium = sel;
	}	
	public AccountManagementLoginPage clickOnLogOff() throws Exception
	{
		clickAndWaitForPageLoad("link=LOG OFF");
		return (AccountManagementLoginPage) PageFactory.getNewPage(AccountManagementLoginPage.class);
	}	
	
	public HelpPage clickOnHelp() throws InterruptedException{
		click("HelpLink");
		System.out.println(getEval("{var windowId; for(var x in selenium.browserbot.openedWindows ) {windowName=x;} }"));
		//selectWindow(getEval("{var windowId; for(var x in selenium.browserbot.openedWindows ) {windowId=x;} }"));
		Thread.sleep(10000);
		selenium.selectWindow("name=Account Management Website Help_frame");
		return (HelpPage) PageFactory.getNewPage(HelpPage.class);
	}
	public ContactSupportPage clickOnSupportLink(){
		String stupidTempWindowId = "csWindow";
		openWindow("/ssws/faces/support_no_header.jsp", stupidTempWindowId);		
		waitForPopUp(stupidTempWindowId);;
		selectWindow(stupidTempWindowId);
		return (ContactSupportPage) PageFactory.getNewPage(ContactSupportPage.class);
	}
	
    public TermsAndConditionsPage clickOnTermsAndConditions(){
		clickAndWaitForPageLoad("TermsAndConditionsLink");
		return (TermsAndConditionsPage) PageFactory.getNewPage(TermsAndConditionsPage.class);
	}
    public PrivacyPolicyPage clickOnPrivacyPolicy(){
    	clickAndWaitForPageLoad("PrivacyPolicyLink");
    	return (PrivacyPolicyPage) PageFactory.getNewPage(PrivacyPolicyPage.class);
	
    }
    
	public SummaryPage clickOnSummary() throws Exception
	{
		clickAndWaitForPageLoad("SummaryLink");
		return (SummaryPage) PageFactory.getNewPage(SummaryPage.class);
	}
	public AccountHistoryPage clickOnViewHistory() throws Exception
	{
		clickAndWaitForPageLoad("ViewHistoryLink");
		return (AccountHistoryPage) PageFactory.getNewPage(AccountHistoryPage.class);
	}
	
	/** Method to perform the click on Retrieve Files With MyRoamLink
	 * @return
	 * @throws Exception
	 */
	public MyRoamPage clickOnRetrieveFilesWithMyRoam() throws Exception
	{
		clickAndWaitForPageLoad("RetrieveFilesWithMyRoamLink");
		return (MyRoamPage) PageFactory.getNewPage(MyRoamPage.class);
	}
	
	/** Method to perform the click on Retrieve Files With ReinstallAgentLink
	 * @return
	 * @throws Exception
	 */
	public ReinstallAgentPage clickOnReinstallAgent() throws Exception
	{
		clickAndWaitForPageLoad("ReinstallAgentLink");
		return (ReinstallAgentPage) PageFactory.getNewPage(ReinstallAgentPage.class);
	}	
	
	
	public EditProfilePage clickOnEditProfile() throws Exception
	{
		clickAndWaitForPageLoad("EditProfileLink");
		return (EditProfilePage) PageFactory.getNewPage(EditProfilePage.class);		
	}
	/**
	 * If the User belongs to an LDAP community he may not have privilege to edit the profile information
	 * Such cases instead of edit profile the link name will be view profile.
	 * 
	 * @return
	 * @throws Exception
	 */
	public EditProfilePage clickOnViewProfile() throws Exception
	{
		clickAndWaitForPageLoad("ViewProfileLink");
		return (EditProfilePage) PageFactory.getNewPage(EditProfilePage.class);		
	}
	
	public OrderCdOrDvdForm1Page clickOnOrderCDsorDVDs() throws Exception
	{
		clickAndWaitForPageLoad("OrderCDsorDVDsLink");
		return (OrderCdOrDvdForm1Page) PageFactory.getNewPage(OrderCdOrDvdForm1Page.class);		
	}

	/** Method to open the Registration Page 
	 * @return
	 * @throws Exception
	 */
	public RegistrationPage openRegistrationUrl() throws Exception
	{
		String registrationURL = TestDataProvider.getTestData("RegistrationURL");
		open(registrationURL);
		waitForPageLoad("30000");
		return (RegistrationPage) PageFactory.getNewPage(RegistrationPage.class);		
	}
	/**
	 * Open the provided Registration Url
	 * 
	 * @param registrationUrl
	 * @return
	 * @throws Exception
	 */
	public RegistrationPage openRegistrationUrl(String registrationUrl) throws Exception
	{
		open(registrationUrl);
		return (RegistrationPage) PageFactory.getNewPage(RegistrationPage.class);		
	}
	
	/** Method to open the Registration Page of an LDAP Community
	 * @return
	 * @throws Exception
	 */
	public RegistrationPage openLDAPRegistrationUrl() throws Exception
	{
		String LDAPRegistrationURL = TestDataProvider.getTestData("LDAPRegistrationURL");
		open("LDAPRegistrationURL");
		waitForPageLoad("30000");
		return (RegistrationPage) PageFactory.getNewPage(RegistrationPage.class);		
	}
	
	/** Method to open the Custom Registration Page of a custom community./
	 * @return
	 * @throws Exception
	 */
	public RegistrationPage openCustomCommRegistrationUrl() throws Exception
	{
		setSpeed("1000");
		selenium.refresh();
		waitForSeconds(5);
		open("CustomRegistrationURL");
		waitForPageLoad("30000");
		return (RegistrationPage) PageFactory.getNewPage(RegistrationPage.class);		
	}

	public ContactSupportPage clickOnContactSupportLink(){
		clickAndWaitForPageLoad("ContactSupportLink");
		return (ContactSupportPage) PageFactory.getNewPage(ContactSupportPage.class);
	}
	
	public String getAccountNumber(){
		String text =  getText("//table/tbody/tr/td[6]/table/tbody/tr/td[1]/span[@class='accountbar']");
		text = text.replaceAll("Account Number:", "");
		return text.trim();		
	}
	
	
}
