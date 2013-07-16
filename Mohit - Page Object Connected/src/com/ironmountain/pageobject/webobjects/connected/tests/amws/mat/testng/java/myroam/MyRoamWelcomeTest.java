package com.ironmountain.pageobject.webobjects.connected.tests.amws.mat.testng.java.myroam;

import java.io.File;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.database.registry.CdqTable;
import com.ironmountain.pageobject.webobjects.connected.database.registry.CustomerTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;


/** Test to verify the my roam welcome screen
 * @author pjames
 *
 */
@SeleniumUITest
public class MyRoamWelcomeTest extends AccountManagementTest {
	

	
	CustomerTable customerTable = null;
	String email=null;
	String password= null;
	
	@BeforeMethod
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		//TestDataProvider.reloadTestData(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" );
		TestDataProvider.reloadTestData(AccountManagementTest.TEST_DATA_XML_FILE_PATH);
		customerTable = new CustomerTable(DatabaseServer.COMMON_SERVER);
	}
	
	/**Tests to verify the My roam welcome screen
	 * @param Email
	 * @param Password
	 * @param FirstName
	 * @param LastName
	 * @param AccountNumber
	 * @param ComputerName
	 * @throws Exception
	 */
	@Parameters({"FirstName", "LastName"})
	@Test(enabled = true, groups= {"amws","mat", "MyRoam"})
	public void testMyRoamWelcome(String FirstName, String LastName) throws Exception
			{
				email = TestDataProvider.getTestData("Email");
				password = TestDataProvider.getTestData("Password");
				AccountManagementLogin.login(email, password);
				myRoamPage = AccountManagementNavigation.viewMyRoamPage();
				Asserter.assertEquals(myRoamPage.verifyTitle(), true);
				Asserter.assertEquals(myRoamPage.verifyWelcomeName(FirstName, LastName), true);
				String acc = String.valueOf(customerTable.getAccountNumber(email));
				acc = StringUtils.getUiFormattedAccountNumber(acc);
				Asserter.assertEquals(myRoamPage.verifyAccountNumber(acc), true);
				//Asserter.assertEquals(myRoamPage.verifyComputerName(ComputerName), true);
				Asserter.assertEquals(myRoamPage.verifyBrowseBtn(), true);
				Asserter.assertEquals(myRoamPage.verifyTree(), true);
				
			}
	
	@AfterMethod
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}

}
