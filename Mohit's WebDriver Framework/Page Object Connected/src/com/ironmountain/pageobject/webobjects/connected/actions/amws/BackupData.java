package com.ironmountain.pageobject.webobjects.connected.actions.amws;

import com.ironmountain.pageobject.webobjects.connected.actions.testrunner.agent.BackupRunner;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.OrderCdOrDvdForm1Page;

public class BackupData {
	
	public static void installAgentAndBackupData(String backupRunnerFile, String Email, String Password) throws Exception{
		Reinstallagent.reinstallAgent(Email, Password);
		BackupRunner.runBackup(backupRunnerFile);
	}	
	
	public static void backupDataIfNoBackupDatePresent(int noOfBackups) throws Exception{
		OrderCdOrDvdForm1Page orderCdorDvdForm1Page = AccountManagementNavigation.viewOrderCdOrDvdsPage();
		if(! orderCdorDvdForm1Page.isBackupDatesPresent()){
			BackupRunner.runBackup(noOfBackups);
		}
	}
	public static void reinstallAgentAndBackupDataIfNoBackupDatePresent(int noOfBackups, String Email, String Password) throws Exception{
		OrderCdOrDvdForm1Page orderCdorDvdForm1Page = AccountManagementNavigation.viewOrderCdOrDvdsPage();
		if(! orderCdorDvdForm1Page.isBackupDatesPresent()){
			Reinstallagent.reinstallAgent(Email, Password);
			BackupRunner.runBackup(noOfBackups);
		}
	}
	/**
	 * This method will always re-install the agent, then does the backup if no backups present.
	 * 
	 * @param backupRunnerFile
	 * @param Email
	 * @param Password
	 * @throws Exception
	 */
	public static void reinstallAgentAndBackupDataIfNoBackupDatePresent(String backupRunnerFile, String Email, String Password) throws Exception{
		OrderCdOrDvdForm1Page orderCdorDvdForm1Page = AccountManagementNavigation.viewOrderCdOrDvdsPage();
		Reinstallagent.reinstallAgent(Email, Password);
		if(! orderCdorDvdForm1Page.isBackupDatesPresent()){
			BackupRunner.runBackup(backupRunnerFile);
		}
	}
	
}
