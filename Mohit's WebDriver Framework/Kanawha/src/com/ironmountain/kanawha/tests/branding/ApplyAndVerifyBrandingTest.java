package com.ironmountain.kanawha.tests.branding;

import java.util.HashMap;

import org.apache.log4j.Logger;
/*import org.json.JSONException;
import org.json.JSONObject;
import org.openqa.selenium.By;
import org.openqa.selenium.support.PageFactory;
import org.testng.Assert;*/
import org.testng.annotations.AfterMethod;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeMethod;
//import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

/*import com.ironmountain.connected.supportcenter.pages.ApplyBrandingPage;
import com.ironmountain.connected.supportcenter.pages.ApplyBrandingResultPage;
import com.ironmountain.connected.supportcenter.pages.SCHomePage;
import com.ironmountain.connected.supportcenter.pages.SCLoginPage;
import com.ironmountain.kanawha.commons.CommonUtils;
import com.ironmountain.kanawha.managementapi.apis.GetBrandingInfo;
import com.ironmountain.kanawha.managementapi.apis.Login;*/
import com.ironmountain.kanawha.commons.CommonUtils;
import com.ironmountain.kanawha.tests.KanawhaTest;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CommunityTable;
//import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
/*import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium.WebDriverPage;*/
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;

public class ApplyAndVerifyBrandingTest extends KanawhaTest{
	private static final Logger logger = Logger.getLogger(ApplyAndVerifyBrandingTest.class.getName());
	CommunityTable community = new CommunityTable(DatabaseServer.COMMON_SERVER);
	BrandingUtils scBrand = new BrandingUtils();
	private static HashMap<String, String> testInput = new HashMap<String,String>();
	private static HashMap<String, String> testOutput = new HashMap<String,String>();
	private static HashMap<String, String> brandingOutputData = new HashMap<String,String>();
	
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		logger.info("Starting ApplyAndVerifyBrandingTest");
		TestDataProvider.loadTestDataXML(FileUtils.getBaseDirectory()+"/src/com/ironmountain/kanawha/tests/branding/testdata", "branding.xml");
		testInput = TestDataProvider.getTestInput("applyAndVerifyBranding");
		brandingOutputData = TestDataProvider.getTestOutput("BrandingData");
		CommonUtils.updateAccountCommunity(testInput.get("username"), testInput.get("communityName"));// doing this to undo the effect of account movement in account migration tests
		super.initWebDriverTest(scBrand.getSupportCenterLogoutURL(), "");
	}
	
	/**
	 * Test to apply and verify branding to amws
	 * @throws Exception
	 */
	@Test(enabled = true)
	public void applyAndVerifyBranding() throws Exception {
		logger.info("Started Apply and Verify Branding");
		//Apply Branding to amws with the image name and text sourced from branding.xml
		scBrand.applyBranding(testInput.get("communityName"),FileUtils.getBaseDirectory() + testInput.get("imagePath"), testInput.get("siteName"),testInput.get("poweredByLogo"));
		//Verify the applied branding settings by executing the Getbrandinginfo api and validation response against data from branding.xml
		scBrand.verifyBrandingInfo(testInput.get("username"),testInput.get("password"), brandingOutputData.get("spiderMan"),testInput.get("siteName"),brandingOutputData.get("autonomyPowerdByLogo"));
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
