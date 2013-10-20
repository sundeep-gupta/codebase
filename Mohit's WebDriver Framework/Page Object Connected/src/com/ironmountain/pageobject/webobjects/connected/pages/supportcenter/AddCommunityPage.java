package com.ironmountain.pageobject.webobjects.connected.pages.supportcenter;

import com.thoughtworks.selenium.Selenium;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.database.registry.CommunityTable;

/** Add Community Page Object
 * @author pjames
 *
 */
public class AddCommunityPage extends SeleniumPage {
	
	CommunityTable communityTable = null;
	
	public AddCommunityPage(Selenium sel)
	{
		selenium =sel;
		setSpeed("2000");
		communityTable = new CommunityTable(DatabaseServer.COMMON_SERVER);
	}
	public void typeCommunityName(String CommunityName){
		type("AddCommunityPage.Name", CommunityName);
	}
	public SupportCenterHomePage clickOnSubCommunitySaveBtn(){
		click("AddSubCommunityPage.SaveBtn");
		//selenium.waitForPageToLoad("30000");
		//selenium.refresh();
		return(SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
	}
	public SupportCenterHomePage clickOnSaveBtn(){
		click("AddCommunityPage.SaveBtn");
		//selenium.waitForPageToLoad("30000");
		//selenium.refresh();
		return(SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
	}
	public void clickOnStatusLink(){
		click("ConfigurationStatusPage.StatusLink");
	}
	public void selectWinNodeHeader(){
		selenium.selectWindow("name=NodeHeader");
	}
	public void clickOnHistoryLink(){
		selenium.click("3");
	}
	public void clickOnEnterpriseDirectoryLink(){
		selenium.click("4");
	}
	
	public void selectRelativeUpToAppHeader(){
		selenium.selectFrame("relative=up");
		selenium.selectFrame("relative=up");
		selenium.selectFrame("relative=up");
		selenium.selectFrame("AppHeader");
	}
	
	public void clickOnLogOff(){
		selenium.click("link=LOG OFF");
	}
	
	public boolean verifyHeader(String HeaderText){
		String loc = getLocator("AddCommunityPage.HeaderText");
		String val = getText(loc);
		if (val.contains(HeaderText)){
			return true;
		} else {
			return false;
		}
	}
	
	public String getCommunityID(){
		return communityTable.getLatestCommunityID();
	}
	
}
