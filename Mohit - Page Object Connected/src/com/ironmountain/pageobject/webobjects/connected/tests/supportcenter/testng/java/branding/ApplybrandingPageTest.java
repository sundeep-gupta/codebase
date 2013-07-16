package com.ironmountain.pageobject.webobjects.connected.tests.supportcenter.testng.java.branding;

import java.io.File;

import org.apache.log4j.Logger;
import org.testng.Reporter;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.ImageUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.LocatorUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.ApplyBrandingAction;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.CopyFromDC;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.CreateCustomCommunity;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.SupportCenterLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.testrunner.ActionRunner;
import com.ironmountain.pageobject.webobjects.connected.database.DataBase;
import com.ironmountain.pageobject.webobjects.connected.database.registry.BrandTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.supportcenter.SupportCenterNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;

/** Test to check all the fields on the Apply Branding page TestID:34482
 * @author pjames
 *
 */
@SeleniumUITest(priority=3)
public class ApplybrandingPageTest extends SupportCenterTest{
	BrandTable brandTable = null;
	private static String logopath = "C:"+File.separator+"BrandingData"+File.separator;
	private static Logger logger = Logger.getLogger(ApplybrandingPageTest.class.getName());
	private static String commID = null;
	
	String LoginImgName =null;
	String HeaderImgName =null;
	String MacImageName =null;
	String AgentProdImgName =null;
	String SplashImgName =null;
	String Installer82ImgName =null;
	String Installer84ImgName =null;
	String SSWSImgName=null;
	
	String BrandedMsg = "(Branded; to change, enter new image file)";
	
	@BeforeMethod(alwaysRun=true)
	public void startTest() throws Exception{
		ActionRunner.run("CopyFile.xml");
		super.initSupportCenterTest();
		brandTable = new BrandTable(DatabaseServer.COMMON_SERVER);
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
	public void createCommunityHierarchy(String TechnicianId, String Password) throws Exception{
		supportCenterHomePage = SupportCenterLogin.login(TechnicianId, Password);
		commID = CreateCustomCommunity.createCommunityAction();
		TestDataProvider.setTestDataToXmlFile(TEST_DATA_XML_FILE, "CustomCommunityID", commID);
		commID = TestDataProvider.getTestData("CustomCommunityID");
	}

	@Parameters( {"TechnicianId", "Password", "shortProductName", "longProductName", 
		"installationFolder", "productName", "definstallationFolder", "desktopProductName", "programGroupLocation",
		"siteName"})
	@Test(enabled = true, groups= {"sc","branding", "apply branding page "})
	public void testAllFields(String TechnicianId, String Password, String shortProductName, String longProductName, 
						String installationFolder,String productName,String definstallationFolder, String desktopProductName,
						String programGroupLocation, String siteName)throws Exception{
		SupportCenterNavigation.viewCustomCommunityPage(commID);
		supportCenterHomePage.clickOnToolsLink();
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		logger.info("Step1: The Branding configuration page opens up in Support Center");
		Asserter.assertEquals(applyBrandingPage.isTextPresent("Apply Branding"), true);
		applyBrandingPage = ApplyBrandingAction.enterAllBrandingDetails(LoginImgName, HeaderImgName, shortProductName, longProductName, MacImageName, installationFolder, productName, AgentProdImgName, SplashImgName, Installer82ImgName, Installer84ImgName, 
							definstallationFolder, desktopProductName, programGroupLocation, siteName, SSWSImgName);
		Thread.sleep(10000);
		super.stopSeleniumTest();
		super.initSupportCenterTest();
		initialiseSCafterLogOut();
		//super.initSupportCenterTest();
		supportCenterHomePage = SupportCenterLogin.login(TechnicianId, Password);
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(commID);
		supportCenterHomePage.clickOnToolsLink();
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		logger.info("Step20: Returning to the branding confguration page.");
		Asserter.assertEquals(applyBrandingPage.isElementPresent("ApplyBrandingPage.BrowseBtn"), true);
		logger.info("Step21: The poweredby checkbox is still selected");
		Asserter.assertEquals(applyBrandingPage.verifyShowPoweredByIronMountainLogoCheckboxState(), "on");
		logger.info("Step24: The Mac shortname is changed and branding applied message is displayed and also verifying the DB values.");
		Asserter.assertEquals(applyBrandingPage.getMacAgentShortProductName(), shortProductName);
		Asserter.assertEquals(brandTable.getValueByColNameandCommunityID("MacProductName", commID), shortProductName);
		Asserter.assertEquals(applyBrandingPage.getMacAgentLongProductName(), longProductName);
		Asserter.assertEquals(brandTable.getValueByColNameandCommunityID("MacLongProductName", commID), longProductName);
		Asserter.assertEquals(applyBrandingPage.getMacAgentProductImageInAgentApplication(), BrandedMsg);
		Asserter.assertEquals(applyBrandingPage.getMacAgentDefaultInstallFolder(), installationFolder);
		Asserter.assertEquals(brandTable.getValueByColNameandCommunityID("MacInstallFolder", commID), installationFolder);
		logger.info("Step25: The Account Management sitename is changed and branding applied message is displayed also verified the DB values.");
		Asserter.assertEquals(applyBrandingPage.getAcountManagementSiteName(), siteName);
		Asserter.assertEquals(brandTable.getValueByColNameandCommunityID("AcntMgmtSiteName", commID), siteName);
		Asserter.assertEquals(applyBrandingPage.getAcountManagementSiteimageInHeader(), BrandedMsg);
		verifyImages(AgentProdImgName,SplashImgName,Installer82ImgName,Installer84ImgName,commID);
		logger.info("End of Branding TestCase1");
		
	}
	
	
	public void verifyImages(String AgentProdImgName, String SplashImgName, String Installer82ImgName, String Installer84ImgName, String commID) throws Exception{
		CopyFromDC.copyBrandingDirectoryFromDC();
		logger.info("Comparing the Login Image");
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+LoginImgName, "C:"+File.separator+"DCBrandingFiles"+File.separator+commID+File.separator+"SCLogin.gif"), true);
		logger.info(" Comparing the Header Image");
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+HeaderImgName, "C:"+File.separator+"DCBrandingFiles"+File.separator+commID+File.separator+"HeaderLogo.gif"), true);
		logger.info(" Comparing the Mac Image");
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+MacImageName, "C:"+File.separator+"DCBrandingFiles"+File.separator+commID+File.separator+"macdataprotector_logo.png"), true);
		logger.info(" Comparing the Agent Image");
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+AgentProdImgName, "C:"+File.separator+"DCBrandingFiles"+File.separator+commID+File.separator+"pcdataprotector_logo.png"), true);
		logger.info(" Comparing the Splash Image");
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+SplashImgName, "C:"+File.separator+"DCBrandingFiles"+File.separator+commID+File.separator+"pcdataprotector_splashlogo.png"), true);
		logger.info(" Comparing the Installer Image");
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+Installer82ImgName, "C:"+File.separator+"DCBrandingFiles"+File.separator+commID+File.separator+"pcdataprotector_logo.jpg.ibd"), true);
		logger.info(" Comparing the Installer Image for versions 8.4 and above");
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+Installer84ImgName, "C:"+File.separator+"DCBrandingFiles"+File.separator+commID+File.separator+"pcdataprotector_logo_wise.jpg.ibd"), true);
		logger.info(" Comparing the Account Management Site Header Image");
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+SSWSImgName, "C:"+File.separator+"DCBrandingFiles"+File.separator+commID+File.separator+"acntmgmt_siteheader.png"), true);		
	}
	
	public void initialiseSCafterLogOut(){
		if (!(seleniumPage.isTextPresent("Please Log In"))){
			seleniumPage.selectRelativeUpFrame();
			seleniumPage.selectRelativeUpFrame();
			seleniumPage.selectRelativeUpFrame();
			seleniumPage.selectFrame("AppHeader");
			seleniumPage.click("//a[contains(@onclick,'Logout')]");
			seleniumPage.close();	
		}
	}


	@AfterMethod(alwaysRun=true)
	public void stopTest() throws Exception{
		//supportCenterHomePage = applyBrandingPage.openLoginPage(applicationUrl);
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.clickOnLogOff();	
		brandTable.closeDatabaseConnection();
		logger.info("Stopping Test...");
		super.stopSeleniumTest();
	}
	
}
