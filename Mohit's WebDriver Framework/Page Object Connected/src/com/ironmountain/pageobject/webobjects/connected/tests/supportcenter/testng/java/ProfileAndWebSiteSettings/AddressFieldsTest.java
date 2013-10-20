package com.ironmountain.pageobject.webobjects.connected.tests.supportcenter.testng.java.ProfileAndWebSiteSettings;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.CreateSettings;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.SupportCenterLogin;
import com.ironmountain.pageobject.webobjects.connected.database.registry.AgentWebSiteSettingsTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.supportcenter.SupportCenterNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;

@SeleniumUITest(priority=3)
public class AddressFieldsTest extends SupportCenterTest{
	
	AgentWebSiteSettingsTable agentWebSiteSettingsTable = null;
	String commID = null;
	String ProfileName = null;
	String profileID = null;
	String DBVerificationTextEditable="<DisplayStatus>1";
	String DBVerificationTextRequired ="<DisplayStatus>0";
	String DBVerificationTextReadOnly ="<DisplayStatus>2";
	String DBVerificationTextHidden ="<DisplayStatus>3";
	String dbval = null;
	String alertVerificationText = "The Account Management website URL you entered is invalid. You must enter a complete URL, for example 'http://host/ssws/'";
	
	@BeforeMethod(alwaysRun=true)
	public void startTest() throws Exception{
		super.initSupportCenterTest();
		commID = TestDataProvider.getTestData("PWSCommunityID");
		ProfileName = TestDataProvider.getTestData("ProfileName");
		agentWebSiteSettingsTable = new AgentWebSiteSettingsTable(DatabaseServer.COMMON_SERVER);
	}
	
	@Parameters( {"TechnicianId", "Password", "AddressStatus", "Country", "AddressLine1", "AddressLine2", 
		"AddressLine3", "City","State", "PostalCode", "url","CountryVerifyText", "StateVerifyText"})
	@Test(enabled = true, groups= {"sc","ProfileAndWebSiteSettings", "Default Profile And WebSite Settings"})
	public void testAddressFields(String TechnicianId, String Password, String AddressStatus, String Country, String AddressLine1, String AddressLine2, String AddressLine3,String City,
										String State, String PostalCode, String url, String CountryVerifyText, String StateVerifyText) throws Exception{
		supportCenterHomePage = SupportCenterLogin.login(TechnicianId, Password);	
		profileAndWebSiteSettingsPage = SupportCenterNavigation.viewCustomProfileAndWebSiteSettingsConfigPage(commID);
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		CreateSettings.enterProfileAddressFields(AddressStatus, Country, AddressLine1, AddressLine2, AddressLine3, City, State, PostalCode);
		profileAndWebSiteSettingsPage.clickOnFinishBtn();
		profileAndWebSiteSettingsPage.refreshPage();
		profileID = agentWebSiteSettingsTable.getValueByColNameandCommunityID("ID", commID);
		String whereclause = " ID="+profileID;
		dbval = agentWebSiteSettingsTable.getValueByColNameandCommunityID("SETTINGDETAILS", commID, whereclause);
		Asserter.assertEquals(dbval.contains(DBVerificationTextEditable), true);
		Asserter.assertEquals(dbval.contains(CountryVerifyText), true);
		Asserter.assertEquals(dbval.contains(AddressLine1), true);
		Asserter.assertEquals(dbval.contains(AddressLine2), true);
		Asserter.assertEquals(dbval.contains(AddressLine3), true);
		Asserter.assertEquals(dbval.contains(City), true);
		Asserter.assertEquals(dbval.contains(StateVerifyText), true);
		Asserter.assertEquals(dbval.contains(PostalCode), true);
		profileAndWebSiteSettingsPage = SupportCenterNavigation.viewCustomProfileAndWebSiteSettingsConfigPage(commID);
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		profileAndWebSiteSettingsPage.selectAddressStatus("label=Required");
		profileAndWebSiteSettingsPage.clickOnFinishBtn();
		whereclause = " ID="+profileID;
		dbval = agentWebSiteSettingsTable.getValueByColNameandCommunityID("SETTINGDETAILS", commID, whereclause);
		Asserter.assertEquals(dbval.contains(DBVerificationTextRequired), true);
		profileAndWebSiteSettingsPage = SupportCenterNavigation.viewCustomProfileAndWebSiteSettingsConfigPage(commID);
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		profileAndWebSiteSettingsPage.selectAddressStatus("label=Read-Only");
		profileAndWebSiteSettingsPage.clickOnFinishBtn();
		whereclause = " ID="+profileID;
		dbval = agentWebSiteSettingsTable.getValueByColNameandCommunityID("SETTINGDETAILS", commID, whereclause);
		Asserter.assertEquals(dbval.contains(DBVerificationTextReadOnly), true);
		profileAndWebSiteSettingsPage = SupportCenterNavigation.viewCustomProfileAndWebSiteSettingsConfigPage(commID);
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		profileAndWebSiteSettingsPage.selectAddressStatus("label=Hidden");
		profileAndWebSiteSettingsPage.clickOnFinishBtn();
		whereclause = " ID="+profileID;
		dbval = agentWebSiteSettingsTable.getValueByColNameandCommunityID("SETTINGDETAILS", commID, whereclause);
		Asserter.assertEquals(dbval.contains(DBVerificationTextHidden), true);
		profileAndWebSiteSettingsPage = SupportCenterNavigation.viewCustomProfileAndWebSiteSettingsConfigPage(commID);
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		profileAndWebSiteSettingsPage.clickOnBackBtn();
		profileAndWebSiteSettingsPage.clickOnCustomURL();
		profileAndWebSiteSettingsPage.typeCustomURL(url);
		profileAndWebSiteSettingsPage.clickOnFinishBtn();
		Asserter.assertEquals(profileAndWebSiteSettingsPage.getAlert(), alertVerificationText);
	
	
	}

	
	@AfterMethod(alwaysRun=true)
	public void stopTest() throws Exception{
		profileAndWebSiteSettingsPage.selectRelativeUpFrame();
		profileAndWebSiteSettingsPage.selectRelativeUpFrame();
		profileAndWebSiteSettingsPage.selectRelativeUpFrame();
		profileAndWebSiteSettingsPage.clickOnLogOff();
		super.stopSeleniumTest();
	}

}
