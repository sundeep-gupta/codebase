package com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.accounts;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.webobjects.connected.navigations.supportcenter.SupportCenterNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.SupportCenterHomePage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.accounts.AccountSearchPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.accounts.AccountSummaryPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.accounts.ChangeAccountStatusPage;

public class Account {

	public static AccountSummaryPage cancelAccount(String communityId, String accountNo, String justificationMessage) throws Exception{
		SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		AccountSearchPage accountSearchPage = SupportCenterNavigation.viewAccountSearchPage(communityId);			
		supportCenterHomePage.selectAppBodyNodeViewNodeDetailsFrame();
		accountSearchPage.typeSearchForText(accountNo);
		AccountSummaryPage summaryPage = accountSearchPage.clickOnSearchButton();
		ChangeAccountStatusPage  statusPage =summaryPage.clickOnAccountStatusLink();
		statusPage.checkCanceledRadioButton();
		statusPage.typeJustificationMessage(justificationMessage);
		return statusPage.clickOnChangeStatusNowButton();
	}
	public static AccountSummaryPage activateAccount(String communityId, String accountNo, String justificationMessage) throws Exception{
		SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		AccountSearchPage accountSearchPage = SupportCenterNavigation.viewAccountSearchPage(communityId);			
		supportCenterHomePage.selectAppBodyNodeViewNodeDetailsFrame();
		accountSearchPage.typeSearchForText(accountNo);
		AccountSummaryPage summaryPage = accountSearchPage.clickOnSearchButton();
		ChangeAccountStatusPage  statusPage =summaryPage.clickOnAccountStatusLink();
		statusPage.checkActiveRadioButton();
		statusPage.typeJustificationMessage(justificationMessage);
		return statusPage.clickOnChangeStatusNowButton();
	}
	
}
