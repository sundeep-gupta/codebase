package com.ironmountain.pageobject.webobjects.connected.actions.supportcenter;

import java.io.File;

import org.testng.Reporter;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.webobjects.connected.navigations.supportcenter.SupportCenterNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.AddCommunityPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.SupportCenterHomePage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.tools.ApplyBrandingPage;
import com.ironmountain.pageobject.pageobjectrunner.utils.DownloadUtils;

/**
 * @author pjames
 *
 */

public class ApplyBrandingAction {
	
	private static String logopath = "C:"+File.separator+"BrandingData"+File.separator;
	
	static ApplyBrandingPage applyBrandingPage = (ApplyBrandingPage) PageFactory.getNewPage(ApplyBrandingPage.class);
	static SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
	static String appliedmessage = "Community Successfully Branded. New branding settings were applied to the community. Any subcommunities without customized branding will use this community's branding. The dctomcat service can now be restarted to see any changes to Account Management branding, otherwise branding changes will refresh automatically in five minutes";
	
	/**
	 * @param shortProductName
	 * @param AgentProdImgName
	 * @param SplashImgName
	 * @param Installer82ImgName
	 * @param Installer84ImgName
	 * @throws Exception
	 */
	public static ApplyBrandingPage enterSelectedBrandingDetails(String shortProductName, String longProductName, String SplashImgName, 
			String Installer82ImgName,String Installer84ImgName) throws Exception{
		applyBrandingPage.typeMacAgentShortProductName(shortProductName);
		Reporter.log("Step2: new text is entered into the field.");
		applyBrandingPage.typeMacAgentLongProductName(longProductName);
		Reporter.log("Step3: Path to the file is now in the field.");
		applyBrandingPage.typePcAgentProductImageOnSplashScreen(logopath+SplashImgName);
		Reporter.log("Step4: Path to the file is now in the field.");
		applyBrandingPage.typePcAgentVersion8to8_2_2InstallerProducImage(logopath+Installer82ImgName);
		Reporter.log("Step5: Path to the file is now in the field.");
		applyBrandingPage.typePcAgentVersion8_4AndLaterInstallerProducImage(logopath+Installer84ImgName);
		Reporter.log("Step6: Path to the file is now in the field.");
		applyBrandingPage = applyBrandingPage.clickOnApplyButton();
		applyBrandingPage.selenium.keyPressNative(Integer.toString(java.awt.event.KeyEvent.VK_ENTER )+"");
		return applyBrandingPage;
	}
	
	/**
	 * @param LoginImgName
	 * @param HeaderImgName
	 * @param shortProductName
	 * @param longProductName
	 * @param MacImageName
	 * @param installationFolder
	 * @param productName
	 * @param AgentProdImgName
	 * @param SplashImgName
	 * @param Installer82ImgName
	 * @param Installer84ImgName
	 * @param definstallationFolder
	 * @param desktopProductName
	 * @param programGroupLocation
	 * @param siteName
	 * @param SSWSImgName
	 * @throws Exception
	 */
	public static ApplyBrandingPage enterAllBrandingDetails( String LoginImgName, String HeaderImgName, String shortProductName, String longProductName, 
			String MacImageName,String installationFolder,String productName,String AgentProdImgName,
			String SplashImgName,String Installer82ImgName,String Installer84ImgName, 
			String definstallationFolder, String desktopProductName,String programGroupLocation, 
			String siteName, String SSWSImgName)throws Exception{
		applyBrandingPage.typeProductImageOnLoginScreenTextField(logopath+LoginImgName);
		applyBrandingPage.typeProductImageInHeaderTextField(logopath+HeaderImgName);
		applyBrandingPage.typeMacAgentShortProductName(shortProductName);
		applyBrandingPage.typeMacAgentLongProductName(longProductName);
		applyBrandingPage.typeMacAgentProductImageInAgentApplication(logopath+MacImageName);
		applyBrandingPage.typeMacAgentDefaultInstallFolder(installationFolder);
		applyBrandingPage.typePcAgentProductName(productName);
		applyBrandingPage.typePcAgentProductImageOnAgentApplication(logopath+AgentProdImgName);
		applyBrandingPage.typePcAgentProductImageOnSplashScreen(logopath+SplashImgName);
		applyBrandingPage.typePcAgentVersion8to8_2_2InstallerProducImage(logopath+Installer82ImgName);
		applyBrandingPage.typePcAgentVersion8_4AndLaterInstallerProducImage(logopath+Installer84ImgName);
		applyBrandingPage.typePcAgentDefaultInstallFolder(definstallationFolder);
		applyBrandingPage.typePcAgentDesktopProductName(desktopProductName);
		applyBrandingPage.typePcAgentProgramGroupLocation(programGroupLocation);
		applyBrandingPage.typeAcountManagementSiteName(siteName);
		applyBrandingPage.typeAcountManagementSiteimageInHeader(logopath+SSWSImgName);
		Asserter.assertEquals(applyBrandingPage.verifyShowPoweredByIronMountainLogoCheckboxState(), "on");
		applyBrandingPage = applyBrandingPage.clickOnApplyButton();
		applyBrandingPage.waitForSeconds(5);
		applyBrandingPage.selenium.keyPressNative(Integer.toString(java.awt.event.KeyEvent.VK_ENTER )+"");
		return applyBrandingPage;
		
	}
	
	
	public static void enterFewImageBrandingDetails( String LoginImgName, String HeaderImgName, String SSWSImgName)throws Exception{
		applyBrandingPage.typeProductImageOnLoginScreenTextField(logopath+LoginImgName);
		applyBrandingPage.typeProductImageInHeaderTextField(logopath+HeaderImgName);
		applyBrandingPage.typeAcountManagementSiteimageInHeader(logopath+SSWSImgName);
		applyBrandingPage.clickOnApplyButton();
		applyBrandingPage.waitForSeconds(5);
		applyBrandingPage.selenium.keyPressNative(Integer.toString(java.awt.event.KeyEvent.VK_ENTER )+"");
	}
	
	
	public static void enterInvalidTextBrandingDetails(String shortProductName, String longProductName, 
			String installationFolder,String productName, 
			String definstallationFolder, String desktopProductName,String programGroupLocation, 
			String siteName)throws Exception{
		applyBrandingPage.typeMacAgentShortProductName(shortProductName);
		applyBrandingPage.typeMacAgentLongProductName(longProductName);
		applyBrandingPage.typeMacAgentDefaultInstallFolder(installationFolder);
		applyBrandingPage.typePcAgentProductName(productName);
		applyBrandingPage.typePcAgentDefaultInstallFolder(definstallationFolder);
		applyBrandingPage.typePcAgentDesktopProductName(desktopProductName);
		applyBrandingPage.typePcAgentProgramGroupLocation(programGroupLocation);
		applyBrandingPage.typeAcountManagementSiteName(siteName);
		applyBrandingPage.clickOnApplyButton();
		applyBrandingPage.waitForSeconds(5);
		applyBrandingPage.selenium.keyPressNative(Integer.toString(java.awt.event.KeyEvent.VK_ENTER )+"");
		

	}
	

	
	public static void enterInvalidImageBrandingDetails( String LoginImgName, String HeaderImgName, String MacImageName, 
			String AgentProdImgName, String SplashImgName, String Installer82ImgName, String Installer84ImgName,String SSWSImgName)throws Exception{
		applyBrandingPage.typeProductImageOnLoginScreenTextField(logopath+LoginImgName);
		applyBrandingPage.typeProductImageInHeaderTextField(logopath+HeaderImgName);
		applyBrandingPage.typeMacAgentProductImageInAgentApplication(logopath+MacImageName);
		applyBrandingPage.typePcAgentProductImageOnAgentApplication(logopath+AgentProdImgName);
		applyBrandingPage.typePcAgentProductImageOnSplashScreen(logopath+SplashImgName);
		applyBrandingPage.typePcAgentVersion8to8_2_2InstallerProducImage(logopath+Installer82ImgName);
		applyBrandingPage.typePcAgentVersion8_4AndLaterInstallerProducImage(logopath+Installer84ImgName);
		applyBrandingPage.typeAcountManagementSiteimageInHeader(logopath+SSWSImgName);
		applyBrandingPage.clickOnApplyButton();
		}
	
}
