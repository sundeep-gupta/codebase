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

@SeleniumUITest(HPQCID="5899")
public class SortByDateModifiedTest extends AccountManagementTest {

	
	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
	}
	
	@Parameters({"emailid", "password", "backedupDrive", "backedupFolder", "commonTestData", "ascendingOrderListByModifiedDate"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testSortByDateModified(String emailid, String password, String backedupDrive, String backedupFolder, String commonTestData, String ascendingOrderListByModifiedDate) throws Exception
	{
		AccountManagementLogin.login(emailid, password);
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		myRoamPage.clickOnBackedupFolderExpandCollapseButtonByName(backedupDrive);
		myRoamPage.clickOnBackedupFolderNode(backedupFolder);
		myRoamPage.clickOnBackedupFolderExpandCollapseButtonByName(backedupFolder);
		myRoamPage.clickOnBackedupFolderNode(commonTestData);
		Asserter.assertTrue(myRoamPage.isSortedByAscendingOrder("name"), "Not sorted by Ascending bydefault");
		myRoamPage.clickOnDateModifiedColumn();
		Asserter.assertTrue(myRoamPage.isSortedByDecendingOrder("date"), "Not sorted by Decending order by Modifid Date");
		String[] list = ListUtils.getStringListAsArray(myRoamPage.getAllBackedupItemsFromRightPane());
		String[] ascendingOrderListByMDate = ListUtils.getStringListAsArray(StringUtils.toStringArrayList(ascendingOrderListByModifiedDate));
		for (int i = 0; i < ascendingOrderListByMDate.length; i++) {
			Asserter.assertTrue(list[i].equalsIgnoreCase(ascendingOrderListByMDate[i]), "The sorted data is not matching, expected: " + ascendingOrderListByMDate[i] + " But was: " + list[i]);
		}
		myRoamPage.clickOnDateModifiedColumn();
		Asserter.assertTrue(myRoamPage.isSortedByAscendingOrder("date"), "Not sorted by Ascending order by Modifid Date");
		for (int i = (list.length)-1; i < 0; i--) {
			Asserter.assertTrue(list[i].equalsIgnoreCase(ascendingOrderListByMDate[i]));
		}	
		myRoamPage.clickOnBackedupFolderNode(backedupDrive);
		Asserter.assertTrue(myRoamPage.isSortedByAscendingOrder("date"), "Not sorted by Decending");
		myRoamPage.clickOnBackedupFolderNode(backedupFolder);
		Asserter.assertTrue(myRoamPage.isSortedByAscendingOrder("date"), "Not sorted by Decending");
		summaryPage = myRoamPage.clickOnBackToSummary();
		myRoamPage = summaryPage.clickOnRetrieveFilesWithMyRoam();
		Asserter.assertTrue(myRoamPage.isSortedByAscendingOrder("name"), "Not sorted by Name Ascending bydefault");
		AccountManagementLogin.logout();
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		super.stopSeleniumTest();
	}
	
}
