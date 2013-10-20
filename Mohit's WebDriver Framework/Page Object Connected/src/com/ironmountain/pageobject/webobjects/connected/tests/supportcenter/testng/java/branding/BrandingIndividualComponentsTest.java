package com.ironmountain.pageobject.webobjects.connected.tests.supportcenter.testng.java.branding;

import java.awt.image.BufferedImage;
import java.io.File;

import javax.imageio.ImageIO;

import junit.framework.Assert;

import org.apache.log4j.Logger;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.ImageUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.ApplyBrandingAction;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.CopyFromDC;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.CreateCustomCommunity;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.SupportCenterLogin;
import com.ironmountain.pageobject.webobjects.connected.actions.testrunner.ActionRunner;
import com.ironmountain.pageobject.webobjects.connected.database.registry.BrandTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.supportcenter.SupportCenterNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;

/**
 * @author rramanand
 *
 */
@SeleniumUITest
public class BrandingIndividualComponentsTest extends SupportCenterTest {
	BrandTable brandTable = null;
	private static String logopath = "C:"+File.separator+"BrandingData"+File.separator;
	private static Logger logger = Logger.getLogger(ApplybrandingPageTest.class.getName());
	private static String commID = null;
	private static String chCommID = null;
	private static String chCommID2 = null;
	private static String chCommID3 = null;
	private static String chCommID4 = null;
	
	String LoginImgName =null;
	String HeaderImgName =null;
	String MacImageName =null;
	String AgentProdImgName =null;
	String SplashImgName =null;
	String Installer82ImgName =null;
	String Installer84ImgName =null;
	String SSWSImgName=null;
	String SSWSImgNameBat = null;
	String ParentSplashImgName = null;
	String LoginImg = null;
	String MacImageNameBat = null;
	
	String BrandedMsg = "(Branded; to change, enter new image file)";
	
	@BeforeMethod(alwaysRun=true)
	public void startTest() throws Exception{
		ActionRunner.run("CopyFile.xml");
		super.initSupportCenterTest();
		logger.info("Starting Test..");
		brandTable = new BrandTable(DatabaseServer.COMMON_SERVER);
		LoginImgName = TestDataProvider.getTestData("LoginImgName");
		HeaderImgName = TestDataProvider.getTestData("HeaderImgName");
		MacImageName = TestDataProvider.getTestData("MacImageName");
		AgentProdImgName = TestDataProvider.getTestData("AgentProdImgName");
		SplashImgName = TestDataProvider.getTestData("SplashImgName");
		Installer82ImgName = TestDataProvider.getTestData("Installer82ImgName");
		Installer84ImgName = TestDataProvider.getTestData("Installer84ImgName");
		SSWSImgName= TestDataProvider.getTestData("SSWSImgName");
		SSWSImgNameBat = TestDataProvider.getTestData("SSWSImgNameBat");
		ParentSplashImgName = TestDataProvider.getTestData("ParentSplashImgName");
		LoginImg = TestDataProvider.getTestData("LoginImg");
		MacImageNameBat = TestDataProvider.getTestData("MacImageNameBat");	
		logger.info("Finished Initialization..");
	}
	@Parameters( {"TechnicianId", "Password"})
	@BeforeMethod (alwaysRun=true, dependsOnMethods = {"startTest"})
	public void createCommunityHierarchy(String TechnicianId, String Password) throws Exception{
		supportCenterHomePage = SupportCenterLogin.login(TechnicianId, Password);
		commID = CreateCustomCommunity.createCommunityAction();
		TestDataProvider.setTestDataToXmlFile(TEST_DATA_XML_FILE, "CustomCommunityID", commID);
		commID = TestDataProvider.getTestData("CustomCommunityID");
		logger.info("Creating first child community under the parent community");
		chCommID = CreateCustomCommunity.createCommunityUnderCommunity(TechnicianId, Password, commID);
		TestDataProvider.setTestDataToXmlFile(TEST_DATA_XML_FILE, "ChildCommunityID", chCommID);
		logger.info("Creating second child community under the parent community");
		chCommID2 = CreateCustomCommunity.createCommunityUnderCommunity(TechnicianId, Password, commID);
		TestDataProvider.setTestDataToXmlFile(TEST_DATA_XML_FILE, "ChildCommunityID2", chCommID2);
		logger.info("Creating third child community under the parent community");
		chCommID3 = CreateCustomCommunity.createCommunityUnderCommunity(TechnicianId, Password, commID);
		TestDataProvider.setTestDataToXmlFile(TEST_DATA_XML_FILE, "ChildCommunityID3", chCommID3);
		logger.info("Creating fourth child community under the parent community");
		chCommID4 = CreateCustomCommunity.createCommunityUnderCommunity(TechnicianId, Password, commID);
		TestDataProvider.setTestDataToXmlFile(TEST_DATA_XML_FILE, "ChildCommunityID4", chCommID4);
		
	}
	
	@Parameters( {"TechnicianId", "Password", "shortProductName", "longProductName", 
		"installationFolder", "productName", "definstallationFolder", "desktopProductName", "programGroupLocation","siteName","siteNam","prodName","shortProd"})
    @Test(enabled = true, groups= {"sc","branding", "apply branding page "})
    public void testAllFields(String TechnicianId, String Password, String shortProductName, String longProductName, 
						String installationFolder,String productName,String definstallationFolder, String desktopProductName,
						String programGroupLocation, String siteName,String shortProd, String prodName, String siteNam)throws Exception{
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
		SupportCenterLogin.login(TechnicianId, Password);
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(commID);
		supportCenterHomePage.clickOnToolsLink();
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		logger.info("Returning to the branding confguration page.");
		Asserter.assertEquals(applyBrandingPage.isElementPresent("ApplyBrandingPage.BrowseBtn"), true);
		logger.info("The poweredby checkbox is still selected");
		Asserter.assertEquals(applyBrandingPage.verifyShowPoweredByIronMountainLogoCheckboxState(), "on");
		logger.info("The Mac shortname is changed and branding applied message is displayed and also verifying the DB values.");
		Asserter.assertEquals(applyBrandingPage.getMacAgentShortProductName(), shortProductName);
		Asserter.assertEquals(brandTable.getValueByColNameandCommunityID("MacProductName", commID), shortProductName);
		Asserter.assertEquals(applyBrandingPage.getMacAgentLongProductName(), longProductName);
		Asserter.assertEquals(brandTable.getValueByColNameandCommunityID("MacLongProductName", commID), longProductName);
		Asserter.assertEquals(applyBrandingPage.getMacAgentProductImageInAgentApplication(), BrandedMsg);
		Asserter.assertEquals(applyBrandingPage.getMacAgentDefaultInstallFolder(), installationFolder);
		Asserter.assertEquals(brandTable.getValueByColNameandCommunityID("MacInstallFolder", commID), installationFolder);
		logger.info("The Account Management sitename is changed and branding applied message is displayed also verified the DB values.");
		Asserter.assertEquals(applyBrandingPage.getAcountManagementSiteName(), siteName);
		Asserter.assertEquals(brandTable.getValueByColNameandCommunityID("AcntMgmtSiteName", commID), siteName);
		Asserter.assertEquals(applyBrandingPage.getAcountManagementSiteimageInHeader(), BrandedMsg);
		logger.info("End of Branding TestCase1");
		changeSection(LoginImg,shortProd, MacImageNameBat, prodName, ParentSplashImgName,siteNam,SSWSImgNameBat,TechnicianId,Password);
	}
	
	@Parameters( {"TechnicianId", "Password"})
	public void changeSection(String LoginImg, String shortProd, String MacImageNameBat, String prodName, String ParentSplashImgName, String siteNam, String SSWSImgNameBat, String TechnicianId, String Password)throws Exception{
		super.stopSeleniumTest();
		super.initSupportCenterTest();
		initialiseSCafterLogOut();
		SupportCenterLogin.login(TechnicianId, Password);
		logger.info("Navigating to the First Child Community");
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(chCommID);
		supportCenterHomePage.clickOnToolsLink();
		logger.info("Navigating to the branding page of the first child community");
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		logger.info("Doing changes to Support Center Section Only");
		selectframe();
		supportCenterHomePage.selectAppBodyNodeViewNodeDetailsFrame();
		Asserter.assertEquals(applyBrandingPage.verifyInheritedMsg(), true);
		logger.info("In the method enterSupportCenterOnly");
		applyBrandingPage.typeProductImageOnLoginScreenTextField(logopath+LoginImg);
		applyBrandingPage.clickOnApplyButton();
		applyBrandingPage.waitForSeconds(10);
		applyBrandingPage.selenium.keyPressNative(Integer.toString(java.awt.event.KeyEvent.VK_ENTER )+"");
		verifyImages(LoginImg,chCommID,"SCLogin.gif");
		super.stopSeleniumTest();
		super.initSupportCenterTest();
		initialiseSCafterLogOut();
		SupportCenterLogin.login(TechnicianId, Password);
		logger.info("Navigating to the second Child Community");
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(chCommID2);
		supportCenterHomePage.clickOnToolsLink();
		logger.info("Navigating to the branding page of the second child community");
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		logger.info("Doing changes to Mac Agent Section Only");
		selectframe();
		supportCenterHomePage.selectAppBodyNodeViewNodeDetailsFrame();
		Asserter.assertEquals(applyBrandingPage.verifyInheritedMsg(), true);
		logger.info("In the method enterMacAgentOnly");
		applyBrandingPage.typeMacAgentShortProductName(shortProd);
		applyBrandingPage.typeMacAgentProductImageInAgentApplication(logopath+MacImageNameBat);
		applyBrandingPage.clickOnApplyButton();
		applyBrandingPage.waitForSeconds(10);
		applyBrandingPage.selenium.keyPressNative(Integer.toString(java.awt.event.KeyEvent.VK_ENTER )+"");
		super.stopSeleniumTest();
		super.initSupportCenterTest();
		initialiseSCafterLogOut();
		SupportCenterLogin.login(TechnicianId, Password);
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(chCommID2);
		supportCenterHomePage.clickOnToolsLink();
		logger.info("Navigating to the branding page of the second child community");
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		verifyBrandingDetails(shortProd);
		verifyImages(MacImageNameBat, chCommID2,"macdataprotector_logo.png");
		super.stopSeleniumTest();
		super.initSupportCenterTest();
		initialiseSCafterLogOut();
		SupportCenterLogin.login(TechnicianId, Password);
		logger.info("Navigating to the Third Child Community");
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(chCommID3);
		supportCenterHomePage.clickOnToolsLink();
		logger.info("Navigating to the branding page of the third child community");
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		logger.info("Doing changes to PC Agent Section Only");
		selectframe();
		supportCenterHomePage.selectAppBodyNodeViewNodeDetailsFrame();
		Asserter.assertEquals(applyBrandingPage.verifyInheritedMsg(), true);
		logger.info("In the method enterPCAgentOnly");
		applyBrandingPage.typePcAgentProductName(prodName);
		applyBrandingPage.typePcAgentProductImageOnSplashScreen(logopath+ParentSplashImgName);
		applyBrandingPage.clickOnApplyButton();
		applyBrandingPage.waitForSeconds(10);
		applyBrandingPage.selenium.keyPressNative(Integer.toString(java.awt.event.KeyEvent.VK_ENTER )+"");
		super.stopSeleniumTest();
		super.initSupportCenterTest();
		initialiseSCafterLogOut();
		SupportCenterLogin.login(TechnicianId, Password);
		logger.info("Navigating to the Third Child Community");
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(chCommID3);
		supportCenterHomePage.clickOnToolsLink();
		logger.info("Navigating to the branding page of the third child community");
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		verifyBrandingDetails(prodName);
		verifyImages(ParentSplashImgName, chCommID3,"pcdataprotector_splashlogo.png");
		super.stopSeleniumTest();
		super.initSupportCenterTest();
		initialiseSCafterLogOut();
		SupportCenterLogin.login(TechnicianId, Password);
		logger.info("Navigating to the Fourth Child Community");
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(chCommID4);
		supportCenterHomePage.clickOnToolsLink();
		logger.info("Navigating to the branding page of the fourth child community");
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		logger.info("Doing changes to AMWS Section Only");
		selectframe();
		supportCenterHomePage.selectAppBodyNodeViewNodeDetailsFrame();
		Asserter.assertEquals(applyBrandingPage.verifyInheritedMsg(), true);
		logger.info("In the method enterAMWSOnly");
		applyBrandingPage.typeAcountManagementSiteName(siteNam);
		applyBrandingPage.typeAcountManagementSiteimageInHeader(logopath+SSWSImgNameBat);
		applyBrandingPage.clickOnApplyButton();
		applyBrandingPage.waitForSeconds(10);
		super.stopSeleniumTest();
		super.initSupportCenterTest();
		initialiseSCafterLogOut();
		SupportCenterLogin.login(TechnicianId, Password);
		logger.info("Navigating to the Third Child Community");
		supportCenterHomePage = SupportCenterNavigation.viewCustomCommunityPage(chCommID4);
		supportCenterHomePage.clickOnToolsLink();
		logger.info("Navigating to the branding page of the third child community");
		applyBrandingPage = SupportCenterNavigation.viewApplyBrandingPage();
		verifyBrandingDetails(siteNam);
		verifyImages(SSWSImgNameBat, chCommID4,"acntmgmt_siteheader.png");
		
	}
	public void verifyBrandingDetails(String name){
		logger.info("Verifying that all the settings are inherited from the parent");
		Asserter.assertEquals(applyBrandingPage.verifyShowPoweredByIronMountainLogoCheckboxState(), "on");
		Asserter.assertEquals(applyBrandingPage.getMacAgentShortProductName(), name);
		Asserter.assertEquals(applyBrandingPage.getMacAgentProductImageInAgentApplication(), BrandedMsg);
	}

	
	public void verifyImages(String ImageName, String Comm, String ImageName2) throws Exception{
		CopyFromDC.copyBrandingDirectoryFromDC();
		Asserter.assertEquals(ImageUtils.compareTwoImages(logopath+ImageName, "C:"+File.separator+"DCBrandingFiles"+File.separator+Comm+File.separator+ImageName2), true);		
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
	public void selectframe()
	{
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
	}
	
	@AfterMethod(alwaysRun = true)
	public void stopTest() throws Exception{
		logger.info("Stopping Test...");
		super.stopSeleniumTest();
	}
}

