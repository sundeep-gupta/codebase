package com.ironmountain.kanawha.tests.branding;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.openqa.selenium.support.PageFactory;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.connected.supportcenter.pages.ApplyBrandingPage;
import com.ironmountain.connected.supportcenter.pages.ApplyBrandingResultPage;
import com.ironmountain.connected.supportcenter.pages.SCHomePage;
import com.ironmountain.connected.supportcenter.pages.SCLoginPage;
import com.ironmountain.kanawha.commons.CommonUtils;
import com.ironmountain.kanawha.managementapi.apis.GetBrandingInfo;
import com.ironmountain.kanawha.managementapi.apis.Login;
import com.ironmountain.kanawha.tests.KanawhaTest;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CommunityTable;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium.WebDriverPage;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;

public class BrandingUtils extends KanawhaTest{
	private static final Logger logger = Logger.getLogger(BrandingUtils.class.getName());
	CommunityTable community = new CommunityTable(DatabaseServer.COMMON_SERVER);
	
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {

	}
	
	/**
	 * This test method applies branding settings to a given community through support center UI  
	 * @param communityName
	 * @param imagePath
	 * @param siteName
	 * @param poweredByLogo
	 * @throws Exception
	 */
	@Parameters( {"communityName", "imagePath", "siteName", "poweredByLogo"})
	@Test(enabled = true)
	public void applyBranding(String communityName, String imagePath, String siteName, String poweredByLogo) throws Exception {
		String testCommunity = community.getCommunityIDbyCommunityName(communityName);
		WebDriverPage blankPage = new WebDriverPage();
		blankPage = PageFactory.initElements(getDriver(), WebDriverPage.class);
		blankPage.goTo(this.getSupportCenterURL());
		
		logger.info("Login to Support Center");
		SCHomePage homePage = SCLoginPage.login(PropertyPool.getProperty("scadmin"), PropertyPool.getProperty("scpassword"));
		homePage.waitForElementPresent("frame[name='AppBody']", 1, 20);
		
		//open http://10.145.12.133/supportcenter/Detail.asp?type=2&amp;value=3&amp;community=3&amp;menuchoice=313
		logger.info("Open " + PropertyPool.getProperty("scprotocol")+"://"+PropertyPool.getProperty("schost")+"/supportcenter/Detail.asp?type=2&value="+testCommunity+"&community="+testCommunity+"&menuchoice=313");
		homePage.goTo(PropertyPool.getProperty("scprotocol")+"://"+PropertyPool.getProperty("schost")+"/supportcenter/Detail.asp?type=2&value="+testCommunity+"&community="+testCommunity+"&menuchoice=313");
		
		ApplyBrandingPage applyBrandingPage = (ApplyBrandingPage) PageFactory.initElements(getDriver(), ApplyBrandingPage.class);
		applyBrandingPage.switchToDefaultContent();
		logger.info("AppBody present? " + applyBrandingPage.isElementPresent("name:AppBody"));
		if(applyBrandingPage.isElementPresent("name:AppBody")){ applyBrandingPage.switchToFrame("AppBody"); 
			logger.info("NodeView present? " + applyBrandingPage.isElementPresent("name:NodeView"));
			if(applyBrandingPage.isElementPresent("name:NodeView")){ applyBrandingPage.switchToFrame("NodeView"); 
				logger.info("NodeDetails present? " + applyBrandingPage.isElementPresent("name:NodeDetails"));
				if(applyBrandingPage.isElementPresent("name:NodeDetails")){ applyBrandingPage.switchToFrame("NodeDetails"); }
			}
		}
		else {
			logger.info("Selecting AppBody.NodeView.NodeDetails");
			applyBrandingPage.switchToFrame("AppBody.NodeView.NodeDetails");
		}
		applyBrandingPage.waitForPageLoad();
		
		if(poweredByLogo.equals("on")) {
			applyBrandingPage.setPoweredByLogo();
		}
		else {
			applyBrandingPage.unsetPoweredByLogo();
		}
		
		if(siteName.length() > 0) {
			logger.info("Type site name as " + siteName);
			applyBrandingPage.typeSiteName(siteName);
		}
		
		if(imagePath.length() > 0) {
			logger.info("Type image path as " + imagePath);
			applyBrandingPage.typeSiteHeaderImagePath(imagePath);
		}
		
		logger.info("Click Apply");
		applyBrandingPage.clickApply();
		
		ApplyBrandingResultPage applyBrandingResultPage = (ApplyBrandingResultPage) PageFactory.initElements(getDriver(), ApplyBrandingResultPage.class);
		Thread.sleep(5000);
		applyBrandingResultPage.switchToDefaultContent();
		logger.info("AppBody present? " + applyBrandingPage.isElementPresent("name:AppBody"));
		if(applyBrandingPage.isElementPresent("name:AppBody")){ 
			applyBrandingPage.switchToFrame("AppBody"); 
			logger.info("NodeView present? " + applyBrandingPage.isElementPresent("name:NodeView"));
			if(applyBrandingPage.isElementPresent("name:NodeView")){ 
				applyBrandingPage.switchToFrame("NodeView");
			}
		}
		else{
			logger.info("Selecting AppBody.NodeView");
			applyBrandingResultPage.switchToFrame("AppBody.NodeView");
		}
		/*applyBrandingResultPage.switchToFrame("NodeDetails");*/
		applyBrandingResultPage.waitForPageLoad();
		
		/*applyBrandingResultPage.switchToDefaultContent();
		logger.info("AppBody present? " + applyBrandingPage.isElementPresent("name:AppBody"));
		if(applyBrandingPage.isElementPresent("name:AppBody")){ 
			applyBrandingPage.switchToFrame("AppBody"); 
			logger.info("NodeView present? " + applyBrandingPage.isElementPresent("name:NodeView"));
			if(applyBrandingPage.isElementPresent("name:NodeView")){ 
				applyBrandingPage.switchToFrame("NodeView");
			}
		}
		else{
			logger.info("Selecting AppBody.NodeView");
			applyBrandingResultPage.switchToFrame("AppBody.NodeView");
		}*/
		
		/*logger.info("Verify Apply Branding Result Message");
		Assert.assertEquals(applyBrandingResultPage.getApplyBrandingResultMessage(),"Community Successfully Branded. New branding settings were applied to the community. Any subcommunities without customized branding will use this community's branding. The dctomcat service can now be restarted to see any changes to Account Management branding, otherwise branding changes will refresh automatically in five minutes.","Issue with Apply Branding");*/
		applyBrandingResultPage.switchToDefaultContent();
		
		logger.info("Logoff from Support Center");
		applyBrandingResultPage.goTo(this.getSupportCenterLogoutURL());
		logger.info("Completed Apply Branding");
		
	}

	/**
	 * This test method resets branding settings for a given community through Support Center UI. Exits silently if branding is already reset.
	 * @param communityName
	 * @throws Exception
	 */
	@Parameters( {"communityName"})
	@Test(enabled = true)
	public void resetBranding(String communityName) throws Exception {
		String testCommunity = community.getCommunityIDbyCommunityName(communityName);
		WebDriverPage blankPage = new WebDriverPage();
		blankPage = PageFactory.initElements(getDriver(), WebDriverPage.class);
		String baseWindow = blankPage.getWindowHandle();
		blankPage.goTo(this.getSupportCenterURL());
		SCHomePage homePage = SCLoginPage.login(PropertyPool.getProperty("scadmin"), PropertyPool.getProperty("scpassword"));
		
		homePage.waitForElementPresent("xpath://frame[name='AppBody']", 1, 20);
		logger.info("win = " + homePage.getWindowHandle());
		//open http://10.145.12.133/supportcenter/Detail.asp?type=2&amp;value=3&amp;community=3&amp;menuchoice=313
		logger.info("Open " + PropertyPool.getProperty("scprotocol")+"://"+PropertyPool.getProperty("schost")+"/supportcenter/Detail.asp?type=2&value="+testCommunity+"&community="+testCommunity+"&menuchoice=313");
		homePage.goTo(PropertyPool.getProperty("scprotocol")+"://"+PropertyPool.getProperty("schost")+"/supportcenter/Detail.asp?type=2&value="+testCommunity+"&community="+testCommunity+"&menuchoice=313");
		ApplyBrandingPage applyBrandingPage = (ApplyBrandingPage) PageFactory.initElements(getDriver(), ApplyBrandingPage.class);
		logger.info("win = " + applyBrandingPage.getWindowHandle());
		applyBrandingPage.switchToWindow(baseWindow);
		//applyBrandingPage.switchToDefaultContent();
		applyBrandingPage.switchToActiveElement();
		logger.info("AppBody present? " + applyBrandingPage.isElementPresent("name:AppBody"));
		if(applyBrandingPage.isElementPresent("name:AppBody")){ applyBrandingPage.switchToFrame("AppBody"); 
			logger.info("NodeView present? " + applyBrandingPage.isElementPresent("name:NodeView"));
			if(applyBrandingPage.isElementPresent("name:NodeView")){ applyBrandingPage.switchToFrame("NodeView"); 
				logger.info("NodeDetails present? " + applyBrandingPage.isElementPresent("name:NodeDetails"));
				if(applyBrandingPage.isElementPresent("name:NodeDetails")){ applyBrandingPage.switchToFrame("NodeDetails"); }
			}
		}
		else {
			logger.info("Selecting AppBody.NodeView.NodeDetails");
			applyBrandingPage.switchToFrame("AppBody.NodeView.NodeDetails");
		}
		//applyBrandingPage.switchToFrame("NodeView.NodeDetails");
		applyBrandingPage.waitForPageLoad();
		
		//applyBrandingPage.typeSiteHeaderImagePath(imagePath);
		//applyBrandingPage.switchToDefaultContent();
		if(applyBrandingPage.getResetButtonStatus()) {
		 
			logger.info("Click Reset Branding");
			applyBrandingPage.clickResetBranding();

			ApplyBrandingResultPage applyBrandingResultPage = (ApplyBrandingResultPage) PageFactory.initElements(getDriver(), ApplyBrandingResultPage.class);
			Thread.sleep(5000);
			applyBrandingResultPage.switchToDefaultContent();
			logger.info("AppBody present? " + applyBrandingPage.isElementPresent("name:AppBody"));
			if(applyBrandingPage.isElementPresent("name:AppBody")){ 
				applyBrandingPage.switchToFrame("AppBody"); 
				logger.info("NodeView present? " + applyBrandingPage.isElementPresent("name:NodeView"));
				if(applyBrandingPage.isElementPresent("name:NodeView")){ 
					applyBrandingPage.switchToFrame("NodeView");
				}
			}
			else{
				logger.info("Selecting AppBody.NodeView");
				applyBrandingResultPage.switchToFrame("AppBody.NodeView");
			}
			applyBrandingResultPage.waitForPageLoad();
			
			/*applyBrandingResultPage.switchToDefaultContent();
			logger.info("AppBody present? " + applyBrandingPage.isElementPresent("name:AppBody"));
			if(applyBrandingPage.isElementPresent("name:AppBody")){ 
				applyBrandingPage.switchToFrame("AppBody"); 
				logger.info("NodeView present? " + applyBrandingPage.isElementPresent("name:NodeView"));
				if(applyBrandingPage.isElementPresent("name:NodeView")){ 
					applyBrandingPage.switchToFrame("NodeView");
				}
			}
			else{
				logger.info("Selecting AppBody.NodeView");
				applyBrandingResultPage.switchToFrame("AppBody.NodeView");
			}*/
			
			/*logger.info("Verify Reset Branding Result Message");
			Assert.assertEquals(applyBrandingResultPage.getResetBrandingResultMessage(),"The community's branding was reset to the default. Any subcommunities without customized branding will use the default branding. The Apache DCTomcat service can now be restarted to see changes reflected in the Account Management WebSite settings, otherwise branding changes will refresh automatically in five minutes.","Issue with Apply Branding");*/
			applyBrandingResultPage.switchToDefaultContent();
			logger.info("Logoff from Support Center");
			applyBrandingResultPage.goTo(this.getSupportCenterLogoutURL());
		}
		else {
			logger.info("Logoff from Support Center");
			applyBrandingPage.switchToDefaultContent();
			applyBrandingPage.goTo(this.getSupportCenterLogoutURL());
		}
		
		logger.info("Completed testResetBranding Test");
	}

	/**
	 * This method executes getbrandinginfo API and validates its response against the given inputs
	 * @param username
	 * @param password
	 * @param brandImage
	 * @param siteName
	 * @param powerdByLogo
	 * @throws Exception
	 */
	public void verifyBrandingInfo(String username, String password, String brandImage, String siteName, String powerdByLogo) throws Exception {
		String jsonContent = Login.login(username, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//long modifiedDate = System.currentTimeMillis()/1000;
		jsonContent = GetBrandingInfo.getBrandingInfo(username, password, ""+CommonUtils.getAccountNumber(username));
		verifyBrandingResponse(jsonContent, brandImage, siteName, powerdByLogo);
	}
	
	/**
	 * This method constructs a json object from a response string and compares its properties with the given inputs. 
	 * @param responseString
	 * @param brandImage
	 * @param mgmtSiteName
	 * @param poweredByLogo
	 * @throws Exception
	 */
	public void verifyBrandingResponse(String responseString, String brandImage, String mgmtSiteName, String poweredByLogo) throws Exception {
		//{"BrandImage":null,"MgmtSiteName":null,"PowerdByLogo":null}
		logger.info("Verify response: " + responseString);
		JSONObject responseObject = new JSONObject(responseString);
		String regex = "[\\\\]";
		
		if(mgmtSiteName == null) {
			if(responseObject.get("MgmtSiteName").equals(null)) {
				logger.info("Site Name is null as expected.");//Doing this because AssertNull is not working!
			}
			else {
				throw new Exception(responseObject.get("MgmtSiteName") + " not matching " + mgmtSiteName);
			}
			
		}else {
			Assert.assertEquals(responseObject.get("MgmtSiteName").toString(), mgmtSiteName,"Invalid site header text found");
		}
		if(brandImage == null) {
			if(responseObject.get("BrandImage").equals(null)) {
				logger.info("brandImage is null as expected.");//Doing this because AssertNull is not working!
			}
			else {
				throw new Exception(responseObject.get("BrandImage") + " not matching " + brandImage);
			}
			
		}else {
			logger.info(responseObject.getString("BrandImage").compareTo(brandImage));
			compareImageBuffers(responseObject.get("BrandImage").toString(), brandImage.replaceAll(regex, ""));
			//Assert.assertEquals(responseObject.get("BrandImage").toString(), brandImage, "Unexpected Brand Image Received");
		}
		if(poweredByLogo == null) {
			if(responseObject.get("PoweredByLogo").equals(null)) {
				logger.info("poweredByLogo is null as expected.");//Doing this because AssertNull is not working!
			}
			else {
				throw new Exception(responseObject.get("PoweredByLogo") + " not matching " + poweredByLogo);
			}
			
		}else {
			compareImageBuffers(responseObject.get("PoweredByLogo").toString(),poweredByLogo.replaceAll(regex, ""));
			//Assert.assertEquals(responseObject.get("PowerdByLogo").toString(), powerdByLogo,"Invalid powerdByLogo buffer found");
		}
	}
	
	public String getSupportCenterURL() {
		return PropertyPool.getProperty("scprotocol") + "://" + PropertyPool.getProperty("schost") + "/supportcenter/login.asp";
	}
	
	public String getSupportCenterLogoutURL() {
		//http://10.145.12.133/supportcenter/default.asp?type=12&value=&community=&menuchoice=&2=logout
		return PropertyPool.getProperty("scprotocol") + "://" + PropertyPool.getProperty("schost") + "/supportcenter/default.asp?type=12&value=&community=&menuchoice=&2=logout";
	}
	
	/**
	 * This method compares two given image buffers character by character
	 * @param respBuffer
	 * @param expBuffer
	 * @throws Exception
	 */
	private void compareImageBuffers(String respBuffer, String expBuffer) throws Exception {
		logger.info("respBrandImageBuffer.length()="+respBuffer.length() +" expBrandImageBuffer.length()="+expBuffer.length());
		Assert.assertEquals(respBuffer.length(), expBuffer.length());
		for(int i = 0 ; i < respBuffer.length() ; i++) {
			Assert.assertEquals(respBuffer.charAt(i), expBuffer.charAt(i), "Character mismatch at index "+i);
		}
	}
	
	@AfterMethod(alwaysRun= true)
	public void stopTest() throws Exception {

	}
	@AfterSuite(alwaysRun = true)
	public void stopSuite() throws Exception {

	}

}


