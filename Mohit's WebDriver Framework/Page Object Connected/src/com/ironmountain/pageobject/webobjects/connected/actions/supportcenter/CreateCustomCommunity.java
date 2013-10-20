package com.ironmountain.pageobject.webobjects.connected.actions.supportcenter;

import java.sql.SQLException;

import org.testng.Reporter;

import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.PageFactory;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.webobjects.connected.database.registry.CommunityTable;
import com.ironmountain.pageobject.webobjects.connected.navigations.supportcenter.SupportCenterNavigation;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.AddCommunityPage;
import com.ironmountain.pageobject.webobjects.connected.pages.supportcenter.SupportCenterHomePage;
import com.ironmountain.pageobject.webobjects.connected.tests.SupportCenterTest;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;

/** Support Center Actions Class
 * @author pjames
 *
 */
public class CreateCustomCommunity {
	
	static AddCommunityPage addCommunityPage = (AddCommunityPage) PageFactory.getNewPage(AddCommunityPage.class);
	static SupportCenterHomePage supportCenterHomePage = (SupportCenterHomePage) PageFactory.getNewPage(SupportCenterHomePage.class);
	static CommunityTable communityTable = new CommunityTable(DatabaseServer.COMMON_SERVER);
	
	/** Method to create a community
	 * @param CommnunityName
	 * @return
	 * @throws SQLException 
	 */
	public static String createCommunity(String CommunityName) throws SQLException{
		String commID = null;
		addCommunityPage.typeCommunityName(CommunityName);
		addCommunityPage.clickOnSaveBtn();
		addCommunityPage.waitForSeconds(30);
		//addCommunityPage.selectWinNodeHeader();
		commID = supportCenterHomePage.getCommunityID(CommunityName);
		addCommunityPage.clickOnHistoryLink();
		addCommunityPage.selectRelativeUpFrame();
		addCommunityPage.selectRelativeUpFrame();
		addCommunityPage.selectRelativeUpFrame();
		return commID;
	}
	
	/**Create a subcommunity under the custom community.
	 * @param CommunityName
	 * @return
	 * @throws SQLException 
	 */
	public static String createSubCommunity(String CommunityName) throws SQLException{
		String commID = null;
		addCommunityPage.typeCommunityName(CommunityName);
		addCommunityPage.clickOnSubCommunitySaveBtn();
		addCommunityPage.waitForSeconds(30);
		commID = supportCenterHomePage.getCommunityID(CommunityName);
		addCommunityPage.clickOnHistoryLink();
		addCommunityPage.selectRelativeUpFrame();
		addCommunityPage.selectRelativeUpFrame();
		addCommunityPage.selectRelativeUpFrame();
		return commID;
	}
	
	public static String createCommunityAction() throws Exception{
		String commID = null;
		String comName = StringUtils.createNameVal();
		TestDataProvider.setTestDataToXmlFile(SupportCenterTest.TEST_DATA_XML_FILE, "CommunityName", comName);
		Reporter.log("Navigate to Default Community Page");
		supportCenterHomePage = SupportCenterNavigation.viewDefaultCommunityPage();
		supportCenterHomePage.clickOnToolsLink();
		supportCenterHomePage.selectRelativeUpFrame();
		addCommunityPage = supportCenterHomePage.clickOnAddCommunityLink();
		addCommunityPage.typeCommunityName(comName);
		supportCenterHomePage = addCommunityPage.clickOnSaveBtn();
		commID = supportCenterHomePage.getCommunityID(comName);
		System.out.println(commID);
		//addCommunityPage.clickOnHistoryLink();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		supportCenterHomePage.selectRelativeUpFrame();
		return commID;
	}
	
	
	public static String createSubCommunityUnderParentCommunity(String TechnicianId, String Password, String CommunityID) throws Exception{
		String CommunityName = "Sub Branding " + StringUtils.createNameVal();
		Reporter.log("Login to SupportCenter");
		supportCenterHomePage = SupportCenterLogin.login(TechnicianId, Password);	
		Asserter.assertEquals(supportCenterHomePage.verifyTitle(), true);
		Reporter.log("Navigating to Default Community Page");
		supportCenterHomePage = SupportCenterNavigation.viewDefaultCommunityPage();
		Reporter.log("Navigating to Parent Community Page");
		SupportCenterNavigation.viewCustomCommunityPage(CommunityID);
		Reporter.log("Navigating to Default Community Page");
		supportCenterHomePage.clickOnToolsLink();
		supportCenterHomePage.selectRelativeUpFrame();
		addCommunityPage = supportCenterHomePage.clickOnAddSubCommunityLink();
		String commID = CreateCustomCommunity.createSubCommunity(CommunityName); 
		return commID;
	}
	
	public static String createCommunityUnderCommunity(String TechnicianId, String Password, String SubCommID) throws Exception{
		String CommunityName = "Sub Branding " + StringUtils.createNameVal();
		supportCenterHomePage = SupportCenterNavigation.viewDefaultCommunityPage();
		Reporter.log("Navigating to Parent Community Page");
		SupportCenterNavigation.viewCustomCommunityPage(SubCommID);
		Reporter.log("Navigating to Default Community Page");
		supportCenterHomePage.clickOnToolsLink();
		supportCenterHomePage.selectRelativeUpFrame();
		addCommunityPage = supportCenterHomePage.clickOnAddSubCommunityLink();
		String commID = CreateCustomCommunity.createSubCommunity(CommunityName); 
		return commID;
	}
	
}
