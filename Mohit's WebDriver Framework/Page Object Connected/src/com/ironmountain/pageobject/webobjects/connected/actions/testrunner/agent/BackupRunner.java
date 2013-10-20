package com.ironmountain.pageobject.webobjects.connected.actions.testrunner.agent;

import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.utils.DateUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.webobjects.connected.actions.testrunner.ActionRunner;

public class BackupRunner extends ActionRunner{

	private static String backupXmlPath = FileUtils.getBaseDirectory() + "\\" + PropertyPool.getProperty("testrunnerfilepath");
	
	
	public static void runBackup(String actionXml){
		run(actionXml);
	}
	public static void runBackup(){
		 runBackup("backup.xml");
	}
	public static void runBackup(int noOfBackups){
	
		for(int i=0; i<= noOfBackups; i++){			
			runBackup();
		}
	}
	/**
	 * This method will run backups and return a list of backup dates separated by the separator provided
	 * 
	 * @param backupXmlPath
	 * @param noOfBackups
	 * @return
	 */
	public static String runBackup(String backupXmlPath,int noOfBackups, String backupDateSeparator){
		String backupDates = "";
		for(int i=0; i<= noOfBackups; i++){			
			runBackup(backupXmlPath);
			backupDates = backupDates + DateUtils.getBackupDateFormat()+ " (complete)" + backupDateSeparator;
		}
		return backupDates;
	}
	
	
}
