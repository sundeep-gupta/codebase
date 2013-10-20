package com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.tools;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.SupportCenterHomePage;
import com.thoughtworks.selenium.Selenium;

public class ApplyBrandingPage extends SeleniumPage{

	
	public ApplyBrandingPage(Selenium sel) {
		selenium = sel;
	}
	
	public void checkShowPoweredByIronMountainLogoCheckbox(){
		check("chkPoweredBy");
	}
	
	public String verifyShowPoweredByIronMountainLogoCheckboxState(){
		return getValue("chkPoweredBy");
		
	}
	public void unCheckShowPoweredByIronMountainLogoCheckbox(){
		unCheck("chkPoweredBy");
	}
	
	public boolean verifyShowPoweredByIronMountainImage(){
		String loc = getLocator("ApplyBrandingPage.ProductImageOnLoginScreen");
    	String imgAttribute = selenium.getAttribute(loc+"/@src");
    	if (imgAttribute.contains("SC_PoweredBy-white.jpg")){
    		return true;
    	} else {
    		return false;
    	}
	}
	/**
	 * This method will directly type the logo path instead of opening with file select dialog
	 * @param logoPath
	 */
	public void typeProductImageOnLoginScreenTextField(String logoPath){
		type("SCLogoFilePath", logoPath);
	}
    public boolean verifyProductImageOnLoginScreen(String ImageName){
    	String loc = getLocator("ApplyBrandingPage.ProductImageOnLoginScreen");
    	String imgAttribute = selenium.getAttribute(loc+"/@src");
    	if (imgAttribute.contains(ImageName)){
    		return true;
    	} else {
    		return false;
    	}
    }
 
    
    public boolean verifyProductImageOnLoginScreenwhileLogin(String ImageName){
    //	String loc = getLocator("ApplyBrandingPage.ProductImageOnLoginScreenwhileLogin");
    	String imgAttribute = selenium.getAttribute("//img/@src");
    	if (imgAttribute.contains(ImageName)){
    		return true;
    	} else {
    		return false;
    	}
    }
    public String getSCUrl(){
    	String mainString = getText("ApplyBrandingPage.SupportCenterURL");
    	String urlString = "http://";
    	String brandedURL = StringUtils.extractURL(mainString, urlString);
    	return brandedURL;
    }
	public String getLogoPathforProductImageOnLoginScreen(){
		String lp = getValue("SCLogoFilePath");
		System.out.println(lp);
		return lp;
	}
	public void typeProductImageInHeaderTextField(String imagePath){
		type("SCHeaderLogo", imagePath);
	}
	public boolean verifyProductImageInHeaderScreen(String ImageName){
    	String loc = getLocator("ApplyBrandingPage.ProductImageInHeaderScreen");
    	String imgAttribute = selenium.getAttribute(loc+"/@src");
    	if (imgAttribute.contains(ImageName)){
    		return true;
    	} else {
    		return false;
    	}
    }
	
	public String getLogoPathforProductImageInHeader(){
		String lp = getValue("SCHeaderLogo");
		return lp;
	}
	/*
	 *This section contains configurations for Mac Agents 
	 */
	public void typeMacAgentShortProductName(String shortProductName){
		type("MacProductName", shortProductName);
	}
	public String getMacAgentShortProductName(){
		String maspn = getValue("MacProductName");
		return maspn;
	}
	public void typeMacAgentLongProductName(String longProductName){
		type("MacLongProductName", longProductName);
	}
	public String getMacAgentLongProductName(){
		String maspn = getValue("MacLongProductName");
		return maspn;
	}
	public void typeMacAgentProductImageInAgentApplication(String agentImage){
		type("MacProductLogo", agentImage);
	}

	public String getMacAgentProductImageInAgentApplication(){
		String maspn = getValue("MacProductLogo");
		return maspn;
	}
	public void typeMacAgentDefaultInstallFolder(String installationFolder){
		type("MacInstallFolder", installationFolder);
	}
	public String getMacAgentDefaultInstallFolder(){
		String maspn = getValue("MacInstallFolder");
		return maspn;
	}
	/*
	 * This section contains configurations for PC Agents
	 */
    public void typePcAgentProductName(String productName){
		type("PCProductName", productName);
	}
    public String getPcAgentProductName(){
		String maspn = getValue("PCProductName");
		return maspn;
	}
	public void typePcAgentProductImageOnAgentApplication(String agentImage){
		type("PCProductLogo", agentImage);
	}
	 public String getPcAgentProductImageOnAgentApplication(){
			String maspn = getValue("PCProductLogo");
			return maspn;
		}
    public void typePcAgentProductImageOnSplashScreen(String splashImage){
		type("PCSplashLogo", splashImage);
	}
    public String getPcAgentProductImageOnSplashScreen(){
		String maspn = getValue("PCSplashLogo");
		return maspn;
	}
    public void typePcAgentVersion8to8_2_2InstallerProducImage(String imagePath){
		type("PCInstallLogo", imagePath);
	}
    public String getPcAgentVersion8to8_2_2InstallerProducImage(){
		String maspn = getValue("PCInstallLogo");
		return maspn;
	}
    public void typePcAgentVersion8_4AndLaterInstallerProducImage(String imagePath){
		type("PCInstallLogoWise", imagePath);
	}
    public String getPcAgentVersion8_4AndLaterInstallerProducImage(){
		String maspn = getValue("PCInstallLogoWise");
		return maspn;
	}
	public void typePcAgentDefaultInstallFolder(String installationFolder){
		type("PCInstallFolder", installationFolder);
	}
	public String getPcAgentDefaultInstallFolder(){
			String maspn = getText("PCInstallFolder");
			return maspn;
		}
	public void typePcAgentDesktopProductName(String desktopProductName){
		type("PCDeskTopProductName", desktopProductName);
	}
	public String getPcAgentDesktopProductName(){
		String maspn = getValue("PCDeskTopProductName");
		return maspn;
	}
    public void typePcAgentProgramGroupLocation(String programGroupLocation){
		type("PCProgramGroupLoc", programGroupLocation);
	}
    public String getPcAgentProgramGroupLocation(){
		String maspn = getValue("PCProgramGroupLoc");
		return maspn;
	}
    /*
     * Branding configurations for Account Management Site
     */
    public void typeAcountManagementSiteName(String siteName){
		type("AcntMgmtSiteName", siteName);
	}
    public String getAcountManagementSiteName(){
		String maspn = getValue("AcntMgmtSiteName");
		return maspn;
	}
    public void typeAcountManagementSiteimageInHeader(String imagePath){
		type("AcntMgmtSiteLogo", imagePath);
	}
    public String getAcountManagementSiteimageInHeader(){
		String maspn = getValue("AcntMgmtSiteLogo");
		return maspn;
	}
	public boolean verifyAcountManagementSiteimageInHeader(String ImageName){
    	String loc = getLocator("ApplyBrandingPage.AcountManagementSiteimageInHeader");
    	String imgAttribute = selenium.getAttribute(loc+"/@src");
    	if (imgAttribute.contains(ImageName)){
    		return true;
    	} else {
    		return false;
    	}
    }
	
    public ApplyBrandingPage clickOnApplyButton(){
    	click("ApplyBrandingBtn");
    	waitForSeconds(15);
    	return this;
    }
	public SupportCenterHomePage openLoginPage(String url)
	{
		waitForSeconds(5);
		open(url);
		waitForPageLoad();
		return (SupportCenterHomePage)PageFactory.getNewPage(SupportCenterHomePage.class);
	}
    public void clickOnBrowseBtn(){
    	click("ApplyBrandingPage.BrowseBtn");
    }
    
    public boolean verifyAppliedMsg(){
    	String am = getLocator("ApplyBrandingPage.AppliedMsg");
    	boolean res = isTextPresent(am);
    	if(!res){
    		return false;
    	} else {
    		return true;
    	}
    }
    public boolean verifyInheritedMsg(){
    	String im = getLocator("ApplyBrandingPage.InheritedBrandingText");
    	if(!isTextPresent(im)){
    		return false;
    	} else {
    		return true;
    	}
    }
    public ApplyBrandingPage clickOnOkBtn(){
    	click("ApplyBrandingPage.OKBtn");
    	return (ApplyBrandingPage) PageFactory.getNewPage(ApplyBrandingPage.class);	
    }
	
    public void clickOnResetBrandingBtn(){
    	click("ApplyBrandingPage.ResetBrandingBtn");
    }
    
    public boolean verifyResetMsg(){
    	String rm = getLocator("ApplyBrandingPage.ResetBrandingMessage");
    	if(!isTextPresent(rm)){
    		return false;
    	} else {
    		return true;
    	}
    }
    
    public void selectAppHeaderFrame()
	{
		selectFrame("AppHeader");
	}
	public void selectAppBodyFrame()
	{
		selectFrame("AppBody");
	}
	public void selectAppBodyTreeFrame()
	{
		selectAppBodyFrame();
		selectFrame("Tree");
	}
	public void selectAppBodyNodeViewFrame()
	{
		selectAppBodyFrame();
		selectFrame("NodeView");
	}
	public void selectAppBodyNodeViewNodeHeaderFrame()
	{
		selectAppBodyNodeViewFrame();
		selectFrame("NodeHeader");
	}
	public void selectAppBodyNodeViewNodeDetailsFrame()
	{
		selectAppBodyNodeViewFrame();
		selectFrame("NodeDetails");
	}

}
