package com.ironmountain.pageobject.webobjects.connected.pages.amws;


import com.thoughtworks.selenium.Selenium;

public class AccountHistoryPage extends AccountManagementHomePage {

	private static final String PAGE_NAME_REF = "ViewHistoryPage.";

	public AccountHistoryPage(Selenium sel) {
		selenium = sel;
	}
	
	/**
	 * To get the account number form history page
	 * 
	 * @return {@link String}
	 */
	public String getAccountNumber(){
		return getText(PAGE_NAME_REF + "AccountNumber");
	}
	/**
	 * To get the Computer Name from history page
	 * 
	 * @return String
	 */
	public String getComputerName(){
		return getText(PAGE_NAME_REF + "ComputerName");
	}
	/**
	 * To get the Account Activation date from History Page
	 * 
	 * @return String
	 */
	public String getAccountActivationDate(){
		return getText(PAGE_NAME_REF + "AccountActivationDate");
	}
	/**
	 * To get the Service Plan storage Limit
	 * 
	 * @return String
	 */
	public String getServicePlanStorageLimit(){
		return getText(PAGE_NAME_REF + "ServicePlanStorageLimit");
	}
	public String getLastBackupDateCompleted(){
		return getText(PAGE_NAME_REF + "LastBackupDateCompleted");
	}
	public String getTotalBackupsLast30Days(){
		return getText(PAGE_NAME_REF + "TotalBackupsLast30Days");
	}
	public String getTotalNumberOfFilesProtected(){
		return getText(PAGE_NAME_REF + "TotalNumberOfFilesProtected");
	}
	public String getTotalStorageSize(){
		return getText(PAGE_NAME_REF + "TotalStorageSize");
	}
	public String getLastMyRoamRetrievalDateCompleted(){
		return getText(PAGE_NAME_REF + "LastMyRoamRetrievalDateCompleted");
	}
	public String getNumberOfFilesRetrieved(){
		return getText(PAGE_NAME_REF + "NumberOfFilesRetrieved");
	}
	public String getTotalAmountOfDataRestored(){
		return getText(PAGE_NAME_REF + "TotalAmountOfDataRestored");
	}
	public String getLastCDsAndDVDsOrderDateCompleted(){
		return getText(PAGE_NAME_REF + "LastCDsAndDVDsOrderDateCompleted");
	}	
	public String getLastCDsAndDVDsOrderBackupSetsize(){
		return getText(PAGE_NAME_REF + "LastCDsAndDVDsOrderBackupSetsize");
	}
	public String getNumberOfMediaShipped(){
		return getText(PAGE_NAME_REF + "NumberOfMediaShipped");
	}
}
