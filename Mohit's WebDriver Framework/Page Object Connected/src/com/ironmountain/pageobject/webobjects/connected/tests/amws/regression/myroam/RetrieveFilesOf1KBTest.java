package com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam;


import java.io.File;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;


import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.MyRoam;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.MyRoamPage;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

/*
 * I could see the test is failing because it the continue button is not enabled for download.
 * This happens when one file is selected for the first time message says "0 files selected"
 * A defect is logged for this and its fixed now.(CB-31798). Need to check if the test fails in latest build.
 */


/**
 * @author jinesh devasia
 *
 */
@SeleniumUITest(HPQCID="6008", defectIds ={"CB-31798"})
public class RetrieveFilesOf1KBTest extends AccountManagementTest {
	
	
	private String retrivedFile = null;
	private String retrivedFileUnzipPath = null;
	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		retrivedFile = FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("downloadsdir") + File.separator + PropertyPool.getProperty("ArchiveFile");
		retrivedFileUnzipPath = retrivedFile.replaceAll(".zip", "")  + File.separator;
		FileUtils.deleteDir(retrivedFile);
		FileUtils.deleteDir(retrivedFileUnzipPath);
		FileUtils.createDirectory(FileUtils.getBaseDirectory() +File.separator + PropertyPool.getProperty("downloadsdir"));
	}
	
	@Parameters({"emailid", "password", "backedupFolder", "commonTestData", "oneKBFile", "originalDataLocation"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testRetrieveFilesOf1KB(String emailid, String password, String backedupFolder, String commonTestData, String oneKBFile, String originalDataLocation) throws Exception
	{
		AccountManagementLogin.login(emailid, password);
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		myRoamPage.clickOnFindBtn();
		myRoamPage.enterSearchText(commonTestData);
		myRoamPage.clickOnFindNextBtn();
		myRoamPage.checkBackedupFolderFromRightPane(oneKBFile);		
		MyRoam.retriveSelectedFilesFromMyRoam(MyRoamPage.WINDOWS_EXECUTABLE_FORMAT, retrivedFileUnzipPath, retrivedFile);
		String downloadedFile = retrivedFileUnzipPath + backedupFolder + File.separator + commonTestData + File.separator + oneKBFile;	
		String originalFile = originalDataLocation + File.separator + commonTestData + File.separator + oneKBFile ;
		Asserter.assertTrue(FileUtils.compareFiles(originalFile , downloadedFile), "Files are not equal!! Compared Files are, Retrieved File : " + downloadedFile + " Original File: " + originalFile);
		AccountManagementLogin.logout();
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		super.stopSeleniumTest();
	}
	
}
