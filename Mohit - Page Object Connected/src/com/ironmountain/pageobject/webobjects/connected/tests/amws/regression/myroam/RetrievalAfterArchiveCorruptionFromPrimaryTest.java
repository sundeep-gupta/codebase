package com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam;

import java.io.File;
import java.util.ArrayList;

import org.apache.log4j.Logger;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.digital.qa.automation.connected.archiveHelper.ArchiveCorrupter;
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
import com.ironmountain.pageobject.webobjects.connected.database.directory.ArchiveSetTable;
import com.ironmountain.pageobject.webobjects.connected.database.directory.FileIndexTable;
import com.ironmountain.pageobject.webobjects.connected.database.directory.PoolIndexTable;
import com.ironmountain.pageobject.webobjects.connected.database.directory.VolumesTable;
import com.ironmountain.pageobject.webobjects.connected.database.registry.ExpireRulesTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.MyRoamPage;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;


@SeleniumUITest(priority=37, HPQCID="26421")
public class RetrievalAfterArchiveCorruptionFromPrimaryTest extends AccountManagementTest {

	private static Logger  logger      = Logger.getLogger("RetrievalAfterArchiveCorruptionFromPrimaryTest.class");

	private static String accountNo = null;
	private String archiveVolume = null;
	
	private FileIndexTable fileIndexTable = null;
	private PoolIndexTable poolIndexTablePrimary = null;
	private PoolIndexTable poolIndexTableSecondary = null;
	private ExpireRulesTable expRulesTable = null;
	private ArchiveSetTable archiveSetTable = null;
	private VolumesTable volumesTable = null;

	private String retrivedFile = null;
	private String retrivedFileUnzipPath = null;
	/**
	 * This name is from the TestRunner file
	 * "MyRoamRegressionArchiveCorruptionBackup.xml", if we change the name
	 * there in any case we need to modify this name as well;
	 */
	private static final String ARCHIVE_CORRUPTION_RUNNER_FILE = "MyRoamRegressionArchiveCorruptionPrimaryBackup.xml";
	private static final String TEST_RUNNER_FILE_BACKUP = "MyRoamRegressionDummyBackup.xml";
	private static final String ARCHIVE_CORRUPTION_FILE = "ArchiveCorruptionPrimaryTestDataFile.txt";
	private static final String BACKUP_FOLDER = "MyRoamRegressionData";
	private static final String ARCHIVE_CORRUPTION_FOLDER = "ArchiveCorruptionPrimaryFolder";
	private static final String ARCHIVE_CORRUPTION_FILE_PATH = "C:"	+ File.separator + BACKUP_FOLDER + File.separator + ARCHIVE_CORRUPTION_FOLDER;


	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception {
		super.initAccountManagementTest();

		retrivedFile = FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("downloadsdir") + File.separator + PropertyPool.getProperty("ArchiveFile");
		retrivedFileUnzipPath = retrivedFile.replaceAll(".zip", "") + File.separator;
		FileUtils.deleteDir(retrivedFile);
		FileUtils.deleteDir(retrivedFileUnzipPath);
		FileUtils.createDirectory(FileUtils.getBaseDirectory() + File.separator	+ PropertyPool.getProperty("downloadsdir"));
	}

	@Parameters( { "emailid", "password", "backedupDrive" })
	@Test(groups = { "amws", "regression", "myroam" })
	public void testRetrievalAfterArchiveCorruptionFromPrimary(String emailid,
			String password, String backedupDrive) throws Exception {
		logger.debug("Actual test method called...This test will run only if the Mirrored/clustured setup is there..");
		if(isDCMirrored || isDCClustered){

			initDatabaseTables();
			expRulesTable.setDeletedRevs("0");
			accMgmtHomePage = AccountManagementLogin.login(emailid, password);
			String accNo = accMgmtHomePage.getAccountNumber();
			accountNo = fileIndexTable.getDbFormattedAccountNumber(accNo);
			logger.debug("Account number from my Roam is: " + accountNo);
			AccountManagementLogin.logout();

			deleteFolderAndCompactAccount();
			ActionRunner.run(ARCHIVE_CORRUPTION_RUNNER_FILE);

			int[] fileTypes = fileIndexTable.getFileTypes(accountNo,ARCHIVE_CORRUPTION_FILE);
			Asserter.assertEquals(fileTypes[0],	5,"Base File Type is not found in DB!!! Is the file backedup? First filetype is: " + fileTypes[0]);
			String archiveName = fileIndexTable.getArchiveName(accountNo, ARCHIVE_CORRUPTION_FILE) + ".arc";
			logger.debug("Archive name for the file is: " + archiveName);
			String archiveNameTdate = fileIndexTable.getArchiveNameAsTDate(accountNo,  ARCHIVE_CORRUPTION_FILE);
			logger.debug("Archive name as Tdate is: " + archiveNameTdate);
			int volumeId = archiveSetTable.getVolumeId(accountNo, archiveNameTdate);
			logger.debug("Volume ID in the Primary DB Server for the archive is: " + volumeId);
			archiveVolume = volumesTable.getLocalPath(volumeId);
			logger.debug("Archive actual Volume name is: " + archiveVolume);
			String customerFolderLocation = archiveVolume + File.separator + customerFolder + File.separator ;
			logger.debug("Actual Customer folder location in Primary Dc is: " + customerFolderLocation);			
			String toolsFolder = PropertyPool.getProperty("toolsfolder");
			logger.debug("Tools Folder in DC where archive Corruptor Tool located: " + toolsFolder);
			ArchiveCorrupter arcCorrupter = new ArchiveCorrupter();
			if(! arcCorrupter.corruptArchiveHeader(primaryDataCenterDirectoryMachineName, accountNo, archiveName, customerFolderLocation, toolsFolder)){			
				Asserter.fail("Archive Corruption Failed");
			}
			Compactor.compactAccounts(primaryDataCenterRegistryMachineName, accountNo);

			fileTypes = fileIndexTable.getFileTypes(accountNo,ARCHIVE_CORRUPTION_FILE);
			if (fileTypes.length != 1) {
				Asserter.fail("File index entries found for Corrupted File: " + ARCHIVE_CORRUPTION_FILE + " after compaction is not correct");
			}
			
			AccountManagementLogin.login(emailid, password);
			myRoamPage = AccountManagementNavigation.viewMyRoamPage();
			myRoamPage.selectVersionOption("All");
			myRoamPage.clickOnBackedupFolderExpandCollapseButtonByName(backedupDrive);
			myRoamPage.clickOnBackedupFolderExpandCollapseButtonByName(BACKUP_FOLDER);
			myRoamPage.checkBackedupFolderFromLeftTree(ARCHIVE_CORRUPTION_FOLDER);
			myRoamPage.clickOnBackedupFolderNode(ARCHIVE_CORRUPTION_FOLDER);
			ArrayList<String> fileList = myRoamPage.getAllBackedupItemsFromRightPane();
			if (fileList.size() != 1) {
				Asserter.fail(fileList.size() + " The revisions of : "	+ ARCHIVE_CORRUPTION_FILE	+ " found after archive corruption and compaction");
			}
			MyRoam.retriveSelectedFilesFromMyRoam(MyRoamPage.WINDOWS_EXECUTABLE_FORMAT, retrivedFileUnzipPath, retrivedFile);
			AccountManagementLogin.logout();

			/*
			 * Compare the backedup File and the Downloaded/Retrieved file.
			 */
			String downloadedFile = retrivedFileUnzipPath	+ BACKUP_FOLDER + File.separator + ARCHIVE_CORRUPTION_FOLDER+ File.separator + ARCHIVE_CORRUPTION_FILE;
			String originalFile = ARCHIVE_CORRUPTION_FILE_PATH	+ File.separator + ARCHIVE_CORRUPTION_FILE;
			Asserter.assertTrue(FileUtils.compareFiles(	originalFile,	downloadedFile),	"Files are not equal!! Compared Files are, Retrieved File : " + downloadedFile + " Original File: " + originalFile);
		}			
	}

	public void initDatabaseTables() {
		if (isDCMirrored || isDCClustered){
			fileIndexTable = new FileIndexTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			archiveSetTable = new ArchiveSetTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			volumesTable = new VolumesTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			poolIndexTablePrimary = new PoolIndexTable(
					DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			poolIndexTableSecondary = new PoolIndexTable(
					DatabaseServer.SECONDARY_DIRECTORY_SERVER);
			expRulesTable = new ExpireRulesTable(DatabaseServer.PRIMARY_REGISTRY_SERVER);
		} else {
			fileIndexTable = new FileIndexTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			poolIndexTablePrimary = new PoolIndexTable(
					DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			expRulesTable = new ExpireRulesTable(DatabaseServer.PRIMARY_REGISTRY_SERVER);
		}
	}

	public void deleteFolderAndCompactAccount() throws Exception {
		logger.debug("Deleting the folder: "+ ARCHIVE_CORRUPTION_FILE_PATH +" and doing an empty backup..");
		FileUtils.deleteDir(ARCHIVE_CORRUPTION_FILE_PATH);
		ActionRunner.run(TEST_RUNNER_FILE_BACKUP);
		poolIndexTablePrimary.deletePoolIndexEntryForFile(accountNo,
				ARCHIVE_CORRUPTION_FILE);
		if (isDCMirrored ||  isDCClustered) {
			poolIndexTableSecondary.deletePoolIndexEntryForFile(accountNo,
					ARCHIVE_CORRUPTION_FILE);
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
	@AfterMethod(alwaysRun = true, dependsOnMethods= {"removeFilesForNextExecution"})
	public void closeDataBaseConnections(){
		if (isDCMirrored || isDCClustered){
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
	
	@AfterMethod(alwaysRun = true, dependsOnMethods= {"removeFilesForNextExecution"})
	public void stopTest() throws Exception {
		super.stopSeleniumTest();
	}

}