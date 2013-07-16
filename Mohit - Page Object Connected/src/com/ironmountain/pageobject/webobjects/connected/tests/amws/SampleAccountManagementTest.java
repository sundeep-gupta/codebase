package com.ironmountain.pageobject.webobjects.connected.tests.amws;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.webobjects.connected.actions.testrunner.ActionRunner;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

/**
 * @author Jinesh Devasia
 *
 */

@SeleniumUITest
public class SampleAccountManagementTest extends AccountManagementTest {

	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
	}
	
	@Test(groups={"samples"})
	public void runAccountManagementLoginTests() throws Exception
	{
		System.out.println("Executing the test!!!!");
		ActionRunner.run("RemoteRename.xml");
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		super.stopSeleniumTest();
	}
	
}

