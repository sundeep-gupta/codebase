package com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam;

import java.io.File;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.digital.qa.automation.connected.compaction.Compactor;
import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.testrunner.ActionRunner;
import com.ironmountain.pageobject.webobjects.connected.database.DataBase;
import com.ironmountain.pageobject.webobjects.connected.database.directory.FileIndexTable;
import com.ironmountain.pageobject.webobjects.connected.database.directory.PoolIndexTable;
import com.ironmountain.pageobject.webobjects.connected.database.registry.ExpireRulesTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest(priority=10, HPQCID="26416")
public class RetrievalOfExpiredFilesTest extends AccountManagementTest {


	private static String accountNo = null;
	private FileIndexTable fileIndexTable = null;
	private PoolIndexTable poolIndexTablePrimary = null;	
	private PoolIndexTable poolIndexTableSecondary = null;	
	private ExpireRulesTable expRulesTable = null;
	
	/**
	 * This name is from the TestRunner file "MyRoamRegressionDelta*****Backup.xml", if we change the name there in any case
	 * we need to modify this name as well;
	 */
	private static final String EXPIRED_BACKUP_FILE = "MyRoamRegressionExpiredBackup.xml";
	private static final String TEST_RUNNER_FILE_BACKUP = "MyRoamRegressionDummyBackup.xml";
	private static final String  EXPIRED_FILE = "ExpiredTestDataFile.txt";
	private static final String  EXPIRED_FILE_COPY = "ExpiredTestDataFileCopy.txt";
	private static final String  EXPIRED_FILE_SEARCH = "ExpiredTestDataFile";
	private static final String EXPIRED_FILE_PATH = "C:" + File.separator + "MyRoamRegressionData" + File.separator + "ExpiredFolder" ;
	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		initDatabaseTables();
	}
	
	@Parameters({"emailid", "password"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testRetrievalOfExpiredFiles(String emailid, String password) throws Exception
	{	
		expRulesTable.setDeletedRevs("0");
		
		accMgmtHomePage = AccountManagementLogin.login(emailid, password);
		String accNo = accMgmtHomePage.getAccountNumber();		
		accountNo = fileIndexTable.getDbFormattedAccountNumber(accNo);
		AccountManagementLogin.logout();
		
		deleteFolderAndCompactAccount();
		
		ActionRunner.run(EXPIRED_BACKUP_FILE);
		int[] fileTypes = fileIndexTable.getFileTypes(accountNo, EXPIRED_FILE);		
		Asserter.assertEquals(fileTypes[0], 5, "Base File Type is not found in DB!!! Is the file backedup? First filetype is: " + fileTypes[0]);
		Asserter.assertEquals(fileTypes[1], 6, "Delta File Type is not found in DB!!! Is the file backedup? Second filetype is: " + fileTypes[1]);		
		Asserter.assertEquals(fileTypes[2], 4, "Deleted File Type is not found in DB!!! Is the file backedup? First filetype is: " + fileTypes[2]);
		fileTypes = fileIndexTable.getFileTypes(accountNo, EXPIRED_FILE_COPY);	
		Asserter.assertEquals(fileTypes[0], 3, "SymLink File Type is not found in DB!!! Is the file backedup? First filetype is: " + fileTypes[0]);		
		
		int[] fileKinds = fileIndexTable.getFileKinds(accountNo, EXPIRED_FILE);	
		Asserter.assertEquals(fileKinds[0], 2, "Base File Type is not found in DB!!! Is the file backedup? First filetype is: " + fileKinds[0]);
		Asserter.assertEquals(fileKinds[1], 2, "Delta File Type is not found in DB!!! Is the file backedup? Second filetype is: " + fileKinds[1]);		
		Asserter.assertEquals(fileKinds[2], 2, "Deleted File Type is not found in DB!!! Is the file backedup? First filetype is: " + fileKinds[2]);
		fileKinds = fileIndexTable.getFileKinds(accountNo, EXPIRED_FILE_COPY);	
		Asserter.assertEquals(fileKinds[0], 2, "Base File Type is not found in DB!!! Is the file backedup? First filetype is: " + fileKinds[0]);
		
		Compactor.compactAccounts(primaryDataCenterRegistryMachineName, accountNo);	
		/*
		 * The compact account will never effectively notify the actual compaction is finished or not.
		 * So we are added 2 min wait here as well.
		 */
		Thread.sleep(120000);
		Compactor.startCompactorService(primaryDataCenterRegistryMachineName);
		
		fileTypes = fileIndexTable.getFileTypes(accountNo, EXPIRED_FILE);	
		if(fileTypes.length > 1){
			Asserter.fail("More than 1 file index entry found for Deleted File: " + EXPIRED_FILE + " after compaction");
		}
		fileTypes = fileIndexTable.getFileTypes(accountNo, EXPIRED_FILE_COPY);	
		Asserter.assertEquals(fileTypes[0], 5, "File Type not in DB!!! Is the file backedup? First filetype is: " + fileTypes[0]);	
		
		fileKinds = fileIndexTable.getFileKinds(accountNo, EXPIRED_FILE);	
		Asserter.assertEquals(fileKinds[0], 6, "Base File Type is not changes as PoolContributer in DB!!! Filetype is: " + fileKinds[0]);
		fileKinds = fileIndexTable.getFileKinds(accountNo, EXPIRED_FILE_COPY);	
		Asserter.assertEquals(fileKinds[0], 2, "Base File Type is not found in DB!!! Is the file backedup? First filetype is: " + fileKinds[0]);
		
		AccountManagementLogin.login(emailid, password);
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		Asserter.assertTrue(myRoamPage.getSelectedShowVersionsLabel().contains("Most Recent"), "Most recent version is not checked by default");
		myRoamPage.clickOnFindBtn();
		myRoamPage.enterSearchText(EXPIRED_FILE_SEARCH );
		myRoamPage.clickOnFindNextBtn();
		Asserter.assertFalse(myRoamPage.isTextPresent(EXPIRED_FILE), "The file: " +  EXPIRED_FILE + " found which should not be avilable for retrieve");
		Asserter.assertTrue(myRoamPage.isTextPresent(EXPIRED_FILE_COPY), "The file: " +  EXPIRED_FILE_COPY + " found which should not be avilable for retrieve");
		AccountManagementLogin.logout();		
	}
	public void initDatabaseTables(){
		if(isDCMirrored || isDCClustered){
			fileIndexTable = new FileIndexTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			poolIndexTablePrimary = new PoolIndexTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			poolIndexTableSecondary = new PoolIndexTable(DatabaseServer.SECONDARY_DIRECTORY_SERVER);
			expRulesTable = new ExpireRulesTable(DatabaseServer.PRIMARY_REGISTRY_SERVER);
		}
		else{
			fileIndexTable = new FileIndexTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			poolIndexTablePrimary = new PoolIndexTable(DatabaseServer.PRIMARY_DIRECTORY_SERVER);
			expRulesTable = new ExpireRulesTable(DatabaseServer.PRIMARY_REGISTRY_SERVER);
		}			
	}		
	
	public void deleteFolderAndCompactAccount() throws Exception{		
		FileUtils.deleteDir(EXPIRED_FILE_PATH);
		ActionRunner.run(TEST_RUNNER_FILE_BACKUP);
		poolIndexTablePrimary.deletePoolIndexEntryForFile(accountNo, EXPIRED_FILE);
		poolIndexTablePrimary.deletePoolIndexEntryForFile(accountNo, EXPIRED_FILE_COPY);
		if(isDCMirrored || isDCClustered){
			poolIndexTableSecondary.deletePoolIndexEntryForFile(accountNo, EXPIRED_FILE);
			poolIndexTableSecondary.deletePoolIndexEntryForFile(accountNo, EXPIRED_FILE_COPY);
		}
		Compactor.compactAccounts(primaryDataCenterRegistryMachineName , accountNo);
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
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		super.stopSeleniumTest();
	}
	
	
	
}
