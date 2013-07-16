package com.ironmountain.kanawha.tests.apitests;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.kanawha.managementapi.apis.GetDevices;
import com.ironmountain.kanawha.managementapi.apis.Login;
import com.ironmountain.kanawha.commons.*;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.AccountProfileTable;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CustomerTable;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpJsonAppTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;

public class GetDevicesTest extends HttpJsonAppTest{
	
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		super.inithttpTest();
	}
	
	@Parameters({"username", "password"})
	@Test(enabled = true)
	public void testGetDevices(String username,String password) throws Exception{
		String jsonContent = Login.login(username, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		jsonContent = GetDevices.getDevices(username, password);
		int accountNumber = CommonUtils.getAccountNumber(username);
		String deviceName = CommonUtils.getDeviceName(username);
		JSONAsserter.assertJSONObjects(jsonContent, "NetworkDeviceList/0/AccountNumber", ""+accountNumber);
		JSONAsserter.assertJSONObjects(jsonContent, "NetworkDeviceList/0/NetworkDeviceName", deviceName);
	}
	
	@AfterMethod(alwaysRun= true)
	public void stopTest() throws Exception {
		super.stophttpTest();
	}

}
