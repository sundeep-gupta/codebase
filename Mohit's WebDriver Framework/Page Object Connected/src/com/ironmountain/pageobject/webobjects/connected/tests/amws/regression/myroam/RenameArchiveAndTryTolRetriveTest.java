package com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam;

import java.io.File;

import org.apache.log4j.Logger;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.digital.qa.automation.TestRunner.actions.FileActions.FileRenameAction;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.testrunner.ActionRunner;
import com.ironmountain.pageobject.webobjects.connected.database.DataBase;
import com.ironmountain.pageobject.webobjects.connected.database.directory.ArchiveSetTable;
import com.ironmountain.pageobject.webobjects.connected.database.directory.FileIndexTable;
import com.ironmountain.pageobject.webobjects.connected.database.directory.VolumesTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

/*
 * This test case will fail due to the existing issues
 */
/**
 * @author jdevasia
 *
 */
@SeleniumUITest(priority=9, HPQCID="6044", defectIds={"CB-30753","CB-38038"})
public class RenameArchiveAndTryTolRetriveTest extends AccountManagementTest {

	private static Logger  logger      = Logger.getLogger("RenameArchiveAndTryTolRetriveTest.class");
	
	private String accountNo = null;
	private String archiveName = null;
	private String archiveVolumePrimary = null;
	private String archiveVolumeSecondary = null;
	private String newArchiveName = "ArchiveRenamed";
	private String arcExtention = ".arc";

	private FileIndexTable fileIndexTablePrimary = null;
	private ArchiveSetTable archiveSetTablePrimary = null;
	private VolumesTable volumesTablePrimary = null;
	private FileIndexTable fileIndexTableSecondary = null;
	private ArchiveSetTable archiveSetTableSecondary = null;
	private VolumesTable volumesTableSecondary = null;
	
	/*
	 * Set the value if the rename operation is successful
	 */
	private boolean isRenamed = false;
	/**
	 * This name is from the TestRunner file "MyRoamRegressionRenameArchive*****Backup.xml", if we change the name there in any case
	 * we need to modify this name as well;
	 */
	private static final String archivedFile1 = "0-DataFile.txt";
	private static final String archivedFile10 = "9-DataFile.txt";
	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		skipTest = true; 
		skipMessage = "This test is skipped because of the defects: CB-30753 and CB-38038" ;
		logger.info("Starting test..initializing");
		super.initAccountManagementTest();
		logger.info("Test initialization completed");
		logger.info("");
	}
	
	@Parameters({"emailid", "password"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testRenameArchiveAndTryToRetrive(String emailid, String password) throws Exception
	{	
		logger.info("Actual test method called...This test will run only if the Mirrored/clustured setup is there..");
		
		if (isDCMirrored || isDCClustered) {

			fileIndexTablePrimary = new FileIndexTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			archiveSetTablePrimary = new ArchiveSetTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			volumesTablePrimary = new VolumesTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			
			fileIndexTableSecondary = new FileIndexTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			archiveSetTableSecondary = new ArchiveSetTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			volumesTableSecondary = new VolumesTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			
			logger.info("DC is mirrored/clustered starting the test..");
			accMgmtHomePage = AccountManagementLogin.login(emailid, password);
			logger.info("Getting the account number from UI..");
			String accNo = accMgmtHomePage.getAccountNumber();
			logger.info("Account number is.." + accNo);
			accountNo = fileIndexTablePrimary.getDbFormattedAccountNumber(accNo);
			logger.info("DB formatter account number is.." + accountNo);
			myRoamPage = AccountManagementNavigation.viewMyRoamPage();
			runBackupIfFileNotPresent(archivedFile1,
					"MyRoamRegressionRenameArchiveFirstBackup.xml");
			AccountManagementLogin.logout();
			myRoamPage.waitForSeconds(5);
			logger.info("Getting the archive name for the file: "
					+ archivedFile1);
			archiveName = fileIndexTablePrimary.getArchiveName(accountNo,archivedFile1);
			logger.info("Archive file name is.." + archiveName);
			
			String archiveNameTdate = fileIndexTablePrimary.getArchiveNameAsTDate(accountNo, archivedFile1);
			int volumeId = archiveSetTablePrimary.getVolumeId(accountNo, archiveNameTdate);
			archiveVolumePrimary = volumesTablePrimary.getLocalPath(volumeId);

			archiveNameTdate = fileIndexTableSecondary.getArchiveNameAsTDate(accountNo, archivedFile1);
			volumeId = archiveSetTableSecondary.getVolumeId(accountNo, archiveNameTdate);
			archiveVolumeSecondary = volumesTableSecondary.getLocalPath(volumeId);
			
			logger.info("Logging back to Amws again..");
			AccountManagementLogin.login(emailid, password);
			myRoamPage = AccountManagementNavigation.viewMyRoamPage();
			logger.info("Backing up files 5-10");
			runBackupIfFileNotPresent(archivedFile10,
					"MyRoamRegressionRenameArchiveSecondBackup.xml");
			myRoamPage.waitForSeconds(5);
			AccountManagementLogin.logout();

			renameArchiveFileForFirst5DataFiles(archiveName, newArchiveName);

			logger.info("Login to amws again..");
			AccountManagementLogin.login(emailid, password);
			myRoamPage = AccountManagementNavigation.viewMyRoamPage();
			myRoamPage.clickOnFindBtn();
			logger.info("Searching of acrchive file 1.." + archivedFile1);
			myRoamPage.enterSearchText(archivedFile1);
			myRoamPage.clickOnFindNextBtn();
			myRoamPage.checkRetrieveFile();
			logger.info("Clicking on retrieve button..");
			myRoamPage.clickOnRetrieve();
			logger.info("Verifying the warning message..");
			myRoamPage
					.isTextPresentFailOnNotFound("Myroam cannot access 5 of the files you selected. They might have been removed from Data Center");
			AccountManagementLogin.logout();
		}
		else{
			logger.info("Test is not actually executed since its written for a Stand alone setup..");
		}
	}
	
	
	public void runBackupIfFileNotPresent(String archivedFile, String runnerFile) throws Exception{
		logger.info("Running backup for file.." + archivedFile);
		myRoamPage.clickOnFindBtn();
		myRoamPage.enterSearchText(archivedFile);
		myRoamPage.clickOnFindNextBtn();
		if(! myRoamPage.isBackedupItemPresentInRightPane(archivedFile)){
			logger.info("Running  backup using Runner file.." + runnerFile);
			ActionRunner.run(runnerFile);
			logger.info("Backup completed...");
		}
	}
	
	public void renameArchiveFileForFirst5DataFiles(String arcName, String newArcName){
		logger.info("Renaming archive file.." + arcName + " to new name.." + newArcName);
		String folderRoot = accountNo.substring(accountNo.length() - 2);
		logger.info("Primary Data center machine is.." + primaryDataCenterDirectoryMachineName);
		String archiveFilePathPrimary = archiveVolumePrimary + File.separator + customerFolder + File.separator + folderRoot + File.separator + "0" + accountNo + File.separator + "archives"  + File.separator + arcName + arcExtention;
		String archiveFilePathSecondary = archiveVolumeSecondary + File.separator + customerFolder + File.separator + folderRoot + File.separator + "0" + accountNo + File.separator + "archives" + File.separator + arcName + arcExtention;
		logger.info("Archive file path to rename in the Primary Machine is..." + archiveFilePathPrimary);
		logger.info("Archive file path to rename in the secondary Machine is..." + archiveFilePathSecondary);
		logger.info("Rename action started...");
		logger.info("Primary Data center machine(Directory/Where customer folder kept) is.." + primaryDataCenterDirectoryMachineName + ":" + archiveFilePathPrimary);
		logger.info("Secondary Data center machine(Directory/Where customer folder kept) is.." + secondaryDataCenterDirectoryMachineName + ":" + archiveFilePathSecondary);
		FileRenameAction.renameFileInRemoteMachine(primaryDataCenterDirectoryMachineName, archiveFilePathPrimary, newArcName + arcExtention);	
		FileRenameAction.renameFileInRemoteMachine(secondaryDataCenterDirectoryMachineName, archiveFilePathSecondary, newArcName + arcExtention);
		if(!isRenamed){
			isRenamed = true;
		}
	}
	/**
	 * Closing all the database connections
	 */
	@AfterMethod(alwaysRun = true)
	public void closeDataBaseConnections(){
		if(!skipTest){
		   if(isDCMirrored || isDCClustered){			
			    DataBase.closeDatabaseConnections(fileIndexTablePrimary, fileIndexTableSecondary, archiveSetTablePrimary, archiveSetTableSecondary
					, volumesTablePrimary, volumesTableSecondary);
		    }
		}
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{	
		if(!skipTest){
		super.stopSeleniumTest();
	}
	}

	/**
	 * If the files are renamed in both the DCs we may need to rename them back to the original state
	 * @throws Exception
	 */
	@AfterMethod(alwaysRun = true)
	public void changeArchiveToOriginalName() throws Exception	{
		if(!skipTest){
		if(isRenamed){
			logger.info("Changing Archinve to its original name.." + archiveName);		
			renameArchiveFileForFirst5DataFiles(newArchiveName, archiveName );
		}
	}
	}
	
	
}
