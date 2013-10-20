package com.ironmountain.pageobject.webobjects.connected.navigations.amws;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.AccountHistoryPage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.AccountManagementHomePage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.ChangePasswordPage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.ContactSupportPage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.EditProfilePage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.EnterRegistrationDetails;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.MyRoamPage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.OrderCdOrDvdForm1Page;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.RegistrationCompletePage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.RegistrationDeclinedPage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.RegistrationLicensePage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.RegistrationPage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.ReinstallAgentPage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.SummaryPage;


public class AccountManagementNavigation {

	public static AccountHistoryPage viewAccountHistoryPage() throws Exception
	{
		AccountManagementHomePage accMgmtHomePage = (AccountManagementHomePage) PageFactory.getNewPage(AccountManagementHomePage.class);
		return (AccountHistoryPage) accMgmtHomePage.clickOnViewHistory();
	}
	public static EditProfilePage viewEditProfilePage() throws Exception
	{
		AccountManagementHomePage accMgmtHomePage = (AccountManagementHomePage) PageFactory.getNewPage(AccountManagementHomePage.class);
		return (EditProfilePage) accMgmtHomePage.clickOnEditProfile();
	}
	/** Navigates to ReinstallAgentPage
	 * @return
	 * @throws Exception
	 */
	public static ReinstallAgentPage viewReinstallAgentPage() throws Exception
	{
		AccountManagementHomePage accMgmtHomePage = (AccountManagementHomePage) PageFactory.getNewPage(AccountManagementHomePage.class);
		return (ReinstallAgentPage) accMgmtHomePage.clickOnReinstallAgent();
	}

	public static SummaryPage viewAccountSummaryPage() throws Exception
	{
		AccountManagementHomePage accMgmtHomePage = (AccountManagementHomePage) PageFactory.getNewPage(AccountManagementHomePage.class);
		return (SummaryPage) accMgmtHomePage.clickOnSummary();
	}
	
	public static ChangePasswordPage viewChagePasswordPage() throws Exception
	{
		EditProfilePage editProfilePage = viewEditProfilePage();
		return (ChangePasswordPage) editProfilePage.clickOnChangePasswordButton();
	}
	public static OrderCdOrDvdForm1Page viewOrderCdOrDvdsPage() throws Exception
	{
		AccountManagementHomePage accMgmtHomePage = (AccountManagementHomePage) PageFactory.getNewPage(AccountManagementHomePage.class);
		return (OrderCdOrDvdForm1Page) accMgmtHomePage.clickOnOrderCDsorDVDs();
	}
	/** Navigates to MyRoamPage
	 * @return
	 * @throws Exception
	 */
	public static MyRoamPage viewMyRoamPage() throws Exception
	{
		AccountManagementHomePage accMgmtHomePage = (AccountManagementHomePage) PageFactory.getNewPage(AccountManagementHomePage.class);
		return (MyRoamPage) accMgmtHomePage.clickOnRetrieveFilesWithMyRoam();
	}
	
	/** Navigates to RegistrationPage
	 * @return
	 * @throws Exception
	 */
	public static RegistrationPage viewRegistrationPage() throws Exception
	{
		AccountManagementHomePage accMgmtHomePage = (AccountManagementHomePage) PageFactory.getNewPage(AccountManagementHomePage.class);
		return (RegistrationPage) accMgmtHomePage.openRegistrationUrl();
	}
	/**
	 * View the Registration Page by providing the Registration URL
	 * 
	 * @param registrationUrl
	 * @return
	 * @throws Exception
	 */
	public static RegistrationPage viewRegistrationPage(String registrationUrl) throws Exception
	{
		AccountManagementHomePage accMgmtHomePage = (AccountManagementHomePage) PageFactory.getNewPage(AccountManagementHomePage.class);
		RegistrationPage regPage = accMgmtHomePage.openRegistrationUrl(registrationUrl);
		accMgmtHomePage.waitForSeconds(3);
		return (RegistrationPage) regPage; 
	}
	
	/** Navigates to RegistrationLicensePage
	 * @return
	 * @throws Exception
	 */
	public static RegistrationLicensePage viewRegistrationLicensePage() throws Exception
	{
		RegistrationPage registrationPage = viewRegistrationPage();
		return (RegistrationLicensePage) registrationPage.ClickOnRegisterAndDownloadBtn();
	}
	public static RegistrationLicensePage viewRegistrationLicensePage(String registrationUrl) throws Exception
	{
		RegistrationPage registrationPage = viewRegistrationPage(registrationUrl);
		return (RegistrationLicensePage) registrationPage.ClickOnRegisterAndDownloadBtn();
	}
	
	/** Navigates to RegistrationDeclinedPage
	 * @return
	 * @throws Exception
	 */
	public static RegistrationDeclinedPage viewRegistrationDeclinePage() throws Exception
	{
		RegistrationLicensePage registrationLicensePage = viewRegistrationLicensePage();
		return (RegistrationDeclinedPage) registrationLicensePage.clickOnDeclineBtn();
	}
	
	
	/** Navigates to EnterRegistrationDetails Page
	 * @return
	 * @throws Exception
	 */
	public static EnterRegistrationDetails viewEnterRegistrationDetails() throws Exception
	{
		RegistrationLicensePage registrationLicensePage = viewRegistrationLicensePage();
		return (EnterRegistrationDetails) registrationLicensePage.clickOnAcceptBtn();
	}
	public static EnterRegistrationDetails viewEnterRegistrationDetails(String registrationUrl) throws Exception
	{
		RegistrationLicensePage registrationLicensePage = viewRegistrationLicensePage(registrationUrl);
		return (EnterRegistrationDetails) registrationLicensePage.clickOnAcceptBtn();
	}
	/** Navigates to RegistrationCompletePage
	 * @return
	 * @throws Exception
	 */
	public static RegistrationCompletePage viewRegistrationCompletePage() throws Exception
	{
		EnterRegistrationDetails enterRegistrationDetails = viewEnterRegistrationDetails();
		return (RegistrationCompletePage) enterRegistrationDetails.clickContinue();
	}
	
	/** Navigates to LDAP RegistrationPage
	 * @return
	 * @throws Exception
	 */
	public static RegistrationPage viewLDAPRegistrationPage() throws Exception
	{
		AccountManagementHomePage accMgmtHomePage = (AccountManagementHomePage) PageFactory.getNewPage(AccountManagementHomePage.class);
		return (RegistrationPage) accMgmtHomePage.openLDAPRegistrationUrl();
	}	
	
	public static ContactSupportPage viewContactSupportPage(){
		AccountManagementHomePage accMgmtHomePage = (AccountManagementHomePage) PageFactory.getNewPage(AccountManagementHomePage.class);
		return accMgmtHomePage.clickOnContactSupportLink();		
	}
	
	/** Navigates to Custom Community RegistrationPage
	 * @return
	 * @throws Exception
	 */
	public static RegistrationPage viewCustomCommunityRegistrationPage() throws Exception
	{
		AccountManagementHomePage accMgmtHomePage = (AccountManagementHomePage) PageFactory.getNewPage(AccountManagementHomePage.class);
		return (RegistrationPage) accMgmtHomePage.openCustomCommRegistrationUrl();
	}	
	
	
}
