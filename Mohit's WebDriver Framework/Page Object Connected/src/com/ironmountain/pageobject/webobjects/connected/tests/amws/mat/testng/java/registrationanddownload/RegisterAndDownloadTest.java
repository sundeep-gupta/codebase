package com.ironmountain.pageobject.webobjects.connected.tests.amws.mat.testng.java.registrationanddownload;

import java.io.File;

import org.testng.Assert;
import org.apache.log4j.Logger;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.DownloadUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.InstallUtils;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.EnterRegisterationDetails;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.OrderMedia;
import com.ironmountain.pageobject.webobjects.connected.database.DataBase;
import com.ironmountain.pageobject.webobjects.connected.database.registry.CustomerTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;
@SeleniumUITest(priority=1)
public class RegisterAndDownloadTest extends AccountManagementTest {
	private static Logger  logger      = Logger.getLogger(RegisterAndDownloadTest.class.getName());
	String email =null;
	String password=null;
	int commId = 0;
	int Acct_no = 0;
	String server = null;
	 private static CustomerTable custTable = null;
	@BeforeMethod
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		server = PropertyPool.getProperty("PrimaryDataCenterRegistryMachineName");
		logger.info(server);
		custTable = new CustomerTable(DatabaseServer.PRIMARY_REGISTRY_SERVER);
		TestDataProvider.reloadTestData(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" );
	}
	
	/**
	 * @param FirstName
	 * @param MiddleName
	 * @param LastName
	 * @param Email
	 * @param Password
	 * @param ConfirmPassword
	 * @param Company
	 * @param Country
	 * @param AddressLine1
	 * @param AddressLine2
	 * @param AddressLine3
	 * @param City
	 * @param State
	 * @param ZipCode
	 * @param PhoneNumber
	 * @throws Exception
	 */
	@Parameters( {"FirstName", "MiddleName", "LastName", "ConfirmPassword", "Company", 
		"Country", "AddressLine1", "AddressLine2", "AddressLine3", "City", "State", "ZipCode", "PhoneNumber","Password"})
	@Test(enabled = true, groups= {"amws","mat", "RegistrationAndDownload"})
	public void testEnterDetailsandDownload(String FirstName, String MiddleName, String LastName, String ConfirmPassword, 
			String Company, String Country, String AddressLine1,String AddressLine2,String AddressLine3,
			String City, String State, String ZipCode, String PhoneNumber,String Password ) throws Exception{
		
		//Enter the details and navigate to complete page
		email = StringUtils.createNameVal()+"register@cb.com";
		TestDataProvider.setTestDataToXmlFile(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" , "Email", email);
		email = TestDataProvider.getTestData("Email");
		password = TestDataProvider.getTestData("Password");
		AccountManagementNavigation.viewEnterRegistrationDetails();
		registrationCompletePage = EnterRegisterationDetails.enterAllFields(FirstName, MiddleName, LastName, email,password, ConfirmPassword, Company, Country, 
											AddressLine1, AddressLine2, AddressLine3, City, State, ZipCode, PhoneNumber);
		Assert.assertEquals(registrationCompletePage.verifyAccNumExists(), true);
		Assert.assertEquals(registrationCompletePage.getName(), (FirstName +" "+ LastName));
		Assert.assertEquals(registrationCompletePage.getEmailAdd(), email);
		//Using the default community which has the community id 1
		commId = 1;
		Acct_no = custTable.getAccountNumber(email);
		logger.info(Acct_no);
		String s = new Integer(Acct_no).toString();
		//Converting account number from nine digit format to ten digit format
		String Acct2 = custTable.getUiFormattedAccountNumber(s);
		logger.info(Acct2);
		//Downloading agent msi using ssws api
		InstallUtils.lgenerateAgentSetup_SSWSAPI(commId, Acct2, Password, server);
		InstallUtils.installAgent("AgentSetupFile",email,password );
		registrationCompletePage.waitForSeconds(20);  
		//Verify the details entered on the Enter Registration Details Page.
		AccountManagementLogin.login(email,password);
		editProfilePage = AccountManagementNavigation.viewEditProfilePage();
		Assert.assertEquals(editProfilePage.getFirstName(),FirstName) ;
		Assert.assertEquals(editProfilePage.getMiddleName(),MiddleName);
		Assert.assertEquals(editProfilePage.getLastName(),LastName);
		Assert.assertEquals(editProfilePage.getEmailAddress(), email);
		Assert.assertEquals(editProfilePage.getCompany(), Company);
		Assert.assertEquals(editProfilePage.getAddressLine("1"), AddressLine1);
		Assert.assertEquals(editProfilePage.getAddressLine("2"), AddressLine2);
		Assert.assertEquals(editProfilePage.getAddressLine("3"), AddressLine3);;
		Assert.assertEquals(editProfilePage.getCity(), City);
		Assert.assertEquals(editProfilePage.getZipCode(), ZipCode);
		Assert.assertEquals(editProfilePage.getPhoneNumber(), PhoneNumber);
		
	}
	/**
	 * Closing all the database connections
	 */
	@AfterMethod(alwaysRun = true)
	public void closeDataBaseConnections(){
		if(!skipTest){
		DataBase.closeDatabaseConnections(custTable);
	}
	}

	@AfterMethod
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}	
}



