package com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam;

import java.io.File;
import java.util.ArrayList;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.ListUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.MyRoam;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.MyRoamPage;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;
import com.ironmountain.pageobject.webobjects.connected.tests.VerifyUtils;

/*
 * I could see the test is failing because it the continue button is not enabled for download.
 * This happens when one file is selected for the first time message says "0 files selected"
 * A defect is logged for this and its fixed now.(CB-31798). Need to check if the test fails in latest build.
 */

@SeleniumUITest(HPQCID="19430", defectIds={"CB-31798"})
public class SelectDrivesFromRightSidePaneTest extends AccountManagementTest {


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
	
	@Parameters({"emailid", "password", "backedupDrive", "subFolders"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testSelectDrivesFromRightSidePane(String emailid, String password, String backedupDrive, String subFolders) throws Exception
	{
		AccountManagementLogin.login(emailid, password);
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		myRoamPage.checkBackedupFolderFromRightPane(backedupDrive);	
		myRoamPage.clickOnRetrieve();
		boolean isOverData = myRoamPage.isTextPresent("Your selection is larger than 2 GB. MyRoam cannot download a file selection of this size");
		if(! isOverData){
			MyRoam.retriveSelectedFilesFromMyRoam(MyRoamPage.WINDOWS_EXECUTABLE_FORMAT, retrivedFileUnzipPath, retrivedFile);
			ArrayList<String > list = (ArrayList<String>) FileUtils.getAllSubDirectories(retrivedFileUnzipPath);
			String[] backedUpFolders = ListUtils.getStringListAsArray(StringUtils.toStringArrayList(subFolders));
			VerifyUtils.verifyStringsInaList(backedUpFolders, list, true);
		}		
		AccountManagementLogin.logout();
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		super.stopSeleniumTest();
	}
	
}
