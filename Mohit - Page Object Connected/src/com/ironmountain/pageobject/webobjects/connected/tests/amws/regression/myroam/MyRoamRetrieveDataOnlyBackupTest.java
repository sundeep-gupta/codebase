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
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.MyRoam;
import com.ironmountain.pageobject.webobjects.connected.actions.testrunner.ActionRunner;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.MyRoamPage;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest(priority=28, HPQCID="5979")
public class MyRoamRetrieveDataOnlyBackupTest extends
		AccountManagementTest {

	private static Logger  logger      = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam.MyRoamRetrieveDataOnlyBackupTest");
	
	private String retrivedFile = null;
	private String retrivedFileUnzipPath = null;
	
	/**
	 * This name is from the TestRunner file "MyRoamRegressionDeleteArchiveBackup.xml", if we change the name there in any case
	 * we need to modify this name as well;
	 */
	private static final String DELETE_ARCHIVE_BACKUP_FILE = "MyRoamRegressionDataOnlyFolderBackup.xml";
	
	private static final String archivedFile = "0-DataOnlyFile.txt";
	private static final String backupFolder = "MyRoamRegressionData";
	private static final String archiveDeleteFolder = "DataOnlyFolder";
	private static final String archiveDeleteFileOriginalPath = "C:\\" + backupFolder + File.separator + archiveDeleteFolder ;
	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		logger.info("Starting test..initializing");
		super.initAccountManagementTest();
		logger.info("Test initialization completed");
		
		retrivedFile = FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("downloadsdir") + File.separator + PropertyPool.getProperty("ArchiveFile");
		retrivedFileUnzipPath = retrivedFile.replaceAll(".zip", "")  + File.separator ;
		FileUtils.deleteDir(retrivedFile);
		FileUtils.deleteDir(retrivedFileUnzipPath);
		FileUtils.createDirectory(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("downloadsdir"));
	}
	
	@Parameters({"emailid", "password"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testCancelRetriveButtonInMyRoamPage(String emailid, String password) throws Exception
	{			
		logger.info("Actul test method called...Trying to login with email '" + emailid + "' Password '" + password + "'");
		AccountManagementLogin.login(emailid, password);
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		logger.info("Checking for the fiel already backedup..");
		runBackupIfFileNotPresent(archivedFile, DELETE_ARCHIVE_BACKUP_FILE);
		logger.info("Logging out from application...");
		AccountManagementLogin.logout();
			
		logger.info("Loggig in again...");
		AccountManagementLogin.login(emailid, password);
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		logger.info("Search and retrieve file.." + archivedFile);
		MyRoam.searchAndSelectAllFiles(archivedFile);
		MyRoam.retriveSelectedFilesFromMyRoam(MyRoamPage.WINDOWS_EXECUTABLE_FORMAT, retrivedFileUnzipPath, retrivedFile);
		for (int i = 0; i < 5 ; i++) {
			String file = i + "-DataOnlyFile.txt";
			String retrievedFile = retrivedFileUnzipPath + backupFolder + File.separator + archiveDeleteFolder + File.separator + file;	
			logger.info("Retrieved fiel is..." + retrievedFile);
			String originalFile = archiveDeleteFileOriginalPath + File.separator + file;
			logger.info("Original file to compare is.." + originalFile);
			logger.info("Comparing files..");
			Asserter.assertTrue(FileUtils.compareFiles(originalFile, retrievedFile), "Failed:" + originalFile + " And Retrieved File " + retrievedFile + "not correcrt");
		}
	}
	
	public void runBackupIfFileNotPresent(String archivedFile, String runnerFile) throws Exception{
		myRoamPage.clickOnFindBtn();
		myRoamPage.enterSearchText(archivedFile);
		myRoamPage.clickOnFindNextBtn();
		if(! myRoamPage.isBackedupItemPresentInRightPane(archivedFile)){
			logger.info("File is not backed up...Running backupRunner..");
			ActionRunner.run(runnerFile);
		}
	}	
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{		
		
		logger.info("Stopping session...");
		super.stopSeleniumTest();
		logger.info("Session ended...");
	}
	
}
