package com.ironmountain.kanawha.tests.apitests;

import java.util.HashMap;

import org.apache.log4j.Logger;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import com.ironmountain.kanawha.managementapi.apis.EditProfile;
import com.ironmountain.kanawha.managementapi.apis.Login;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CustomerTable;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpJsonAppTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;

public class EditProfileTest extends HttpJsonAppTest{
	private static final Logger logger = Logger.getLogger(EditProfileTest.class.getName());
	HashMap<String,String> testInput,testOutput=new HashMap<String, String>();
	HashMap<String, String> insertValues = new HashMap<String, String>();
	String Firstname = null,Middlename = null,Lastname = null,Company = null,Department = null,Location = null,MailStop = null,CostCenter = null,EmployeeID = null,Country = null,Addressline1 = null,Addressline2 = null,Addressline3 = null,City = null,State = null,Zip = null,Phonenumber = null,Extension = null,CustomField = null;
	String userNameHidden,statusCode,userNameReadOnly,userNameEditable,userNameRequired,accountNumberString,jsonContent,statusHidden,statusRequired,statusReadOnly,statusEditable,password=null;
	int accountNumber = 0;
	
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		super.inithttpTest();
		TestDataProvider.loadTestDataXML(FileUtils.getBaseDirectory()+"/src/com/ironmountain/kanawha/tests/apitests/testdata","EditProfile.xml");
		}
	
	//This test case verifies the default values for the hidden fields
	@Test
	public void hiddenFieldsDefaultValueTest() throws Exception{
		logger.info("Start hiddenFieldsDefaultValueTest");
		
		//Sourcing Inputs
		getTestData("defaultValueTest");
		
		//Sourcing Usernames and Password
		userNameHidden = testInput.get("UserNameHidden");
		password = testInput.get("password");
		statusHidden = testInput.get("StatusHidden");
		
		logger.info("checking for status hidden, default test");
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userNameHidden);
		logger.info(accountNumber);
		accountNumberString = Integer.toString(accountNumber);
		
		//Calling API's for Hidden Staus
		logger.info("Calling login api");
		jsonContent = Login.login(userNameHidden, password);
		logger.info("Calling edit profile get api");
		jsonContent = EditProfile.getProfileDetails(userNameHidden, password, accountNumberString);
		logger.info("Asserting the response");
		assertJsonObject(jsonContent);
		checkStatus(jsonContent, statusHidden);
		logger.info("Stop hiddenFieldsDefaultValueTest");
	}
	
	//This test case verifies the default values for the read only fields
	@Test
	public void readonlyFieldsDefaultValueTest() throws Exception{
		logger.info("Start readonlyFieldsDefaultValueTest");
		
		//Sourcing Inputs
		getTestData("defaultValueTest");
		
		//Sourcing Usernames and Password
		userNameReadOnly = testInput.get("UserNameReadOnly");
		password = testInput.get("password");
		statusReadOnly = testInput.get("StatusReadOnly");
		
		logger.info("checking for status Read Only, default test");
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userNameReadOnly);
		logger.info(accountNumber);
		accountNumberString = Integer.toString(accountNumber);
		
		//Calling API's for Read Only Status
		logger.info("Calling login api");
		jsonContent = Login.login(userNameReadOnly, password);
		logger.info("Calling edit profile get api");
		jsonContent = EditProfile.getProfileDetails(userNameReadOnly, password, accountNumberString);
		logger.info("Asserting the response");
		assertJsonObject(jsonContent);
		checkStatus(jsonContent, statusReadOnly);
		logger.info("Stop readonlyFieldsDefaultValueTest");
	}
	
	//This test case verifies the default values for the required fields
	@Test
	public void requiredFieldsDefaultValueTest() throws Exception{
		logger.info("Start requiredFieldsDefaultValueTest");
		
		//Sourcing Inputs
		getTestData("defaultValueTest");
		
		//Sourcing Usernames and Password
		userNameRequired = testInput.get("UserNameRequiredDefault");
		password = testInput.get("password");
		statusRequired = testInput.get("StatusRequired");
		
		logger.info("checking for status required, default test");
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userNameRequired);
		logger.info(accountNumber);
		accountNumberString = Integer.toString(accountNumber);
		
		//Calling API's for Required Status
		logger.info("Calling login api");
		jsonContent = Login.login(userNameRequired, password);
		jsonContent = EditProfile.getProfileDetails(userNameRequired, password, accountNumberString);
		logger.info("Asserting the response");
		assertJsonObject(jsonContent);
		checkStatus(jsonContent, statusRequired);
		logger.info("Stop requiredFieldsDefaultValueTest");
	}
	
	//This test case verifies the default values for the editable fields
	@Test
	public void editableFieldsDefaultValueTest() throws Exception{
		logger.info("Start editableFieldsDefaultValueTest");
		
		//Sourcing Inputs
		getTestData("defaultValueTest");
		
		//Sourcing Usernames and Password
		userNameEditable = testInput.get("UserNameEditableDefault");
		password = testInput.get("password");
		statusEditable = testInput.get("StatusEditable");
		
		logger.info("checking for status editable, default test");
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userNameEditable);
		logger.info(accountNumber);
		accountNumberString = Integer.toString(accountNumber);
		
		//Calling API's for Required Status
		logger.info("Calling login api");
		jsonContent = Login.login(userNameEditable, password);
		logger.info("Calling edit profile get api");
		jsonContent = EditProfile.getProfileDetails(userNameEditable, password, accountNumberString);
		logger.info("Asserting the response");
		assertJsonObject(jsonContent);
		checkStatus(jsonContent, statusEditable);
		logger.info("Stop editableFieldsDefaultValueTest");
	}
	
	//This test case verifies the set and get functionalities for the hidden fields
	@Test
	public void hiddenFieldsSetandGetTest() throws Exception{
		logger.info("Start hiddenFieldsSetandGetTest");
		
		//Sourcing Inputs
		getTestData("SetandGetAll4StatusesTest");
		insertValues();
		
		//Sourcing Usernames and Password
		userNameHidden = testInput.get("UserNameHidden");
		password = testInput.get("password");
		statusCode = testInput.get("StatusCode");
		
		logger.info("checking for status hidden, set and get test");
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userNameHidden);
		logger.info(accountNumber);
		accountNumberString = Integer.toString(accountNumber);
		
		//Calling API's for Hidden Status
		logger.info("Calling login api");
		jsonContent = Login.login(userNameHidden, password);
		logger.info("Calling edit profile set api");
		jsonContent = EditProfile.setProfileDetails(userNameHidden, password, accountNumberString, insertValues);
		logger.info("Asserting the response");
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", statusCode);
		logger.info("Stop hiddenFieldsSetandGetTest");
	}
	
	//This test case verifies the set and get functionalities for the read only fields
	@Test
	public void readonlyFieldsSetandGetTest() throws Exception{
		logger.info("Start readonlyFieldsSetandGetTest");
		
		//Sourcing Inputs
		getTestData("SetandGetAll4StatusesTest");
		insertValues();
		
		//Sourcing Usernames and Password
		userNameReadOnly = testInput.get("UserNameReadOnly");
		password = testInput.get("password");
		statusCode = testInput.get("StatusCode");
		
		logger.info("checking for status read only, set and get test");
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userNameReadOnly);
		logger.info(accountNumber);
		accountNumberString = Integer.toString(accountNumber);
		
		//Calling API's for Read Only Status
		logger.info("Calling login api");
		jsonContent = Login.login(userNameReadOnly, password);
		logger.info("Calling edit profile set api");
		jsonContent = EditProfile.setProfileDetails(userNameReadOnly, password, accountNumberString, insertValues);
		logger.info("Asserting the response");
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", statusCode);
		logger.info("Stop readonlyFieldsSetandGetTest");
	}
	
	//This test case verifies the set and get functionalities for the required fields
	@Test
	public void requiredFieldsSetandGetTest() throws Exception{
		logger.info("Start requiredFieldsSetandGetTest");
		
		//Sourcing Inputs
		getTestData("SetandGetAll4StatusesTest");
		insertValues();
		
		//Sourcing Usernames and Password
		userNameRequired = testInput.get("UserNameRequired");
		password = testInput.get("password");
		statusRequired = testInput.get("StatusRequired");
		
		logger.info("checking for status required, set and get test");
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userNameRequired);
		logger.info(accountNumber);
		accountNumberString = Integer.toString(accountNumber);
		
		//Calling API's for Read Only Status
		logger.info("Calling login api");
		jsonContent = Login.login(userNameRequired, password);
		logger.info("Calling edit profile set api");
		jsonContent = EditProfile.setProfileDetails(userNameRequired, password, accountNumberString, insertValues);
		logger.info("Calling edit profile get api");
		jsonContent = EditProfile.getProfileDetails(userNameRequired, password, accountNumberString);
		logger.info("Asserting the response");
		assertJsonObject(jsonContent);
		checkStatus(jsonContent, statusRequired);
		logger.info("Stop requiredFieldsSetandGetTest");
	}
	
	//This test case verifies the set and get functionalities for the editable fields
	@Test
	public void editableFieldsSetandGetTest() throws Exception{
		logger.info("Start editableFieldsSetandGetTest");
		
		//Sourcing Inputs
		getTestData("SetandGetAll4StatusesTest");
		insertValues();
		
		//Sourcing Usernames and Password
		userNameEditable = testInput.get("UserNameEditable");
		password = testInput.get("password");
		statusEditable = testInput.get("StatusEditable");
		
		logger.info("checking for status editable, set and get test");
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userNameEditable);
		logger.info(accountNumber);
		accountNumberString = Integer.toString(accountNumber);
		
		//Calling API's for editable Status
		logger.info("Calling login api");
		jsonContent = Login.login(userNameEditable, password);
		logger.info("Calling edit profile set api");
		jsonContent = EditProfile.setProfileDetails(userNameEditable, password, accountNumberString, insertValues);
		logger.info("Calling edit profile get api");
		jsonContent = EditProfile.getProfileDetails(userNameEditable, password, accountNumberString);
		logger.info("Asserting the response");
		assertJsonObject(jsonContent);
		checkStatus(jsonContent, statusEditable);
		logger.info("Stop editableFieldsSetandGetTest");
	}	
	
	//This test deals with providing empty values to editable fields and getting it
	@Test
	public void editableFieldsEmptyValueSetandGetTest() throws Exception{
		logger.info("Start editableFieldsEmptyValueSetandGetTest");
		
		//Sourcing Inputs
		getTestData("emptyValueTest");
		insertValues();
		
		//Sourcing Usernames and Password
		userNameEditable = testInput.get("UserNameEditable");
		password = testInput.get("password");
		statusEditable = testInput.get("StatusEditable");
		
		logger.info("checking for status editable, for empty values");
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userNameEditable);
		logger.info(accountNumber);
		accountNumberString = Integer.toString(accountNumber);
		
		//Calling API's for editable Status
		logger.info("Calling login api");
		jsonContent = Login.login(userNameEditable, password);
		logger.info("Calling edit profile set api");
		jsonContent = EditProfile.setProfileDetails(userNameEditable, password, accountNumberString, insertValues);
		logger.info("Calling edit profile get api");
		jsonContent = EditProfile.getProfileDetails(userNameEditable, password, accountNumberString);
		getTestData("defaultValueTest");
		assertJsonObject(jsonContent);
		checkStatus(jsonContent, statusEditable);
		logger.info("Stop editableFieldsEmptyValueSetandGetTest");
	}
	
	//This test deals with providing empty values to required fields and getting it
	@Test
	public void requiredFieldsEmptyValueSetandGetTest() throws Exception{
		logger.info("Start requiredFieldsEmptyValueSetandGetTest");
		
		//Sourcing Inputs
		getTestData("emptyValueTest");
		insertValues();
		
		//Sourcing Usernames and Password
		userNameRequired = testInput.get("UserNameRequired");
		password = testInput.get("password");
		statusCode = testInput.get("StatusCode");		
		
		logger.info("checking for status required, for empty values");
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userNameRequired);
		logger.info(accountNumber);
		accountNumberString = Integer.toString(accountNumber);
		
		//Calling API's for editable Status
		logger.info("Calling login api");
		jsonContent = Login.login(userNameRequired, password);
		logger.info("Calling edit profile set api");
		jsonContent = EditProfile.setProfileDetails(userNameRequired, password, accountNumberString, insertValues);
		logger.info("Asserting the response");
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", statusCode);
		logger.info("Stop requiredFieldsEmptyValueSetandGetTest");
	}
	
	//This test deals with providing null values to editable fields and getting it
	@Test
	public void editableFieldsNullValueTest() throws Exception{
		logger.info("Start editableFieldsNullValueTest");
		
		//Sourcing Inputs
		testInput = TestDataProvider.getTestInput("nullValueTest");
		insertNullValues();
		
		//Sourcing Usernames and Password
		userNameEditable = testInput.get("UserNameEditable");
		statusCode = testInput.get("StatusCode");
		password = testInput.get("password");
		
		logger.info("checking for status Editable, for null values");
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userNameEditable);
		logger.info(accountNumber);
		accountNumberString = Integer.toString(accountNumber);
		
		//Calling API's for Editable Staus
		logger.info("Calling login api");
		jsonContent = Login.login(userNameEditable, password);
		logger.info("Calling edit profile set api");
		jsonContent = EditProfile.setProfileDetails(userNameEditable, password, accountNumberString, insertValues);
		logger.info("Asserting the response");
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", statusCode);
		logger.info("Stop editableFieldsNullValueTest");
	}
	
	//This test deals with providing null values to required fields and getting it
	@Test
	public void requiredFieldsNullValueTest() throws Exception{
		logger.info("Start requiredFieldsNullValueTest");
		
		//Sourcing Inputs
		testInput = TestDataProvider.getTestInput("nullValueTest");
		insertNullValues();
		
		//Sourcing Usernames and Password
		userNameRequired = testInput.get("UserNameRequired");
		statusCode = testInput.get("StatusCode");
		password = testInput.get("password");
		logger.info("checking for status Required");
		
		logger.info("checking for status Required, for null values");
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userNameRequired);
		logger.info(accountNumber);
		accountNumberString = Integer.toString(accountNumber);
	
		//Calling API's for Required Staus
		logger.info("Calling login api");
		jsonContent = Login.login(userNameRequired, password);
		logger.info("Calling edit profile set api");
		jsonContent = EditProfile.setProfileDetails(userNameRequired, password, accountNumberString, insertValues);
		logger.info("Asserting the response");
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", statusCode);
		logger.info("Stop requiredFieldsNullValueTest");
	}
	
	//This test case verifies the data type for all the fields
	@Test
	public void allFieldsDataTypeCheck() throws Exception{
		logger.info("Start AllFieldsDataTypeCheck");
		
		//Sourcing Inputs
		getTestData("AllFieldsDataTypeCheck");
		insertValues();
		
		//Sourcing Usernames and Password
		userNameEditable = testInput.get("UserNameEditable");
		password = testInput.get("password");
		statusCode = testInput.get("StatusCode");
		
		logger.info("checking for status editable, for all data types");
		//Getting account number from DB
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(userNameEditable);
		logger.info(accountNumber);
		accountNumberString = Integer.toString(accountNumber);
		
		//Calling API's for Editable Status
		logger.info("Calling login api");
		jsonContent = Login.login(userNameEditable, password);
		logger.info("Calling edit profile set api");
		jsonContent = EditProfile.setProfileDetails(userNameEditable, password, accountNumberString, insertValues);
		logger.info("Asserting the response");
		JSONAsserter.assertJSONObjects(jsonContent, "ImdStatusCode", statusCode);
		logger.info("Stop allFieldsDataTypeCheck");
	}
		
	//This method is to assert for the json response for Status only
	public void checkStatus(String jsonObject,String Status) throws SecurityException, IllegalArgumentException, NoSuchFieldException, IllegalAccessException{
		JSONAsserter.assertJSONObjects(jsonObject, "Company/Status", Status);
		JSONAsserter.assertJSONObjects(jsonObject, "Department/Status", Status);
		JSONAsserter.assertJSONObjects(jsonObject, "Location/Status", Status);
		JSONAsserter.assertJSONObjects(jsonObject, "MailStop/Status", Status);
		JSONAsserter.assertJSONObjects(jsonObject, "CostCenter/Status", Status);
		JSONAsserter.assertJSONObjects(jsonObject, "EmployeeID/Status", Status);
		JSONAsserter.assertJSONObjects(jsonObject, "AddressDetails/DisplayStatus", Status);
		JSONAsserter.assertJSONObjects(jsonObject, "PhoneNumber/Status", Status);
		JSONAsserter.assertJSONObjects(jsonObject, "Extension/Status", Status);
		JSONAsserter.assertJSONObjects(jsonObject, "CustomField1/Status", Status);
	}
	
	//This method is to assert for the json response for values only
	public void assertJsonObject(String jsonObject) throws SecurityException, IllegalArgumentException, NoSuchFieldException, IllegalAccessException{
		JSONAsserter.assertJSONObjects(jsonObject, "Firstname", Firstname);
		JSONAsserter.assertJSONObjects(jsonObject, "Middlename", Middlename);
		JSONAsserter.assertJSONObjects(jsonObject, "Lastname", Lastname);
		JSONAsserter.assertJSONObjects(jsonObject, "Company/Value", Company);
		JSONAsserter.assertJSONObjects(jsonObject, "Department/Value", Department);
		JSONAsserter.assertJSONObjects(jsonObject, "Location/Value", Location);
		JSONAsserter.assertJSONObjects(jsonObject, "MailStop/Value", MailStop);
		JSONAsserter.assertJSONObjects(jsonObject, "CostCenter/Value", CostCenter);
		JSONAsserter.assertJSONObjects(jsonObject, "EmployeeID/Value", EmployeeID);
		JSONAsserter.assertJSONObjects(jsonObject, "AddressDetails/Country", Country);
		JSONAsserter.assertJSONObjects(jsonObject, "AddressDetails/Addressline1", Addressline1);
		JSONAsserter.assertJSONObjects(jsonObject, "AddressDetails/Addressline2", Addressline2);
		JSONAsserter.assertJSONObjects(jsonObject, "AddressDetails/Addressline3", Addressline3);
		JSONAsserter.assertJSONObjects(jsonObject, "AddressDetails/City", City);
		JSONAsserter.assertJSONObjects(jsonObject, "AddressDetails/State", State);
		JSONAsserter.assertJSONObjects(jsonObject, "AddressDetails/Zip", Zip);
		JSONAsserter.assertJSONObjects(jsonObject, "PhoneNumber/Value", Phonenumber);
		JSONAsserter.assertJSONObjects(jsonObject, "Extension/Value", Extension);
		JSONAsserter.assertJSONObjects(jsonObject, "CustomField1/Value", CustomField);
		}
	
	//This method sources input from test data xml
	public void getTestData(String testName){
		testInput = TestDataProvider.getTestInput(testName);
		Firstname = testInput.get("Firstname");
		Middlename = testInput.get("Middlename");
		Lastname = testInput.get("Lastname");
		Company = testInput.get("Company");
		Department = testInput.get("Department");
		Location = testInput.get("Location");
		MailStop = testInput.get("MailStop");
		CostCenter = testInput.get("CostCenter");
		EmployeeID = testInput.get("EmployeeID");
		Country = testInput.get("Country");
		Addressline1 = testInput.get("Addressline1");
		Addressline2 = testInput.get("Addressline2");
		Addressline3 = testInput.get("Addressline3");
		City = testInput.get("City");
		State = testInput.get("State");
		Zip = testInput.get("Zip");
		Phonenumber = testInput.get("Phonenumber");
		Extension = testInput.get("Extension");
		CustomField = testInput.get("CustomField");
	}
	
	//This method inserts the values to hashmap
	public void insertValues(){
		insertValues.put("Firstname",Firstname);
		insertValues.put("Middlename",Middlename);
		insertValues.put("Lastname",Lastname);
		insertValues.put("Company",Company);
		insertValues.put("Department",Department);
		insertValues.put("Location",Location);
		insertValues.put("MailStop",MailStop);
		insertValues.put("CostCenter",CostCenter);
		insertValues.put("EmployeeID",EmployeeID);
		insertValues.put("Country",Country);
		insertValues.put("Addressline1",Addressline1);
		insertValues.put("Addressline2",Addressline2);
		insertValues.put("Addressline3",Addressline3);
		insertValues.put("City",City); 
		insertValues.put("State",State);
		insertValues.put("Zip",Zip);
		insertValues.put("Phonenumber",Phonenumber);
		insertValues.put("Extension",Extension);
		insertValues.put("CustomField",CustomField);
	}
	
	//Inserting null values to hashmap for set api
	public void insertNullValues(){
		insertValues.put("Firstname",null);
		insertValues.put("Middlename",null);
		insertValues.put("Lastname",null);
		insertValues.put("Company",null);
		insertValues.put("Department",null);
		insertValues.put("Location",null);
		insertValues.put("MailStop",null);
		insertValues.put("CostCenter",null);
		insertValues.put("EmployeeID",null);
		insertValues.put("Country",null);
		insertValues.put("Addressline1",null);
		insertValues.put("Addressline2",null);
		insertValues.put("Addressline3",null);
		insertValues.put("City",null); 
		insertValues.put("State",null);
		insertValues.put("Zip",null);
		insertValues.put("Phonenumber",null);
		insertValues.put("Extension",null);
		insertValues.put("CustomField",null);
		
	}
	@AfterMethod(alwaysRun= true)
	public void stopTest() throws Exception {
		super.stophttpTest();
	}

}
