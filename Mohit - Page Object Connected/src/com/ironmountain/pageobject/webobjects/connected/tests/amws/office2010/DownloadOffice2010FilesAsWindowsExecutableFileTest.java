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
import com.ironmountain.pageobject.webobjects.connected.actions.testrunner.agent.BackupRunner;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.MyRoamPage;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest(priority=1)
public class DownloadOffice2010FilesAsWindowsExecutableFileTest extends AccountManagementTest {
	
	private final String[] excelFiles = {"Excel2010.xls", "Excel2010.xlsb","Excel2010.xlsm","Excel2010.xlsx"};
	private final String[] wordFiles = {"Word2010.docm", "Word2010.docx","Word2010.dotm"};
	private final String[] noteFiles = {"Notebook2010.one"};
	private final String[] pptFiles = {"Presentation1.ppt", "Presentation1.pptm","Presentation1.pptx"};
	private final String[] pubFiles = {"Publication2010.pub"};
	
	private String retrivedFile = null;
	private String retrivedFileUnzipPath = null;
	private String backupFolder = "Office2010BackupData";	

	@BeforeMethod
	public void startTest() throws Exception{
		super.initAccountManagementTest();
		retrivedFile = FileUtils.getBaseDirectory() + "\\" + PropertyPool.getProperty("downloadsdir") + "\\" + PropertyPool.getProperty("ArchiveFile");
		retrivedFileUnzipPath = retrivedFile.replaceAll(".zip", "");
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
		if(! checkForExistingBackup()){
			BackupRunner.runBackup("office2010filesbackup.xml");
		}
		downloadMyRoamArchiveFileAsWindowsExecutable(email, password);
		unzipAndExtractWindowsExecutable();
		comparefiles();
	}
	
	public boolean checkForExistingBackup() throws Exception{
		AccountManagementLogin.login("jmd@im.com", "1connected");
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		myRoamPage.clickOnFindBtn();
		myRoamPage.enterSearchText(backupFolder);
		myRoamPage.clickOnFindBtn();
		myRoamPage.clickOnFindNextBtn();
		return myRoamPage.isTextPresent("Excel2010");
	}
	
	public void downloadMyRoamArchiveFileAsWindowsExecutable(String email, String password) throws Exception {
		AccountManagementLogin.login(email, password);
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		myRoamPage.clickOnFindBtn();
		myRoamPage.enterSearchText(backupFolder);
		myRoamPage.clickOnFindBtn();
		myRoamPage.clickOnFindNextBtn();
		myRoamPage.checkRetrieveFile();
		myRoamPage.clickOnRetrieve();
		myRoamPage.selectArchiveFormat(MyRoamPage.WINDOWS_EXECUTABLE_FORMAT);
		myRoamPage.clickOnContinue();
		myRoamPage.clickOnDownload();
		DownloadUtils.handleDownloadDialog("File Download","ArchiveFile");
	}
	
	public void comparefiles(){
		String filePath1 = "D:\\Connected Automation\\workspace\\uitests\\testdata\\Office2010\\Version2\\";
		String filePath2 = retrivedFileUnzipPath + "\\" + backupFolder;
		
		for (int i = 0; i < excelFiles.length; i++) {
			System.out.println("Files Under Test: " + filePath1 + excelFiles[i]);
			Asserter.assertTrue(FileUtils.compareFiles(filePath1 + excelFiles[i], filePath2 + excelFiles[i]), "Failed:" + filePath1 + excelFiles[i]);
		}	
		for (int i = 0; i < wordFiles.length; i++) {
			System.out.println("Files Under Test: " + filePath1 + wordFiles[i]);
			Asserter.assertTrue(FileUtils.compareFiles(filePath1 + wordFiles[i], filePath2 + wordFiles[i]), "Failed:" + filePath1 + wordFiles[i]);
		}	
		for (int i = 0; i < noteFiles.length; i++) {
			System.out.println("Files Under Test: " + filePath1 + noteFiles[i]);
			Asserter.assertTrue(FileUtils.compareFiles(filePath1 + noteFiles[i], filePath2 + noteFiles[i]), "Failed:" + filePath1 + noteFiles[i]);
		}	
		for (int i = 0; i < pptFiles.length; i++) {
			System.out.println("Files Under Test: " + filePath1 + pptFiles[i]);
			Asserter.assertTrue(FileUtils.compareFiles(filePath1 + pptFiles[i], filePath2 + pptFiles[i]), "Failed:" + filePath1 + pptFiles[i]);
		}	
		for (int i = 0; i < pubFiles.length; i++) {
			System.out.println("Files Under Test: " + filePath1 + pubFiles[i]);
			Asserter.assertTrue(FileUtils.compareFiles(filePath1 + pubFiles[i], filePath2 + pubFiles[i]), "Failed:" + filePath1 + pubFiles[i]);
		}	
	}
	
	public void unzipAndExtractWindowsExecutable(){
		ZipUtils.unzipRetrivedFile(retrivedFileUnzipPath + File.separator   ,retrivedFile );
		String[] command =  {retrivedFileUnzipPath + File.separator + "Myroam_Expander.exe" };
		Executor.executeProcess(command, 30);		
	}
		
	
	@AfterMethod
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}
	
}
