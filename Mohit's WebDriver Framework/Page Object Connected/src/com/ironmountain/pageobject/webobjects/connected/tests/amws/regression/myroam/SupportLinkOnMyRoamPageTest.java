package com.ironmountain.pageobject.webobjects.connected.tests.amws.regression.myroam;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;
import com.ironmountain.pageobject.webobjects.connected.navigations.amws.AccountManagementNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.amws.ContactSupportPage;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;

@SeleniumUITest(HPQCID="6001")
public class SupportLinkOnMyRoamPageTest extends AccountManagementTest {

	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		super.initAccountManagementTest();
	}
	
	@Parameters({"emailid", "password"})
	@Test(groups={"amws", "regression", "myroam"})
	public void testSupportLinkOnMyRoamPage(String emailid, String password) throws Exception
	{
		AccountManagementLogin.login(emailid, password);
		myRoamPage = AccountManagementNavigation.viewMyRoamPage();
		ContactSupportPage cp = myRoamPage.clickOnSupportLink();
		Asserter.assertTrue(cp.getTitle().contains( "Contact Support"));
		Asserter.assertTrue(cp.getText("//body[@id='tinymce']/ul/li[1]").contains( "support@automation.com,"));
		Asserter.assertTrue(cp.getText("//body[@id='tinymce']/ul/li[2]").contains("100-200-3000"));
		Asserter.assertTrue(cp.getText("//body[@id='tinymce']/p[2]").contains("Technical Support representatives are available to help you Monday through Friday"));
		cp.closeWindow();
		AccountManagementLogin.logout();
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		super.stopSeleniumTest();
	}
	
}
