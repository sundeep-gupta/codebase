package com.ironmountain.pageobject.webobjects.connected.tools.cleanup;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.webobjects.connected.actions.InstallUtils;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

/** This test uninstalls the Agent after the tests are run.
 * @author pjames
 *
 */
@SeleniumUITest
public class AgentCleanUpTest extends AccountManagementTest { 
	@BeforeMethod (alwaysRun=true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
	}
	
	@Parameters( {"email", "password"})
	@Test(enabled = true, groups= {"amws","mat", "CleanUp"})
	public void testAgentCleanUp()throws Exception{
		InstallUtils.cleanupAgent("AgentSetupFile");
	}
	
	@AfterMethod(alwaysRun=true)
	public void stopTest() throws Exception{
		super.stopSeleniumTest();
	}
}
