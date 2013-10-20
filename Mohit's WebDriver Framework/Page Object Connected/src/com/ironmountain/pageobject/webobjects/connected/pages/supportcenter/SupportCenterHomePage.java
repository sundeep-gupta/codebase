/**
 * 
 */
package com.ironmountain.pageobject.webobjects.connected.pages.supportcenter;

import java.sql.SQLException;

import com.ironmountain.pageobject.webobjects.connected.database.registry.AgentWebSiteSettingsTable;
import com.ironmountain.pageobject.webobjects.connected.database.registry.CommunityTable;
import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.accounts.AccountSearchPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.pcagentrulesets.PCAgentCreateRuleSetGeneralPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.tools.ApplyBrandingPage;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.thoughtworks.selenium.Selenium;

/** Support Center Home Page Object with all the urls.
 * @author jdevasia
 *
 */
public class SupportCenterHomePage extends SeleniumPage {
	

	CommunityTable communityTable = new CommunityTable(DatabaseServer.COMMON_SERVER);
	AgentWebSiteSettingsTable agentWebSiteSettingsTable = new AgentWebSiteSettingsTable(DatabaseServer.COMMON_SERVER);
	

	// Type Constants
	public static int accountsType = 3;
	public static int techniciansType = 5;
	public static int reportTemplatesType = 7;
	public static int reportsType = 9;
	public static int configurationsType = 50;
	public static int defaultType = 2;
	public static int defaultCommunityID = 1;
	public static int profileWebSiteSettingsType = 48;
	public static int macType = 51;
	public static int pcType = 39;
	public static int agentVersionsType = 41;
	public static int agentSettingsType = 43;
	public static int pcAgentRuleSetsType = 45;
	public static int macAgentRuleSetsType = 57;
	public static int dataCenterType = 1;
	public static int dcCommunityID = -1;
	public static int defaultConfigType = 40;
	public static String defaultPCOnlyConfigurationvalue = "40_5";
	public static String defaultProfileAndWebSiteSettingsConfigvalue = "49_1";
	public static int defaultprofileWebSiteSettingsConfigType = 49;
	public static String customProfileAndWebSiteSettingsConfigvalue = "49_11";
	
	
	public static String applicationHostname = PropertyPool.getProperty("supportcenterurl");
	public static String applicationPort = PropertyPool.getProperty("supportcenterport");
	public static String appendUrl = PropertyPool.getProperty("supportcenterappendurl");
	
	
	public SupportCenterHomePage(Selenium sel)
	{
		selenium =sel;
		setSpeed("1000");
		//communityTable = new CommunityTable(DatabaseServer.COMMON_SERVER);
	}
	

	/**Method to click on the Default Community Node
	 * @author pjames
	 */
	public SupportCenterHomePage clickOnDefaultCommunityNode(){
		String url = ("type=" + dataCenterType + 
					  "&value=&community=" + dcCommunityID + 
					  "&menuchoice=0");
		open("/supportcenter/nodeview.asp?"+ url);
		return (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
	}
	
	/**Method to go to the new PC agent setting page in the default community
	 * @author pjames
	 * @return
	 */
	public PCAgentConfigSummaryPage clickOnNewPCAgentSettingsinDefaultComm(){
		String url = ("type=" + agentSettingsType + 
				  "&value=&community=" + defaultCommunityID + 
				  "&menuchoice=0");
		System.out.println(url);
		open("/supportcenter/nodeview.asp?"+ url);
		return (PCAgentConfigSummaryPage) PageFactory.getNewPage(PCAgentConfigSummaryPage.class);
	}
	/**Method to go to the PC node in the default community
	 * @author pjames
	 * @return
	 */
	public PCAgentConfigSummaryPage clickOnPCinDefaultComm(){
		String url = ("type=" + pcType + 
				  "&value=&community=" + defaultCommunityID + 
				  "&menuchoice=0");
		System.out.println(url);
		open("/supportcenter/nodeview.asp?"+ url);
		return (PCAgentConfigSummaryPage) PageFactory.getNewPage(PCAgentConfigSummaryPage.class);
	}
	
	
	/**Method to Navigate to the New Default PC Configuration Page
	 * @author pjames
	 * @return
	 */
	public PCAgentConfigSummaryPage clickOnNewDefaultPCConfig(){
		String url = ("type=" + pcType + 
			    "&value=&community=" + defaultCommunityID + 
	  		    "&menuchoice=0");
	System.out.println(url);
	open("/supportcenter/nodeview.asp?"+ url);
	return (PCAgentConfigSummaryPage) PageFactory.getNewPage(PCAgentConfigSummaryPage.class);
	}
	
	/**Method to navigate to the new Default PC Config Create Page.
	 * @author pjames
	 * @return
	 */
	public PCAgentConfigCreatePage clickOnNewDefaultConfigCreate(){
		String url = ("type=" + pcType + 
			    "&value=&community=" + defaultCommunityID + 
	  		    "&menuchoice=1402");
	System.out.println(url);
	open("/supportcenter/Detail.asp?"+ url);
	return (PCAgentConfigCreatePage) PageFactory.getNewPage(PCAgentConfigCreatePage.class);
	
	}
	
	public PCAgentConfigCreatePage clickOnDefaultPCOnlyConfigNode(){
		String url = ("type=" + defaultConfigType + 
			    "&value=" + defaultPCOnlyConfigurationvalue +
			    "&community=" + defaultCommunityID + 
	  		    "&menuchoice=0");
	System.out.println(url);
	open("/supportcenter/Detail.asp?"+ url);
	return (PCAgentConfigCreatePage) PageFactory.getNewPage(PCAgentConfigCreatePage.class);
	
	}
	
	public PCAgentConfigCreatePage selectNewDefaultCongurationPage(){
		String url = ("type=" + defaultConfigType + 
			    "&value=40_17&community=" + defaultCommunityID + 
	  		    "&menuchoice=0");
	System.out.println(url);
	open("/supportcenter/nodeview.asp?"+ url);
	return (PCAgentConfigCreatePage) PageFactory.getNewPage(PCAgentConfigCreatePage.class);
	
	}
	
	public PCAgentConfigCreatePage clickOnNewPCConfigCreateNode(String CommunityID){
		String url = ("type=" + pcType + 
			    "&value=&community=" + CommunityID + 
	  		    "&menuchoice=1402");
	System.out.println(url);
	open("/supportcenter/Detail.asp?"+ url);
	//selectRefreshIcon();
	return (PCAgentConfigCreatePage) PageFactory.getNewPage(PCAgentConfigCreatePage.class);
	}
	
	public PCAgentConfigCreatePage clickOnNewMacConfigCreateNode(String CommunityID){
		String url = ("type=" + macType + 
			    "&value=&community=" + CommunityID + 
	  		    "&menuchoice=1402");
	System.out.println(url);
	open("/supportcenter/Detail.asp?"+ url);
	//selectRefreshIcon();
	return (PCAgentConfigCreatePage) PageFactory.getNewPage(PCAgentConfigCreatePage.class);
	}
	
	public SupportCenterHomePage clickOnCreatedConfigNode(String CommunityID){
		String url = ("type=" + defaultConfigType + 
			    "&value=&community=" + CommunityID + 
	  		    "&menuchoice=0");
	System.out.println(url);
	open("/supportcenter/Detail.asp?"+ url);
	return (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
	}
	/**
	 * This method will click on a PC Agent Configuration node which is already created
	 * 
	 * @param communityId
	 * @param configId
	 * @return
	 */
	public PCAgentConfigCreatePage clickOnPCAgentConfigurationName(String communityId, String configId){
		String url = ("type=" + defaultConfigType + 
			    "&value=" + communityId+ "_" + configId + 
	  		    "&community="+ communityId + "&menuchoice=1501");
	open("/supportcenter/Detail.asp?"+ url);
	return (PCAgentConfigCreatePage) PageFactory.getNewPage(PCAgentConfigCreatePage.class);
	}
	public PCAgentConfigSummaryPage clickOnPCNode(String CommunityID){
		String url = ("type=" + pcType + 
			    "&value=&community=" + CommunityID + 
	  		    "&menuchoice=1401");
	System.out.println(url);
	open("/supportcenter/nodeview.asp?"+ url);
	return (PCAgentConfigSummaryPage) PageFactory.getNewPage(PCAgentConfigSummaryPage.class);
	
	}
	
	public void selectRefreshIcon(){
		selenium.selectWindow("name=AppHeader");
		String refreshbtn = getLocator("SupportCenterPage.RefreshBtn");
		selenium.click(refreshbtn);
		//selenium.waitForPageToLoad("30000");
	}
	
	public void selectWinAppHeader(){
		selenium.selectWindow("name=AppHeader");
	}
	
	public void closePage(){
		selenium.close();
	}
	
	public void selectRelativeUptoAppHeader(){
		selenium.selectFrame("relative=up");
		selenium.selectFrame("relative=up");
		selenium.selectFrame("relative=up");
		selenium.selectFrame("AppHeader");
	}
	
	public void selectAppletView(){
	 	selectFrame("AppBody");
		selectFrame("NodeView");
		selectFrame("NodeHeader");
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
	public void selectNodeHeader(){
		selectFrame("NodeHeader");
	}
	public void selectNodeDetails(){
		selectFrame("NodeDetails");
	}
	
	public void selectWinNodeHeader(){
		selectFrame("NodeHeader");
		//selectWindow("name=NodeHeader");
	}
	public void selectWinNodeDetails(){
		//selectFrame("NodeHeader");
		selectWindow("name=NodeDetails");
	}
	
	public SupportCenterLoginPage clickOnLogOff()
	{
		selectAppHeaderFrame();
		selenium.click("//a[contains(@onclick,'Logout')]");
		return (SupportCenterLoginPage) PageFactory.getNewPage(SupportCenterLoginPage.class);
	}
	
	
	public boolean verifyTitle(){
		String res = getTitle();
		String val = getLocator("supportcenterpagetitle");
		if (res.contains(val)){
			return true;
		} else {
			return false;
		}
	}
	
	public void clickOnToolsLink(){
		click("SupportCenterPage.ToolsLink");
	}
	public void clickOnEnterpriseDirectoryLink(){
		selenium.click("4");
	}
	
	public AddCommunityPage clickOnAddCommunityLink(){
		click("SupportCenterPage.AddCommunityLink");
		return (AddCommunityPage) PageFactory.getNewPage(AddCommunityPage.class);
	}
	public AddCommunityPage clickOnAddSubCommunityLink(){
		click("SupportCenterPage.AddSubCommunityLink");
		return (AddCommunityPage) PageFactory.getNewPage(AddCommunityPage.class);
	}
	
	public String getCommunityID(String CommunityName) throws SQLException{
		
		String commID =	communityTable.getCommunityIDbyCommunityName(CommunityName);
		System.out.println(commID);
		return commID;
	}
	
	public SupportCenterHomePage clickOnLatestCommunityNode(String commId) throws SQLException{
		//String commId = getCommunityID(CommunityName);
		String url = ("type=" + defaultType + 
			    "&value=&community=" + commId + 
	  		    "&menuchoice=0");
	System.out.println(url);
	open("/supportcenter/nodeview.asp?"+ url);
	return (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
	}
	public SupportCenterHomePage clickOnSubCommunityParentNode(){
		String commId = TestDataProvider.getTestData("PrereqCustomCommunityID");
		//String commId = getLocator("CustomCommunityID");
		String url = ("type=" + defaultType + 
			    "&value=&community=" + commId + 
	  		    "&menuchoice=0");
	System.out.println(url);
	open("/supportcenter/nodeview.asp?"+ url);
	return (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
	}
	public ProfileAndWebSiteSettingsPage clickOnProfileAndWebSiteSettingsnode(String CommunityID){
		String url = ("type=" + profileWebSiteSettingsType + 
			    "&value=&community=" + CommunityID + 
	  		    "&menuchoice=0");
	System.out.println(url);
	open("/supportcenter/nodeview.asp?"+ url);
	//selectRefreshIcon();
	return (ProfileAndWebSiteSettingsPage) PageFactory.getNewPage(ProfileAndWebSiteSettingsPage.class);
	}
	
	public ProfileAndWebSiteSettingsPage clickOnDefaultProfileAndWebSiteSettingsConfignode(){
		String url = ("type=" + defaultprofileWebSiteSettingsConfigType + 
			    "&value="+ defaultProfileAndWebSiteSettingsConfigvalue +
			    "&community=" + dcCommunityID + 
	  		    "&menuchoice=0");
	System.out.println(url);
	open("/supportcenter/nodeview.asp?"+ url);
	//selectRefreshIcon();
	return (ProfileAndWebSiteSettingsPage) PageFactory.getNewPage(ProfileAndWebSiteSettingsPage.class);
	}
	public ProfileAndWebSiteSettingsPage clickOnCustomProfileAndWebSiteSettingsConfignode(String CommunityID){
		String customprofileId = agentWebSiteSettingsTable.getValueByColNameandCommunityID("ID", CommunityID);
		String url = ("type=" + defaultprofileWebSiteSettingsConfigType + 
			    "&value="+ CommunityID+"_"+customprofileId +
			    "&community=" + CommunityID + 
	  		    "&menuchoice=0");
	System.out.println(url);
	open("/supportcenter/nodeview.asp?"+ url);
	return (ProfileAndWebSiteSettingsPage) PageFactory.getNewPage(ProfileAndWebSiteSettingsPage.class);
	}
	public ProfileAndWebSiteSettingsPage clickOnDefaultProfileAndWebSiteSettingsConfignode(String CommunityID){
		String url = ("type=" + defaultprofileWebSiteSettingsConfigType + 
			    "&value="+ defaultProfileAndWebSiteSettingsConfigvalue +
			    "&community=" + CommunityID + 
	  		    "&menuchoice=0");
	System.out.println(url);
	open("/supportcenter/nodeview.asp?"+ url);
	return (ProfileAndWebSiteSettingsPage) PageFactory.getNewPage(ProfileAndWebSiteSettingsPage.class);
	}
	
	public SupportCenterHomePage clickOnAgentVersionsNode(String CommunityID){
	String url = ("type=" + agentVersionsType + 
			    "&value=&community=" + CommunityID + 
	  		    "&menuchoice=0");
	System.out.println(url);
	open("/supportcenter/nodeview.asp?"+ url);
	return (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
	
	}
	
	public SupportCenterHomePage clickOnAgentSettingsNode(String CommunityID){
		String url = ("type=" + agentSettingsType + 
				    "&value=&community=" + CommunityID + 
		  		    "&menuchoice=0");
		System.out.println(url);
		open("/supportcenter/nodeview.asp?"+ url);
		return (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		
		}
	public PCAgentCreateRuleSetGeneralPage clickOnPCAgentRuleSetsNode(String CommunityID){
		String url = ("type=" + pcAgentRuleSetsType + 
				    "&value=&community=" + CommunityID + 
		  		    "&menuchoice=0");
		System.out.println(url);
		open("/supportcenter/nodeview.asp?"+ url);
		return (PCAgentCreateRuleSetGeneralPage) PageFactory.getNewPage(PCAgentCreateRuleSetGeneralPage.class);		
	}
	
	public TechniciansPage clickOnTechniciansNode(String CommunityID){
		String url = ("type=" + techniciansType + 
				    "&value=&community=" + CommunityID + 
		  		    "&menuchoice=0");
		System.out.println(url);
		open("/supportcenter/nodeview.asp?"+ url);
		return (TechniciansPage) PageFactory.getNewPage(TechniciansPage.class);		
	}
	
	
	public String getRegURL(){
		String loc = getLocator("SupportCenterPage.RegURL");
		String url = getText(loc);
		return url;
	}
	
	public ApplyBrandingPage clickOnApplyBrandingMenuItem(){
		selectRelativeUpFrame();
		selectRelativeUpFrame();
		selectRelativeUpFrame();
		selectAppBodyNodeViewNodeDetailsFrame();
		click("SupportCenterPage.ApplyBrandingMenu");
		waitForSeconds(7);
		return (ApplyBrandingPage) PageFactory.getNewPage(ApplyBrandingPage.class);
	}
	public AccountSearchPage clickOnAccountsNode(String communityId){
		String url = ("type=" + accountsType + 
				    "&value=&community=" + communityId + 
		  		    "&menuchoice=0");
		open("/supportcenter/nodeview.asp?"+ url);
		return (AccountSearchPage) PageFactory.getNewPage(AccountSearchPage.class);		
	}
	
	public boolean verifyShowPoweredByIronMountainImage(){
		//	String loc = getLocator("ApplyBrandingPage.ProductImageOnLoginScreen");
	    	String imgAttribute = getAttribute("//div[2]/img/@src");
	    	System.out.println(imgAttribute);
	    	if (imgAttribute.contains("SC_PoweredBy-white.jpg")){
	    		return true;
	    	} else {
	    		return false;
	    	}
		}
	
	public boolean verifyShowPoweredByIronMountainElement(){
		//	String loc = getLocator("ApplyBrandingPage.ProductImageOnLoginScreen");
	    	
	    	if (isElementPresent("//div[2]/img/@src")){
	    		return true;
	    	} else {
	    		return false;
	    	}
		}
	
}
