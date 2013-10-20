package com.ironmountain.pageobject.webobjects.connected.tests;

import java.io.File;

import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.AddCommunityPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.AddLDAPConfigPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.PCAgentConfigCreatePage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.PCAgentConfigSummaryPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.ProfileAndWebSiteSettingsPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.SupportCenterHomePage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.SupportCenterLoginPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.TechniciansPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.pcagentrulesets.PCAgentCreateRuleSetGeneralPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.pcagentrulesets.PCAgentCreateRuleSetRulesPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.pcagentrulesets.PCAgentRuleSetsPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.tools.ApplyBrandingPage;

/**
 * @author Jinesh Devasia
 *
 */
public class SupportCenterTest extends SeleniumTest {
	
	public static String TEST_DATA_XML_FILE_PATH = FileUtils.getBaseDirectory() + File.separator + PropertyPool.getProperty("supportcentertestdatadir");
	public static String TEST_DATA_XML_FILE = TEST_DATA_XML_FILE_PATH + File.separator + "scdataprovider.xml" ;	

	
	protected SupportCenterLoginPage supportCenterLoginPage = null;
	protected SupportCenterHomePage supportCenterHomePage = null; 
	protected PCAgentConfigSummaryPage pcAgentConfigSummaryPage = null;
	protected PCAgentConfigCreatePage pcAgentConfigCreatePage = null;
	protected AddCommunityPage addCommunityPage = null;
	protected ProfileAndWebSiteSettingsPage profileAndWebSiteSettingsPage = null;
	protected AddLDAPConfigPage addLDAPConfigpage = null;
	protected ApplyBrandingPage applyBrandingPage = null;
	protected TechniciansPage techniciansPage = null;
	protected PCAgentCreateRuleSetGeneralPage pcAgentCreateRuleSetGeneralPage = null;
	protected PCAgentRuleSetsPage pcAgentRuleSetsPage = null;
	protected PCAgentCreateRuleSetRulesPage pcAgentCreateRuleSetRulesPage = null;	
	
	protected final void initSupportCenterTest()throws Exception {
		initSupportCenterTest(IE);
	}
	
	protected final void initSupportCenterTest(String browser)throws Exception {		
		super.init();	
		SupportCenterTest.loadSupportCenterTestData();
		applicationProtocol = PropertyPool.getProperty("supportcenterprotocol");
		applicationHostname = PropertyPool.getProperty("supportcenterurl");
		applicationPort = PropertyPool.getProperty("supportcenterport");
		appendUrl = PropertyPool.getProperty("supportcenterappendurl");
		/*
		 * Checking the Skip Test Feature
		 */
		resetSkipTestValue();
		super.initSeleniumTest(applicationProtocol, applicationHostname, applicationPort, appendUrl, browser);
		PageFactory.setNewPage(SupportCenterLoginPage.class);
	}
	
	public String getSupportCenterUrl(){
		String protocol = PropertyPool.getProperty("supportcenterprotocol");
		String hostname = PropertyPool.getProperty("supportcenterurl");
		String port = PropertyPool.getProperty("supportcenterport");
		String url = PropertyPool.getProperty("supportcenterappendurl");
		
		return protocol + "://"+ hostname +  ":"  + port + "/"+ url;
	}	
	
	/**
	 * Method to check the Skip Test value 
	 */
	public void resetSkipTestValue(){
		if(resetSkipTests){
			resetSkipTestsIfFailedInTestDataProvider(TEST_DATA_XML_FILE, AccountManagementTest.TEST_DATA_XML_FILE);
		}
	}
	public static void loadSupportCenterTestData(){
		TestDataProvider.loadTestData(TEST_DATA_XML_FILE_PATH);
	}
	
	public void stopSeleniumTest() throws Exception{
		super.stopSeleniumTestEnableSkipTest(TEST_DATA_XML_FILE,AccountManagementTest.TEST_DATA_XML_FILE);
	}
	
}
