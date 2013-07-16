package com.ironmountain.pageobject.webobjects.connected.tests.supportcenter.testng.java.ProfileAndWebSiteSettings;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.SupportCenterLogin;
import com.ironmountain.pageobject.webobjects.connected.database.registry.AgentWebSiteSettingsTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.supportcenter.SupportCenterNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;

@SeleniumUITest
public class OptionalFieldsTest extends SupportCenterTest{
	
	AgentWebSiteSettingsTable agentWebSiteSettingsTable = null;
	String commID = null;
	String ProfileName = null;
	String profileID = null;
	String fieldname = null;
	String displaystatuscode = null;
	String DBVerificationText = null;
	String dbval = null;
		
	@BeforeMethod(alwaysRun=true)
	public void startTest() throws Exception{
		super.initSupportCenterTest();
		commID = TestDataProvider.getTestData("PWSCommunityID");
		ProfileName = TestDataProvider.getTestData("ProfileName");
		agentWebSiteSettingsTable = new AgentWebSiteSettingsTable(DatabaseServer.COMMON_SERVER);
		profileID = agentWebSiteSettingsTable.getValueByColNameandCommunityID("ID", commID);
		String whereclause = " ID="+profileID;
		dbval = agentWebSiteSettingsTable.getValueByColNameandCommunityID("SETTINGDETAILS", commID, whereclause);
		System.out.println(dbval);
	}
	
	@Parameters( {"TechnicianId", "Password", "CompDefValue", "DepartDefValue", "LocDefValue", "MailStopDefValue", 
				  "CostCenterDefValue", "EmplDefValue",  "PhoneNumDefValue", "ExtnDefValue","CustomLabel", "DefValue"})
	@Test(enabled = true, groups= {"sc","ProfileAndWebSiteSettings", "Default Profile And WebSite Settings"})
	public void testOptionalFields(String TechnicianId, String Password, String CompDefValue, String DepartDefValue, String LocDefValue, String MailStopDefValue, 
			String CostCenterDefValue, String EmplDefValue,  String PhoneNumDefValue, String ExtnDefValue,String CustomLabel, String DefValue) throws Exception{
		supportCenterHomePage = SupportCenterLogin.login(TechnicianId, Password);	
		profileAndWebSiteSettingsPage = SupportCenterNavigation.viewCustomProfileAndWebSiteSettingsConfigPage(commID);
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		profileAndWebSiteSettingsPage.changeStatus("Company", "Read-Only");
		profileAndWebSiteSettingsPage.typeCompanyDefValue(CompDefValue);	
		profileAndWebSiteSettingsPage.changeStatus("Department", "Editable");
		profileAndWebSiteSettingsPage.typeDepartmentDefValue(DepartDefValue);	
		profileAndWebSiteSettingsPage.changeStatus("Location", "Editable");
		profileAndWebSiteSettingsPage.typeLocationDefValue(LocDefValue);	
		profileAndWebSiteSettingsPage.changeStatus("Mail Stop", "Editable");
		profileAndWebSiteSettingsPage.typeMailStopDefValue(MailStopDefValue);
		profileAndWebSiteSettingsPage.changeStatus("Cost Center", "Hidden");
		profileAndWebSiteSettingsPage.typeCostCenterDefValue(CostCenterDefValue);
		profileAndWebSiteSettingsPage.changeStatus("Employee ID", "Read-Only");
		profileAndWebSiteSettingsPage.typeEmployeeDefValue(EmplDefValue);	
		profileAndWebSiteSettingsPage.changeStatus("Phone Number", "Required");
		profileAndWebSiteSettingsPage.typePhoneNumDefValue(PhoneNumDefValue);	
		profileAndWebSiteSettingsPage.changeStatus("Extension", "Required");
		profileAndWebSiteSettingsPage.typeExtnDefValue(ExtnDefValue);	
		profileAndWebSiteSettingsPage.createCustom(CustomLabel, "Required", DefValue);
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		profileAndWebSiteSettingsPage.clickOnFinishBtn();
		profileAndWebSiteSettingsPage = SupportCenterNavigation.viewCustomProfileAndWebSiteSettingsConfigPage(commID);
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		Asserter.assertEquals(profileAndWebSiteSettingsPage.getSelectedPWSLabel("Company"), "Read-Only");
		Asserter.assertEquals(profileAndWebSiteSettingsPage.getSelectedPWSLabel("Department"), "Editable");	
		Asserter.assertEquals(profileAndWebSiteSettingsPage.getSelectedPWSLabel("Location"), "Editable");	
		Asserter.assertEquals(profileAndWebSiteSettingsPage.getSelectedPWSLabel("Mail Stop"), "Editable");
		Asserter.assertEquals(profileAndWebSiteSettingsPage.getSelectedPWSLabel("Cost Center"), "Hidden");
		Asserter.assertEquals(profileAndWebSiteSettingsPage.getSelectedPWSLabel("Employee ID"), "Read-Only");
		Asserter.assertEquals(profileAndWebSiteSettingsPage.getSelectedPWSLabel("Phone Number"), "Required");
		Asserter.assertEquals(profileAndWebSiteSettingsPage.getSelectedPWSLabel("Extension"), "Required");	
		String whereclause = " ID="+profileID;
		dbval = agentWebSiteSettingsTable.getValueByColNameandCommunityID("SETTINGDETAILS", commID, whereclause);
		Asserter.assertEquals(dbval.contains(CompDefValue), true);
		Asserter.assertEquals(dbval.contains(DepartDefValue), true);
		Asserter.assertEquals(dbval.contains(LocDefValue), true);
		Asserter.assertEquals(dbval.contains(MailStopDefValue), true);
		Asserter.assertEquals(dbval.contains(CostCenterDefValue), true);
		Asserter.assertEquals(dbval.contains(EmplDefValue), true);
		Asserter.assertEquals(dbval.contains(PhoneNumDefValue), true);
		Asserter.assertEquals(dbval.contains(ExtnDefValue), true);	
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
