package com.ironmountain.pageobject.webobjects.connected.tests.supportcenter;


import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.SupportCenterLogin;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.pcagentrulesets.PCAgentCreateRuleSetGeneralPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.pcagentrulesets.PCAgentCreateRuleSetRulesPage;
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;

@SeleniumUITest
public class SampleRulesetsTest extends SupportCenterTest {


	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception{
		super.initSupportCenterTest();
	}
	
	@Test(groups={"samples", "all", "sc"})
	public void testBrandingPage() throws Exception
	{
		supportCenterHomePage = SupportCenterLogin.login("admin", "1Connected");
		PCAgentCreateRuleSetGeneralPage pg = supportCenterHomePage.clickOnPCAgentRuleSetsNode("13");
		//PCAgentCreateRuleSetGeneralPage pg = (PCAgentCreateRuleSetGeneralPage) PageFactory.getNewPage(PCAgentCreateRuleSetGeneralPage.class);
		pg.typeRuleSetName("Sample RuleSet");
		//pg.typeRuleSetDescription("Sample RuleSet dec");
		//pg.typeDrivesToSkipDuringBackup("C");
		PCAgentCreateRuleSetRulesPage rp = pg.clickOnNextButton();
		Thread.sleep(5000);
		rp.selectFrame("//html/frameset/frame[@name='NodeDetails']");
		rp.setAgentRule("%3cRules%3e%0a%3cSkipRule%3e%3cSkip%3e%3c!%5bCDATA%5b%5d%5d%3e%3c%2fSkip%3e%0a%3c%2fSkipRule%3e%0a%3cRule%3e%3cFolder%3e%3c!%5bCDATA%5bC%3a%5cJinesh%5c" +
				"TestFolder%5d%5d%3e%3c%2fFolder%3e%0a%3cFileName%3e%3c!%5bCDATA%5bFilePriyaJinu%5d%5d%3e%3c%2fFileName%3e%0a%3cExtension" +
				"%3e%3c!%5bCDATA%5bDOC,File,Fix%5d%5d%3e%3c%2fExtension%3e%0a%3cFileType%3e2%3c%2fFileType%3e%0a%3cName%3e%3c!%5bCDATA%5b" +
				"SampleTestRule%5d%5d%3e%3c%2fName%3e%0a%3cSource%3e2%3c%2fSource%3e%0a%3cRecursive%3e1%3c%2fRecursive%3e%0a%3cLocked%3e1%3c%2fLocked%3e%0a%3cId%3" +
				"e0%3c%2fId%3e%0a%3c%2fRule%3e%0a%3c%2fRules%3e%0a");
		//rp.isTextPresent("Rules are applied in the order");
		pg = rp.clickOnFinishRuleSetsButton();		
	}
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception	{
		super.stopSeleniumTest();
	}	
}
