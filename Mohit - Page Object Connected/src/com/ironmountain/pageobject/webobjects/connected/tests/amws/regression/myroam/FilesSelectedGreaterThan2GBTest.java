package com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam;


import java.io.File;
import java.util.ArrayList;

import org.apache.log4j.Logger;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;


import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.utils.DownloadUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.MyRoam;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.MyRoamPage;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest(HPQCID="5999")
public class FilesSelectedGreaterThan2GBTest extends AccountManagementTest{
	
	private static Logger  logger      = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam.FilesSelectedGreaterThan2GBTests");
	
	private static String retrivedFile = null;
	private static String retrivedFileUnzipPath = null;
	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		logger.info("Startign test..initializing");
		super.initAccountManagementTest();
		logger.info("Test initialization completed");
		logger.info("Deleting and recreating dowloded files are folders...");
		retrivedFile = FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("downloadsdir") + File.separator + PropertyPool.getProperty("ArchiveFile");
		retrivedFileUnzipPath = retrivedFile.replaceAll(".zip", "")  + File.separator;
		FileUtils.deleteDir(retrivedFile);
		FileUtils.deleteDir(retrivedFileUnzipPath);
		FileUtils.createDirectory(FileUtils.getBaseDirectory() +File.separator + PropertyPool.getProperty("downloadsdir"));
		logger.info("Downloads Directory creation completed");
	}
	
	@Parameters({"emailid", "password","backedupFolder", "twoGBFolder", "excludeFile", "actualFilesForDownload", "originalDataLocation"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testFilesSelectedGreaterThan2GB(String emailid, String password, String backedupFolder, String twoGBFolder, String excludeFile, String actualFilesForDownload, String originalDataLocation) throws Exception
	{
		logger.info("Actual test method called...Trying to login with email '" + emailid + "' Password '" + password + "'");
		AccountManagementLogin.login(emailid, password);
		logger.info("Navigating to myroam page..");
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		logger.info("Searching for folder.." + twoGBFolder);
		MyRoam.searchAndSelectAllFiles(twoGBFolder);
		logger.info("Clicking on retrieve button..");
		myRoamPage.clickOnRetrieve();
		logger.info("Verifying the large file Warning..");
		myRoamPage.isTextPresentFailOnNotFound(MyRoamPage.LARGEFILE_WARNING);	
		logger.info("Returnign to my roam page..");
		myRoamPage.clickOnReturnToRetrieve();
		logger.info("Unchecking a file to exclue..." + excludeFile);
		myRoamPage.unCheckBackedupFolderFromRightPane(excludeFile);
		myRoamPage.clickOnRetrieve();
		logger.info("Verifying no warning present..");
		Asserter.assertFalse(myRoamPage.isTextPresent(MyRoamPage.LARGEFILE_WARNING, 3),"Warning Text Found even after deselecting few files.");
		logger.info("Trying to download the file..");
		myRoamPage.selectArchiveFormat(MyRoamPage.WINDOWS_EXECUTABLE_FORMAT);
		myRoamPage.clickOnContinue(10);
		logger.info("Trying to click on Download Button");
		myRoamPage.clickOnDownload();
		logger.info("Downloading the zip file...");
		DownloadUtils.handleDownloadDialog("File Download","ArchiveFile");
		logger.info("Unzipping the retrieved files..");
		MyRoam.unzipAndExtractWindowsExecutableMyRoamFile(retrivedFileUnzipPath, retrivedFile);
		ArrayList<String > list1 = StringUtils.toStringArrayList(actualFilesForDownload);
		logger.info("Comparing the files..");
		for (String file : list1) {
			String originalFile = originalDataLocation + File.separator + twoGBFolder+ File.separator + file;
			String downloadedFile = retrivedFileUnzipPath + backedupFolder + File.separator+ twoGBFolder + File.separator + file;
			System.out.println("Comparing files...Retrieved File : " + downloadedFile + " Original File: " + originalFile);
			Asserter.assertTrue(FileUtils.compareFiles(originalFile, downloadedFile), "Files are not equal!! Compared Files are, Retrieved File : " + downloadedFile + " Original File: " + originalFile);
		}	
		logger.info("Loggign out from application...");
		AccountManagementLogin.logout();
		logger.info("Test Completed successfully...");
	}	
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		logger.info("Stopping session...");
		super.stopSeleniumTest();
		logger.info("Session ended...");
	}

	
}
