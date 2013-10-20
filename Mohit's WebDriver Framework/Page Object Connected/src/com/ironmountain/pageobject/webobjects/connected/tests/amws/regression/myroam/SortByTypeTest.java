package com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam;

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

@SeleniumUITest(HPQCID="17568")
public class SortByTypeTest extends AccountManagementTest {

	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
	}
	
	@Parameters({"emailid", "password", "backedupDrive","backedupFolder","commonTestData","ascendingOrderListByType"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testSortByTypeInMyRoamPage(String emailid, String password, String backedupDrive, String backedupFolder, String commonTestData, String ascendingOrderListByType) throws Exception
	{
		AccountManagementLogin.login(emailid, password);
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		myRoamPage.clickOnBackedupFolderExpandCollapseButtonByName(backedupDrive);
		myRoamPage.clickOnBackedupFolderNode(backedupFolder);
		myRoamPage.clickOnBackedupFolderExpandCollapseButtonByName(backedupFolder);
		myRoamPage.clickOnBackedupFolderNode(commonTestData);
		Asserter.assertTrue(myRoamPage.isSortedByAscendingOrder("name"), "Not sorted by Ascending bydefault");
		myRoamPage.clickOnTypeColumn();
		Asserter.assertTrue(myRoamPage.isSortedByDecendingOrder("type"), "Not sorted by Decending order by Type");
		String[] list = ListUtils.getStringListAsArray(myRoamPage.getAllBackedupItemsFromRightPane());
		String[] ascendingOrderList = ListUtils.getStringListAsArray(StringUtils.toStringArrayList(ascendingOrderListByType));
		for (int i = 0; i < list.length; i++) {
			Asserter.assertTrue(list[i].equalsIgnoreCase(ascendingOrderList [i]), "The sorted data by Type is not matching, expected: " + ascendingOrderList[i] + " But was: " + list[i]);
		}
		myRoamPage.clickOnTypeColumn();
		Asserter.assertTrue(myRoamPage.isSortedByAscendingOrder("type"), "Not sorted by Ascending order by Type");
		for (int i = (list.length)-1; i < 0; i--) {
			Asserter.assertTrue(list[i].equalsIgnoreCase(ascendingOrderList[i]));
		}	
		myRoamPage.clickOnBackedupFolderNode(backedupDrive);
		Asserter.assertTrue(myRoamPage.isSortedByAscendingOrder("type"), "Not sorted by Type Decending");
		myRoamPage.clickOnBackedupFolderNode(backedupFolder);
		Asserter.assertTrue(myRoamPage.isSortedByAscendingOrder("type"), "Not sorted by Type Decending");
		summaryPage = myRoamPage.clickOnBackToSummary();
		myRoamPage = summaryPage.clickOnRetrieveFilesWithMyRoam();
		Asserter.assertTrue(myRoamPage.isSortedByAscendingOrder("name"), "Not sorted by name Ascending bydefault");
		AccountManagementLogin.logout();
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		super.stopSeleniumTest();
	}
	
}
