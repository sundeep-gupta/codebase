package com.ironmountain.kanawha.tests.apitests;

import org.apache.log4j.Logger;
import org.json.JSONException;
import org.json.JSONObject;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.connected.supportcenter.tests.accounts.AccountStatusChangeTest;
import com.ironmountain.kanawha.commons.CommonUtils;
import com.ironmountain.kanawha.managementapi.apis.GetBrandingInfo;
import com.ironmountain.kanawha.managementapi.apis.Login;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CommunityTable;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpJsonAppTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;

public class GetBrandingInfoTest extends HttpJsonAppTest{
	private static final Logger logger = Logger.getLogger(GetBrandingInfoTest.class.getName());
	CommunityTable community = new CommunityTable(DatabaseServer.COMMON_SERVER);
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		super.inithttpTest();
	}
	
	@Parameters({"username", "password"})
	@Test(enabled = true)
	public void testGetBrandingInfo(String username,String password) throws Exception{
		String jsonContent = Login.login(username, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		long modifiedDate = System.currentTimeMillis()/1000;
		jsonContent = GetBrandingInfo.getBrandingInfo(username, password, ""+CommonUtils.getAccountNumber(username));
		/*verifyBrandingResponse(jsonContent, community.getCommunityIDbyCommunityName("sprint15"), null, true, null);
		Thread.sleep(30000);
		jsonContent = GetBrandingInfo.getBrandingInfo(username, password, "?0");
		verifyBrandingResponse(jsonContent, community.getCommunityIDbyCommunityName("sprint15"), null, true, null);
		Thread.sleep(30000);
		jsonContent = GetBrandingInfo.getBrandingInfo(username, password, "?"+modifiedDate);
		verifyBrandingResponse(jsonContent, community.getCommunityIDbyCommunityName("sprint15"), null, true, null);*/
	}
	
	private void verifyBrandingResponse(String responseString, String comId, String image, Boolean imageAvailable, String imagePath) throws SecurityException, IllegalArgumentException, NoSuchFieldException, IllegalAccessException, JSONException {
		//{"CommunityId":3,"Image":null,"MgmtSiteName":"Kanawha Account Management","bImageAvailable":false,"bPoweredByFlag":true}
		logger.info("Verify response: " + responseString);
		//JSONAsserter.assertJSONObjects(responseString, "communityid", community.getCommunityIDbyCommunityName("sprint15"));
		JSONObject responseObject = new JSONObject(responseString);
		logger.info("communityid="+responseObject.get("CommunityId"));
		Assert.assertEquals(responseObject.get("CommunityId").toString(), comId , "Invalid Community ID. Is it the same community that was branded?");
		//logger.info("image="+responseObject.get("image"));
		logger.info("imageAvailable="+responseObject.get("imageAvailable"));
		Assert.assertEquals(responseObject.get("imageAvailable"), imageAvailable, "Invalid image availability status");
		//logger.info("imagePath="+responseObject.get("imagePath"));
	}

	@AfterMethod(alwaysRun= true)
	public void stopTest() throws Exception {
		super.stophttpTest();
	}

}
