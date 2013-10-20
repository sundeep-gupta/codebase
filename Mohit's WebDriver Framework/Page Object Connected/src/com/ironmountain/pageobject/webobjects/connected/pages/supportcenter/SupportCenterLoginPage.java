package com.ironmountain.pageobject.webobjects.connected.pages.supportcenter;

import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestException;
import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.thoughtworks.selenium.Selenium;

public class SupportCenterLoginPage extends SeleniumPage {

	
	public SupportCenterLoginPage(Selenium sel)
	{
		selenium =sel;
	}
	
	public void typeTechnicianId(String technicianId)
	{
		//String technicianIdloc = getLocator("supportcenterloginpage.technicianid");
		type("supportcenterloginpage.technicianid", technicianId);
	}
	public void typePassword(String password)
	{
		String passwordloc = getLocator("supportcenterloginpage.password");
		type(passwordloc, password);
	}
	public void typeOldPassword(String password)
	{
		String passwordloc = getLocator("supportcenterloginpage.oldpassword");
		type(passwordloc, password);
	}
	public void typeNewPassword(String password)
	{
		String passwordloc = getLocator("supportcenterloginpage.newpassword");
		type(passwordloc, password);
	}
	public void typeConfirmNewPassword(String password)
	{
		String passwordloc = getLocator("supportcenterloginpage.confirmnewpassword");
		type(passwordloc, password);
	}
	public void typeCommunity(String community)
	{
		String communityloc = getLocator("supportcenterloginpage.communityname");
		type(communityloc, community);
	}
	public SupportCenterHomePage clickOnChangePasswordButton()
	{		
			String loginBtnLoc = getLocator("supportcenterloginpage.changepasswordbutton");
			clickAndWaitForPageLoad(loginBtnLoc);
			return (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		
	}
	public SupportCenterHomePage clickOnLogOnButton()
	{
		try {
			String loginBtnLoc = getLocator("supportcenterloginpage.logonbutton");
			clickAndWaitForPageLoad(loginBtnLoc);
			return (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
		} catch (Exception e) {
			throw new TestException("Exception occoured while clickong the button and retreving page object" + e.getMessage());
		}
	}
	public SupportCenterLoginPage clickOnOKBtn(){
		click("SupportCenterPage.OKBtn");
		return (SupportCenterLoginPage) PageFactory.getNewPage(SupportCenterLoginPage.class);
	}
	
	public boolean verifyProductImageOnLoginScreenwhileLogin(String commID){
		String imgAttribute = selenium.getAttribute("//img/@src");
    	System.out.println(imgAttribute);
    	if (imgAttribute.contains("/"+commID+"/SCLogin.gif")){
    		return true;
    	} else {
    		return false;
    	}
    }
	
	public SupportCenterLoginPage openBrandURL(String url){
		open(url);
		return (SupportCenterLoginPage) PageFactory.getNewPage(SupportCenterLoginPage.class);			
	}
	
	
}
