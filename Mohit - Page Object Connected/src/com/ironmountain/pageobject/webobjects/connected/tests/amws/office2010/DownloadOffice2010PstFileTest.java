package com.ironmountain.pageobject.webobjects.connected.tests.amws.office2010;

import java.io.File;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.utils.DownloadUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.Executor;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.ZipUtils;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.MyRoamPage;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest(priority=1)
public class DownloadOffice2010PstFileTest extends AccountManagementTest {
	
	private final String pstFile = "Outlook2010.pst";	
	private String retrivedFile = null;
	private String retrivedFileUnzipPath = null;
	private String backupFolder = "Office2010BackupData";	

	@BeforeMethod
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		retrivedFile = FileUtils.getBaseDirectory() + File.separator  + PropertyPool.getProperty("downloadsdir") + File.separator  + PropertyPool.getProperty("ArchiveFile");
		retrivedFileUnzipPath = retrivedFile.replaceAll(".zip", "") + File.separator  ;
		FileUtils.deleteDir(retrivedFile);
		FileUtils.deleteDir(retrivedFileUnzipPath);
	}
		
	/** Tests to verify the My Roam Archive exe format
	 * @param email 
	 * @param password 
	 * @throws Exception
	 */
	@Parameters({"email","password"})
	@Test(enabled = true, groups= {"office2010"})
	public void testMethod(String email, String password) throws Exception{
		downloadMyRoamArchiveFileAsWindowsExecutable(email, password, backupFolder);
		unzipAndExtractWindowsExecutable();
		verifyPstFile(pstFile);
	}
	
	public void downloadMyRoamArchiveFileAsWindowsExecutable(String Email, String Password,
			String searchText) throws Exception {
		AccountManagementLogin.login(Email, Password);
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		myRoamPage.clickOnFindBtn();
		myRoamPage.enterSearchText(searchText);
		myRoamPage.clickOnFindBtn();
		myRoamPage.clickOnFindNextBtn();
		myRoamPage.checkRetrieveFile();
		myRoamPage.clickOnRetrieve();
		myRoamPage.selectArchiveFormat(MyRoamPage.WINDOWS_EXECUTABLE_FORMAT);
		myRoamPage.clickOnContinue();
		myRoamPage.clickOnDownload();
		DownloadUtils.handleDownloadDialog("File Download","ArchiveFile");
	}
	
	public void verifyPstFile(String pstFile){
		String filePath2 = retrivedFileUnzipPath + backupFolder;	
		System.out.println(filePath2);
		File f = new File(filePath2);
		File[] files = f.listFiles();
		for (int i = 0; i < files.length; i++) {
			if(files[i].getName().contains(pstFile)){
				Asserter.fail("Pst File is downloaded while retreving from MyRoam!!! File is " + files[i].getName());
			}
		}		
	}
	
	public void unzipAndExtractWindowsExecutable(){
		ZipUtils.unzipRetrivedFile(retrivedFileUnzipPath, retrivedFile );
		String[] command =  {retrivedFileUnzipPath + "Myroam_Expander.exe"} ;
		Executor.executeProcess(command, 30);		
	}
		
	
	@AfterMethod
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}
	
	
}
