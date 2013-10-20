package com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam;

import java.io.File;

import org.apache.log4j.Logger;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.digital.qa.automation.TestRunner.actions.FileActions.FileDeleteAction;
import com.ironmountain.digital.qa.automation.connected.compaction.Compactor;
import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.MyRoam;
import com.ironmountain.pageobject.webobjects.connected.actions.testrunner.ActionRunner;
import com.ironmountain.pageobject.webobjects.connected.database.DataBase;
import com.ironmountain.pageobject.webobjects.connected.database.directory.ArchiveSetTable;
import com.ironmountain.pageobject.webobjects.connected.database.directory.FileIndexTable;
import com.ironmountain.pageobject.webobjects.connected.database.directory.PoolIndexTable;
import com.ironmountain.pageobject.webobjects.connected.database.directory.VolumesTable;
import com.ironmountain.pageobject.webobjects.connected.database.registry.ExpireRulesTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.AccountManagementLoginPage;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.MyRoamPage;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

/**
 * @author jdevasia
 * 
 * This test case may randomly fail due to Compactor Performance(Compaction time delay)
 * The mail issue is while logging in you will get a 500 server error from AMWS. (The test out put will be something like "java.lang.AssertionError: The locator: findButton not found")
 * We added 2 minutes delay for compaction and restart but still sometimes it may fail.(Re-running may give better result)
 *
 */
@SeleniumUITest(priority=27, HPQCID="26420")
public class MyRoamRetrieveAfterArchiveDeleteFromPrimaryTest extends
		AccountManagementTest {

	private static Logger  logger      = Logger.getLogger("MyRoamRetrieveAfterArchiveDeleteFromPrimaryTest.class");
	
	private String accountNo = null;
	private String archiveName = null;
	private String archiveVolume = null;
	private String arcExtention = ".arc";	
	private String retrivedFile = null;
	private String retrivedFileUnzipPath = null;
	
	/*
	 * Tables
	 */

	private PoolIndexTable poolIndexTablePrimary = null;
	private PoolIndexTable poolIndexTableSecondary = null;
	private FileIndexTable fileIndexTable = null;
	private ArchiveSetTable archiveSetTable = null;
	private VolumesTable volumesTable = null;
	private ExpireRulesTable expRulesTable = null;
	/**
	 * This name is from the TestRunner file "MyRoamRegressionDeleteArchiveBackup.xml", if we change the name there in any case
	 * we need to modify this name as well;
	 */
	private static final String DELETE_ARCHIVE_BACKUP_FILE = "MyRoamRegressionDeleteArchiveBackup.xml";
	private static final String TEST_RUNNER_FILE_BACKUP = "MyRoamRegressionDummyBackup.xml";
	private static final String archivedFile = "DeleteFromPrimaryDataCenter.txt";
	private static final String backupFolder = "MyRoamRegressionData";
	private static final String archiveDeleteFolder = "ArchiveDeleteFolder";
	private static final String archiveDeleteFileOriginalPath = "C:\\" + backupFolder + File.separator + archiveDeleteFolder ;
	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		logger.info("Starting test..initializing");
		super.initAccountManagementTest();
		logger.info("Test initialization completed");
		
		logger.info("Creating a Fileindex table object from Primary Directory DB");	
		logger.info("Deletign and recreating downloaded folders..");
		retrivedFile = FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("downloadsdir") + File.separator + PropertyPool.getProperty("ArchiveFile");
		retrivedFileUnzipPath = retrivedFile.replaceAll(".zip", "")  + File.separator ;
		FileUtils.deleteDir(retrivedFile);
		FileUtils.deleteDir("C:\\" + archiveDeleteFolder);
		FileUtils.deleteDir(retrivedFileUnzipPath);
		FileUtils.createDirectory(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("downloadsdir"));
		logger.info("Downloads directory created..");
	}
	
	@Parameters({"emailid", "password"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testRetriveAfterArchiveDeleteFromPrimary(String emailid, String password) throws Exception
	{	
		
		logger.info("Actual test method called...This test will run only if the Mirrored/clustured setup is there..");

		if(isDCMirrored || isDCClustered){
			
			initDatabaseTables();
			expRulesTable.setDeletedRevs("0");
			logger.info("Trying to login with email '" + emailid + "' Password '" + password + "'");
			accMgmtHomePage =AccountManagementLogin.login(emailid, password);
			logger.info("Account number got form UI.." + accountNo);
			String accNo = accMgmtHomePage.getAccountNumber();		
			accountNo = fileIndexTable.getDbFormattedAccountNumber(accNo);
			logger.info("Account number for DB is.." + accountNo);
			AccountManagementLogin.logout();
			
			/*
			 * Do a cleanup of the file if previous execution leaves any entries.
			 */
			deleteFolderAndCompactAccount();
			ActionRunner.run(DELETE_ARCHIVE_BACKUP_FILE);
			
			/*
			 * To replace the deleted file if any of the previous tests did it.. !!!
			 */
			logger.info("Logging in to acms again..");
			AccountManagementLogin.login(emailid, password);
			myRoamPage = AccountManagementNavigation.viewMyRoamPage();
			logger.info("Trying to select the files");
			MyRoam.searchAndSelectAllFiles(archivedFile);
			myRoamPage.clickOnRetrieve();
			myRoamPage.selectArchiveFormat(MyRoamPage.WINDOWS_EXECUTABLE_FORMAT);
			logger.info("Trying to download the file");
			myRoamPage.clickOnContinue();
			logger.info("Before clicking on download logging out..");
			AccountManagementLogin.logout();
			
			logger.info("Getting Archive name which the file '"+ archivedFile + "' contains..");
			String archiveNameTdate = fileIndexTable.getArchiveNameAsTDate(accountNo, archivedFile);
			int volumeId = archiveSetTable.getVolumeId(accountNo, archiveNameTdate);
			archiveVolume = volumesTable.getLocalPath(volumeId);
			archiveName = fileIndexTable.getArchiveName(accountNo, archivedFile);
			logger.info("Archive name is: " + archiveName);
			logger.info("Deleting the archive..");
			deleteArchiveFile(archiveName, archiveVolume);
			
			/*
			 * Compact the account after file deletion.
			 * This tests tend to fail due to improper compactor runs.. (Sometime compactor will not finish within a minute)
			 * We added 2 more minutes waiting time!!
			 */
			Compactor.compactAccounts(primaryDataCenterRegistryMachineName, accountNo);	
			Thread.sleep(120000);
			
			/*
			 * Login to account management and retrieve files.
			 */
	
			logger.info("Logging to amws...");
			accMgmtLoginPage = (AccountManagementLoginPage) PageFactory.getNewPage(AccountManagementLoginPage.class);
			accMgmtLoginPage.open(PropertyPool.getProperty("accountmanagementappendurl"));			
			AccountManagementLogin.login(emailid, password);
			logger.info("Navigating to myroam..");
			AccountManagementNavigation.viewMyRoamPage();
			logger.info("Searching for " + archivedFile);
			MyRoam.searchAndSelectAllFiles(archivedFile);
			logger.info("Trying to download the " + archivedFile);
			MyRoam.retriveSelectedFilesFromMyRoam(MyRoamPage.WINDOWS_EXECUTABLE_FORMAT, retrivedFileUnzipPath, retrivedFile);
			String retrievedFile = retrivedFileUnzipPath + backupFolder + File.separator + archiveDeleteFolder + File.separator + archivedFile;	
			logger.info("File retrieved is.." + retrievedFile);
			String originalFile = archiveDeleteFileOriginalPath + File.separator + archivedFile;
			logger.info("Original file is.." + originalFile);
			logger.info("Comparing the fiels...");
			Asserter.assertTrue(FileUtils.compareFiles(originalFile, retrievedFile), "Failed: " + originalFile + " And Retrieved File " + retrievedFile + " not equal!!");
			logger.info("Test Completed Successfully..");
			AccountManagementLogin.logout();
		}
		else{
			logger.info("Test Completed w/o executed..");
		}
	}
	public void initDatabaseTables() {
		fileIndexTable = new FileIndexTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
		archiveSetTable = new ArchiveSetTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
		volumesTable = new VolumesTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
		poolIndexTablePrimary = new PoolIndexTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
		poolIndexTableSecondary = new PoolIndexTable(DatabaseServer.SECONDARY_DIRECTORY_SERVER);
		expRulesTable = new ExpireRulesTable(DatabaseServer.PRIMARY_REGISTRY_SERVER);
	}
	
	public void deleteArchiveFile(String arcName, String archiveVolume){
		String folderRoot = accountNo.substring(accountNo.length() - 2);
		String archiveFilePath = archiveVolume + File.separator + customerFolder + File.separator + folderRoot + File.separator + "0" + accountNo + File.separator + "archives" +
		File.separator + arcName + arcExtention;		
		logger.info("Archive Path: " + archiveFilePath);
		logger.info("Trying to delete archive from primary..");
		FileDeleteAction.deleteFileFromRemoteMachine(primaryDataCenterDirectoryMachineName, archiveFilePath);
	}

	public void deleteFolderAndCompactAccount() throws Exception {
		logger.debug("Deleting the folder: "+ archiveDeleteFileOriginalPath +" and doing an empty backup..");
		FileUtils.deleteDir(archiveDeleteFileOriginalPath);
		ActionRunner.run(TEST_RUNNER_FILE_BACKUP);
		poolIndexTablePrimary.deletePoolIndexEntryForFile(accountNo,
				archivedFile);
		if (isDCMirrored ||  isDCClustered) {
			poolIndexTableSecondary.deletePoolIndexEntryForFile(accountNo,
					archivedFile);
		}
		Compactor.compactAccounts(primaryDataCenterRegistryMachineName, accountNo);
		/*
		 * The compact account will never effectively notify the actual compaction is finished or not.
		 * So we are added 2 min wait here as well.
		 */
		Thread.sleep(120000);
		Compactor.startCompactorService(primaryDataCenterRegistryMachineName);
	}
	/**
	 * Closing all the database connections
	 */
	@AfterMethod(alwaysRun=true, dependsOnMethods= {"removeFilesForNextExecution"})
	public void closeDataBaseConnections(){
		if(isDCMirrored || isDCClustered){
			DataBase.closeDatabaseConnections(fileIndexTable,poolIndexTablePrimary, poolIndexTableSecondary, archiveSetTable, volumesTable, expRulesTable);
		}
	}
	/**
	 * Cleanup the files after Test
	 * @throws Exception
	 */
	@AfterMethod(alwaysRun = true)
	public void removeFilesForNextExecution() throws Exception{
		if(isDCClustered || isDCMirrored){
			deleteFolderAndCompactAccount();
			expRulesTable.setDeletedRevs("90");
		}		
	}
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		logger.info("Stopping session...");
		super.stopSeleniumTest();
		logger.info("Session ended...");	
	}
	
}
