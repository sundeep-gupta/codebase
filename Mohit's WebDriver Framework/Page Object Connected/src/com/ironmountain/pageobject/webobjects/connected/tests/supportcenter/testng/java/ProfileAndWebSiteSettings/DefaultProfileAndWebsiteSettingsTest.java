package com.ironmountain.pageobject.webobjects.connected.tests.supportcenter.testng.java.ProfileAndWebSiteSettings;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.CreateCustomCommunity;
import com.ironmountain.pageobject.webobjects.connected.actions.supportcenter.SupportCenterLogin;
import com.ironmountain.pageobject.webobjects.connected.database.registry.AgentWebSiteSettingsTable;
import com.ironmountain.pageobject.webobjects.connected.database.registry.CommunityTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.supportcenter.SupportCenterNavigation;
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;

@SeleniumUITest(priority=1)
public class DefaultProfileAndWebsiteSettingsTest extends SupportCenterTest{
	
	AgentWebSiteSettingsTable agentWebSiteSettingsTable = new AgentWebSiteSettingsTable(DatabaseServer.COMMON_SERVER);
	String profilePageText = null;
	String commID = null;
	String supportInfo = "<p>You can contact Support using one of the following methods:</p>"
        +"\n<ul>www.ironmountain.com"
        +"\n<li>Email: tester@ironmountain.com</li>"
        +"\n<li>Phone: 508-123-1234</li>"
        +"\n</ul>"
        +"\n<p>Technical Support representatives are available to help you Monday through Friday, 08:30 AM to 05:30 PM.</p>";
	String supportInfoVerificationText = "Technical Support representatives are available to help you Monday through Friday, 08:30 AM to 05:30 PM.";	
	
	
	@BeforeMethod(alwaysRun=true)
	public void startTest() throws Exception{
		super.initSupportCenterTest();
	}
	
	@Parameters( {"TechnicianId", "Password"})
	@Test(enabled = true, groups= {"sc","ProfileAndWebSiteSettings", "Default Profile And WebSite Settings"})
	public void testAllFields(String TechnicianId, String Password) throws Exception{
		supportCenterHomePage = SupportCenterLogin.login(TechnicianId, Password);
		Asserter.assertEquals(supportCenterHomePage.verifyTitle(), true);
		profileAndWebSiteSettingsPage = SupportCenterNavigation.viewDefaultProfileAndWebSiteSettingsConfigPage();
		verifyEditableFields();
		profileAndWebSiteSettingsPage = SupportCenterNavigation.viewDefaultProfileAndWebSiteSettingsConfigPage();
		profileAndWebSiteSettingsPage.typeSupportInfo(supportInfo);
		supportCenterHomePage = profileAndWebSiteSettingsPage.clickOnFinishBtn();
		commID = CreateCustomCommunity.createCommunityAction();
		TestDataProvider.setTestDataToXmlFile(TEST_DATA_XML_FILE, "PWSCommunityID", commID);
		commID = TestDataProvider.getTestData("PWSCommunityID");
		profileAndWebSiteSettingsPage = SupportCenterNavigation.viewDefaultProfileAndWebSiteSettingsConfigPage(commID);
		profileAndWebSiteSettingsPage.selectAppBodyNodeViewNodeDetailsFrame();
		Asserter.assertEquals(profileAndWebSiteSettingsPage.isTextPresent(supportInfo), true);
	}
	
	public void verifyEditableFields(){
		supportCenterHomePage.selectAppBodyNodeViewNodeDetailsFrame();
		profilePageText = supportCenterHomePage.getLocator("SupportCenterPage.EditProfileAndWebsitePageText");
		Asserter.assertEquals(profileAndWebSiteSettingsPage.isTextPresent(profilePageText), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyNameEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyDescriptionEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifySupportInfoEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyDefaultURLEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyCustomURLEditable(), true);
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyAddressStateEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyCountryEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyAddLine1Editable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyAddLine2Editable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyAddLine3Editable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyCityEditable(), true);
		//Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyStateEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyPostalCodeEditable(), true);
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyCompanyStatusEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyCompanyDefEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyDepartmentStatusEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyDepartmentDefEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyLocationStatusEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyLocationDefEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyMailStopStatusEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyMailStopDefEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyCostCenterStatusEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyCostCenterDefEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyEmployeeStatusEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyEmployeeDefEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyPhoneNumStatusEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyPhoneNumDefEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyExtnStatusEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyExtnDefEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyCustomStatusEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyCustomDefEditable(), true);
		profileAndWebSiteSettingsPage.clickOnNextBtn();
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyAgentMenuOptionEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyPermitUserAsianOptionEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyAllowEditProfOptionEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyRequireAuthenOptionEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyProhibitDownloadOptionEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyShowServiceLicenseOptionEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyAllowOrderMediaOptionEditable(), true);
		Asserter.assertEquals(profileAndWebSiteSettingsPage.verifyAllowRetrieveFilesOptionEditable(), true);
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
