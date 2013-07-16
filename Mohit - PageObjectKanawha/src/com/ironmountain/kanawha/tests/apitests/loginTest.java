package com.ironmountain.kanawha.tests.apitests;


import org.apache.log4j.Logger;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.kanawha.managementapi.apis.Login;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpJsonAppTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;

public class loginTest extends HttpJsonAppTest{
	
	public static final Logger logger = Logger.getLogger(Login.class.getName());
	
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		super.inithttpTest();
	}
	
	@Parameters({"username", "password"})
	@Test(enabled = true)
	public void testLogin(String username,String password) throws Exception{
		logger.info("Starting test: testLogin");
		String jsoncontent = Login.login(username, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsoncontent);
		JSONAsserter.assertJSONObjects(jsoncontent, "AuthResult", "1");
	}
	
	@AfterMethod(alwaysRun= true)
	public void stopTest() throws Exception {
		super.stophttpTest();
	}

}
