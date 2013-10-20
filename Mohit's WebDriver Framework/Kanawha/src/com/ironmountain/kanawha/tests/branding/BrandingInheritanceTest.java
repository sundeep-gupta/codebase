package com.ironmountain.kanawha.tests.branding;

import java.util.HashMap;

import org.apache.log4j.Logger;
import org.json.JSONException;
import org.json.JSONObject;
import org.openqa.selenium.By;
import org.openqa.selenium.support.PageFactory;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.connected.supportcenter.pages.ApplyBrandingPage;
import com.ironmountain.connected.supportcenter.pages.ApplyBrandingResultPage;
import com.ironmountain.connected.supportcenter.pages.SCHomePage;
import com.ironmountain.connected.supportcenter.pages.SCLoginPage;
import com.ironmountain.kanawha.managementapi.apis.GetBrandingInfo;
import com.ironmountain.kanawha.managementapi.apis.Login;
import com.ironmountain.kanawha.tests.KanawhaTest;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CommunityTable;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium.WebDriverPage;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;

public class BrandingInheritanceTest extends KanawhaTest{
	private static final Logger logger = Logger.getLogger(BrandingInheritanceTest.class.getName());
	CommunityTable community = new CommunityTable(DatabaseServer.COMMON_SERVER);
	BrandingUtils scBrand = new BrandingUtils();
	private static HashMap<String, String> testInput = new HashMap<String,String>();
	private static HashMap<String, String> testOutput = new HashMap<String,String>();
	private static HashMap<String, String> brandingOutputData = new HashMap<String,String>();
	
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		logger.info("Starting BrandingInheritanceTest.");
		TestDataProvider.loadTestDataXML(FileUtils.getBaseDirectory()+"/src/com/ironmountain/kanawha/tests/branding/testdata", "branding.xml");
		testInput = TestDataProvider.getTestInput("brandingInheritance");
		brandingOutputData = TestDataProvider.getTestOutput("BrandingData");
		//super.initWebDriverTest("about:blank", "");
		super.initWebDriverTest(scBrand.getSupportCenterLogoutURL(), "");
	}
	
	/**
	 * Test to verify inheritance of branding settings for amws. 
	 * We are applying branding to a hierarchy of three communities in this test and verifying its effect on each community.
	 * @throws Exception
	 */
	@Test(enabled = true)
	public void brandingInheritance() throws Exception {
		
		//Reset branding for all the three communities.
		scBrand.resetBranding(testInput.get("community0"));
		scBrand.resetBranding(testInput.get("community1"));
		scBrand.resetBranding(testInput.get("community2"));
		
		//Apply branding to the top most community and Verify its effect on all the three
		scBrand.applyBranding(testInput.get("community0"),FileUtils.getBaseDirectory() + testInput.get("imagePath0"), testInput.get("siteName0"),testInput.get("poweredByLogo0"));
		scBrand.verifyBrandingInfo(testInput.get("username0"),testInput.get("password0"), brandingOutputData.get("spiderMan"),testInput.get("siteName0"),brandingOutputData.get("autonomyPowerdByLogo"));
		scBrand.verifyBrandingInfo(testInput.get("username1"),testInput.get("password1"), brandingOutputData.get("spiderMan"),testInput.get("siteName0"),brandingOutputData.get("autonomyPowerdByLogo"));
		scBrand.verifyBrandingInfo(testInput.get("username2"),testInput.get("password2"), brandingOutputData.get("spiderMan"),testInput.get("siteName0"),brandingOutputData.get("autonomyPowerdByLogo"));

		//Apply branding to the middle level community and Verify its effect on all the three
		scBrand.applyBranding(testInput.get("community1"),FileUtils.getBaseDirectory() + testInput.get("imagePath1"), testInput.get("siteName1"),testInput.get("poweredByLogo1"));
		scBrand.verifyBrandingInfo(testInput.get("username0"),testInput.get("password0"), brandingOutputData.get("spiderMan"),testInput.get("siteName0"),brandingOutputData.get("autonomyPowerdByLogo"));
		scBrand.verifyBrandingInfo(testInput.get("username1"),testInput.get("password1"), brandingOutputData.get("batMan"),testInput.get("siteName1"),brandingOutputData.get("autonomyPowerdByLogo"));
		scBrand.verifyBrandingInfo(testInput.get("username2"),testInput.get("password2"), brandingOutputData.get("batMan"),testInput.get("siteName1"),brandingOutputData.get("autonomyPowerdByLogo"));

		//Apply branding to the lowest community and Verify its effect on all the three
		scBrand.applyBranding(testInput.get("community2"),FileUtils.getBaseDirectory() + testInput.get("imagePath2"), testInput.get("siteName2"),testInput.get("poweredByLogo2"));
		scBrand.verifyBrandingInfo(testInput.get("username0"),testInput.get("password0"), brandingOutputData.get("spiderMan"),testInput.get("siteName0"),brandingOutputData.get("autonomyPowerdByLogo"));
		scBrand.verifyBrandingInfo(testInput.get("username1"),testInput.get("password1"), brandingOutputData.get("batMan"),testInput.get("siteName1"),brandingOutputData.get("autonomyPowerdByLogo"));
		scBrand.verifyBrandingInfo(testInput.get("username2"),testInput.get("password2"), brandingOutputData.get("theSpiderMan"),testInput.get("siteName2"),brandingOutputData.get("autonomyPowerdByLogo"));
		
		//Reset branding for all the three communities.
		scBrand.resetBranding(testInput.get("community0"));
		scBrand.resetBranding(testInput.get("community1"));
		scBrand.resetBranding(testInput.get("community2"));
		/*this.applyBranding(communityName,imagePath2, siteName2);
		this.verifyBrandingInfo(username,password,communityName, siteName2);
		this.resetBranding(communityName);
		//this.verifyBrandingInfo(username,password,communityName, "Account Management");
		this.verifyBrandingInfo(username,password,communityName, "null");*/
	}
	
	
	@AfterMethod(alwaysRun= true)
	public void stopTest() throws Exception {
		logger.info("Completed a branding test.");
		super.stopWebDriverTest();
	}
	@AfterSuite(alwaysRun = true)
	public void stopSuite() throws Exception {
		logger.info("Completed Branding Tests");
		super.stopAllWebDriverTest();
	}

}


