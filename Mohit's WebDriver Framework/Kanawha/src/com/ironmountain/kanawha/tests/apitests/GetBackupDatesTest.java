package com.ironmountain.kanawha.tests.apitests;

import org.apache.log4j.Logger;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.kanawha.managementapi.apis.GetBackupDates;
import com.ironmountain.kanawha.managementapi.apis.Login;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.AccountBackupDatesTable;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CustomerTable;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpJsonAppTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.JSONAsserter;
import com.ironmountain.pageobject.pageobjectrunner.utils.DateUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;

public class GetBackupDatesTest extends HttpJsonAppTest{
	
	int accountNumber = 0;
	private static final Logger logger = Logger.getLogger(GetBackupDatesTest.class.getName());
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		super.inithttpTest();
	}
	
	@Parameters({"username", "password"})
	@Test(enabled = true)
	public void testbackupDates(String username,String password) throws Exception{
		logger.info("testBackupDates inputs: username="+username+" password="+password);
		String jsonContent = Login.login(username, password);
		//JSONAsserter.assertJSONSuccessObjectTrue(jsonContent);
		JSONAsserter.assertJSONObjects(jsonContent, "AuthResult", "1");
		
		accountNumber = (new CustomerTable(DatabaseServer.COMMON_SERVER)).getAccountNumber(username);
		jsonContent = GetBackupDates.getBackupDates(username, password, ""+accountNumber);
		validateBackupDates(jsonContent);
	}
	
	@AfterMethod(alwaysRun= true)
	public void stopTest() throws Exception {
		super.stophttpTest();
	}
	
	public void validateBackupDates(String jsonContent) throws Exception {
		String [] backupDatesDB = getBackupDates(accountNumber);
		for(int i=0; i< backupDatesDB.length ; i++ ){
			JSONAsserter.assertJSONObjects(jsonContent, "DateList/"+i+"/Date", backupDatesDB[i]);
		}
	}
	
	public String [] getBackupDates(int accountNumber) throws Exception {
		
    	AccountBackupDatesTable accountBackupDatesTable = new AccountBackupDatesTable(DatabaseServer.COMMON_SERVER);
    	String [] dates = accountBackupDatesTable.getBackupDates(""+accountNumber);
    	logger.info("Total number of Backups for "+accountNumber+" - "+dates.length);
    	for(int i = 0 ; i < dates.length; i++){
    		dates[i] = DateUtils.getKanawhaWebappBackupDateFormat(dates[i]);
    	}		
		return dates;
	}

}
