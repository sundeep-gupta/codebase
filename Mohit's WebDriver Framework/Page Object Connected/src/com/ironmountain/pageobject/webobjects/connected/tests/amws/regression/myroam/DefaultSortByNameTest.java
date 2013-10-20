package com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam;

import org.apache.log4j.Logger;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.utils.ListUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest(HPQCID="5897")
public class DefaultSortByNameTest extends AccountManagementTest {

	private static Logger  logger      = Logger.getLogger("com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam.DefaultSortByNameTest");
	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		logger.info("Startign test..initializing");
		super.initAccountManagementTest();
		logger.info("Test initialization completed");
	}
	
	@Parameters({"emailid", "password", "backedupDrive", "backedupFolder","commonTestData", "ascendingOrderList"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testDefaultSortByName(String emailid, String password, String backedupDrive, String backedupFolder, String commonTestData, String ascendingOrderList) throws Exception
	{
		logger.info("Actul test method called...Trying to login with emial '" + emailid + "' Password '" + password + "'");
		String[] ascendingOrderListArray = ListUtils.getStringListAsArray(StringUtils.toStringArrayList(ascendingOrderList));
		AccountManagementLogin.login(emailid, password);
		logger.info("Navigating to myroam page..");
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		logger.info("Expanding backup drive.." + backedupDrive);
		myRoamPage.clickOnBackedupFolderExpandCollapseButtonByName(backedupDrive);
		logger.info("expanding backedup fiolder.." + backedupFolder);
		myRoamPage.clickOnBackedupFolderExpandCollapseButtonByName(backedupFolder);
		logger.info("clicking on foldr.." +commonTestData);
		myRoamPage.clickOnBackedupFolderNode(commonTestData);
		logger.info("verifying soreted by Ascending bydefault");
		Asserter.assertTrue(myRoamPage.isSortedByAscendingOrder("name"), "Not soreted by Ascending bydefault");
		logger.info("Getting al the items from right pane..");
		String[] list = ListUtils.getStringListAsArray(myRoamPage.getAllBackedupItemsFromRightPane());
		logger.info("Verifying the sorted order...");
		for (int i = 0; i < list.length; i++) {
			Asserter.assertTrue(list[i].equalsIgnoreCase(ascendingOrderListArray[i]), "Data Compared is: " + list[i] + " and " + ascendingOrderListArray[i]);
		}
		logger.info("Clicking in on name column.,.");
		myRoamPage.clickOnNameColumn();
		logger.info("verifying soreted by decending ");
		Asserter.assertTrue(myRoamPage.isSortedByDecendingOrder("name"), "Not soreted by Decending");
		logger.info("Verifying the sorted order...");
		for (int i = (list.length)-1; i < 0; i--) {
			Asserter.assertTrue(list[i].equalsIgnoreCase(ascendingOrderListArray[i]), "Data Compared is: " + list[i] + " and " + ascendingOrderListArray[i]);
		}
		logger.info("Clicking on backedup drive.." + backedupDrive);
		myRoamPage.clickOnBackedupFolderNode(backedupDrive);
		logger.info("Verifying the sorted order remains same...Decending");
		Asserter.assertTrue(myRoamPage.isSortedByDecendingOrder("name"), "Not soreted by Decending");
		logger.info("Clicking on backup node.." + backedupFolder);
		myRoamPage.clickOnBackedupFolderNode(backedupFolder);
		logger.info("Verifying the sorted order remains same...decending");
		Asserter.assertTrue(myRoamPage.isSortedByDecendingOrder("name"), "Not soreted by Decending");
		logger.info("Clicking on on date modified colum header");
		myRoamPage.clickOnDateModifiedColumn();
		logger.info("Verifing soreted by Ascending order by Modifid Date ");
		Asserter.assertTrue(myRoamPage.isSortedByDecendingOrder("date"), "Not soreted by Ascending order by Modifid Date");
		logger.info("Clicking on back to summary link...");
		summaryPage = myRoamPage.clickOnBackToSummary();
		logger.info("From summary clicking myroam link");
		myRoamPage = summaryPage.clickOnRetrieveFilesWithMyRoam();
		logger.info("Verifying soreted by Ascending name order by default");
		Asserter.assertTrue(myRoamPage.isSortedByAscendingOrder("name"), "Not soreted by Ascending bydefault");
		AccountManagementLogin.logout();
		logger.info("Test Completed...succesfully..");
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		logger.info("Stopping session...");
		super.stopSeleniumTest();
		logger.info("Session ended...");
	}
	
}
