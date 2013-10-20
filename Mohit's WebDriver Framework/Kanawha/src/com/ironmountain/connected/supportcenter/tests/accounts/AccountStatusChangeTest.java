package com.ironmountain.connected.supportcenter.tests.accounts;

import org.apache.log4j.Logger;
import org.openqa.selenium.support.PageFactory;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.connected.supportcenter.pages.AccountStatusPage;
import com.ironmountain.connected.supportcenter.pages.AccountSummaryPage;
import com.ironmountain.connected.supportcenter.pages.SCHomePage;
import com.ironmountain.connected.supportcenter.pages.SCLoginPage;
import com.ironmountain.connected.supportcenter.tests.SupportCenter8xTest;
import com.ironmountain.kanawha.commons.CommonUtils;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CommunityTable;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CustomerTable;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;

public class AccountStatusChangeTest extends SupportCenter8xTest{
	
	private static final Logger logger = Logger.getLogger(AccountStatusChangeTest.class.getName());
	CustomerTable customer = new CustomerTable(DatabaseServer.COMMON_SERVER);
	CommunityTable community = new CommunityTable(DatabaseServer.COMMON_SERVER);
	
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		logger.info("Started Account Status Change Tests\nOpening Support Center ...");
		super.initSupportCenter8xTest("firefox");
	}

	/**
	 * Tests to cancel an account
	 * 
	 * @param Username
	 * @param Password
	 * @throws Exception
	 */
	
	@Test(enabled = true)
	public void cancelAccount(String username, String password) throws Exception {
		String acStatus = customer.getAccountStatus(CommonUtils.getAccountNumber(username));
		logger.info("Account Status: " + acStatus);
		if(acStatus.equals("C")) {
			logger.info("Account already cancelled");
			return;
		}
		editAccountStatus(username,"Canceled");
		/*SCHomePage homePage = SCLoginPage.login(PropertyPool.getProperty("scadmin"), PropertyPool.getProperty("scpassword"));
		//homePage.goTo("http://10.145.12.133/supportcenter/detail.asp?type=4&value=101000892&community=3&menuchoice=109");
		homePage.goTo(PropertyPool.getProperty("scprotocol")+"://"+PropertyPool.getProperty("schost")+"/supportcenter/detail.asp?type=4&value="+CommonUtils.getAccountNumber(username)+"&community="+community.getCommunityIDbyCommunityName(PropertyPool.getProperty("kanawhawebappcommunity"))+"&menuchoice=109");
		Thread.sleep(3000);
		AccountStatusPage acStatusPage = (AccountStatusPage) PageFactory.initElements(getDriver(), AccountStatusPage.class);
		//acStatusPage.switchToFrame("AppBody.NodeView.NodeDetails");
		acStatusPage.switchToFrame("AppBody");
		acStatusPage.switchToFrame("NodeView");
		acStatusPage.switchToFrame("NodeDetails");
		AccountSummaryPage acSummaryPage = acStatusPage.changeAccountStatus("cancel", "This account is cancelled.");
		acSummaryPage.switchToFrame("AppBody.NodeView.NodeDetails");
		Assert.assertEquals(acSummaryPage.getAccountStatus(), "Canceled", "Could not cancel account");*/
	}
	
	
	@Test(enabled = true)
	public void putAccountOnHold(String username, String password) throws Exception {
		
		String acStatus = customer.getAccountStatus(CommonUtils.getAccountNumber(username));
		logger.info("Account Status: " + acStatus);
		if(acStatus.equals("H")) {
			logger.info("Account already On Hold");
			return;
		}
		editAccountStatus(username,"On Hold");
		/*SCHomePage homePage = SCLoginPage.login(PropertyPool.getProperty("scadmin"), PropertyPool.getProperty("scpassword"));
		homePage.goTo(PropertyPool.getProperty("scprotocol")+"://"+PropertyPool.getProperty("schost")+"/supportcenter/detail.asp?type=4&value="+CommonUtils.getAccountNumber(username)+"&community="+community.getCommunityIDbyCommunityName(PropertyPool.getProperty("kanawhawebappcommunity"))+"&menuchoice=109");
		Thread.sleep(3000);
		AccountStatusPage acStatusPage = (AccountStatusPage) PageFactory.initElements(getDriver(), AccountStatusPage.class);
		acStatusPage.switchToFrame("AppBody.NodeView.NodeDetails");
		AccountSummaryPage acSummaryPage = acStatusPage.changeAccountStatus("hold", "This account is put on hold.");
		acSummaryPage.switchToFrame("AppBody.NodeView.NodeDetails");
		Assert.assertEquals(acSummaryPage.getAccountStatus(), "On Hold", "Could not put account on hold");*/
	}
	
	@Test(enabled = true)
	public void activateAccount(String username, String password) throws Exception {
		
		String acStatus = customer.getAccountStatus(CommonUtils.getAccountNumber(username));
		logger.info("Account Status: " + acStatus);
		if(acStatus.equals("A")) {
			logger.info("Account already active");
			return;
		}
		editAccountStatus(username,"Active");
		/*SCHomePage homePage = SCLoginPage.login(PropertyPool.getProperty("scadmin"), PropertyPool.getProperty("scpassword"));
		homePage.goTo(PropertyPool.getProperty("scprotocol")+"://"+PropertyPool.getProperty("schost")+"/supportcenter/detail.asp?type=4&value="+CommonUtils.getAccountNumber(username)+"&community="+community.getCommunityIDbyCommunityName(PropertyPool.getProperty("kanawhawebappcommunity"))+"&menuchoice=109");
		Thread.sleep(3000);
		AccountStatusPage acStatusPage = (AccountStatusPage) PageFactory.initElements(getDriver(), AccountStatusPage.class);
		acStatusPage.switchToFrame("AppBody.NodeView.NodeDetails");
		AccountSummaryPage acSummaryPage = acStatusPage.changeAccountStatus("active", "This account is activated.");
		acSummaryPage.switchToFrame("AppBody.NodeView.NodeDetails");
		Assert.assertEquals(acSummaryPage.getAccountStatus(), "Active", "Could not activate account");*/
	}

	private void editAccountStatus(String username,String status) throws Exception {
		SCHomePage homePage = SCLoginPage.login(PropertyPool.getProperty("scadmin"), PropertyPool.getProperty("scpassword"));
		homePage.waitForElementPresent("frame[name='AppBody']", 1, 20);
		
		logger.info("Opening "+PropertyPool.getProperty("scprotocol")+"://"+PropertyPool.getProperty("schost")+"/supportcenter/detail.asp?type=4&value="+CommonUtils.getAccountNumber(username)+"&community="+community.getCommunityIDbyCommunityName(PropertyPool.getProperty("kanawhawebappcommunity"))+"&menuchoice=109");
		homePage.goTo(PropertyPool.getProperty("scprotocol")+"://"+PropertyPool.getProperty("schost")+"/supportcenter/detail.asp?type=4&value="+CommonUtils.getAccountNumber(username)+"&community="+community.getCommunityIDbyCommunityName(PropertyPool.getProperty("kanawhawebappcommunity"))+"&menuchoice=109");
		Thread.sleep(5000);
		AccountStatusPage acStatusPage = (AccountStatusPage) PageFactory.initElements(getDriver(), AccountStatusPage.class);
		acStatusPage.waitForElementPresent("AppBody", 1, 5);
		acStatusPage.switchToFrame("AppBody");
		acStatusPage.switchToFrame("NodeView");
		acStatusPage.switchToFrame("NodeDetails");
		AccountSummaryPage acSummaryPage = acStatusPage.changeAccountStatus(status, "Account Status is now set to "+status);
		/*acStatusPage.switchToFrame("AppBody");
		acStatusPage.switchToFrame("NodeView");
		acStatusPage.switchToFrame("NodeDetails");*/
		Assert.assertEquals(acSummaryPage.getAccountStatus(), status, "Could not set account status to "+status);
		logger.info("Account Status is now set to " + status);
	}
	
	@AfterMethod(alwaysRun= true)
	public void stopTest() throws Exception {
		logger.info("Completed Account Status Change Tests\nClosing Support Center ...");
		super.stopWebDriverTest();
	}

}
