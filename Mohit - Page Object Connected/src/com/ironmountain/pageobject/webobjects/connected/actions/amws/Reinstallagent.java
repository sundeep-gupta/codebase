package com.ironmountain.pageobject.webobjects.connected.actions.amws;

import com.ironmountain.pageobject.pageobjectrunner.utils.DownloadUtils;
import com.ironmountain.pageobject.webobjects.connected.actions.InstallUtils;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.ReinstallAgentPage;

public class Reinstallagent {

	public static void reinstallAgent(String Email, String Password) throws Exception{
		ReinstallAgentPage reinstallAgentPage = AccountManagementNavigation.viewReinstallAgentPage();
		reinstallAgentPage.waitForSeconds(5);
		reinstallAgentPage.clickOnDownloadSoftwareButton();
		reinstallAgentPage.clickOnBeginDownloadButton();
		DownloadUtils.handleDownloadDialog("File Download - Security Warning","AgentSetupFile");
		reinstallAgentPage.waitForSeconds(75);
		InstallUtils.installAgent("AgentSetupFile",Email, Password);	
	}
	
	
}
