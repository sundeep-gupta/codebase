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


@SeleniumUITest(priority=37, HPQCID="26418")
public class RetrievalAfterArchiveCorruptionTest extends AccountManagementTest {
	
	private static Logger  logger      = Logger.getLogger("RetrievalAfterArchiveCorruptionTest.class");
	
	private static String accountNo = null;
	private String archiveVolumePrimary = null;
	private String archiveVolumeSecondary = null;
	
	private PoolIndexTable poolIndexTablePrimary = null;	
	private PoolIndexTable poolIndexTableSecondary = null;	
	private ExpireRulesTable expRulesTable = null;
	private FileIndexTable fileIndexTablePrimary = null;
	private ArchiveSetTable archiveSetTablePrimary = null;
	private VolumesTable volumesTablePrimary = null;
	private FileIndexTable fileIndexTableSecondary = null;
	private ArchiveSetTable archiveSetTableSecondary = null;
	private VolumesTable volumesTableSecondary = null;
	
	private String retrivedFile = null;
	private String retrivedFileUnzipPath = null;
	/**
	 * This name is from the TestRunner file "MyRoamRegressionArchiveCorruptionBackup.xml", if we change the name there in any case
	 * we need to modify this name as well;
	 */
	private static final String ARCHIVE_CORRUPTION_RUNNER_FILE = "MyRoamRegressionArchiveCorruptionBackup.xml";
	private static final String TEST_RUNNER_FILE_BACKUP = "MyRoamRegressionDummyBackup.xml";
	private static final String ARCHIVE_CORRUPTION_FILE = "ArchiveCorruptionTestDataFile.txt";
	private static final String ARCHIVE_CORRUPTION_FILE_COPY = "ArchiveCorruptionTestDataFileCopy.txt";
	private static final String BACKUP_FOLDER = "MyRoamRegressionData";
	private static final String ARCHIVE_CORRUPTION_FOLDER = "ArchiveCorruptionFolder";
	private static final String ARCHIVE_CORRUPTION_FILE_PATH = "C:" + File.separator + BACKUP_FOLDER +  File.separator + ARCHIVE_CORRUPTION_FOLDER ;
	private static final String ARCHIVE_CORRUPTION_FILE_ORIGINAL_PATH = "C:" + File.separator + ARCHIVE_CORRUPTION_FOLDER ;
	
	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{		

		skipTest = true;
		skipMessage = "This test is forced to skip due to a problem with Archive Corruption..";
		
		super.initAccountManagementTest();
		initDatabaseTables();
		
		retrivedFile = FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("downloadsdir") + File.separator + PropertyPool.getProperty("ArchiveFile");
		retrivedFileUnzipPath = retrivedFile.replaceAll(".zip", "")  + File.separator;
		FileUtils.deleteDir(retrivedFile);
		FileUtils.deleteDir(retrivedFileUnzipPath);
		FileUtils.createDirectory(FileUtils.getBaseDirectory() +File.separator + PropertyPool.getProperty("downloadsdir"));
	}
	
	@Parameters({"emailid", "password", "backedupDrive"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testRetrievalAfterArchiveCorruption(String emailid, String password, String backedupDrive) throws Exception
	{
		logger.debug("Executed Started...");
		logger.debug("Setting the Expiration Rules to '0'");
		expRulesTable.setDeletedRevs("0");
		
		accMgmtHomePage = AccountManagementLogin.login(emailid, password);
		String accNo = accMgmtHomePage.getAccountNumber();		
		accountNo = fileIndexTablePrimary.getDbFormattedAccountNumber(accNo);
        AccountManagementLogin.logout();	

        logger.debug("Compacting the Accounts");
        deleteFolderAndCompactAccount();      
        logger.debug("Running new backup for the Archive Corruption File..");
		ActionRunner.run(ARCHIVE_CORRUPTION_RUNNER_FILE);		

		logger.debug("Checking the File Types after Backup..");
		int[] fileTypes = fileIndexTablePrimary.getFileTypes(accountNo, ARCHIVE_CORRUPTION_FILE);		
		Asserter.assertEquals(fileTypes[0], 5, "Base File Type is not found in DB!!! Is the file backedup? Base filetype is: " + fileTypes[0]);
		Asserter.assertEquals(fileTypes[1], 6, "Delta File Type is not found in DB!!! Is the file backedup? First Delta filetype is: " + fileTypes[1]);		
		Asserter.assertEquals(fileTypes[2], 6, "Delta File Type is not found in DB!!! Is the file backedup? Second Delta filetype is: " + fileTypes[2]);
		Asserter.assertEquals(fileTypes[3], 6, "Delta File Type is not found in DB!!! Is the file backedup? Third Delta filetype is: " + fileTypes[3]);

		int[] fileKinds = fileIndexTablePrimary.getFileKinds(accountNo, ARCHIVE_CORRUPTION_FILE);	
		Asserter.assertEquals(fileKinds[0], 2, "File Kind is not correct in DB!!! Is the file corrupted? First filekind is: " + fileKinds[0]);
		Asserter.assertEquals(fileKinds[1], 2, "File Kind is not correct in DB!!! Is the file corrupted? Second filekind is: " + fileKinds[1]);
		Asserter.assertEquals(fileKinds[2], 2, "File Kind is not correct in DB!!! Is the file corrupted? Third filekind is: " + fileKinds[2]);
		Asserter.assertEquals(fileKinds[3], 2, "File Kind is not correct in DB!!! Is the file corrupted? Third filekind is: " + fileKinds[3]);
		/*
		 * Getting the first Delta File Archive name.
		 */
		String archiveName = fileIndexTablePrimary.getArchiveName(accountNo, ARCHIVE_CORRUPTION_FILE, 1);
		logger.debug("Archive Name for the backedup file" + ARCHIVE_CORRUPTION_FILE + " is: " + archiveName);
		String toolsFolder = PropertyPool.getProperty("toolsfolder") ;
		logger.debug("The Tools like Archive Corruptor and Writer are copied to DataCenter Folder: " + toolsFolder);

		String archiveNameTdate = fileIndexTablePrimary.getArchiveNameAsTDate(accountNo, ARCHIVE_CORRUPTION_FILE, 1);
		logger.debug("Archive NameTadate for the backedup file" + ARCHIVE_CORRUPTION_FILE + " is: " + archiveNameTdate);
		int volumeId = archiveSetTablePrimary.getVolumeId(accountNo, archiveNameTdate);
		archiveVolumePrimary = volumesTablePrimary.getLocalPath(volumeId);
		logger.debug("The File is stored in to Primary DataCenter Volume: " + archiveVolumePrimary);		
		String customerFolderLocationPrimary = archiveVolumePrimary + File.separator + customerFolder + File.separator ;	
		logger.debug("Customer Folder full path in Primary DC is: " + customerFolderLocationPrimary);
		
		/*
		 * Corrupt the archive for the First Delta File
		 */
		ArchiveCorrupter arcCorrupter = new ArchiveCorrupter();
		if(! arcCorrupter.corruptArchiveHeader(primaryDataCenterDirectoryMachineName, accountNo, archiveName, customerFolderLocationPrimary + File.separator, toolsFolder)){			
			Asserter.fail("Archive Corruption Failed on: " + primaryDataCenterDirectoryMachineName);
		}
		logger.debug("Archive Corruption Completed on: " + primaryDataCenterDirectoryMachineName);
		if(isDCMirrored || isDCClustered){
			archiveNameTdate = fileIndexTableSecondary.getArchiveNameAsTDate(accountNo, ARCHIVE_CORRUPTION_FILE);
			volumeId = archiveSetTableSecondary.getVolumeId(accountNo, archiveNameTdate);
			archiveVolumeSecondary = volumesTableSecondary.getLocalPath(volumeId);
			logger.debug("The File is stored in to Secondary DataCenter Volume: " + archiveVolumeSecondary);
			String customerFolderLocationSeconday = archiveVolumeSecondary + File.separator + customerFolder + File.separator ;
			logger.debug("Customer Folder full path in Secondary DC is: " + customerFolderLocationSeconday);
			if(! arcCorrupter.corruptArchiveHeader(secondaryDataCenterDirectoryMachineName, accountNo, archiveName, customerFolderLocationSeconday, toolsFolder)){			
				Asserter.fail("Archive Corruption Failed");
			}
			logger.debug("Archive Corruption Completed on: " + secondaryDataCenterDirectoryMachineName);
		}	
		/*
		 * Wait for sometime and
		 * Compact the Accounts
		 */
		Thread.sleep(120000);
		Compactor.compactAccounts(primaryDataCenterRegistryMachineName, accountNo);	
		/*
		 * The compact account will never effectively notify the actual compaction is finished or not.
		 * So we are added 2 min wait here as well.
		 */
		Thread.sleep(120000);
		Compactor.startCompactorService(primaryDataCenterRegistryMachineName);
		logger.debug("Compaction completed...");
		
		/*
		 * Verify the FileInedx Entries (Type and Kind for the File)
		 */
		logger.debug("Checking the FileIndex Entries..");
		fileTypes = fileIndexTablePrimary.getFileTypes(accountNo, ARCHIVE_CORRUPTION_FILE);	
//		if(fileTypes.length != 1 ){
//			Asserter.fail("File index entries found for Corrupted File: " + ARCHIVE_CORRUPTION_FILE + " after compaction is not correct");
//		}
//		Asserter.assertEquals(fileTypes[0], 5, "Base File Type is not found in DB!!! Is the file backedup? First filetype is: " + fileTypes[0]);
//		Asserter.assertEquals(fileTypes[1], 6, "Delta File Type is not found in DB!!! Is the file backedup as First Delta? Second filetype is: " + fileTypes[1]);		
//		Asserter.assertEquals(fileTypes[2], 6, "Delta File Type is not found in DB!!! Is the file backedup as Second Delta? Third filetype is: " + fileTypes[2]);		
//		
//		int fileKind = fileIndexTablePrimary.getFileKind(accountNo, ARCHIVE_CORRUPTION_FILE, 1);	
//		Asserter.assertEquals(fileKind, 8, "Base File Type is not found in DB!!! Is the file backedup? First filetype is: " + fileKind);
//		//Asserter.assertEquals(fileKinds[1], 8, "Delta File Type is not found in DB!!! Is the file backedup? Second filetype is: " + fileKinds[1]);	
		
		logger.debug("Login to the AMWS and validate the Files...");
		AccountManagementLogin.login(emailid, password);
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		myRoamPage.selectVersionOption("All");
		myRoamPage.clickOnBackedupFolderExpandCollapseButtonByName(backedupDrive);
		myRoamPage.clickOnBackedupFolderExpandCollapseButtonByName(BACKUP_FOLDER);
		myRoamPage.checkBackedupFolderFromLeftTree(ARCHIVE_CORRUPTION_FOLDER);
		myRoamPage.clickOnBackedupFolderNode(ARCHIVE_CORRUPTION_FOLDER);
		ArrayList<String> fileList = myRoamPage.getAllBackedupItemsFromRightPane();
		if(fileList.size() != 1){
			Asserter.fail("More than 1 revisions of : " + ARCHIVE_CORRUPTION_FILE + " found after archive corruption and compaction");
		}
		MyRoam.retriveSelectedFilesFromMyRoam(MyRoamPage.WINDOWS_EXECUTABLE_FORMAT, retrivedFileUnzipPath, retrivedFile);
		AccountManagementLogin.logout();
		logger.debug("");
		String ARCHIVE_CORRUPTIONDownloadedFile = retrivedFileUnzipPath + BACKUP_FOLDER + File.separator + ARCHIVE_CORRUPTION_FOLDER + File.separator + ARCHIVE_CORRUPTION_FILE;	
		String ARCHIVE_CORRUPTIONOriginalFile = ARCHIVE_CORRUPTION_FILE_ORIGINAL_PATH + File.separator + ARCHIVE_CORRUPTION_FILE;
		Asserter.assertTrue(FileUtils.compareFiles(ARCHIVE_CORRUPTIONOriginalFile , ARCHIVE_CORRUPTIONDownloadedFile), "Files are not equal!! Compared Files are, Retrieved File : " + ARCHIVE_CORRUPTIONDownloadedFile + " Original File: " + ARCHIVE_CORRUPTIONOriginalFile);
		logger.debug("");
	}
	public void initDatabaseTables(){
		logger.debug("Initializing the DataBaseTable Objects");
		if(isDCMirrored || isDCClustered){
			logger.debug("DC is a Mirrored/Clusterd Pair");
			fileIndexTablePrimary = new FileIndexTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			poolIndexTablePrimary = new PoolIndexTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			poolIndexTableSecondary = new PoolIndexTable(DatabaseServer.SECONDARY_DIRECTORY_SERVER);
			expRulesTable = new ExpireRulesTable(DatabaseServer.PRIMARY_REGISTRY_SERVER);
			archiveSetTablePrimary = new ArchiveSetTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			volumesTablePrimary = new VolumesTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);			
			fileIndexTableSecondary = new FileIndexTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			archiveSetTableSecondary = new ArchiveSetTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			volumesTableSecondary = new VolumesTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
		}
		else{
			logger.debug("DC is Stand Alone");
			fileIndexTablePrimary = new FileIndexTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			archiveSetTablePrimary = new ArchiveSetTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			volumesTablePrimary = new VolumesTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			poolIndexTablePrimary = new PoolIndexTable(
					DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			expRulesTable = new ExpireRulesTable(DatabaseServer.PRIMARY_REGISTRY_SERVER);
		}			
	}
	/**
	 * Cleanup the test Data      
	 * @throws Exception
	 */
	@AfterMethod(alwaysRun = true)
	public void deleteFolderAndCompactAccount() throws Exception{	
		
		if(!skipTest){			
			FileUtils.deleteDir(ARCHIVE_CORRUPTION_FILE_PATH);
			ActionRunner.run(TEST_RUNNER_FILE_BACKUP);
			poolIndexTablePrimary.deletePoolIndexEntryForFile(accountNo, ARCHIVE_CORRUPTION_FILE);
			poolIndexTablePrimary.deletePoolIndexEntryForFile(accountNo, ARCHIVE_CORRUPTION_FILE_COPY);
			if(isDCMirrored || isDCClustered){
				poolIndexTableSecondary.deletePoolIndexEntryForFile(accountNo, ARCHIVE_CORRUPTION_FILE);
				poolIndexTableSecondary.deletePoolIndexEntryForFile(accountNo, ARCHIVE_CORRUPTION_FILE_COPY);
			}
			Compactor.compactAccounts(primaryDataCenterRegistryMachineName , accountNo);
			Thread.sleep(120000);
			Compactor.startCompactorService(primaryDataCenterRegistryMachineName);
			logger.debug("Compaction completed...");
		}
	}

	/**
	 * Resetting the Expiration rule back to 90 days
	 * @throws Exception
	 */
	@AfterMethod(alwaysRun = true, dependsOnMethods= {"deleteFolderAndCompactAccount"})
	public void removeFilesForNextExecution() throws Exception{
		
		if(!skipTest){
			expRulesTable.setDeletedRevs("90");
		}
	}
	/**   
	 * Closing all the database connections
	 */
	@AfterMethod(alwaysRun = true, dependsOnMethods= {"removeFilesForNextExecution"})
	public void closeDataBaseConnections(){
		if(!skipTest){

			logger.debug("Closing DataBase Connections...");
			if(isDCMirrored || isDCClustered){
				DataBase.closeDatabaseConnections(fileIndexTablePrimary, fileIndexTableSecondary, poolIndexTablePrimary, 
						poolIndexTableSecondary, expRulesTable, archiveSetTablePrimary, 
						archiveSetTableSecondary, volumesTablePrimary, volumesTableSecondary);
			}	
			else
			{
				DataBase.closeDatabaseConnections(fileIndexTablePrimary, poolIndexTablePrimary, expRulesTable,
						archiveSetTablePrimary, volumesTablePrimary);
			}
		}
	}
	@AfterMethod(alwaysRun = true, dependsOnMethods= {"removeFilesForNextExecution"})
	public void stopTest() throws Exception {
		super.stopSeleniumTest();
	}	
	
}
