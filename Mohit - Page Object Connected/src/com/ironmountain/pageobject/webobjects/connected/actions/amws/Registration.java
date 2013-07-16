package com.ironmountain.pageobject.webobjects.connected.actions.amws;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.framework.LocatorPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.utils.DownloadUtils;
import com.ironmountain.pageobject.webobjects.connected.actions.InstallUtils;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.AccountManagementHomePage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.RegistrationCompletePage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.ReinstallAgentPage;

/**
 * @author Jinesh Devasia
 *
 *This class will be used to register the accounts
 */
public class Registration {
	
	private static Logger  logger      = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.actions.amws.Registration");

	private static String summaryPageTitle = LocatorPool.getLocator("SummaryPageTitle");
		
	public static void registerAnAccount(String firstName, String lastName, String email, String password, String confirmPassword, 
			String employeeId) throws Exception{		
		AccountManagementNavigation.viewEnterRegistrationDetails();
		EnterRegisterationDetails.enterFields(firstName, lastName, email, password, confirmPassword, employeeId);		
	}
	
	public static void registerAnAccount(String firstName, String lastName, String email, String password, String confirmPassword) throws Exception{		
		AccountManagementNavigation.viewEnterRegistrationDetails();
		EnterRegisterationDetails.enterFields(firstName, lastName, email, password, confirmPassword);		
	}
	public static void registerAnAccountWithRegistrationUrl(String registrationUrl, String firstName, String lastName, String email, String password, String confirmPassword) throws Exception{		
		AccountManagementNavigation.viewEnterRegistrationDetails(registrationUrl);
		EnterRegisterationDetails.enterFields(firstName, lastName, email, password, confirmPassword);		
	}
	public static void registerAnAccount(String firstName, String middleName, String lastName, String email, String password, String confirmPassword, 
			String company, String location, String employeeId, String customField, String country, String addressLine1,String addressLine2, String addressLine3,
			String city, String state, String zipCode, String phoneNumber ) throws Exception{		
		AccountManagementNavigation.viewEnterRegistrationDetails();
		EnterRegisterationDetails.enterAllFields(firstName, middleName, lastName, email, password, confirmPassword, 
				company, location, employeeId, customField, country, addressLine1,addressLine2,addressLine3,
				city, state, zipCode, phoneNumber )	;
	}
	public static void registerAnAccount(String registrationUrl, String firstName, String middleName, String lastName, String email, String password, String confirmPassword, 
			String company, String location, String employeeId, String customField, String country, String addressLine1,String addressLine2, String addressLine3,
			String city, String state, String zipCode, String phoneNumber ) throws Exception{		
		AccountManagementNavigation.viewEnterRegistrationDetails(registrationUrl);
		EnterRegisterationDetails.enterAllFields(firstName, middleName, lastName, email, password, confirmPassword, 
				company, location, employeeId, customField, country, addressLine1,addressLine2,addressLine3,
				city, state, zipCode, phoneNumber )	;
	}
	public static void registerUserIfNotPresent(String firstName, String lastName, String email, String password, String confirmPassword, 
			String employeeId) throws Exception{
		AccountManagementHomePage accHome = AccountManagementLogin.login(email, password);
		if(! accHome.getTitle().contains(summaryPageTitle)){
			logger.info("User was not in Home/Summary Page..means not existing..");
			logger.info("Registerign the User...");
			registerAnAccount(firstName, lastName, email, password, confirmPassword, employeeId);
		}
	}
	
	public static void registerUserIfNotPresentWithCustomRegistrationURL(String registrationURL, String firstName, String lastName, 
			String email, String password, String employeeId) throws Exception{
		AccountManagementHomePage accHome = AccountManagementLogin.login(email, password);
		if(! accHome.getTitle().contains(summaryPageTitle)){
			registerAnAccountWithRegistrationUrlAndCustomField(registrationURL, firstName, lastName, email, password, employeeId);
		}
	}
	public static void registerAnAccountWithRegistrationUrlAndCustomField(String registrationUrl, String firstName, String lastName, String email, String password, String employeeId) throws Exception{		
		AccountManagementNavigation.viewEnterRegistrationDetails(registrationUrl);
		EnterRegisterationDetails.enterFields(firstName, lastName, email, password, password, employeeId);
	}
	public static void registerUserIfNotPresentWithRegistrationUrl(String registrationUrl,  String firstName, String lastName, String email, String password, String confirmPassword) throws Exception{
		AccountManagementHomePage accHome = AccountManagementLogin.login(email, password);
		if(! accHome.getTitle().contains(summaryPageTitle)){
			registerAnAccountWithRegistrationUrl(registrationUrl, firstName, lastName, email, password, confirmPassword);
		}
		accHome.waitForSecond();
	}
	public static void registerUserIfNotPresent(String firstName, String middleName, String lastName, String email, String password, String confirmPassword, 
			String company, String location, String employeeId, String customField, String country, String addressLine1,String addressLine2, String addressLine3,
			String city, String state, String zipCode, String phoneNumber ) throws Exception{
		AccountManagementHomePage accHome = AccountManagementLogin.login(email, password);
		if(! accHome.getTitle().contains(summaryPageTitle)){
			registerAnAccount(firstName, middleName, lastName, email, password, confirmPassword, 
					company, location, employeeId, customField, country, addressLine1,addressLine2,addressLine3,
					city, state, zipCode, phoneNumber )	;
		}
	}
	public static void downloadAndInstallAgentAfterRegisteringIfAccNotPresent(String registrationUrl, String Email, String Password, String FirstName, String LastName) throws Exception{
		ReinstallAgentPage reinstallAgentPage = (ReinstallAgentPage)PageFactory.getNewPage(ReinstallAgentPage.class);
		RegistrationCompletePage registrationCompletePage = (RegistrationCompletePage)PageFactory.getNewPage(RegistrationCompletePage.class);
		AccountManagementHomePage accHome = AccountManagementLogin.login(Email, Password);
		if(accHome.getTitle().contains(summaryPageTitle)){
			reinstallAgentPage = accHome.clickOnReinstallAgent();	
			reinstallAgentPage.clickOnDownloadSoftwareButton();
			reinstallAgentPage.clickOnBeginDownloadButton();
			// Downloading the Agent using the Autoit acripts
			DownloadUtils.handleDownloadDialog("File Download - Security Warning","AgentSetupFile");
			reinstallAgentPage.waitForSeconds(20);
			InstallUtils.installAgent("AgentSetupFile",Email, Password);
			reinstallAgentPage.waitForSeconds(20);  
		} else {
			AccountManagementNavigation.viewEnterRegistrationDetails(registrationUrl);
			registrationCompletePage = EnterRegisterationDetails.enterFields(FirstName, LastName, Email, Password, Password);		
			registrationCompletePage.clickOnDownloadSoftware();
			registrationCompletePage.waitForSeconds(30);
			registrationCompletePage.clickOnBeginDownload();
			// Downloading the Agent using the Autoit acripts
			DownloadUtils.handleDownloadDialog("File Download - Security Warning","AgentSetupFile");
			registrationCompletePage.waitForSeconds(20);
			InstallUtils.installAgent("AgentSetupFile",Email, Password);
			registrationCompletePage.waitForSeconds(20);  
		}
			
	}
	
	
}
