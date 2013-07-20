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
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

/** Test to verify the my roam search feature
* @author pjames
*
*/
@SeleniumUITest
public class MyRoamSearchTest extends AccountManagementTest {
	
	String email=null;
	String password= null;
	
	@BeforeMethod
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		//TestDataProvider.reloadTestData(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" );
		TestDataProvider.reloadTestData(AccountManagementTest.TEST_DATA_XML_FILE_PATH);
		}
	

	/**Tests to verify the my roam search
	 * @param Email
	 * @param Password
	 * @throws Exception
	 */
	@Test(enabled = true, groups= {"amws","mat", "RegistrationAndDownload"})
	public void testMyRoamSearch() throws Exception
			{
				email = TestDataProvider.getTestData("Email");
				password = TestDataProvider.getTestData("Password");
				AccountManagementLogin.login(email, password);
				myRoamPage = AccountManagementNavigation.viewMyRoamPage();
				Asserter.assertEquals(myRoamPage.verifyTitle(), true);
				Asserter.assertEquals(myRoamPage.verifyFindBtn(), true);
				myRoamPage.clickOnFindBtn();
				Asserter.assertEquals(myRoamPage.verifySearchBox(), true);
				Asserter.assertEquals(myRoamPage.verifyFindPrevBtn(), true);
				Asserter.assertEquals(myRoamPage.verifyFindPrevBtn(), true);
				Asserter.assertEquals(myRoamPage.verifySearchCloseBtn(), true);
				
				myRoamPage.clickOnCloseSearch();
				Asserter.assertEquals(myRoamPage.verifySearchBox(), false);
				Asserter.assertEquals(myRoamPage.verifyFindPrevBtn(), false);
				Asserter.assertEquals(myRoamPage.verifyFindPrevBtn(), false);
				Asserter.assertEquals(myRoamPage.verifySearchCloseBtn(), false);
				
			}
	
	@AfterMethod
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}

}