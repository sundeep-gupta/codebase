package com.ironmountain.pageobject.webobjects.connected.actions.amws;

import java.io.File;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumTest;
import com.ironmountain.pageobject.pageobjectrunner.utils.DownloadUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.Executor;
import com.ironmountain.pageobject.pageobjectrunner.utils.ZipUtils;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.MyRoamPage;

/**
 * @author pjames
 *
 */
public class MyRoam {
	
	private static MyRoamPage myroamPage = null;
	
	private static MyRoamPage getMyRoamPage(){
		return (MyRoamPage) PageFactory.getNewPage(MyRoamPage.class);
	}
	
	/**
	 * To Select the drive and retrieve from the Backup Tree. 
	 * 
	 * @param 
	 * @param 
	 * @param 
	 */
	public static void selectFilesAndRetrieve(){
		myroamPage = getMyRoamPage();
		myroamPage.selectDrive();
		myroamPage.clickOnRetrieve();
		
	}	
	public static void searchFiles(String backedupFolder){
		myroamPage = getMyRoamPage();
		myroamPage.clickOnFindBtn();
		myroamPage.enterSearchText(backedupFolder );
		myroamPage.clickOnFindBtn();
		myroamPage.clickOnFindNextBtn();
	}
	public static void searchAndSelectAllFiles(String backedupFolder){
		myroamPage = getMyRoamPage();
		myroamPage.clickOnFindBtn();
		myroamPage.enterSearchText(backedupFolder );
		myroamPage.clickOnFindBtn();
		myroamPage.clickOnFindNextBtn();
		myroamPage.isTextPresentFailOnNotFound(backedupFolder);
		myroamPage.checkRetrieveFile();
	}
	public static MyRoamPage selectFilesAndGoToRetriveOption(String backedupFolder){
		myroamPage = getMyRoamPage();
		myroamPage.clickOnFindBtn();
		myroamPage.enterSearchText(backedupFolder );
		myroamPage.clickOnFindBtn();
		myroamPage.clickOnFindNextBtn();
		myroamPage.checkRetrieveFile();
		return myroamPage.clickOnRetrieve();
	}
		
	public static void unzipAndExtractWindowsExecutableMyRoamFile(String downloadPath, String zipFile){
		ZipUtils.unzipRetrivedFile(downloadPath, zipFile);
		String[] command =  {downloadPath + File.separator + MyRoamPage.MYROAM_WINDOWS_EXECUTABLE_FILE_NAME} ;
		Executor.executeProcess(command, 120);		
	}
	/**
	 * Once the files/folders are selected this method can download and unzip them from myRoam
	 * 
	 * @param retriveFormat
	 * @param downloadPath
	 * @param zipFile
	 * @throws Exception
	 */
	public static void retriveSelectedFilesFromMyRoam(String retriveFormat, String downloadPath, String zipFile) throws Exception{
		myroamPage = getMyRoamPage();
		myroamPage.clickOnRetrieve();
		myroamPage.selectArchiveFormat(retriveFormat);
		myroamPage.clickOnContinue();
		myroamPage.clickOnDownload();
		DownloadUtils.handleDownloadDialog("File Download","ArchiveFile");

		if(retriveFormat.equalsIgnoreCase(MyRoamPage.WINDOWS_EXECUTABLE_FORMAT)){
			unzipAndExtractWindowsExecutableMyRoamFile(downloadPath, zipFile);
		}
		else{
			ZipUtils.unzipRetrivedFile(downloadPath, zipFile);
		}
	}

}
