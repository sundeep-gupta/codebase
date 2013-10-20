package com.ironmountain.pageobject.webobjects.connected.actions.supportcenter;

import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.SupportCenterHomePage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.SupportCenterLoginPage;

public class SupportCenterLogin {


	/**
	 * Login method for Support Center
	 * 
	 * @param technicianId
	 * @param password
	 * @param community
	 * @return SupportCenterHomePage
	 * @throws Exception
	 */
	public static SupportCenterHomePage login(String technicianId, String password, String community) throws Exception
	{
		SupportCenterLoginPage supportCenterLoginPage = (SupportCenterLoginPage) PageFactory.getNewPage(SupportCenterLoginPage.class);
		supportCenterLoginPage.typeTechnicianId(technicianId);
		supportCenterLoginPage.typePassword(password);
		supportCenterLoginPage.typeCommunity(community);
		return (SupportCenterHomePage)supportCenterLoginPage.clickOnLogOnButton();
	}
	/**
	 * Overloaded version with no community name
	 * 
	 * @param technicianId
	 * @param password
	 * @return SupportCenterHomePage
	 * @throws Exception
	 */
	public static SupportCenterHomePage login(String technicianId, String password) throws Exception
	{
		SupportCenterLoginPage supportCenterLoginPage = (SupportCenterLoginPage) PageFactory.getNewPage(SupportCenterLoginPage.class);
		supportCenterLoginPage.typeTechnicianId(technicianId);
		supportCenterLoginPage.typePassword(password);
		return (SupportCenterHomePage)supportCenterLoginPage.clickOnLogOnButton();
	}
	
	
	public static SupportCenterHomePage loginAndChangePassword(String technicianId, String password, String newpassword, String CommunityName){
		
		SupportCenterLoginPage supportCenterLoginPage = (SupportCenterLoginPage) PageFactory.getNewPage(SupportCenterLoginPage.class);
		supportCenterLoginPage.typeTechnicianId(technicianId);
		supportCenterLoginPage.typePassword(password);
		supportCenterLoginPage.typeCommunity(CommunityName);
		supportCenterLoginPage.clickOnLogOnButton();
		supportCenterLoginPage.clickOnOKBtn();
		supportCenterLoginPage.typeTechnicianId(technicianId);
		supportCenterLoginPage.typeOldPassword(password);
		supportCenterLoginPage.typeNewPassword(newpassword);
		supportCenterLoginPage.typeConfirmNewPassword(newpassword);
		supportCenterLoginPage.typeCommunity(CommunityName);
		return (SupportCenterHomePage)supportCenterLoginPage.clickOnChangePasswordButton();
		//return (SupportCenterHomePage)supportCenterLoginPage.clickOnLogOnButton();
	}
	
	
	
		
	
	
	
	
	

}
