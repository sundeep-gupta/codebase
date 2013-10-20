/**
 * 
 */
package com.ironmountain.pageobject.webobjects.connected.tests;

import java.io.File;

import org.testng.log4testng.Logger;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.AccountHistoryPage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.AccountManagementHomePage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.AccountManagementLoginPage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.ChangePasswordPage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.ContactSupportPage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.EditProfilePage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.EnterRegistrationDetails;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.MyRoamPage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.NetworkLogonPage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.OrderCdOrDvdConfirmationPage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.OrderCdOrDvdForm1Page;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.OrderCdOrDvdForm2Page;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.RegistrationCompletePage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.RegistrationDeclinedPage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.RegistrationLicensePage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.RegistrationPage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.ReinstallAgentPage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.SelectBackupAccountPage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.SummaryPage;

/**
 * @author Jinesh Devasia
 *
 */
public class AccountManagementTest extends SeleniumTest{

	private Logger logger = Logger.getLogger(AccountManagementTest.class);

	public static String TEST_DATA_XML_FILE_PATH = FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("accountmanagementtestdatadir");
	public static String TEST_DATA_XML_FILE = TEST_DATA_XML_FILE_PATH + File.separator + "amwsdataprovider.xml" ;

	
	protected AccountManagementLoginPage accMgmtLoginPage = null;
    protected AccountManagementHomePage accMgmtHomePage = null;
    protected AccountHistoryPage accountHistoryPage = null;
    protected ContactSupportPage contactSupportPage = null;
    protected EditProfilePage editProfilePage = null;
    protected MyRoamPage myRoamPage = null;
    protected ReinstallAgentPage reinstallAgentPage = null;
    protected SelectBackupAccountPage selectBackupAccountPage = null;
    protected SummaryPage summaryPage = null;   
    protected ChangePasswordPage changePasswordPage = null;
    protected RegistrationPage registrationPage = null;
    protected RegistrationLicensePage registrationLicensePage = null;
    protected RegistrationCompletePage registrationCompletePage = null;
    protected EnterRegistrationDetails enterRegistrationDetailsPage = null;
	protected RegistrationDeclinedPage registrationDeclinepage = null;
    protected EnterRegistrationDetails enterRegisrtationDetailsPage = null;
    protected OrderCdOrDvdForm1Page orderCdorDvdForm1Page = null;
    protected OrderCdOrDvdForm2Page orderCdorDvdForm2Page = null;
    protected OrderCdOrDvdConfirmationPage orderCdOrDvdConfirmationPage = null;
    protected NetworkLogonPage networkLogonPage = null;
        
    
	protected final void initAccountManagementTest()throws Exception {
		initAccountManagementTest("");
	}
	
	protected final void initAccountManagementTest(String browser)throws Exception {
		super.init();		
		AccountManagementTest.loadAccountManagementTestData();
		applicationProtocol = PropertyPool.getProperty("accountmanagementprotocol");
		applicationHostname = PropertyPool.getProperty("accountmanagementurl");
		applicationPort = PropertyPool.getProperty("accountmanagementport");
		appendUrl = PropertyPool.getProperty("accountmanagementappendurl");	
		loadDataCenterInfo();
		
		/*
		 * Checking the Skip Test Feature
		 */
		resetSkipTestValue();	
		super.initSeleniumTest(applicationProtocol, applicationHostname, applicationPort, appendUrl, browser);
		PageFactory.setNewPage(AccountManagementLoginPage.class);	
		
	}
	
	public void stopSeleniumTest() throws Exception{
		super.stopSeleniumTestEnableSkipTest(TEST_DATA_XML_FILE,SupportCenterTest.TEST_DATA_XML_FILE);
	}
	
	public static void loadAccountManagementTestData(){
		TestDataProvider.loadTestData(TEST_DATA_XML_FILE_PATH);
	}
		
	/**
	 * Method to check the Skip Test value 
	 */
	public void resetSkipTestValue(){
		if(resetSkipTests){
			resetSkipTestsIfFailedInTestDataProvider(TEST_DATA_XML_FILE, SupportCenterTest.TEST_DATA_XML_FILE);
		}
	}
	
	/*
	 *  Loading and initializing DataCenter properties
	 */	
	public static boolean isDCMirrored = false;
	public static boolean isDCClustered = false;
	public static String customerFolder = null;
	public static String primaryDataCenterRegistryMachineName = null;
	public static String secondaryDataCenterRegistryMachineName = null;
	public static String primaryDataCenterDirectoryMachineName = null;
	public static String secondaryDataCenterDirectoryMachineName = null;
	
	public static void loadDataCenterInfo(){
		
		if(PropertyPool.getProperty("DataCenterMirrored").equalsIgnoreCase("yes") ){
			isDCMirrored = true;
		}
		if(PropertyPool.getProperty("DataCenterClustered").equalsIgnoreCase("yes") ){
			isDCClustered = true;
		}
		customerFolder = "Customers" ; //PropertyPool.getProperty("CustomerFolderLocation");
		primaryDataCenterRegistryMachineName = PropertyPool.getProperty("PrimaryDataCenterRegistryMachineName");
		secondaryDataCenterRegistryMachineName = PropertyPool.getProperty("SecondaryDataCenterRegistryMachineName");
		primaryDataCenterDirectoryMachineName = PropertyPool.getProperty("PrimaryDataCenterDirectoryMachineName");
		secondaryDataCenterDirectoryMachineName = PropertyPool.getProperty("SecondaryDataCenterDirectoryMachineName");
	}

		
}
