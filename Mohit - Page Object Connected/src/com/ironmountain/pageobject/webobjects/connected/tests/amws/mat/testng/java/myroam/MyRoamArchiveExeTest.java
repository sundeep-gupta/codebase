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
import com.ironmountain.pageobject.pageobjectrunner.utils.DownloadUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

/** Test to verify the my roam archive format feature
* @author pjames
*
*/
@SeleniumUITest
public class MyRoamArchiveExeTest extends AccountManagementTest {
	
	String email=null;
	String password= null;
	
	@BeforeMethod
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		//TestDataProvider.reloadTestData(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir")+ File.separator + "scdataprovider.xml" );
		TestDataProvider.reloadTestData(AccountManagementTest.TEST_DATA_XML_FILE_PATH);
		}
	

	
	/** Tests to verify the My Roam Archive exe format
	 * @param Email
	 * @param Password
	 * @param ShowVersionsValue
	 * @param searchText
	 * @param windowsZipText
	 * @param windowsExeText
	 * @throws Exception
	 */
	@Parameters({"searchText", "windowsZipText", "windowsExeText"})
	@Test(enabled = true, groups= {"amws","mat", "RegistrationAndDownload"})
	public void testMyRoamArchiveFormats(String searchText, String windowsZipText,String windowsExeText) throws Exception
			{
		
				email = TestDataProvider.getTestData("Email");
				password = TestDataProvider.getTestData("Password");
				AccountManagementLogin.login(email, password);
				myRoamPage = AccountManagementNavigation.viewMyRoamPage();
				Asserter.assertEquals(myRoamPage.verifyTitle(), true);
				myRoamPage.clickOnFindBtn();
				myRoamPage.enterSearchText(searchText);
				myRoamPage.clickOnFindBtn();
				myRoamPage.clickOnFindNextBtn();
				myRoamPage.checkRetrieveFile();
				myRoamPage.clickOnRetrieve();
				Asserter.assertEquals(myRoamPage.verifyArchiveFormatCombo(), true);
				String[] ArcFormats = myRoamPage.getArchiveFormats();
				Asserter.assertEquals(ArcFormats[1], windowsZipText);
				Asserter.assertEquals(ArcFormats[0], windowsExeText);
				myRoamPage.selectArchiveFormat(windowsExeText);
				myRoamPage.clickOnReturnToRetrieve();
				Asserter.assertEquals(myRoamPage.verifyTitle(), true);
				myRoamPage.clickOnFindBtn();
				myRoamPage.enterSearchText("c:"+File.separator+"BackupData"+File.separator+searchText);
				myRoamPage.clickOnFindBtn();
				myRoamPage.clickOnFindNextBtn();
				myRoamPage.checkRetrieveFile();
				myRoamPage.clickOnRetrieve();
				myRoamPage.clickOnContinue();
				myRoamPage.waitForSeconds(5);
				myRoamPage.clickOnDownload();
				DownloadUtils.handleDownloadDialog("File Download","ArchiveFile");
			}
	
	@AfterMethod
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}


}
