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
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.MyRoamPage;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

/*
 * There is a known issue with this test. (Test fails)
 * Long FilePaths will not be Downloaded correctly because of the Windows Limitation, windows wont display long folder paths
 */


@SeleniumUITest(HPQCID="6033")
public class RetrieveFilesWithLongNameTest extends AccountManagementTest {

	private String retrivedFile = null;
	private String retrivedFileUnzipPath = null;
	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		skipTest = true; 
		skipMessage = "This test is skipped because there is a windows issue of long file names retrieval" ;
		super.initAccountManagementTest();
		retrivedFile = FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("downloadsdir") + File.separator + PropertyPool.getProperty("ArchiveFile");
		retrivedFileUnzipPath = retrivedFile.replaceAll(".zip", "")  + File.separator ;
		FileUtils.deleteDir(retrivedFile);
		FileUtils.deleteDir(retrivedFileUnzipPath);
		FileUtils.createDirectory(FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("downloadsdir"));
	}
	
	@Parameters({"emailid", "password", "originalDataLocation", "filePath", "longFile"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testRetrieveFilesWithLongName(String emailid, String password,String originalDataLocation, String filePath, String longFile) throws Exception
	{
		AccountManagementLogin.login(emailid, password);
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		MyRoam.searchAndSelectAllFiles(filePath);
		MyRoam.retriveSelectedFilesFromMyRoam(MyRoamPage.WINDOWS_EXECUTABLE_FORMAT, retrivedFileUnzipPath, retrivedFile);
		String downloadedFile = retrivedFileUnzipPath + File.separator + filePath + File.separator + longFile;	
		String originalFile = originalDataLocation + File.separator + filePath + File.separator + longFile;
		Asserter.assertTrue(FileUtils.compareFiles(originalFile , downloadedFile), "Files Compared are:" + originalFile + " and " + downloadedFile);
		AccountManagementLogin.logout();
	}
	
	@AfterMethod(alwaysRun = true)
	
	public void stopTest() throws Exception	{
		if(!skipTest){
		super.stopSeleniumTest();
		}
	}
	
}
