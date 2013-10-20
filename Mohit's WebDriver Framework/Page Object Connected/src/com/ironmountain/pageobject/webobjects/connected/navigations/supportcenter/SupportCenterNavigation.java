package com.ironmountain.pageobject.webobjects.connected.navigations.supportcenter;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.PCAgentConfigCreatePage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.PCAgentConfigSummaryPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.ProfileAndWebSiteSettingsPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.SupportCenterHomePage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.SupportCenterLoginPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.TechniciansPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.accounts.AccountSearchPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.pcagentrulesets.PCAgentCreateRuleSetGeneralPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.tools.ApplyBrandingPage;

public class SupportCenterNavigation {
	
	public static SupportCenterHomePage viewDefaultCommunityPage() throws Exception
	{
		SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		return (SupportCenterHomePage) supportCenterHomePage.clickOnDefaultCommunityNode();
	}
	
	public static PCAgentConfigSummaryPage viewPCAgentSettingsinDefaultCommunityPage() throws Exception
	{
		SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		return (PCAgentConfigSummaryPage) supportCenterHomePage.clickOnNewPCAgentSettingsinDefaultComm();
	}
	
	public static PCAgentConfigSummaryPage viewPCinDefaultCommunityPage() throws Exception
	{
		SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		return (PCAgentConfigSummaryPage) supportCenterHomePage.clickOnPCinDefaultComm();
	}
	public static PCAgentConfigCreatePage viewDefaultPCConfigurationCreatePage() throws Exception
	{
		SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		return (PCAgentConfigCreatePage) supportCenterHomePage.clickOnNewDefaultConfigCreate();
	}
	
	public static PCAgentConfigCreatePage viewCustomPCConfigurationCreatePage(String CommunityID) throws Exception
	{
		SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		return (PCAgentConfigCreatePage) supportCenterHomePage.clickOnNewPCConfigCreateNode(CommunityID);
	}
	public static PCAgentConfigCreatePage viewCustomMACConfigurationCreatePage(String CommunityID) throws Exception
	{
		SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		return (PCAgentConfigCreatePage) supportCenterHomePage.clickOnNewMacConfigCreateNode(CommunityID);
	}
	public static SupportCenterHomePage viewCustomConfigurationPage(String CommunityID) throws Exception
	{
		SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		return (SupportCenterHomePage) supportCenterHomePage.clickOnCreatedConfigNode(CommunityID);
	}
	/**
	 * This navigation method helps to go to the configuration page which is already created.
	 * 
	 * @param communityId
	 * @param configId
	 * @return
	 * @throws Exception
	 */
	public static PCAgentConfigCreatePage viewPCAgentConfigurationPage(String communityId, String configId) throws Exception
	{
		SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		return (PCAgentConfigCreatePage) supportCenterHomePage.clickOnPCAgentConfigurationName(communityId, configId);
	}
	public static PCAgentConfigSummaryPage viewCustomPCConfigurationPage(String CommunityID) throws Exception
	{
		SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		return (PCAgentConfigSummaryPage) supportCenterHomePage.clickOnPCNode(CommunityID);
	}
	public static SupportCenterHomePage viewCustomCommunityPage(String CommunityID) throws Exception
	{
		SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		return (SupportCenterHomePage) supportCenterHomePage.clickOnLatestCommunityNode(CommunityID);
	}
	public static ProfileAndWebSiteSettingsPage viewCustomProfileAndWebSiteSettingsPage(String CommunityID) throws Exception
	{
		SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		return (ProfileAndWebSiteSettingsPage) supportCenterHomePage.clickOnProfileAndWebSiteSettingsnode(CommunityID);
	}
	public static ProfileAndWebSiteSettingsPage viewDefaultProfileAndWebSiteSettingsConfigPage() throws Exception
	{
		SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		return (ProfileAndWebSiteSettingsPage) supportCenterHomePage.clickOnDefaultProfileAndWebSiteSettingsConfignode();
	}
	public static ProfileAndWebSiteSettingsPage viewDefaultProfileAndWebSiteSettingsConfigPage(String CommunityID) throws Exception
	{
		SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		return (ProfileAndWebSiteSettingsPage) supportCenterHomePage.clickOnDefaultProfileAndWebSiteSettingsConfignode(CommunityID);
	}
	public static ProfileAndWebSiteSettingsPage viewCustomProfileAndWebSiteSettingsConfigPage(String CommunityID) throws Exception
	{
		SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		return (ProfileAndWebSiteSettingsPage) supportCenterHomePage.clickOnCustomProfileAndWebSiteSettingsConfignode(CommunityID);
	}
	public static SupportCenterHomePage viewCustomAgentVersionsPage(String CommunityID) throws Exception
	{
		SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		return (SupportCenterHomePage) supportCenterHomePage.clickOnAgentVersionsNode(CommunityID);
	}
	public static SupportCenterHomePage viewCustomAgentSettingsPage(String CommunityID) throws Exception
	{
		SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		return (SupportCenterHomePage) supportCenterHomePage.clickOnAgentSettingsNode(CommunityID);
	}
	public static SupportCenterHomePage viewSubCommParentCommunityPage() throws Exception
	{
		SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		return (SupportCenterHomePage) supportCenterHomePage.clickOnSubCommunityParentNode();
	}
	
	public static ApplyBrandingPage viewApplyBrandingPage() throws Exception
	{
		SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		return (ApplyBrandingPage) supportCenterHomePage.clickOnApplyBrandingMenuItem();
	}
	public static PCAgentCreateRuleSetGeneralPage viewPCAgentCreateRuleSetsPage(String communityId) throws Exception
	{
		SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		return (PCAgentCreateRuleSetGeneralPage) supportCenterHomePage.clickOnPCAgentRuleSetsNode(communityId);
	}
	public static TechniciansPage viewTechniciansPage(String communityId) throws Exception
	{
		SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		return (TechniciansPage) supportCenterHomePage.clickOnTechniciansNode(communityId);
	}
	
	public static PCAgentConfigCreatePage viewDefaultPCOnlyConfigPage() throws Exception
	{
		SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		return (PCAgentConfigCreatePage) supportCenterHomePage.clickOnDefaultPCOnlyConfigNode();
	}
	public static PCAgentCreateRuleSetGeneralPage viewPCAgentRuleSettingsPage(String communityId) throws Exception
	{
		SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		return supportCenterHomePage.clickOnPCAgentRuleSetsNode(communityId);
	}
	public static AccountSearchPage viewAccountSearchPage(String communityId) throws Exception
	{
		SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		return supportCenterHomePage.clickOnAccountsNode(communityId);
	}
	public static SupportCenterLoginPage viewBrandedSupportCenterPage(String url) throws Exception
	{
		SupportCenterLoginPage supportCenterLoginPage = (SupportCenterLoginPage) PageFactory.getNewPage(SupportCenterLoginPage.class);
		return supportCenterLoginPage.openBrandURL(url);
	}

}
