package com.ironmountain.kanawha.tests.apitests;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.log4j.Logger;
import org.hamcrest.text.pattern.Parse;
import org.json.JSONObject;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.AfterSuite;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import com.ironmountain.kanawha.commons.CommonUtils;
import com.ironmountain.kanawha.managementapi.apis.ChangeLogonInfo;
import com.ironmountain.kanawha.managementapi.apis.GetRetrievalSetDownload;
import com.ironmountain.kanawha.managementapi.apis.Login;
import com.ironmountain.pageobject.pageobjectrunner.framework.Asserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpJsonAppTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONConverter;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;

/** Change Password Tests
 * @author pjames
 *
 */
public class ChangeLogonInfoTest extends HttpJsonAppTest{
	
	int accountNumber = 0;
	String jsonContent;
	private static final Logger logger = Logger.getLogger(ChangeLogonInfoTest.class.getName());
	private static HashMap<String, String> testInput = new HashMap<String,String>();
	//private static HashMap<String, String> testOutput = new HashMap<String,String>();
	Boolean caseSensitive = null;
	String userName,password,accountNumberString,searchFileName,path,startBackupDate,includeSubFolders,newpassword,revision,fileName,BackupDate,newEmailID = null;
	String PRIMARY_SQLSERVER_NAME = PropertyPool.getProperty("PrimaryDataCenterRegistryMachineName");
	String DATA_FILE_PATH = FileUtils.getBaseDirectory()+"/src/com/ironmountain/kanawha/tests/apitests/testdata/" ;
	String DATA_FILE_NAME = "ChangePasswordTest.xml" ;
	
				
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		super.inithttpTest();
		TestDataProvider.loadTestDataXML(DATA_FILE_PATH, DATA_FILE_NAME);	
	}
	
	//Validate Single account change password and relogin
	@Test(enabled = true)
	public void testSingleAccChangePassword() throws Exception{
		logger.info("Start Change Password Sanity Test");
		//Getting test user name from test data provider
		testInput = TestDataProvider.getTestInput("SingleAccountTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		newpassword = StringUtils.createStrongPasswordString();
		System.out.println("newpassword = "+ newpassword);
		logger.info("Calling the login API" );
		//Calling the login API
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Calling the change password API
		jsonContent = ChangeLogonInfo.setAccountPassword(userName, password, newpassword);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		//Calling the Login API after change password
		jsonContent = Login.login(userName, newpassword);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Reseting the password
		logger.info("Resetting the password");
		jsonContent = ChangeLogonInfo.setAccountPassword(userName, newpassword, password);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		logger.info("End of test");
	}
	
	//Validate change password and retrieve using the new password.
	@Test(enabled = true)
	public void testChangePasswordAndRetrieve() throws Exception{
		logger.info("Start Change Password and Retrieve Test");
		//Getting test user name from test data provider
		testInput = TestDataProvider.getTestInput("ChangePasswordAndRetrieveTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		String noOfFiles = testInput.get("noOfFiles");
		int noOfFilesInt = Integer.parseInt(noOfFiles);
		String[] templist = new String[noOfFilesInt];
		HashMap<String,String> pathFileHashMap = new HashMap<String,String>();
		ArrayList<HashMap<String,String>> listOfHashMaps = new ArrayList<HashMap<String,String>>();
		path = testInput.get("path");
		fileName = testInput.get("fileName");
		

		//Generating the password string dynamically
		newpassword = StringUtils.createStrongPasswordString();
		logger.info("NewPassword = "+ newpassword);
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(userName);
		accountNumberString = Integer.toString(accountNumber);	
		//Calling the login API
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Calling the change password API
		jsonContent = ChangeLogonInfo.setAccountPassword(userName, password, newpassword);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		//Calling the Search and Retrieve API after change password
		templist[0]= "2011-04-26T08:33:59Z";
		pathFileHashMap.put(path,fileName);
		listOfHashMaps.add(pathFileHashMap);		
		jsonContent= GetRetrievalSetDownload.getRetrievalSet("Most%20Recent", userName, newpassword, accountNumberString, listOfHashMaps, templist, noOfFilesInt);
		JSONObject response = new JSONObject(jsonContent);	
		Assert.assertEquals(response.get("success"), "true", "Unable to retrieve " + fileName);
		//Getting test user name from test data provider
		testInput = TestDataProvider.getTestInput("ChangePasswordAndRetrieveTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		logger.info(response.get("downloadUrl").toString()+"\n"+path);

		//Reset the password.
		logger.info("Resetting the password");
		jsonContent = ChangeLogonInfo.setAccountPassword(userName, newpassword, password);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		logger.info("End of test");
	}
	
	//Validate change password as On hold acc.
	@Test(enabled = true)
	public void testOnHoldAccChangePassword() throws Exception{
		logger.info("Start Change Password for on hold account Test");
		//Getting test user name from test data provider
		testInput = TestDataProvider.getTestInput("OnHoldChangePasswordTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		//Generating the password string dynamically
		newpassword = StringUtils.createStrongPasswordString();
		logger.info("NewPassword = "+ newpassword);
		//Calling the login API
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Calling the change password API
		jsonContent = ChangeLogonInfo.setAccountPassword(userName, password, newpassword);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		//Calling the Login API after change password
		jsonContent = Login.login(userName, newpassword);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Reset the password.
		logger.info("Resetting the password");
		jsonContent = ChangeLogonInfo.setAccountPassword(userName, newpassword, password);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		logger.info("End of test");
	}
	
	//Validate change password as multiple account user.
	@Test(enabled = true)
	public void testMultiAccChangePassword() throws Exception{
		logger.info("Start Change Password for on multiple account Test");
		//Getting test user name from test data provider
		testInput = TestDataProvider.getTestInput("MultipleAccountTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		//Generating the password string dynamically
		newpassword = StringUtils.createStrongPasswordString();
		logger.info("NewPassword = "+ newpassword);
		//Calling the login API
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Calling the change password API
		jsonContent = ChangeLogonInfo.setAccountPassword(userName, password, newpassword);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		//Calling the Login API after change password
		jsonContent = Login.login(userName, newpassword);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Reset the password.
		logger.info("Resetting the password");
		jsonContent = ChangeLogonInfo.setAccountPassword(userName, newpassword, password);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		logger.info("End of test");
	}
	
	//Submit change password without new password.
	/*@Test(enabled = true)
	public void testChangePasswordWoNewPassword() throws Exception{
		logger.info("Submit change password without new password Test");
		//Getting test user name from test data provider
		testInput = TestDataProvider.getTestInput("ChangePasswordWithNullNewPasswordTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		try {
		//Generating the password string dynamically
		newpassword = null;
		logger.info("NewPassword = "+ newpassword);
		//Calling the login API
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Calling the change password API
		jsonContent = ChangeLogonInfo.setAccountPassword(userName, password, newpassword);
		JSONAsserter.assertJSONSuccessObjectFalse(jsonContent);
		}
		catch (Exception e){
			if (e.toString().contains("")){
				logger.info("");
			}
		}
		logger.info("End of test");
	}*/
	
	//Submit change password without old password.
	@Test(enabled = true)
	public void testChangePasswordWoOldPassword() throws Exception{
		logger.info("Submit change password without old password Test");
		//Getting test user name from test data provider
		testInput = TestDataProvider.getTestInput("ChangePasswordWoOldPasswordTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		//Generating the password string dynamically
		newpassword = StringUtils.createStrongPasswordString();
		logger.info("NewPassword = "+ newpassword);
		//Calling the login API
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Calling the change password API
		jsonContent = ChangeLogonInfo.setAccountPassword(userName, null, newpassword);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusDescription", "Bad Request.");
		logger.info("End of test");
	}
	
	//Submit change password with same password as old password but with case sensitive password
	@Test(enabled = true)
	public void testChangePasswordOnCaseSensitivity() throws Exception{
		logger.info("Submit change password with same password as old password but with case sensitive password Test");
		//Getting test user name from test data provider
		testInput = TestDataProvider.getTestInput("ChangePasswordOnCaseSensitivityTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		newpassword = testInput.get("newpassword");
		logger.info("NewPassword = "+ newpassword);
		//Calling the login API
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Calling the change password API
		jsonContent = ChangeLogonInfo.setAccountPassword(userName, password, newpassword);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		//Calling the Login API after change password
		jsonContent = Login.login(userName, newpassword);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Reset the password.
		logger.info("Resetting the password");
		jsonContent = ChangeLogonInfo.setAccountPassword(userName, newpassword, password);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		logger.info("End of test");
	}
	
	//Submit change password with alpha numeric password
	@Test(enabled = true)
	public void testChangePasswordWAlphaNumeric() throws Exception{
		logger.info("Submit change password with alpha numeric password Test");
		//Getting test user name from test data provider
		testInput = TestDataProvider.getTestInput("ChangePasswordWAlphaNumericTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		newpassword = testInput.get("newpassword");
		logger.info("NewPassword = "+ newpassword);
		//Calling the login API
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Calling the change password API
		jsonContent = ChangeLogonInfo.setAccountPassword(userName, password, newpassword);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		//Calling the Login API after change password
		jsonContent = Login.login(userName, newpassword);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Reset the password.
		jsonContent = ChangeLogonInfo.setAccountPassword(userName, newpassword, password);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		logger.info("End of test");
	}
	
	
	//Change Password and login with the old password
	/*@Test(enabled = true)
	public void testChangePasswordAndLoginWOldPassword() throws Exception{
		logger.info("Change Password and login with the old password Test");
		//Getting test user name from test data provider
		testInput = TestDataProvider.getTestInput("ChangePasswordAndLoginWOldPasswordTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		try {
		//Generating the password string dynamically
		newpassword = StringUtils.createStrongPasswordString();
		logger.info("NewPassword = "+ newpassword);
		//Calling the login API
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Calling the change password API
		jsonContent = ChangeLogonInfo.setAccountPassword(userName, password, newpassword);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		//Calling the Login API after change password
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "0");
		//Reset the password
		jsonContent = ChangeLogonInfo.setAccountPassword(userName, newpassword, password);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		}
		catch (Exception e){
			if (e.toString().contains("")){
				logger.info("");
			}
		}
		logger.info("End of test");
	}*/
	
	//Change password when the SQL server is down.
	/*@Test(enabled = true)
	public void testChangePasswordWhenSQLServerDown() throws Exception{
		logger.info("Change password when the SQL server is down Test");
		//Getting test user name from test data provider
		testInput = TestDataProvider.getTestInput("ChangePasswordWhenSQLServerDownTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		try {
		//Generating the password string dynamically
		newpassword = StringUtils.createStrongPasswordString();
		logger.info("NewPassword = "+ newpassword);
		//Calling the login API
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Stopping the SQL Service
		qaSTAFPing qsp = new qaSTAFPing();
		boolean res = qsp.ping(PRIMARY_SQLSERVER_NAME);
		logger.info("Primary SQL Server ping res is "+ res);
		qaSTAFProcessService ps = new qaSTAFProcessService("qa");
		STAFResult result = ps.startProcWait(PRIMARY_SQLSERVER_NAME,
                "c:/windows/system32/sc.exe", "stop " + "MSSQLSERVER",
                "C:/windows/system32");
		//Calling the change password API
		jsonContent = ChangeLogonInfo.setAccountPassword(userName, password, newpassword);
		JSONAsserter.assertJSONSuccessObjectFalse(jsonContent);
		//Calling the Login API after change password
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Restarting the SQLServer.
		result = ps.startProcWait(PRIMARY_SQLSERVER_NAME,
                "c:/windows/system32/sc.exe", "start " + "MSSQLSERVER",
                "C:/windows/system32");
		//Reset the password.
		jsonContent = ChangeLogonInfo.setAccountPassword(userName, newpassword, password);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		}
		catch (Exception e){
			if (e.toString().contains("")){
				logger.info("");
			}
		}
		logger.info("End of test");
	}*/
	
	//Change password with username as password
	@Test(enabled = true)
	public void testChangePasswordWUsernameAsPassword() throws Exception{
		logger.info("Change password with username as password Test");
		//Getting test user name from test data provider
		testInput = TestDataProvider.getTestInput("ChangePasswordWUsernameAsPasswordTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		//Calling the login API
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Calling the change password API
		jsonContent = ChangeLogonInfo.setAccountPassword(userName, password, userName);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusDescription", "Password is not up to security standard!");
		logger.info("End of test");
	}
	
	//Change User Name
	@Test(enabled = true)
	public void testChangeUserName() throws Exception{
		logger.info("Change password with username as password Test");
		//Getting test user name from test data provider
		testInput = TestDataProvider.getTestInput("ChangeUserNameTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		newEmailID = testInput.get("newEmailID");
		//Calling the login API
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Calling the change password API
		jsonContent = ChangeLogonInfo.setAccountEmailID(newEmailID,userName, password);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		//Calling the Login API after change password
		jsonContent = Login.login(newEmailID, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Reset the UserName.
		jsonContent = ChangeLogonInfo.setAccountEmailID(userName,newEmailID, password);
		JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		logger.info("End of test");
	}
	
	//Validate Email ID format
	@Test(enabled = true)
	public void testInvalidEmailID1() throws Exception{
		logger.info("Change password with username as password Test");
		//Getting test user name from test data provider
		testInput = TestDataProvider.getTestInput("InvalidEmailIDFormatTest1");
		userName = testInput.get("userName");
		password = testInput.get("password");
		newEmailID = testInput.get("newEmailID");
		//Calling the login API
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Calling the change password API
		jsonContent = ChangeLogonInfo.setAccountEmailID(newEmailID,userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", "1007");
		logger.info("End of test");
	}
	
	//Validate Alpha Numeric Email ID change
	@Test(enabled = true)
	public void testChangeUserNametoAplhaNumericUserName() throws Exception{
		logger.info("Change password with username as password Test");
		//Getting test user name from test data provider
		testInput = TestDataProvider.getTestInput("ChangeUserNametoAplhaNumericUserNameTest");
		userName = testInput.get("userName");
		password = testInput.get("password");
		newEmailID = testInput.get("newEmailID");
		//Calling the login API
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Calling the change password API
		jsonContent = ChangeLogonInfo.setAccountEmailID(newEmailID,userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", "1007");
		logger.info("End of test");
	}
	
	//Validate Invalid Email ID change
	@Test(enabled = true)
	public void testInvalidEmailID2() throws Exception{
		logger.info("Change password with username as password Test");
		//Getting test user name from test data provider
		testInput = TestDataProvider.getTestInput("InvalidEmailIDFormatTest2");
		userName = testInput.get("userName");
		password = testInput.get("password");
		newEmailID = testInput.get("newEmailID");
		//Calling the login API
		jsonContent = Login.login(userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Calling the change password API
		jsonContent = ChangeLogonInfo.setAccountEmailID(newEmailID,userName, password);
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", "1007");
		logger.info("End of test");
	}
	/* This feature is yet to be implemented
	//Change Password with same as old password
	@Test(enabled = true)
	public void testChangePasswordWSameAsOldPassword(String username, String oldpassword) throws Exception{
		logger.info("Start GetRetrievalSet Sanity Test");
		try {
		//Getting account number from DB
		accountNumber = CommonUtils.getAccountNumber(username);
		accountNumberString = Integer.toString(accountNumber);		
		//Calling the login API
		jsonContent = Login.login(username, oldpassword);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		//Calling the change password API
		jsonContent = ChangePassword.setAccountPassword(accountNumberString, username, oldpassword, oldpassword);
		JSONAsserter.assertJSONSuccessObjectFalse(jsonContent);
		}
		catch (Exception e){
			if (e.toString().contains("")){
				logger.info("");
			}
		}
		logger.info("End of test");
	} */
	

	@AfterMethod(alwaysRun= true)
	public void stopTest() throws Exception {
		super.stophttpTest();
	}
	
}
