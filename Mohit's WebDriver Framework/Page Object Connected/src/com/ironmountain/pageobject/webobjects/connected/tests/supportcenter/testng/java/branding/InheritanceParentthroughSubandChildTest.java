
package com.ironmountain.pageobject.webobjects.connected.tests.supportcenter.testng.java.branding;

import java.io.File;

import org.apache.log4j.Logger;
import org.testng.Reporter;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.webobjects.connected.database.registry.BrandTable;
import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.ApplyBrandingAction;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.CreateCustomCommunity;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.SupportCenterLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.testrunner.ActionRunner;
import com.ironmountain.pageobject.webobjects.connected.navigations.supportcenter.SupportCenterNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;
import com.ironmountain.pageobject.pageobjectrunner.utils.ImageUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.LocatorUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;

@SeleniumUITest(priority=1)
public class InheritanceParentthroughSubandChildTest extends SupportCenterTest{
	
	private static Logger  logger      = Logger.getLogger(InheritanceParentthroughSubandChildTest.class.getName());
	private static String commID = null;
	String CommunityID = null;
	String LoginImgName =null;
	String HeaderImgName =null;
	String MacImageName =null;
	String AgentProdImgName =null;
	String SplashImgName =null;
	String Installer82ImgName =null;
	String Installer84ImgName =null;
	String SSWSImgName=null;
	String logopath = "C:"+File.separator+"BrandingData"+File.separator;
	
	String BrandedText = "(Branded; to change, enter new image file)";
	
	@BeforeMethod(alwaysRun=true)
	public void startTest() throws Exception{
		logger.info("Starting Test...");
		super.initSupportCenterTest();
		CommunityID = TestDataProvider.getTestData("CustomCommunityID");
		LoginImgName = TestDataProvider.getTestData("LoginImgName");
		HeaderImgName = TestDataProvider.getTestData("HeaderImgName");
		MacImageName = TestDataProvider.getTestData("MacImageName");
		AgentProdImgName = TestDataProvider.getTestData("AgentProdImgName");
		SplashImgName = TestDataProvider.getTestData("SplashImgName");
		Installer82ImgName = TestDataProvider.getTestData("Installer82ImgName");
		Installer84ImgName = TestDataProvider.getTestData("Installer84ImgName");
		SSWSImgName= TestDataProvider.getTestData("SSWSImgName");
	}
	
	@Parameters( {"TechnicianId", "Password"})
	@BeforeMethod (alwaysRun=true, dependsOnMethods = {"startTest"})
	public String createSubCommunity(String TechnicianId, String Password) throws Exception{
		logger.info("Creating Community");
		commID = CreateCustomCommunity.createSubCommunityUnderParentCommunity(TechnicianId, Password, CommunityID);
		TestDataProvider.setTestDataToXmlFile(TEST_DATA_XML_FILE, "SubCommunityID", commID);
		commID = TestDataProvider.getTestData("SubCommunityID");
		return commID;
	}

	@Parameters( {"TechnicianId", "Password", "shortProductName", "longProductName", 
		"installationFolder", "productName", "definstallationFolder", "desktopProductName", "programGroupLocation",
		"siteName"})
	@Test(enabled = true, groups= {"sc","branding", "apply branding page "})
	public void testAllFields(String TechnicianId, String Password, String shortProductName, String longProductName, 
			String installationFolder,String productName,String definstallationFolder, String desktopProductName,
			String programGroupLocation, String siteName) throws Exception{
		//SupportCenterLogin.login(TechnicianId, Password);
		logger.info("View Custom Community Page");
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(commID);
		supportCenterHomePage.clickOnToolsLink();
		logger.info("View Apply Branding Page");
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		Asserter.assertEquals(applyBrandingPage.verifyInheritedMsg(), true);
		Asserter.assertEquals(applyBrandingPage.verifyShowPoweredByIronMountainLogoCheckboxState(), "on");
		Asserter.assertEquals(applyBrandingPage.getMacAgentShortProductName(), shortProductName);
		Asserter.assertEquals(applyBrandingPage.getMacAgentLongProductName(), longProductName);
		Asserter.assertEquals(applyBrandingPage.getMacAgentProductImageInAgentApplication(), BrandedText);
		Asserter.assertEquals(applyBrandingPage.getMacAgentDefaultInstallFolder(), installationFolder);
		Asserter.assertEquals(applyBrandingPage.getAcountManagementSiteName(), siteName);
		Asserter.assertEquals(applyBrandingPage.getAcountManagementSiteimageInHeader(), BrandedText);
			
	}
	
	@AfterMethod(alwaysRun=true)
	public void stopTest() throws Exception{
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.clickOnLogOff();	
		logger.info("Stopping Test...");
		super.stopSeleniumTest();
	}

}
