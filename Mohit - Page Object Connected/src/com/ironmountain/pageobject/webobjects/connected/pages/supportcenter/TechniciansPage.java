package com.ironmountain.pageobject.webobjects.connected.pages.supportcenter;

import com.ironmountain.pageobject.webobjects.connected.database.registry.CommunityTable;
import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.thoughtworks.selenium.Selenium;

public class TechniciansPage extends SeleniumPage {
	
	//CommunityTable communityTable = null;
	
	public TechniciansPage(Selenium sel)
	{
		selenium =sel;
		setSpeed("2000");
		//communityTable = new CommunityTable(DatabaseServer.COMMON_SERVER);
	}
	
	public void checkAccountStatus(){
		check("TechnicianPage.AccountStatus");
	}
	
	public void checkModifyCommunities(){
		check("TechnicianPage.ModifyCommunities");
	}
	public void checkModifyTechnicianPermissions(){
		check("TechnicianPage.ModifyTechnicianPermissions");
	}

	public void checkRunReports(){
		check("TechnicianPage.RunReports");
	}
	public void checkServiceEvents(){
		check("TechnicianPage.ServiceEvents");
	}
	public void checkAgentConfiguration(){
		check("TechnicianPage.AgentConfiguration");
	}
	public void checkAccountChangeUser(){
		check("TechnicianPage.AccountChangeUser");
	}
	
	public void checkImportBrandedAgent(){
		check("TechnicianPage.ImportBrandedAgent");
	}
	public void checkAllocateLicenses(){
		check("TechnicianPage.AllocateLicenses");
	}
	
	public void checkMoveAccounts(){
		check("TechnicianPage.MoveAccounts");
	}
	public void checkCDOrder(){
		check("TechnicianPage.CDOrder");
	}
	public void typeTechID(String TechID){
		type("TechnicianPage.TechID", TechID);
	}
	public void setTechnicianAsAdmin(String DCName){
		select("TechnicianPage.SetAs","label="+DCName+"\\Admin");
	}
	public void clickOnAddTechnicianBtn(){
		click("TechnicianPage.AddTechnician");
	}
	public void typePassword(String password){
		type("TechniciansPage.Password", password);
	}
	public void typeConfirmPassword(String password){
		type("TechniciansPage.ConfirmPassword", password);
	}
	public void selectAppHeaderFrame()
	{
		selectFrame("AppHeader");
	}
	public SupportCenterLoginPage clickOnLogOff()
	{
		selectAppHeaderFrame();
		selenium.click("//a[contains(@onclick,'Logout')]");
		return (SupportCenterLoginPage) PageFactory.getNewPage(SupportCenterLoginPage.class);
	}
	
	public SupportCenterLoginPage openLoginPage(String url)
	{
		open(url);
		waitForPageLoad();
		return (SupportCenterLoginPage)PageFactory.getNewPage(SupportCenterLoginPage.class);
	}
}
