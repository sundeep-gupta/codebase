package com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam;

import java.io.File;
import java.util.ArrayList;


import org.apache.log4j.Logger;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.digital.qa.automation.connected.compaction.Compactor;
import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;

import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.MyRoam;
import com.ironmountain.pageobject.webobjects.connected.actions.testrunner.ActionRunner;
import com.ironmountain.pageobject.webobjects.connected.database.DataBase;
import com.ironmountain.pageobject.webobjects.connected.database.directory.FileIndexTable;
import com.ironmountain.pageobject.webobjects.connected.database.directory.PoolIndexTable;
import com.ironmountain.pageobject.webobjects.connected.database.registry.ExpireRulesTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.MyRoamPage;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest(HPQCID="39132")
public class MyRoamRetrievalofAllVersionTest extends AccountManagementTest {

    private static Logger  logger      = Logger.getLogger("MyRoamRetrievalofAllVersionTest");
    
    /*
     * Reference Tables
     */
    private String accountNo = null;
    private FileIndexTable fileIndexTable = null;
	private PoolIndexTable poolIndexTablePrimary = null;	
	private PoolIndexTable poolIndexTableSecondary = null;
	private ExpireRulesTable expRulesTable = null;
    
    private static final String BACKUP_FOLDER = "MyRoamRegressionData";
    private static final String TEST_FOLDER_NAME = "VersionFolder";
    private static final String TEST_FILE_NAME = "VersionTestFile.txt";
    private static final String TEST_FILE_NAME_NEW = "VersionTestFileNew.txt";
    private static final String TEST_FILE_NAME_DELTA_RETIEVED = "VersionTestFile Retrieved 1.txt";
	
	/**
	 * This name is from the TestRunner file "MyRoamRegressionDelta*****Backup.xml", if we change the name there in any case
	 * we need to modify this name as well;
	 */
    private static final String TEST_RUNNER_FILE_BACKUP = "MyRoamRegressionDummyBackup.xml";
	private static final String VERSION_BACKUP_FILE = "MyRoamRegressionVersionBackup.xml";
	private static final String VERSION_FILE_ORIGINAL_PATH = "C:\\" + BACKUP_FOLDER + File.separator + TEST_FOLDER_NAME ;
	private static final String VERSION_FILE_TEMP_PATH = "C:\\" + TEST_FOLDER_NAME ;
	
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
	
	@Parameters({"emailid", "password"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testMyRoamRetrievalofAllVersion(String emailid, String password) throws Exception
	{
		logger.info("Actul test method called...Trying to login with emial '" + emailid + "' Password '" + password + "'");
		initDatabaseTables();
		expRulesTable.setDeletedRevs("0");
		accMgmtHomePage = AccountManagementLogin.login(emailid, password);
		String accNo = accMgmtHomePage.getAccountNumber();
		accountNo = fileIndexTable.getDbFormattedAccountNumber(accNo);
		logger.debug("Account number from my Roam is: " + accountNo);
		logger.info("Navigating to myroam page..");
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		logger.info("Checking if the backup is already done..");
		runBackupIfFileNotPresent(TEST_FILE_NAME, VERSION_BACKUP_FILE);
		AccountManagementLogin.logout();
		
		/*
		 * After Backup login again and Verify the File Versions
		 */
		accMgmtHomePage = AccountManagementLogin.login(emailid, password);
		logger.info("Navigating to myroam page..");
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		logger.info("Verifying the default show version label..");
		myRoamPage.selectVersionOption("All");		
		logger.info("Clicking on find button..");
		myRoamPage.clickOnFindBtn();
		logger.info("Typing text..'" + TEST_FILE_NAME + "' for search");
		myRoamPage.enterSearchText(TEST_FILE_NAME);
		myRoamPage.clickOnFindNextBtn();
		logger.info("Check the files from right pane..");
		ArrayList<String> fileList = myRoamPage.getAllBackedupItemsFromRightPane();
		int noOfRevisions = 0;
		for (String string : fileList) {
			if(string.equalsIgnoreCase(TEST_FILE_NAME)){
				noOfRevisions ++ ;
			}
		} 
		if(noOfRevisions != 2){
			Asserter.fail("The revisions of '" + TEST_FILE_NAME + "' found in  MyRoam Page is Wrong!!! Found '" + noOfRevisions + "' Revisions'");
		}		
		myRoamPage.checkAllBackupFoldersFromRightPane();
		logger.info("Retrive files..");
		MyRoam.retriveSelectedFilesFromMyRoam(MyRoamPage.WINDOWS_EXECUTABLE_FORMAT, retrivedFileUnzipPath, retrivedFile);
		String downloadedFileBase = retrivedFileUnzipPath + BACKUP_FOLDER + File.separator + TEST_FOLDER_NAME + File.separator + TEST_FILE_NAME;	
		String downloadedFileDelta = retrivedFileUnzipPath + BACKUP_FOLDER + File.separator + TEST_FOLDER_NAME + File.separator + TEST_FILE_NAME_DELTA_RETIEVED;	
		String downloadedFileNew = retrivedFileUnzipPath + BACKUP_FOLDER + File.separator + TEST_FOLDER_NAME + File.separator + TEST_FILE_NAME_NEW;	
		logger.info("Base File downloaded is '" + downloadedFileBase);
		logger.info("Delta File downloaded is '" + downloadedFileDelta);
		logger.info("New File downloaded is '" + downloadedFileNew);
		
		String originalFileBase = VERSION_FILE_TEMP_PATH + File.separator + TEST_FILE_NAME;
		String originalFileDelta = VERSION_FILE_ORIGINAL_PATH + File.separator + TEST_FILE_NAME;
		String originalFileNew = VERSION_FILE_ORIGINAL_PATH + File.separator + TEST_FILE_NAME_NEW;		
		logger.info("Original Base file for comparison is.." + originalFileBase);
		logger.info("Original Delta file for comparison is.." + originalFileDelta);
		logger.info("Original New file for comparison is.." + originalFileNew);
		
		logger.info("Comparing files...");
		Asserter.assertTrue(FileUtils.compareFiles(originalFileBase , downloadedFileBase), "Files are not equal!! Compared Files are, Retrieved File : " + downloadedFileBase + " Original File: " + originalFileBase);
		Asserter.assertTrue(FileUtils.compareFiles(originalFileDelta, downloadedFileDelta), "Files are not equal!! Compared Files are, Retrieved File : " + downloadedFileDelta + " Original File: " + originalFileDelta);
		Asserter.assertTrue(FileUtils.compareFiles(originalFileNew , downloadedFileNew), "Files are not equal!! Compared Files are, Retrieved File : " + downloadedFileNew + " Original File: " + originalFileNew);
		logger.info("Test Completed successfully...");
		AccountManagementLogin.logout();
	}	
	public void runBackupIfFileNotPresent(String file, String runnerFile) throws Exception{
		logger.info("Trying to fidn the file..");
		myRoamPage.clickOnFindBtn();
		myRoamPage.enterSearchText(file);
		myRoamPage.clickOnFindNextBtn();
		logger.info("Checking file if its already present..");
		if(! myRoamPage.isBackedupItemPresentInRightPane(file)){
			logger.info("Fiel not present..Runngin backup...");
			ActionRunner.run(runnerFile);
			logger.info("Backeup completed...");
		}
	}
	public void initDatabaseTables(){
		logger.info("Initializing DataBaseTables..");
		if(isDCMirrored || isDCClustered){
			logger.info("Mirrored Data Center found..initializing tables..");
			fileIndexTable = new FileIndexTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			poolIndexTablePrimary = new PoolIndexTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			poolIndexTableSecondary = new PoolIndexTable(DatabaseServer.SECONDARY_DIRECTORY_SERVER);
			expRulesTable = new ExpireRulesTable(DatabaseServer.PRIMARY_REGISTRY_SERVER);
		}
		else{
			logger.info("Stand alone.. Data Center found..initializing tables..");
			fileIndexTable = new FileIndexTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			poolIndexTablePrimary = new PoolIndexTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			expRulesTable = new ExpireRulesTable(DatabaseServer.PRIMARY_REGISTRY_SERVER);
		}	
		logger.info("Database initialization completed..");
	}
	
	public void deleteFolderAndCompactAccount() throws Exception {
		logger.debug("Deleting the folder: "+ VERSION_FILE_ORIGINAL_PATH +" and doing an empty backup..");
		FileUtils.deleteDir(VERSION_FILE_ORIGINAL_PATH);
		ActionRunner.run(TEST_RUNNER_FILE_BACKUP);
		poolIndexTablePrimary.deletePoolIndexEntryForFile(accountNo,
				TEST_FILE_NAME);
		if (isDCMirrored ||  isDCClustered) {
			poolIndexTableSecondary.deletePoolIndexEntryForFile(accountNo,
					TEST_FILE_NAME);
		}
		Compactor.compactAccounts(primaryDataCenterRegistryMachineName, accountNo);
		/*
		 * The compact account will never effectively notify the actual compaction is finished or not.
		 * So we are added 2 min wait here as well.
		 */
		Thread.sleep(120000);
		Compactor.startCompactorService(primaryDataCenterRegistryMachineName);
	}
	
	@AfterMethod(alwaysRun = true)
	public void cleanupAfterTest() throws Exception{
        /*
         * Deleting the files for next execution.
         */		
        deleteFolderAndCompactAccount();
		expRulesTable.setDeletedRevs("90");
	}
	/**
	 * Closing all the database connections
	 */
	@AfterMethod(alwaysRun = true, dependsOnMethods= {"cleanupAfterTest"})
	public void closeDataBaseConnections(){
		if (isDCMirrored || isDCClustered){
			DataBase.closeDatabaseConnections(fileIndexTable, poolIndexTablePrimary, poolIndexTableSecondary, expRulesTable);
		}
		else{
			DataBase.closeDatabaseConnections(fileIndexTable, poolIndexTablePrimary, expRulesTable);
		}
	}
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		logger.info("Stopping session...");
		super.stopSeleniumTest();
		logger.info("Session ended...");
	}
	
	
}
