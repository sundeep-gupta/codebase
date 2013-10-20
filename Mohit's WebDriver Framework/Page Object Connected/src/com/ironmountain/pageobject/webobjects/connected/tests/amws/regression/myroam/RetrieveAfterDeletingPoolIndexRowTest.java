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

@SeleniumUITest(priority=34, HPQCID="26417")
public class RetrieveAfterDeletingPoolIndexRowTest extends
		AccountManagementTest {
	private static Logger  logger      = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam.RetrieveAfterDeletingPoolIndexRowTest");
	
	private FileIndexTable fileIndexTable = null;
	private PoolIndexTable poolIndexTablePrimary = null;	
	private PoolIndexTable poolIndexTableSecondary = null;	
	private ExpireRulesTable expRulesTable = null;
	private String retrivedFile = null;
	private String retrivedFileUnzipPath = null;
	
	private static String accountNumber = null;
	
	/**
	 * This name is from the TestRunner file "MyRoamRegressionDelta*****Backup.xml", if we change the name there in any case
	 * we need to modify this name as well;
	 */
	private static final String TEST_RUNNER_FILE_BASE = "MyRoamRegressionPoolIndexDeleteBaseBackup.xml";
	private static final String TEST_RUNNER_FILE_DELTA = "MyRoamRegressionPoolIndexDeleteDeltaBackup.xml";
	private static final String TEST_RUNNER_FILE_BACKUP = "MyRoamRegressionDummyBackup.xml";

	private String poolFileName = "PoolIndexDeleteFile.txt" ;
	private static final String backupFolder = "MyRoamRegressionData";
	private static final String poolFolder = "PoolIndexDeleteFolder" ;
	private static final String poolFileOriginalPath = "C:" + File.separator + backupFolder + File.separator + poolFolder ;
	
	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		logger.info("Startign test..initializing");
		super.initAccountManagementTest();
		logger.info("Test initialization completed");
		
		retrivedFile = FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("downloadsdir") + File.separator + PropertyPool.getProperty("ArchiveFile");
		retrivedFileUnzipPath = retrivedFile.replaceAll(".zip", "")  + File.separator;
		FileUtils.deleteDir(retrivedFile);
		FileUtils.deleteDir(retrivedFileUnzipPath);
		FileUtils.createDirectory(FileUtils.getBaseDirectory() +File.separator + PropertyPool.getProperty("downloadsdir"));
		initDatabaseTables();
	}
	
	
	@Parameters({"emailid", "password"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testDeltaFilesRetriveUsingMyRoam(String emailid, String password) throws Exception
	{	
		logger.info("Executing the actual Test method..");
		logger.info("Getting the primary datacenter machine.." +  primaryDataCenterDirectoryMachineName);
		logger.info("Setting the Expiration rule for Delted Revisiosn..");
		expRulesTable.setDeletedRevs("0");

		accMgmtHomePage = AccountManagementLogin.login(emailid, password);
		accountNumber =  fileIndexTable.getDbFormattedAccountNumber(accMgmtHomePage.getAccountNumber());
		logger.info("Account number for test is.." + accountNumber);
		AccountManagementLogin.logout();
		
		deleteFolderAndCompactAccount();
		
		runBackup(TEST_RUNNER_FILE_BASE);
		logger.info("Sleeping acter first backup..");
		Thread.sleep(10000);
		logger.info("Getting file types after first backup...");
		int[] type = fileIndexTable.getFileTypes(accountNumber, poolFileName);
		Asserter.assertEquals(type[0], 5, "The Base File type '5' is expected");
		poolIndexTablePrimary.deletePoolIndexEntryForFile(accountNumber, poolFileName);
		if(isDCMirrored || isDCClustered){
			poolIndexTableSecondary.deletePoolIndexEntryForFile(accountNumber, poolFileName);
		}
		runBackup(TEST_RUNNER_FILE_DELTA);
		logger.info("Sleeping after second backup..");
		Thread.sleep(5000);
		logger.info("Getting the file type after second backup");		
		type = fileIndexTable.getFileTypes(accountNumber, poolFileName);
		Asserter.assertEquals(type[1], 6, "The Delta File type '6' is expected");		
		
		Compactor.compactAccounts(primaryDataCenterRegistryMachineName , accountNumber);
		/*
		 * The compact account will never effectively notify the actual compaction is finished or not.
		 * So we are added 2 min wait here as well.
		 */
		Thread.sleep(120000);
		Compactor.startCompactorService(primaryDataCenterRegistryMachineName);
		
		logger.info("Login to account management");
		AccountManagementLogin.login(emailid, password);
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		Asserter.assertTrue(myRoamPage.getSelectedShowVersionsLabel().contains("Most Recent"), "Most recent version is not checked by default");
		myRoamPage.clickOnFindBtn();
		logger.info("Searching for file.." + poolFileName);
		myRoamPage.enterSearchText(poolFileName);
		myRoamPage.clickOnFindNextBtn();
		myRoamPage.checkAllBackupFoldersFromRightPane();
		logger.info("Selected the file.." + poolFileName);
		MyRoam.retriveSelectedFilesFromMyRoam(MyRoamPage.WINDOWS_EXECUTABLE_FORMAT, retrivedFileUnzipPath, retrivedFile);
		String downloadedFile = retrivedFileUnzipPath + backupFolder + File.separator + poolFolder + File.separator + poolFileName;	
		logger.info("Downloaded File is.." + downloadedFile);
		String originalFile = poolFileOriginalPath + File.separator + poolFileName;
		logger.info("Original Fiel is.." + originalFile);
		logger.info("Comparing Files..");
		Asserter.assertTrue(FileUtils.compareFiles(originalFile , downloadedFile), "Files are not equal!! Compared Files are, Retrieved File : " + downloadedFile + " Original File: " + originalFile);
        AccountManagementLogin.logout();
        logger.info("Test Completed Successfully..");
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
	
	public void deleteFolderAndCompactAccount() throws Exception{
		logger.info("Deleting folder after compaction..");
		FileUtils.deleteDir(poolFileOriginalPath);
		runBackup(TEST_RUNNER_FILE_BACKUP);
		logger.info("Compacting account...");
		Compactor.compactAccounts(primaryDataCenterRegistryMachineName , accountNumber);
		/*
		 * The compact account will never effectively notify the actual compaction is finished or not.
		 * So we are added 2 min wait here as well.
		 */
		Thread.sleep(120000);
		Compactor.startCompactorService(primaryDataCenterRegistryMachineName);
		logger.info("Account compaction completed...");
	}
	/**
	 * Closing all the database connections
	 */
	@AfterMethod(alwaysRun = true, dependsOnMethods= {"deleteFolderAndCompactAccountForTest"})
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
	public void deleteFolderAndCompactAccountForTest() throws Exception{		
		deleteFolderAndCompactAccount();
		expRulesTable.setDeletedRevs("90");
	}
		
	@AfterMethod(alwaysRun = true, dependsOnMethods={"deleteFolderAndCompactAccountForTest"})
	public void stopTest() throws Exception	{	
		logger.info("Stopping session...");
		super.stopSeleniumTest();
		logger.info("Session ended...");
	}
	
	

}
