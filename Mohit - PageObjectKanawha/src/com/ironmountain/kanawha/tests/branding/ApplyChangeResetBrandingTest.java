package com.ironmountain.kanawha.tests.branding;

import java.util.HashMap;

import org.apache.log4j.Logger;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import com.ironmountain.kanawha.commons.CommonUtils;
import com.ironmountain.kanawha.tests.KanawhaTest;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CommunityTable;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;

public class ApplyChangeResetBrandingTest extends KanawhaTest {
	private static final Logger logger = Logger
			.getLogger(ApplyChangeResetBrandingTest.class.getName());
	CommunityTable community = new CommunityTable(DatabaseServer.COMMON_SERVER);
	BrandingUtils scBrand = new BrandingUtils();
	private static HashMap<String, String> testInput = new HashMap<String, String>();
	private static HashMap<String, String> testOutput = new HashMap<String, String>();
	private static HashMap<String, String> brandingOutputData = new HashMap<String, String>();

	@BeforeMethod(alwaysRun = true)
	public void startTest() throws Exception {
		logger.info("Starting ApplyChangeResetBrandingTest.");
		TestDataProvider.loadTestDataXML(FileUtils.getBaseDirectory()
				+ "/src/com/ironmountain/kanawha/tests/branding/testdata",
				"branding.xml");
		testInput = TestDataProvider.getTestInput("applyChangeResetBranding");
		brandingOutputData = TestDataProvider.getTestOutput("BrandingData");
		CommonUtils.updateAccountCommunity(testInput.get("username"), testInput.get("communityName"));// doing this to undo the effect of account movement in account migration tests
		super.initWebDriverTest(scBrand.getSupportCenterLogoutURL(), "");
	}

	/**
	 * Test to verify branding settings at each stage of Apply, Edit and Reset branding operations
	 * 
	 * @param username
	 * @param password
	 * @throws Exception
	 */

	@Test(enabled = true)
	public void applyChangeResetBranding() throws Exception {
		BrandingUtils scBrand = new BrandingUtils();
		
		//Apply Branding to amws with the image name and text sourced from branding.xml
		scBrand.applyBranding(testInput.get("communityName"), FileUtils
				.getBaseDirectory()
				+ testInput.get("imagePath1"), "Spider Man", testInput
				.get("poweredByLogo1"));
		//Verify the applied branding settings by executing the Getbrandinginfo api and validation response against data from branding.xml
		scBrand.verifyBrandingInfo(testInput.get("username"), testInput
				.get("password"), brandingOutputData.get("spiderMan"),
				"Spider Man", brandingOutputData.get("autonomyPowerdByLogo"));
		
		//Edit Branding settings for the given community with the new image name and text sourced from branding.xml
		scBrand.applyBranding(testInput.get("communityName"), FileUtils
				.getBaseDirectory()
				+ testInput.get("imagePath2"), testInput.get("siteName2"),
				testInput.get("poweredByLogo2"));
		//Verify the applied branding settings by executing the Getbrandinginfo api and validation response against data from branding.xml
		scBrand.verifyBrandingInfo(testInput.get("username"), testInput
				.get("password"), brandingOutputData.get("batMan"), testInput
				.get("siteName2"), brandingOutputData
				.get("autonomyPowerdByLogo"));
		
		//reset branding for the given community
		scBrand.resetBranding(testInput.get("communityName"));
		//Verify default branding settings for the above community 
		scBrand.verifyBrandingInfo(testInput.get("username"), testInput
				.get("password"), null, null, null);
	}

	@AfterMethod(alwaysRun = true)
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
