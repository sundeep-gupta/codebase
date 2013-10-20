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
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.MyRoam;
import com.ironmountain.pageobject.webobjects.connected.actions.testrunner.ActionRunner;
import com.ironmountain.pageobject.webobjects.connected.database.directory.FileIndexTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.MyRoamPage;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest(priority=10, HPQCID="5944")
public class DeltaFilesRetriveUsingMyRoamTest extends AccountManagementTest {

	private static Logger  logger      = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam.DeltaFilesRetriveUsingMyRoamTest");
	
	private String accountNo = null;
	private FileIndexTable fileIndexTable = null;
	private String retrivedFile = null;
	private String retrivedFileUnzipPath = null;
	
	/**
	 * This name is from the TestRunner file "MyRoamRegressionDelta*****Backup.xml", if we change the name there in any case
	 * we need to modify this name as well;
	 */
	private static final String DELTA_BACKUP_FILE = "MyRoamRegressionDeltaBackup.xml";
	private static final String deltaFile = "DeltaTestDataFile.txt";
	private static final String backupFolder = "MyRoamRegressionData";
	private static final String deltaFolder = "DeltaFolder";
	private static final String deltaFileOriginalPath = "C:\\" + backupFolder + File.separator + deltaFolder ;
	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		logger.info("Startign test..initializing");
		super.initAccountManagementTest();
		logger.info("Test initialization completed");
		logger.info("Creating fileindex table object..");
		fileIndexTable = new FileIndexTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
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
	
	@Parameters({"emailid", "password"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testDeltaFilesRetriveUsingMyRoam(String emailid, String password) throws Exception
	{	
		logger.info("Actul test method called...Trying to login with emial '" + emailid + "' Password '" + password + "'");
		accMgmtHomePage = AccountManagementLogin.login(emailid, password);
		logger.info("Getting account number for user..");
		String accNo = accMgmtHomePage.getAccountNumber();		
		logger.info("Account number from account management website is.." + accNo);
		accountNo = fileIndexTable.getDbFormattedAccountNumber(accNo);
		logger.info("Account number formatted for DB.." + accountNo);
		logger.info("Navigating to myroam page..");
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		logger.info("Checking if the backup is already done..");
		runBackupIfFileNotPresent(deltaFile, DELTA_BACKUP_FILE);
		logger.info("Retrieving the file types from fielindex table..");
		int[] fileTypes = fileIndexTable.getFileTypes(accountNo, deltaFile);			
		Asserter.assertEquals(fileTypes[0], 5, "Base File Type is not found in DB!!! Is the file backedup? First filetype is: " + fileTypes[0]);
		Asserter.assertEquals(fileTypes[1], 6, "Delta File Type is not found in DB!!! Is the file backedup? Second filetype is: " + fileTypes[0]);	
		logger.info("Logging out from application...");
        AccountManagementLogin.logout();
		
		AccountManagementLogin.login(emailid, password);
		logger.info("Logged in and trying to navigate to MyRoam..");
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		logger.info("Verifying the default show version label..");
		Asserter.assertTrue(myRoamPage.getSelectedShowVersionsLabel().contains("Most Recent"), "Most recent version is not checked by default");
		logger.info("Clicking on find button..");
		myRoamPage.clickOnFindBtn();
		logger.info("Typing text..'" + deltaFile + "' for search");
		myRoamPage.enterSearchText(deltaFile);
		myRoamPage.clickOnFindNextBtn();
		logger.info("Clciked on find button..");
		logger.info("Check the files from right pane..");
		myRoamPage.checkAllBackupFoldersFromRightPane();
		logger.info("Retrive files..");
		MyRoam.retriveSelectedFilesFromMyRoam(MyRoamPage.WINDOWS_EXECUTABLE_FORMAT, retrivedFileUnzipPath, retrivedFile);
		String downloadedFile = retrivedFileUnzipPath + backupFolder + File.separator + deltaFolder + File.separator + deltaFile;	
		logger.info("Fiel downloaded is '" + downloadedFile);
		String originalFile = deltaFileOriginalPath + File.separator + deltaFile;
		logger.info("Original file for comparison is.." + originalFile);
		logger.info("Comparing files...");
		Asserter.assertTrue(FileUtils.compareFiles(originalFile , downloadedFile), "Files are not equal!! Compared Files are, Retrieved File : " + downloadedFile + " Original File: " + originalFile);
		logger.info("Test Completed successfully...");
	}
		
	public void runBackupIfFileNotPresent(String archivedFile, String runnerFile) throws Exception{
		logger.info("Trying to fidn the file..");
		myRoamPage.clickOnFindBtn();
		myRoamPage.enterSearchText(archivedFile);
		myRoamPage.clickOnFindNextBtn();
		logger.info("Checking file if its already present..");
		if(! myRoamPage.isBackedupItemPresentInRightPane(archivedFile)){
			logger.info("Fiel not present..Runngin backup...");
			ActionRunner.run(runnerFile);
			logger.info("Backeup completed...");
		}
	}
	/**
	 * Closing all the database connections
	 */
	public void closeDataBaseConnections(){
		if(fileIndexTable!=null){
			try {
				fileIndexTable.closeDatabaseConnection();
			} catch (Exception e) {
				e.printStackTrace();
			}
			finally{
				fileIndexTable.closeDatabaseConnection();
			}
		}
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{		
		closeDataBaseConnections();
		logger.info("Stopping session...");
		super.stopSeleniumTest();
		logger.info("Session ended...");
	}
	
	
	
}
