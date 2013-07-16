package com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam;

import java.io.File;

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
import com.ironmountain.pageobject.pageobjectrunner.utils.ListUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.MyRoam;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.MyRoamPage;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest(HPQCID="17614")
public class DownloadFilesAsWindowsExecutableTest extends AccountManagementTest {

	private static Logger  logger      = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam.DownloadFilesAsWindowsExecutableTest");
	
	private String retrivedFile = null;
	private String retrivedFileUnzipPath = null;

	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		logger.info("Starting test..initializing");
		super.initAccountManagementTest();
		logger.info("Test initialization completed");
		logger.info("Getting Retrieved file location..");
		retrivedFile = FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("downloadsdir") + File.separator + PropertyPool.getProperty("ArchiveFile");
		logger.info("Retrived fiel location is: " + retrivedFile);
		retrivedFileUnzipPath = retrivedFile.replaceAll(".zip", "")  + File.separator;
		logger.info("Deleting directory " + retrivedFile);
		FileUtils.deleteDir(retrivedFile);
		logger.info("deletign directory.." + retrivedFileUnzipPath);
		FileUtils.deleteDir(retrivedFileUnzipPath);
		logger.info("creating downloads directory...");
		FileUtils.createDirectory(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("downloadsdir"));
	}
	
	@Parameters({"emailid", "password", "backedupFolder", "commonTestData", "commonTestDataFilesRetrieveList", "originalDataLocation"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testDownloadFilesAsWindowsExecutable(String emailid, String password,String backedupFolder, String commonTestData,String commonTestDataFilesRetrieveList, String originalDataLocation) throws Exception
	{
		logger.info("Actul test method called...Trying to login with emial '" + emailid + "' Password '" + password + "'");
		String[] testFilesList = ListUtils.getStringListAsArray(StringUtils.toStringArrayList(commonTestDataFilesRetrieveList));
		AccountManagementLogin.login(emailid,password);
		logger.info("Navigating to myroam page..");
		AccountManagementNavigation.viewMyRoamPage();
		logger.info("Selecting files from folder..'" + commonTestData + "' for retrive.." );
		myRoamPage = MyRoam.selectFilesAndGoToRetriveOption(commonTestData);
		Asserter.assertEquals(myRoamPage.getSelectedArchiveFormatLabel(), MyRoamPage.WINDOWS_EXECUTABLE_FORMAT, "Default Format is not correct");
		myRoamPage.clickOnContinue();
		myRoamPage.clickOnDownload();
		logger.info("Downloading the zip file...");
		DownloadUtils.handleDownloadDialog("File Download","ArchiveFile");
		logger.info("Unzippping the file...");
		MyRoam.unzipAndExtractWindowsExecutableMyRoamFile(retrivedFileUnzipPath ,retrivedFile);		
		String downloadedFilePath = retrivedFileUnzipPath + File.separator + backedupFolder + File.separator + commonTestData;
		logger.info("downloaded fiel is.." + downloadedFilePath);
		originalDataLocation = originalDataLocation +  File.separator + commonTestData;
		logger.info("Original file is.." + originalDataLocation);
		logger.info("Comparing fiels...");
		for (int i = 0; i < testFilesList.length; i++) {
			Asserter.assertTrue(FileUtils.compareFiles(originalDataLocation + File.separator + testFilesList[i], downloadedFilePath + File.separator + testFilesList[i]), "Files Compared are: " + originalDataLocation + File.separator + testFilesList[i]+ " and " +downloadedFilePath + File.separator + testFilesList[i]);
		}		
		AccountManagementLogin.logout();
		logger.info("Test completed successfully...");
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		logger.info("Stopping session...");
		super.stopSeleniumTest();
		logger.info("Session ended...");
	}
	
}
