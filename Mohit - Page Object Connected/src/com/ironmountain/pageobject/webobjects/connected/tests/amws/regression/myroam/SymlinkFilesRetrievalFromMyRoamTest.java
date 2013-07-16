package com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam;


import java.io.File;
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
import com.ironmountain.pageobject.webobjects.connected.actions.testrunner.agent.BackupRunner;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.MyRoamPage;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest(priority = 7, HPQCID="5943")
public class SymlinkFilesRetrievalFromMyRoamTest extends AccountManagementTest{

	private String backupRunnerFile =  "MyRoamRegressionBackupVersionedData.xml";	
	private String retrivedFile = null;
	private String retrivedFileUnzipPath = null;

	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		retrivedFile = FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("downloadsdir") + File.separator + PropertyPool.getProperty("ArchiveFile");
		retrivedFileUnzipPath = retrivedFile.replaceAll(".zip", "")  + File.separator;
		FileUtils.deleteDir(retrivedFile);
		FileUtils.deleteDir(retrivedFileUnzipPath);
		FileUtils.createDirectory(FileUtils.getBaseDirectory() +File.separator + PropertyPool.getProperty("downloadsdir"));
	}
	
	@Parameters({"emailid", "password", "versionedDataLocation", "backedupFolder", "symLinkFolder", "symLinkFile"})
	@Test(groups={"amws", "myroamsetup"})
	public void setupAccountForMyRoamTests(String emailid, String password, String versionedDataLocation, String backedupFolder, String symLinkFolder, String symLinkFile) throws Exception
	{
		AccountManagementLogin.login(emailid, password);
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		if(! isSymLinkPresent(symLinkFolder)){
		    myRoamPage.enterSearchText("");
			BackupRunner.runBackup(backupRunnerFile);
		}		
		AccountManagementLogin.logout();
		
		AccountManagementLogin.login(emailid, password);
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		MyRoam.searchAndSelectAllFiles(symLinkFolder);
		MyRoam.retriveSelectedFilesFromMyRoam(MyRoamPage.WINDOWS_EXECUTABLE_FORMAT, retrivedFileUnzipPath, retrivedFile);
		String downloadedFile = retrivedFileUnzipPath + backedupFolder + File.separator + symLinkFolder + File.separator + symLinkFile;	
		String originalFile = versionedDataLocation + File.separator +  symLinkFolder + File.separator + symLinkFile ;
		Asserter.assertTrue(FileUtils.compareFiles(originalFile, downloadedFile), "Failed:" + originalFile + " and " + downloadedFile + "are not equal!!");
		AccountManagementLogin.logout();		
	}
	
	public boolean isSymLinkPresent(String folder) throws Exception{
		myRoamPage.clickOnFindBtn();
		myRoamPage.enterSearchText(folder );
		myRoamPage.clickOnFindNextBtn();
		return myRoamPage.isTextPresent(folder);
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		super.stopSeleniumTest();
	}
	
}
