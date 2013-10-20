package com.ironmountain.pageobject.webobjects.connected.pages.supportcenter;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.thoughtworks.selenium.Selenium;

public class CreateAgentVersionPage extends SeleniumPage {
	
	public CreateAgentVersionPage(Selenium sel)
	{
		selenium =sel;
		setSpeed("2000");
	}
	
	public void typeName(String Name){
		type("SupportCenterPage.Name", Name);
	}
	public void typeDescription(String Description){
		type("SupportCenterPage.Desc", Description);
	}
	 public SupportCenterHomePage clickOnCreateBtn(){
		 click("AgentVersionPage.CreateBtn");
		 return (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
	 }

}
