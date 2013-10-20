package com.ironmountain.kanawha.tests.apitests;

import java.util.HashMap;

import org.apache.log4j.Logger;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.kanawha.managementapi.apis.GetDynamicSubTree;
import com.ironmountain.kanawha.managementapi.apis.Login;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpJsonAppTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;

public class GetDynamicSubTreeTest extends HttpJsonAppTest{
	private static final Logger logger = Logger.getLogger(GetDynamicSubTreeTest.class.getName());
	private static HashMap<String, String> testInput = new HashMap<String,String>();
	private static HashMap<String, String> testOutput = new HashMap<String,String>();
	
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		super.inithttpTest();
		logger.info("loadTestDataXML");
		TestDataProvider.loadTestDataXML(FileUtils.getBaseDirectory()+"/src/com/ironmountain/kanawha/tests/apitests/testdata", "GetDynamicSubTree.xml");
	}
	
	@Parameters({"username", "password","accountnumber","dynamicbackupdate"})
	@Test(enabled = true)
	public void testGetDynamicSubTree(String username,String password,String accountnumber,String dynamicbackupdate) throws Exception{
		logger.info("username="+username+" password="+password+" accountnumber="+accountnumber+" dynamicbackupdate="+dynamicbackupdate);
		testInput = TestDataProvider.getTestInput("testGetDynamicSubTree");
		testOutput = TestDataProvider.getTestOutput("testGetDynamicSubTree");
		logger.info("My username="+testInput.get("username"));
		logger.info("My volumeslist="+testOutput.get("volumeslist"));

		String jsonContent = Login.login(username, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");

		jsonContent = GetDynamicSubTree.getDynamicSubTree(username, password, accountnumber, dynamicbackupdate, "VolumesList", "");
		jsonContent = GetDynamicSubTree.getDynamicSubTree(username, password, accountnumber, dynamicbackupdate, "FoldersList", "C:\\");
		jsonContent = GetDynamicSubTree.getDynamicSubTree(username, password, accountnumber, dynamicbackupdate, "FileList", "C:\\\\");
		
		//JSONAsserter.assertJSONObjects(jsonContent, "NetworkDeviceList/0/AccountNumber", "101000001");
		//JSONAsserter.assertJSONObjects(jsonContent, "NetworkDeviceList/0/NetworkDeviceName", "NEWXPAUTO");
	}
	
	
	@AfterMethod(alwaysRun= true)
	public void stopTest() throws Exception {
		testInput = null;
		super.stophttpTest();
	}

}
