package com.ironmountain.pageobject.webobjects.connected.pages.amws;


import java.util.ArrayList;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.thoughtworks.selenium.Selenium;

/**
 * The Page Object which maps the OrderCD or DVD Page
 * 
 * @author Jinesh Devasia
 *
 */
public class OrderCdOrDvdForm1Page extends AccountManagementHomePage {

	private static final String PAGE_NAME_REF = "OrderCdOrDvdForm1Page.";
	
	public OrderCdOrDvdForm1Page(Selenium sel){
		selenium = sel;
	}
    /**
     * Select a backup date from the list "Available backup dates:"
     * This method will select the options based on the option indices, here the user may not know the label
     * or what option is going to select, please refer the overloaded method below.
     * 
     * @param optionIndex
     */
    public void selectBackupDate(String optionIndex){
		
        select(PAGE_NAME_REF + "BackupDateList", "value="+ optionIndex );
    }
	/**
	 * Select a backup date from the list "Available backup dates:"
	 * Select is failing because of the spaces in the label values, so we should pass
	 * the option value, basically it's the index of the label/backup dates list, then dynamically
	 * get the label form the page. Added an addition condition that the backup date provided and 
	 * the system select are equal.
	 * 
	 * @param optionIndex
	 * @param backupDate
	 */
	public void selectBackupDate(String optionIndex, String backupDate){
		
		String optionIndexLabel = getText("//option[@value='"+optionIndex+"']").replaceAll(" ", "");
		String backupLabel = backupDate.replaceAll(" ", "");
        if(optionIndexLabel.contains(backupLabel))
             select(PAGE_NAME_REF + "BackupDateList", "label="+getText("//option[@value='"+optionIndex+"']"));
		else
			Asserter.fail("Unable to find backup date with the optionindex provided.");
    }
	
	/**
	 * return the selected backup date 
	 * 
	 * @return
	 */
	public String getSelectedBackupdate(){
		return getSelectedLabel(PAGE_NAME_REF + "BackupDateList");
	}

	/**
	 * Return all the backup dates in list
	 * 
	 * @return
	 */
	public ArrayList<String> getAllBackupdates(){
		String[] list = getSelectOptions(PAGE_NAME_REF + "BackupDateList");
		ArrayList<String> bdList =new ArrayList<String>();
		for (int i = 0; i < list.length; i++) {
			bdList.add(list[i].trim());
		}
		return bdList;
	}
	/**
	 * Check the Hide incomplete backup dates checkbox
	 */
	public void checkHideIncompleteBackupDatesCheckbox(){
		check(PAGE_NAME_REF + "HideIncompleteBackupDatesCheckbox");
		waitForSeconds(5);		
	}
	/**
	 * un-Check the Hide incomplete backup dates checkbox
	 */
	public void unCheckHideIncompleteBackupDatesCheckbox(){
		unCheck(PAGE_NAME_REF + "HideIncompleteBackupDatesCheckbox");
		waitForSeconds(5);		
	}
	
	/**
	 * Click on the next button, will take to order page2 
	 */
	public OrderCdOrDvdForm2Page clickOnNextButton(){
		clickAndWaitForPageLoad(PAGE_NAME_REF + "NextButton");
		return (OrderCdOrDvdForm2Page) PageFactory.getNewPage(OrderCdOrDvdForm2Page.class);
	}
	/**
	 * Click on the cancel button and go back to SummaryPage
	 */
	public SummaryPage clickOnCancelButton(){
		clickAndWaitForPageLoad(PAGE_NAME_REF + "CancelButton");
		return (SummaryPage) PageFactory.getNewPage(SummaryPage.class);
	}
	
	public boolean isBackupDatesPresent(){
		return !isTextPresent(PAGE_NAME_REF + "NoBackupDateText", 10);
	}
	
	
}
