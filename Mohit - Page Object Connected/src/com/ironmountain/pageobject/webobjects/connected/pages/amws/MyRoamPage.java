package com.ironmountain.pageobject.webobjects.connected.pages.amws;


import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.TimeKeeper;
import com.thoughtworks.selenium.Selenium;

/**
 * @author pjames
 *
 */
/**
 * @author jdevasia
 *
 */
public class MyRoamPage extends AccountManagementHomePage {

	private static final Logger logger = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.pages.amws.MyRoamPage");
	
	public static final String WINDOWS_EXECUTABLE_FORMAT = "Windows Executable - restores data and metadata";
	public static final String ZIP_FILE_FORMAT = "ZIP File - restores data only";
	public static final String MYROAM_WINDOWS_EXECUTABLE_FILE_NAME = "Myroam_Expander.exe";
	public static final String LARGEFILE_WARNING ="Your selection is larger than 2 GB. MyRoam cannot download a file selection of this size. " +
			"To retrieve files through MyRoam, you must deselect some files and try again" ;
	
	
	public MyRoamPage(Selenium sel) {
		selenium = sel;
		selenium.setTimeout("120000000");
		logger.debug("Selenium session For MyRoamPage is:"  + selenium);
	}
	
	public String getAccountName(){
		return getText("MyRoamPage.AccountName");
	}
	
	public boolean verifyAccountNumber(String AccountNumber){
		return isTextPresent(AccountNumber);
	}
	public boolean verifyWelcomeName(String FirstName, String LastName){
		return isTextPresent("Welcome, "+FirstName+" "+LastName);
	}
	
	public boolean verifyComputerName(String ComputerName){
		return isTextPresent(ComputerName);
	}
	
	public boolean verifyBrowseBtn(){
		return isElementPresent("MyRoamPage.BrowseBtn");
	}
	
	public boolean verifyFindBtn(){
		return isElementPresent("MyRoamPage.FindBtn");
	}
	public String getShowVersionsCombo(){
		return getText("MyRoamPage.ShowVersions");
	}
	public boolean verifyTree(){
		return isElementPresent("MyRoamPage.Tree");
	}
	
	public boolean verifyTitle(){
		String res = getTitle();
		String val = getLocator("MyRoamPageTitle");
		if (res.contains(val)){
			return true;
		} else {
			return false;
		}
	}
	
	public boolean verifyRetrievePageTitle(){
		String res = getTitle();
		String val = getLocator("MyRoamRetrievePageTitle");
		if (res.contains(val)){
			return true;
		} else {
			return false;
		}
	}
	
	public boolean verifySummaryTitle(){
		String res = getTitle();
		String val = getLocator("SummaryPageTitle");
		if (res.contains(val)){
			return true;
		} else {
			return false;
		}
	}
	
	public boolean verifyRetriveBtn(){
		return isElementPresent("MyRoamPage.RetrieveBtn");
	}
	
	public boolean verifySearchBox(){
		return isElementPresent("MyRoamPage.SearchBox");
	}
	
	public boolean verifyFindNextBtn(){
		return isElementPresent("MyRoamPage.FindNextBtn");
	}
	
	public boolean verifyFindPrevBtn(){
		return isElementPresent("MyRoamPage.FindPrevBtn");
	}
	
	public boolean verifySearchCloseBtn(){
		return isElementPresent("MyRoamPage.SearchCloseBtn");
	}
	
	public boolean verifyShowVersionsCombo(){
		return isElementPresent("MyRoamPage.ShowVersions");
	}
	public boolean verifyShowVersionsText(){
		return isTextPresent("MyRoamPage.ShowVersionsText");
	}
	
	public boolean verifyArchiveFormatCombo(){
		return isElementPresent("MyRoamPage.ArchiveFormat");
	}
	
	public boolean verifyDownloadTimeExists(){
		return isTextPresent("MyRoamPage.EstimatedDownloadTimeText");
	}
		
	
	public boolean verifySearchText(String searchText){
		String res = getSearchTextTable();
		System.out.println(res);
		if (res.contains(searchText)){
			return true;
		} else {
			return false;
		}	
	}
	
	public void searchFile(String searchText){
		clickOnFindBtn();
		type("MyRoamPage.SearchBox", searchText);
	}
	
	public void checkRetrieveFile(){
		check("MyRoamPage.MultiFileListSelect");
	}
	
	public boolean verifySelectedDate(String dateOption){
		String res = getSelectedLabel("MyRoamPage.ShowVersions");
		if (res.contains(dateOption)){
			return true;
		} else {
			return false;
		}
	}
	
	public String[]  getArchiveFormats(){
		String[] arcformat = getSelectOptions("MyRoamPage.ArchiveFormat");
		return arcformat;
	}
	public String getSelectedArchiveFormatLabel(){
		return getSelectedLabel("MyRoamPage.ArchiveFormat");
	}
	
	public void selectArchiveFormat(String formatOption){
		select("MyRoamPage.ArchiveFormat", "label="+formatOption);
	}
	
	public String[] getselectBackupDates(){
		String[] dates = getSelectOptions("MyRoamPage.DateList");
		return dates;		
	}
	public String[] getBackupDatesList(){
		String[] datesList = getSelectOptions("MyRoamPage.DateList");
		return datesList;		
	}
	public void selectBackUpDate(String dateOption){
		select("MyRoamPage.DateList", dateOption);
		click("MyRoamPage.SubmitDate");
		waitForPageLoad();
	}
	
	public String getSearchTextTable(){
		return getText("MyRoamPage.FileListTable"); 
	}
	
	public String getSelectedShowVersions(){
		return getSelectedValue("MyRoamPage.ShowVersions");
	}
	public String getSelectedShowVersionsLabel(){
		return getSelectedLabel("MyRoamPage.ShowVersions");
	}
	
	public void selectVersionOption(String ShowVersionsValue){
		
		if(! getSelectedShowVersionsLabel().equalsIgnoreCase(ShowVersionsValue)){
			select("MyRoamPage.ShowVersions", "label="+ShowVersionsValue);
			waitForPageLoad();
		}
	}
	
	public void selectDrive(){
		check("MyRoamPage.DriveChkBox");
	}
	public void enterSearchText(String searchText){
		type("MyRoamPage.SearchBox", searchText);
		fireEvent("MyRoamPage.SearchBox", "keyup");
		waitForSeconds(1);
	}
	public void clickOnNameContainsTextField(){
		click("MyRoamPage.SearchBox");
		waitForSeconds(1);
	}
	public void clickOnFindBtn(){
		click("MyRoamPage.FindBtn");
		waitForSeconds(5);
	}
	public void clickOnFindNextBtn(){
		click("MyRoamPage.FindNextBtn");
		waitForSeconds(8);
	}
	public boolean isFindNextButtonEnabled(){
		return isEditable("MyRoamPage.FindNextBtn");
	}
	public boolean isFindPreviousButtonEnabled(){
		return isEditable("MyRoamPage.FindPreviousButton");
	}
	public void clickOnCloseSearch(){
		click("MyRoamPage.SearchCloseBtn");
		waitForSeconds(5);
	}
	
	public SummaryPage clickOnBackToSummary(){
		clickAndWaitForPageLoad("MyRoamPage.BackToSummary");
		return (SummaryPage) PageFactory.getNewPage(SummaryPage.class);
	}
	public MyRoamPage clickOnRetrieve(){
		click("MyRoamPage.RetrieveBtn");
		waitForSeconds(5);
		Asserter.assertTrue(isTextPresent("Files selected to retrieve"),"Page is not navigated after clicking on Retrieve button");
		return this;
	}
	public void clickOnReturnToRetrieve(){
		click("MyRoamPage.ReturnToRetrieveBtn");
		waitForSeconds(1);
		Asserter.assertTrue(isTextPresent("Show Versions"),"Page is not navigated after clicking on ReturnToRetrieve button");

	}
	public void clickOnReturnToRetrieveFromDownloadPage(){
		click("myroam_download_next_form:backupCancel");
		waitForSeconds(1);
		Asserter.assertTrue(isTextPresent("Show Versions"),"Page is not navigated after clicking on ReturnToRetrieve button");
	}
	public void clickOnContinue(){
		click("MyRoamPage.ContinueBtn");
		waitForSeconds(2);
		isTextPresent("Please wait, MyRoam is creating a self-extracting executable");
		waitForSeconds(5);
		isTextPresent("Windows PC Download Instructions");
	}
	/**
	 * For situations where we need to wait for long time to download file ready
	 * 
	 * @param minutes
	 */
	public void clickOnContinue(int minutes){
		click("MyRoamPage.ContinueBtn");
		for (int i = 0; i < minutes; i++) {

			waitForSeconds(60);
			if(isTextPresent("Windows PC Download Instructions", 1)){
				break;
			}
		}
	}

	public void clickOnDownload(){
		click("MyRoamPage.DownloadBtn");
		//isElementPresent("MyRoamPage.ReturnToRetrieveBtn");
	}
	
	public boolean isMachineNameTreePaneSelected(){
		return isElementPresent("//span[@class='treeSelected' and @id='MyRoamForm:server_tree:1:nodeTextGroup']",5);
	}
	public boolean isBackedupFolderTreeNodeSelected(String backedupFolder){
		String folderIndex = getBackedupFolderIndexFromLeftTree(backedupFolder);
		return isElementPresent("//span[@class='treeSelected' and @id='MyRoamForm:server_tree:" + folderIndex + ":nodeTextGroup']",5);
	}
	public boolean isBrowseButtonSelected(){
		return isElementPresent("//button[@class='selectedButton' and @id='browseButton']",5);
	}
	public boolean isTreePaneNodePresent(String nodeIndex){
		return isElementPresent("MyRoamForm:server_tree:" + nodeIndex + ":nodeTextGroup",5);
	}
	public boolean isBackedupFolderPresent(String backedupFolder){
		return isElementPresent("//span[contains(text(), '"+ backedupFolder + "') and contains(@id, 'MyRoamForm:server_tree')]",5);
	}
	public MyRoamPage clickOnBackedupFolderNode(String backedupFolder){
		clickAndWaitForPageLoad("//span[contains(text(), '"+ backedupFolder + "') and contains(@id, 'MyRoamForm:server_tree')]");
		return this;
	}
	public void checkMachineNameFromLeftTree(){
		check("MyRoamForm:server_tree:1:selBox");
	}
	public void clickOnMachineNameFromLeftTree(){
		check("MyRoamForm:server_tree:1:nodetext");
	}
	public String getBackedupFolderIndexFromLeftTree(String backedupFolder){
		String index = "0" ;
		for (int i = 1; i < 20; i++) {
			if(isElementPresent("//span[@id='MyRoamForm:server_tree:" + i +":nodetext']", 1)){
					if(getText("//span[@id='MyRoamForm:server_tree:" + i +":nodetext']").equalsIgnoreCase(backedupFolder)){
					index = Integer.toString(i);
					break;
				}
			}
		}
		return index;
	}
	public MyRoamPage clickOnBackedupFolderExpandCollapseButtonByIndex(String folderIndex){
		clickAndWaitForPageLoad("MyRoamForm:server_tree:"+ folderIndex +":t2");
		return this;
	}
	public MyRoamPage clickOnBackedupFolderExpandCollapseButtonByName(String backedupFolder){		
		String folderIndex = getBackedupFolderIndexFromLeftTree(backedupFolder);
		clickAndWaitForPageLoad("MyRoamForm:server_tree:"+ folderIndex  +":t2");
		return this;
	}
	public boolean isEmoPstFilePresent(){
		return isElementPresent("//table[contains(@id, 'file_type_name_grid') and contains(@title, 'This file can only be retrieved through the Agent application')]",5);
	}
	public void checkBackedupFolderFromLeftTree(String backedupFolder){
		String index = getBackedupFolderIndexFromLeftTree(backedupFolder);
		check("MyRoamForm:server_tree:"+ index + ":selBox");
	}
	public void unCheckBackedupFolderFromLeftTree(String backedupFolder){
		String index = getBackedupFolderIndexFromLeftTree(backedupFolder);
		unCheck("MyRoamForm:server_tree:"+ index + ":selBox");
	}
	public boolean isBackedupFolderFromTreeChecked(String backedupFolder){
		String index = getBackedupFolderIndexFromLeftTree(backedupFolder);
		return isChecked("MyRoamForm:server_tree:"+ index + ":selBox");
	}
	public boolean isBackedupFolderInRightPaneSelected(String backedupFolder){
		String index = getBackedupFolderIndexFromRightPane(backedupFolder);
		return isElementPresent("//span[@class='treeSelected' and @id='MyRoamForm:filelistdatatable:" + index +":nametext']",5);
	}
	public String getBackedupFolderIndexFromRightPane(String backedupFolder){
		String index = "" ;
		for (int i = 0; i < 20; i++) {
			if(isElementPresent("MyRoamForm:filelistdatatable:" + i +":nametext", 1)){
					if(getText("MyRoamForm:filelistdatatable:"+ i +":nametext").equalsIgnoreCase(backedupFolder)){
					    index = Integer.toString(i);
					    System.out.println("Folder index is: " + i);
					    break;
				    }
			 }
		}
		if(StringUtils.isEmpty(index)){
			Asserter.fail("Failed to get the folder index, the reason will be \n 1.Folder doesn't exist \n 2. Folder not selected");
		}
		return index;
	}	
	public String getFirstSelectCheckboxIndexFromRightPane(){
		for (int i = 1; i < 25; i++) {
			if(isElementPresent("MyRoamForm:listViewSelections:" + i, 1)){
				return Integer.toString(i);
			 }
		}
		return "";
	}	
	public void checkBackedupFolderFromRightPane(String backedupFolder){
		String startValue = getFirstSelectCheckboxIndexFromRightPane();
		String index = getBackedupFolderIndexFromRightPane(backedupFolder);
		int actualCheckboxIndex = Integer.parseInt(startValue) +  Integer.parseInt(index);
		check("MyRoamForm:listViewSelections:" + actualCheckboxIndex);
		fireEvent("MyRoamForm:listViewSelections:" + actualCheckboxIndex, "blur");		
	}
	public void unCheckBackedupFolderFromRightPane(String backedupFolder){
		String startValue = getFirstSelectCheckboxIndexFromRightPane();
		String index = getBackedupFolderIndexFromRightPane(backedupFolder);
		int actualCheckboxIndex = Integer.parseInt(startValue) +  Integer.parseInt(index);
		unCheck("MyRoamForm:listViewSelections:" + actualCheckboxIndex);
	}
	public void checkAllBackupFoldersFromRightPane(){
		check("MyRoamPage.MultiFileListSelect");
	}
	public boolean isAllBackupFoldersFromRightPaneChecked(){
		ArrayList<String> list= getAllBackedupItemsIndicesFromRightPane();
		String startValue = getFirstSelectCheckboxIndexFromRightPane();
		for (String i : list) {			
			int actualCheckboxIndex = Integer.parseInt(startValue) +  Integer.parseInt(i);
			if(isEditable("MyRoamForm:listViewSelections:" + actualCheckboxIndex)){
				if(! isChecked("MyRoamForm:listViewSelections:" + actualCheckboxIndex)){
					return false;
				}
			}
		}
		return true;		
	}
	public boolean isAllBackupFoldersFromRightPaneUnChecked(){
		ArrayList<String> list= getAllBackedupItemsIndicesFromRightPane();
		String startValue = getFirstSelectCheckboxIndexFromRightPane();
		for (String i : list) {
			int actualCheckboxIndex = Integer.parseInt(startValue) +  Integer.parseInt(i);
			if(isChecked("MyRoamForm:listViewSelections:" + actualCheckboxIndex)){
				return false;
			}
		}
		return true;		
	}
	public ArrayList<String> getAllBackedupItemsFromRightPane(){
		ArrayList<String> list = new ArrayList<String>();
		int notFoundCounter = 0;
		for (int i = 0; i < 20; i++) {
			if(isElementPresent("MyRoamForm:filelistdatatable:" + i +":nametext", 1)){
				list.add(getText("MyRoamForm:filelistdatatable:" + i +":nametext"));
			 }
			 else{
				notFoundCounter ++;
			 }
			 if(notFoundCounter >= 2){
				break;
			 }
		}
		return list;
	}	
	public boolean isBackedupItemPresentInRightPane(String backedupFolder){

		int notFoundCounter = 0;
		for (int i = 0; i < 20; i++) {
			if(isElementPresent("MyRoamForm:filelistdatatable:" + i +":nametext", 1)){
				if(getText("MyRoamForm:filelistdatatable:" + i +":nametext").equalsIgnoreCase(backedupFolder)){
					return true;
				}
			 }
			 else{
				notFoundCounter ++;
			 }
			 if(notFoundCounter >= 2){
				break;
			 }
		}
		return false;
	}	
	public ArrayList<String> getAllBackedupItemsIndicesFromRightPane(){
		ArrayList<String> list = new ArrayList<String>();
		int notFoundCounter = 0;
		for (int i = 0; i < 30; i++) {
			if(isElementPresent("MyRoamForm:filelistdatatable:" + i +":nametext", 1)){
				list.add(Integer.toString(i));
			 }
			 else{
				notFoundCounter ++;
			 }
			 if(notFoundCounter >= 2){
				break;
			 }
		}
		return list;
	}	
	/**
	 * Click on the Name Column header from the right pane, this will sort the column by Name
	 */
	public void clickOnNameColumn(){
		clickAndWaitForPageLoad("MyRoamForm:filelistdatatable:nametextheader");
	}
	public void clickOnSizeColumn(){
		clickAndWaitForPageLoad("MyRoamForm:filelistdatatable:sizetextheader");
	}
	public void clickOnTypeColumn(){
		clickAndWaitForPageLoad("MyRoamForm:filelistdatatable:typetextheader");
	}
	public void clickOnDateModifiedColumn(){
		clickAndWaitForPageLoad("MyRoamForm:filelistdatatable:datetextheader");
	}
	public boolean isSortedByAscendingOrder(String header){
		header = header.toLowerCase();
		return isElementPresent("//a[@id='MyRoamForm:filelistdatatable:sortby"+ header +"']/img[contains(@src,'sort_arrow_down')]",2);
	}
	public boolean isSortedByDecendingOrder(String header){
		header = header.toLowerCase();
		return isElementPresent("//a[@id='MyRoamForm:filelistdatatable:sortby"+ header +"']/img[contains(@src,'sort_arrow_up')]",2);
	}
	/*
	 * Methods to Operate with the Find Files/Folder options
	 */
	
	public boolean isFindFilesAreaDisplayed(){
		return isElementPresent("//input[@id='MyRoamForm:findModeCtrl' and @value='true']",5);
	}
	public String getLookInFolder(){
		return getText("//table[@id='MyRoamForm:findDivTable2']/tbody/tr[2]/td[2]");
	}
	public String getErrorMessagesInRed(){
		return getText("//span[@class='errorMessage']/b");
	}

	/*
	 * Methods to check Tool Tip texts
	 */
	
	public boolean isBrowseButtonToolTipTextPresent(){
		String tooltip = getLocator("MyRoamPage.BrowseButtonToolTip");
		return isElementPresent("//img[@title='"+ tooltip +"' and @alt='" + tooltip + "']");
	}
	public boolean isFindButtonToolTipTextPresent(){
		String tooltip = getLocator("MyRoamPage.FindButtonToolTip");
		return isElementPresent("//img[@title='"+ tooltip +"' and @alt='" + tooltip + "']");
	}
	public boolean isShowVersionsButtonToolTipTextPresent(){
		String tooltip = getLocator("MyRoamPage.ShowVersionsButtonToolTip");
		return isElementPresent("//span[@title='"+ tooltip +"']");
	}
	public boolean isRetrieveButtonToolTipTextPresent(){
		String tooltip = getLocator("MyRoamPage.RetrieveButtonToolTip");
		return isElementPresent("//input[@title='"+ tooltip +"']");
	}
}
