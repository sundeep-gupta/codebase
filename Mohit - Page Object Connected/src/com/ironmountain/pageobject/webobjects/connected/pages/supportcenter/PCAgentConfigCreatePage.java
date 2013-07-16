package com.ironmountain.pageobject.webobjects.connected.pages.supportcenter;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.thoughtworks.selenium.Selenium;

/** PCAgent Configuration Create Page Object
 * @author pjames
 *
 */
public class PCAgentConfigCreatePage extends SeleniumPage {
	

	public PCAgentConfigCreatePage(Selenium sel)
	{
		selenium =sel;
		setSpeed("2000");
	}
	
	public void typeName(String Name){
		type("SupportCenterPage.Name", Name);
	}
	
	public void typeDesc(String Desc){
		type("SupportCenterPage.Desc", Desc);
	}
	
	public SupportCenterHomePage clickOnCreateBtn(){
		click("SupportCenterPage.Create");
		return (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
	}
	public void keyRefreshPage(){
		selenium.keyPressNative(Integer.toString(java.awt.event.KeyEvent.VK_F5));
	}
	public void selectAgentVersion(String VersionName){
		select("PCAgentCreatePage.VersionName", "label="+VersionName);
	}
	public void selectAgentSettings(String AgentSettingsName){
		select("PCAgentCreatePage.SettingsName", "label="+AgentSettingsName);
	}
	public void selectProfileAndWebSettings(String profileSettings){
		select("agentsswssettingid", "label=" + profileSettings);
	}
	public void selectAgentRuleSet(String ruleSet){
		select("agentrulesid", "label=" + ruleSet);
	}
	
	public boolean verifyText(){
		return isTextPresent("Create PC Agent Configuration");
	}
	
	public String getRegURL(){
		String loc = getLocator("SupportCenterPage.RegURL");
		String url = getText(loc);
		return url;
	}
}
