package com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam;

import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest(priority=20, HPQCID="5956")
public class WildCardsInNameContainsFieldTest extends AccountManagementTest {

	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
	}
	
	@Parameters({"emailid", "password", "allSearchText", "searchFile1", "searchFile2", "singleSearchText", "singleFile"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testWildCardsInNameContainsField(String emailid, String password, String allSearchText, String searchFile1, String searchFile2, String singleSearchText, String singleFile) throws Exception
	{
		AccountManagementLogin.login(emailid, password);
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		myRoamPage.clickOnFindBtn();
		myRoamPage.enterSearchText("*" + allSearchText + "*");			
		myRoamPage.clickOnFindNextBtn();
		Asserter.assertTrue(myRoamPage.isBackedupFolderInRightPaneSelected(searchFile1), "Folder/File Not Selected");
		myRoamPage.clickOnFindNextBtn();
		Asserter.assertTrue(myRoamPage.isBackedupFolderInRightPaneSelected(searchFile2), "Folder/File Not Selected");
		myRoamPage.enterSearchText( "?" + singleSearchText);
		myRoamPage.clickOnFindNextBtn();
		Asserter.assertTrue(myRoamPage.isBackedupFolderInRightPaneSelected(singleFile), "Folder/File Not Selected");
		Assert.assertEquals(myRoamPage.getErrorMessagesInRed(),"Finished searching for file or folder");
		AccountManagementLogin.logout();
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		super.stopSeleniumTest();
	}
	
	
}
