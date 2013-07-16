package com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam;

import java.io.File;

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
import com.ironmountain.pageobject.pageobjectrunner.utils.ListUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
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

@SeleniumUITest(priority=36, HPQCID="5965")
public class RetrieveDifferentFileTypesAfterCompactionTest extends
		AccountManagementTest {
	private static Logger  logger      = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam.RetrieveDifferentFileTypesAfterCompactionTest");
	
	private String accountNo = null;
	private FileIndexTable fileIndexTable = null;
	private PoolIndexTable poolIndexTablePrimary = null;	
	private PoolIndexTable poolIndexTableSecondary = null;
	private ExpireRulesTable expRulesTable = null;
	private String retrivedFile = null;
	private String retrivedFileUnzipPath = null;
	
	/**
	 * This name is from the TestRunner file "MyRoamRegressionDelta*****Backup.xml", if we change the name there in any case
	 * we need to modify this name as well;
	 */
	private static final String TEST_RUNNER_FILE_BACKUP = "MyRoamRegressionDummyBackup.xml";
	private static final String DELTA_BACKUP_FILE = "MyRoamRegressionDeltaBackup.xml";
	private static final String DELTA_FILE = "DeltaTestDataFile.txt";
	private static final String BACKUP_FOLDER = "MyRoamRegressionData";
	private static final String DELTA_FOLDER = "DeltaFolder";
	private static final String DELETA_FILE_ORIGINAL_PATH = "C:\\" + BACKUP_FOLDER + File.separator + DELTA_FOLDER ;
	
	private String SYMLINK_BACKUP_FILE =  "MyRoamRegressionBackupVersionedData.xml";	
	private static final String SYMLINK_FILE = "SymLinkFile.txt";
	private static final String SYMLINK_FOLDER = "SymLinkFolder";
	private static final String SYMLINK_FILE_ORIGINAL_PATH = "C:\\" + BACKUP_FOLDER + File.separator + SYMLINK_FOLDER ;
	
	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		logger.info("Starting the test initialization...startTest Called");
		super.initAccountManagementTest();
		logger.info("Creating a fileIndexTable object..");
		retrivedFile = FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("downloadsdir") + File.separator + PropertyPool.getProperty("ArchiveFile");
		retrivedFileUnzipPath = retrivedFile.replaceAll(".zip", "")  + File.separator;
		FileUtils.deleteDir(retrivedFile);
		FileUtils.deleteDir(retrivedFileUnzipPath);
		FileUtils.createDirectory(FileUtils.getBaseDirectory() +File.separator + PropertyPool.getProperty("downloadsdir"));
		logger.info("Test initialization completed..");
	}
	
	@Parameters({"emailid", "password", "backedupDrive", "commonTestData", "commonTestDataFilesRetrieveList", "originalDataLocation"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testRetriveDifferentFileTypesAfterCompaction(String emailid, String password, String backedupDrive, String commonTestData, String commonTestDataFilesRetrieveList, String originalDataLocation) throws Exception
	{
		logger.info("Starting actual Test method..");
		initDatabaseTables();
		logger.info("Setting the Expiration rule for Delted Revision..");
		expRulesTable.setDeletedRevs("0");
		logger.info("Login to AMWS...");
		accMgmtHomePage = AccountManagementLogin.login(emailid, password);
		String accNo = accMgmtHomePage.getAccountNumber();		
		logger.info("Account number form AMWS.."+ accNo);
		accountNo = fileIndexTable.getDbFormattedAccountNumber(accNo);
		logger.info("Account Number form DB is.."+ accountNo);
        AccountManagementLogin.logout();
        /*
         * Deleting the files from previous execution.
         */		
        deleteFolderAndCompactAccount(DELTA_BACKUP_FILE, DELETA_FILE_ORIGINAL_PATH);
        deleteFolderAndCompactAccount(SYMLINK_FILE, SYMLINK_FILE_ORIGINAL_PATH);
        
        /*
         * Run the backup for files
         */
        runBackup(DELTA_BACKUP_FILE);
        runBackup(SYMLINK_BACKUP_FILE);

		logger.info("Compacting account...");
		Compactor.compactAccounts(primaryDataCenterRegistryMachineName, accountNo);	
		/*
		 * The compact account will never effectively notify the actual compaction is finished or not.
		 * So we are added 2 min wait here as well.
		 */
		Thread.sleep(120000);
		Compactor.startCompactorService(primaryDataCenterRegistryMachineName);
		logger.info("Compaction completed...");
		
		logger.info("Login to AMWS after compaction...");
		AccountManagementLogin.login(emailid, password);
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		myRoamPage.clickOnBackedupFolderExpandCollapseButtonByName(backedupDrive);
		myRoamPage.clickOnBackedupFolderExpandCollapseButtonByName(BACKUP_FOLDER);
		myRoamPage.checkBackedupFolderFromLeftTree(DELTA_FOLDER);
		myRoamPage.checkBackedupFolderFromLeftTree(SYMLINK_FOLDER);
		myRoamPage.checkBackedupFolderFromLeftTree(commonTestData);
		logger.info("Retrieving Files from my Roam..");
		MyRoam.retriveSelectedFilesFromMyRoam(MyRoamPage.WINDOWS_EXECUTABLE_FORMAT, retrivedFileUnzipPath, retrivedFile);
		logger.info("Logging out from AMWS...");
		AccountManagementLogin.logout();
		
		logger.info("Checking downloaded files..");
		String deltaDownloadedFile = retrivedFileUnzipPath + BACKUP_FOLDER + File.separator + DELTA_FOLDER + File.separator + DELTA_FILE;	
		logger.info("DeltaFile downloaded is.." + deltaDownloadedFile);
		String deltaOriginalFile = DELETA_FILE_ORIGINAL_PATH + File.separator + DELTA_FILE;
		logger.info("DeltaFile original is.." + deltaOriginalFile);
		logger.info("Comparing files...");
		Asserter.assertTrue(FileUtils.compareFiles(deltaOriginalFile , deltaDownloadedFile), "Files are not equal!! Compared Files are, Retrieved File : " + deltaDownloadedFile + " Original File: " + deltaOriginalFile);
		
		String symlinkDownloadedFile = retrivedFileUnzipPath + BACKUP_FOLDER + File.separator + SYMLINK_FOLDER + File.separator + SYMLINK_FILE;	
		logger.info("Symlink File downloaded is,,," + symlinkDownloadedFile);
		String symlinkOriginalFile = SYMLINK_FILE_ORIGINAL_PATH + File.separator + SYMLINK_FILE ;
		logger.info("Symlink File Original is.." + symlinkOriginalFile);
		logger.info("Comparing Files....");
		Asserter.assertTrue(FileUtils.compareFiles(symlinkOriginalFile, symlinkDownloadedFile), "Failed: orignal file" + symlinkOriginalFile + " and downloaded file " + symlinkDownloadedFile + "are not equal!!");
		
		logger.info("Comparing common Files...");
		String commonDataDownloadedFilePath = retrivedFileUnzipPath + File.separator + BACKUP_FOLDER + File.separator + commonTestData;
		String commonDataOriginalDataLocation = originalDataLocation +  File.separator + commonTestData;
		String[] testFilesList = ListUtils.getStringListAsArray(StringUtils.toStringArrayList(commonTestDataFilesRetrieveList));
		for (int i = 0; i < testFilesList.length; i++) {
			Asserter.assertTrue(FileUtils.compareFiles(commonDataOriginalDataLocation + File.separator + testFilesList[i], commonDataDownloadedFilePath + File.separator + testFilesList[i]), "Files Compared are: " + commonDataOriginalDataLocation + File.separator + testFilesList[i]+ " and " + commonDataDownloadedFilePath + File.separator + testFilesList[i]);
		}	
		logger.info("Test Completed Successfully...");
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
	public void runBackup(String runnerFile) throws Exception{		
		logger.info("Running backup with runner file.." + runnerFile);
		ActionRunner.run(runnerFile);
	}
	public void deleteFolderAndCompactAccount(String file, String filePath) throws Exception {
		logger.debug("Deleting the folder: "+ filePath +" and doing an empty backup..");
		FileUtils.deleteDir(filePath);
		runBackup(TEST_RUNNER_FILE_BACKUP);
		poolIndexTablePrimary.deletePoolIndexEntryForFile(accountNo,
				file);
		if (isDCMirrored ||  isDCClustered) {
			poolIndexTableSecondary.deletePoolIndexEntryForFile(accountNo,
					file);
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
        deleteFolderAndCompactAccount(DELTA_BACKUP_FILE, DELETA_FILE_ORIGINAL_PATH);
        deleteFolderAndCompactAccount(SYMLINK_FILE, SYMLINK_FILE_ORIGINAL_PATH);
		expRulesTable.setDeletedRevs("90");
	}
	
	/**
	 * Closing all the database connections
	 */
	@AfterMethod(alwaysRun = true, dependsOnMethods= {"cleanupAfterTest"})
	public void closeDataBaseConnections(){
		if (isDCMirrored || isDCClustered){
			DataBase.closeDatabaseConnections(fileIndexTable,poolIndexTablePrimary, poolIndexTableSecondary, expRulesTable);
		}
		else
		{
			DataBase.closeDatabaseConnections(fileIndexTable,poolIndexTablePrimary, expRulesTable);
		}
	}
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{		
		logger.info("Stopping selenium after test...");
		super.stopSeleniumTest();
		logger.info("Stop completed...");
	}
	

}
