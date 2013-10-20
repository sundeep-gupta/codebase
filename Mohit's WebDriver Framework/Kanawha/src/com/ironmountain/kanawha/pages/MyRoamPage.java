package com.ironmountain.kanawha.pages;

import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Pattern;

import org.apache.commons.collections.map.MultiValueMap;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.PageFactory;
import org.testng.Assert;

import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.AccountBackupDatesTable;
import com.ironmountain.pageobject.pageobjectrunner.connected.database.registry.CustomerTable;
import com.ironmountain.pageobject.pageobjectrunner.utils.ListUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.QueryExecutor;



/**
 * @author msompura
 *
 */
public class MyRoamPage extends KanawhaHomePage{

	private static final Logger logger = Logger.getLogger(MyRoamPage.class.getName());
	String userName = null;
	String selectedDevice = null;
	String selectedDate = "Most Recent";
	String mostRecent = null;
	String[] backupDates = null;
	String[] backupTDates = null;
	String[] backupDatesFromDB = null;
	String OS = null;
	String nsep = "\\";
	
	HashMap< String, String> mapUIDBBackupDates = new HashMap<String, String>();
	HashMap< String, String> mapBackupPathID = new HashMap< String, String>();
	HashMap< String, String> mapFolderDetails = new HashMap<String, String>();
	
	HashMap< String, String[]> mapTreeGridDataDB = new HashMap<String, String[]>();
	MultiValueMap multiMapTreeGridDataDB = new MultiValueMap();
	
	HashMap< String, String[]> mapTreeGridData = new HashMap<String, String[]>();
	MultiValueMap multiMapTreeGridData = new MultiValueMap();
	


	CustomerTable customerTable = null;
	AccountBackupDatesTable accountBackupDatesTable = null;
	JavascriptExecutor js = (JavascriptExecutor) driver;
	
	int accountNumber;
	
	public MyRoamPage() throws Exception {
		super();
		driver = getDriver();
	}
    
	public void selectDevice(String Device) throws Exception{
    	logger.info("Selecting a backup device - " + Device);
    	//Click on device drop down arrow
    	this.clickAndWaitForPageLoad(findElement(driver, By.xpath(getLocator("MyRoamPage.DeviceDropDownArrow"))),2);
    
    	//Click on device
    	this.clickAndWaitForPageLoad(findElement(driver, By.xpath("//div[text()='"+Device+"']")),2);
    	waitForIndicator("Loading....",1,60);
    	//TBD: verify
    	selectedDevice = Device;
    	
    }
	public String getSelectedDevice() throws Exception {
		logger.info("Getting Selected Device...");
		String loc = getLocator("MyRoamPage.DeviceDropDown");
		WebElement deviceDropDown = driver.findElement(By.id(loc));
		String selectedDevice = this.getValue(deviceDropDown);
		return selectedDevice;
	}
    
    public void selectDate(String Date)throws Exception{
    	logger.info("Selecting a backup date - " + Date);
    	logger.info("Passing "+this.mapUIDBBackupDates.keySet()+"\n"+this.mapUIDBBackupDates.values());//REM
        
    	//Click on date drop down arrow
    	this.clickAndWaitForPageLoad(findElement(driver, By.xpath(getLocator("MyRoamPage.DateDropDownArrow"))),2);
    	
    	//Click on a date
    	this.clickAndWaitForPageLoad(findElement(driver, By.xpath("//div[text()='" + Date + "']")),2);
    	waitForIndicator("Loading....",1,60);
    	//TBD: verify
    	selectedDate = Date;
    }

    public void verifyBackupData()throws Exception{
    	
    	String actualSelectedDate = selectedDate;
    	String backupTDate = "";
    	this.getSelectedDateUI();
    	if(selectedDate.equals("Most Recent"))
    	{
    		logger.info("Selected Date is " + selectedDate + ", So get actual date");
    		actualSelectedDate = getMostRecentDateUI();
    	}
    	//TBD:First verify if the account has any data backedup

    	this.collapseFolderTree();
    	//Prepare backend
    	if(actualSelectedDate.equals("All")){
    		backupTDate = "All";
    	}
    	else{
    		//getTDate for selectedDate
    		logger.info("Passing "+this.mapUIDBBackupDates.keySet()+"\n"+this.mapUIDBBackupDates.values());
    		backupTDate = accountBackupDatesTable.getBackupTDate(""+accountNumber, "'"+this.mapUIDBBackupDates.get(actualSelectedDate)+"00'");
    		logger.info("account="+accountNumber+" selectedDate="+actualSelectedDate+" TDate="+backupTDate);
    	}
    	//Thread.sleep(30000);
    	//getBackupPaths for Account and TDate
    	logger.info("Get BackupPaths");
    	this.getBackupPathsFromDB(accountNumber,backupTDate);
    	//Now traverse and verify
    	logger.info("Verify Backup Data");
    	WebElement treeItem = null;
    	if(isElementPresent(driver,By.xpath("//form/div[1]//div[@class='x-tree-root-node']/li/div"))) {
    		treeItem = findElement(driver,By.xpath("//form/div[1]//div[@class='x-tree-root-node']/li/div"));
    		clickAndWaitForPageLoad(treeItem,2);
    		waitForIndicator("Loading....",1,60);
    	}
    	for(int i = 1 ; i <= 100000 ; i++){
    		//if(isElementPresent(driver,By.xpath("//form/div[1]//div[@class='x-tree-root-node']/li["+i+"]"))){
    		if(isElementPresent(driver,By.xpath("//form/div[1]//div[@class='x-tree-root-node']/li/ul/li["+i+"]"))){
    			treeItem = findElement(driver,By.xpath("//form/div[1]//div[@class='x-tree-root-node']/li/ul/li["+i+"]"));
    			
    			logger.info("Tree Item "+i+"="+treeItem.getText());
    			this.traverseAndVerify(treeItem,treeItem.getText(), backupTDate);
    		}
    		else{
    			logger.info("Empty folder tree or no more tree items to traverse");
    			return;
    		}
    		
    		//Now verify the data for this i'th folder node
            
    	}
    }
    public void highlightFolder(String folderPath) throws Exception {
    	
    	//this.collapseFolderTree();

    	WebElement treeItem = null;
    	if(isElementPresent(driver,By.xpath("//form/div[1]//div[@class='x-tree-root-node']/li/div"))) {
    		treeItem = findElement(driver,By.xpath("//form/div[1]//div[@class='x-tree-root-node']/li/div"));
    		clickAndWaitForPageLoad(treeItem,2);
    		waitForIndicator("Loading....",1,60);
    	}
    	for(int i = 1 ; i <= 100000 ; i++){
    		//if(isElementPresent(driver,By.xpath("//form/div[1]//div[@class='x-tree-root-node']/li["+i+"]"))){
    		if(isElementPresent(driver,By.xpath("//form/div[1]//div[@class='x-tree-root-node']/li/ul/li["+i+"]"))){
    			treeItem = findElement(driver,By.xpath("//form/div[1]//div[@class='x-tree-root-node']/li/ul/li["+i+"]"));
    			
    			logger.info("Tree Item "+i+"="+treeItem.getText());
    			if(folderPath.startsWith(treeItem.getText())) {
    				this.traverseAndHighlightFolder(treeItem,treeItem.getText(), folderPath);
    				return;
    			}
    		}
    		else{
    			logger.info("Empty folder tree or no more tree items to traverse");
    			return;
    		}
    		
    		//Now verify the data for this i'th folder node
            
    	}
    }
    public void verifyBackupDatesList(String username) throws Exception{
    	logger.info("Verifying Backup Dates");
    	userName = username; 
    	logger.info(js.executeScript("return document.title"));
    	//Verify the default text on the date select drop down
    	//{broken in 183}Assert.assertEquals(this.getValue(findElement(driver,By.id(getLocator("MyRoamPage.DateDropDown")))), "Select date...", "There was no Select date message on the date select drop down");

    	//Click on date drop down arrow to expand
    	this.clickAndWaitForPageLoad(findElement(driver, By.xpath(getLocator("MyRoamPage.DateDropDownArrow"))),2);
    	String dateList = this.getText(findElement(driver,By.xpath("//div[text()='Most Recent']/parent::div")));
    	logger.info(dateList);
    	backupDates = this.getDates(dateList);
    	backupDatesFromDB = this.getBackupDatesFromDB(username);
    	logger.info("Passing "+this.mapUIDBBackupDates.keySet()+"\n"+this.mapUIDBBackupDates.values());//REM
    	this.compareUIAndDBBackupDates(backupDates,backupDatesFromDB);
    	Thread.sleep(2000);
    	//Click on date drop down arrow to collapse
    	this.clickAndWaitForPageLoad(findElement(driver, By.id(getLocator("MyRoamPage.DateDropDown"))),2);  	
    }

    public String[] getDates(String dateList) throws Exception{
	   	Pattern p = Pattern.compile("\n");
        String[] dates = p.split(dateList);
        Assert.assertEquals((dates[0].equals("Most Recent") && dates[1].equals("All")), true, "Backup Dates List is corrupt.");
        
        for (int i = 2; i < dates.length; i++) {
          String backupDatePattern = "\\d{1,2}/\\d{1,2}/\\d{2,4} \\d{1,2}:\\d{1,2}:\\d{1,2} [AP]M";
          //A sample date looks like this "1/18/2011 10:25:36 PM";
   	      Assert.assertEquals(Pattern.matches(backupDatePattern, dates[i]), true, "Backup Date " + dates[i] + " is corrupt.");
        }

        return dates;
    }
    public String[] getBackupDatesFromDB(String username) throws Exception{
    	String[] dates = null;
    	customerTable = new CustomerTable(DatabaseServer.COMMON_SERVER);
    	accountNumber = customerTable.getAccountNumber(username);
    	logger.info(username+" - "+accountNumber);
    	
    	accountBackupDatesTable = new AccountBackupDatesTable(DatabaseServer.COMMON_SERVER);
    	dates = accountBackupDatesTable.getBackupDates(""+accountNumber);
    	logger.info("Total number of Backups for "+accountNumber+" - "+dates.length);
    	for(int i = 0 ; i < dates.length; i++){
    		this.mapUIDBBackupDates.put(backupDates[i+2], dates[i]);
    		logger.info(backupDates[i+2]+ " accountNumber " +dates[i]);
    		logger.info(this.mapUIDBBackupDates.get(backupDates[i+2]));
    		dates[i] = this.getKanawhaWebappBackupDateFormat(dates[i]);
    		logger.info("UI Backup dates["+i+"] for "+accountNumber+" - "+dates[i]);
    	}
    	/*
    	QueryExecutor qe = new QueryExecutor(DatabaseServer.COMMON_SERVER, "DIRECTORY");
    	ResultSet res = qe.executeQuery("select CONVERT(varchar(30),DATEadd(s,tdate, '19700101 00:00:00:000'),126) as tdate from fileindex");
    	while(res.next()){
    		logger.info(res.getString("tdate"));
    	}
    	*/
    	return dates;
    	
    }
    
	public String getKanawhaWebappBackupDateFormat(String date){
		Date newDate = null;
		DateFormat uiDateFormat = new SimpleDateFormat("M/d/yyyy h:mm:ss a");
		DateFormat dbDateFormat = new SimpleDateFormat("yyyy-MM-dd k:mm:s");
		try {
			newDate = dbDateFormat.parse(date) ;
			System.out.println("Parsed Date: " + newDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return  uiDateFormat.format(newDate);
	}
    
	public boolean compareUIAndDBBackupDates(String[] UIDates, String[] DBDates) throws Exception{
    	logger.info("Comparing UI and DB dates");
    	
    	for(int i = 0; (i < DBDates.length) && ((i+2) < UIDates.length); i++){
    		logger.info("Comparing UIDates["+(i+2)+"]="+UIDates[i+2]+" with DBDates["+i+"]="+DBDates[i]+" - " + StringUtils.indexOfDifference(UIDates[i+2], DBDates[i]));
    		
    		//Assert.assertEquals(UIDates[i+2],DBDates[i] ,"Backup date on UI does not match with date from DB");
    		Assert.assertEquals(UIDates[i+2].equals(DBDates[i]), true, "Backup date on UI does not match with date from DB");
    		
    	}
    	
    	return true;
    }
	
	public void collapseFolderTree() throws Exception{
		//We'll traverse the folder tree using BFS
		logger.info("Will try to collapse the entire folder tree");
		WebElement treeItem = null;
    	for(int i = 1 ; i <= 100000 ; i++){
    		if(isElementPresent(driver,By.xpath("//form/div[1]//div[@class='x-tree-root-node']/li["+i+"]"))){
    			
    			treeItem = findElement(driver,By.xpath("//form/div[1]//div[@class='x-tree-root-node']/li["+i+"]"));
    			logger.info("Tree Item "+i);
    			this.printListItems(treeItem);
    			traverseAndCollapse(treeItem);
    		}
    		else{
    			logger.info("Empty folder tree or no more tree items to traverse");
    			return;
    		}
    		
    		//Now verify the data for this i'th folder node
            
    	}
	}
	public void traverseAndCollapse(WebElement treeItem) throws Exception{
		//logger.info("Traversing "+treeItem.getAttribute("class"));
		/*treeItem.findElement(By.xpath("//div[@class='x-tree-node-el x-unselectable folder x-tree-selected x-tree-node-expanded']"));*/
		WebElement child = treeItem.findElement(By.xpath("div[1]"));
		/*x-tree-node-el x-unselectable folder x-tree-node-expanded*/
		//logger.info(child.findElement(By.xpath("a/span")).getText()+" - "+child.getAttribute("class"));
		if(isElementPresent(treeItem,By.xpath("div[contains(@class,'expanded')]"))){
          //logger.info("It is an expanded folder");
          if(isElementPresent(treeItem, By.xpath("ul/li"))){
        	  //logger.info("It has list items");
        	  for(int i =1; i< 100000;i++){
        		  //logger.info("List Item "+i+" for "+treeItem.findElement(By.xpath("div/a/span")).getText());
        		  
        		  if(isElementPresent(treeItem,By.xpath("ul/li["+i+"]"))){
        			  //logger.info("call tAc for "+treeItem.findElement(By.xpath("ul/li["+i+"]")).getText());
        			  this.printListItems(treeItem.findElement(By.xpath("ul/li["+i+"]")));
        			  this.traverseAndCollapse(treeItem.findElement(By.xpath("ul/li["+i+"]")));
        			  //logger.info("done with tAc for "+treeItem.findElement(By.xpath("ul/li["+i+"]")).getText());
        		  }
        		  else
        		  {
        			  //logger.info("Break: No more list items at "+i+" for "+treeItem.findElement(By.xpath("div/a/span")).getText());
        			  break;
        		  }
        	  }//End of for         	  
          }else{
        	  //logger.info("But it does not have list items");
          }
          
          //this.traverseAndCollapse(child);
          logger.info("Collapsing "+child.getText());
          this.clickAndWaitForPageLoad(child.findElement(By.xpath("img[@src='data:image/gif;base64,R0lGODlhAQABAID/AMDAwAAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==' and contains(@class,'minus')]")), 2);
		}else{
			//logger.info("It isn't an expanded folder!");
		}
	}
	public void traverseAndVerify(WebElement treeItem, String preceedingPath, String TDate) throws Exception{
		logger.info("Traversing tree node " + treeItem.getTagName() + " preceedingPath="+preceedingPath);
		preceedingPath.replace("\\\\", "\\");
		logger.info("Traversing tree node " + treeItem.getTagName() + " preceedingPath="+preceedingPath);
		String folderName = null;
		if(isElementPresent(treeItem,By.xpath("div[contains(@class,'folder')]"))){
		  //if(isElementPresent(treeItem,By.xpath("div/img[@src='data:image/gif;base64,R0lGODlhAQABAID/AMDAwAAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==')]"))){
			logger.info("Current treeItem is a folder");
			folderName = treeItem.findElement(By.xpath("div/a/span")).getText();
			logger.info("Folder name is "+folderName);
			if(isElementPresent(treeItem,By.xpath("div[contains(@class,'collapsed')]"))){
				
				if(isElementPresent(treeItem,By.xpath("div/img[contains(@class,'plus')]"))){
					logger.info("Expanding folder - "+folderName);
					this.clickAndWaitForPageLoad(treeItem.findElement(By.xpath("div/img[contains(@class,'plus')]")), 1);
					waitForIndicator("Loading....",1,60);
					logger.info("Highlighting folder - "+folderName);
					this.clickAndWaitForPageLoad(treeItem.findElement(By.xpath("div")), 1);
					waitForIndicator("Loading....",1,60);
				}
				else
				{
					logger.info("Looks like the folder is already expanded. This should not happen");
				}
				//verify if the node item is present in backup paths
				if(mapBackupPathID.containsKey(preceedingPath)){
					//getSubFolders
					String [] subFolders = this.getSubFolders( accountNumber ,TDate, preceedingPath);
					
					//getFolderDetailsFromDB
					this.getFolderDetailsFromDB(accountNumber,TDate, mapBackupPathID.get(preceedingPath));
					//getGridDataForFolder from UI
					this.getGridDataForFolderFromUI(folderName);
					//compare data from UI and DB
					this.compareUIAndDBGridData(subFolders);
					
				}
				else{
					logger.info("Looks like this was not explicitly selected for backup\n"+preceedingPath);
				}
				if(isElementPresent(treeItem,By.xpath("ul/li"))){
		        	  for(int i =1; i< 100000;i++){
		        		  if(isElementPresent(treeItem,By.xpath("ul/li["+i+"]"))){
		        			  WebElement nextTreeItem = treeItem.findElement(By.xpath("ul/li["+i+"]"));
		        			  this.traverseAndVerify(nextTreeItem, preceedingPath+nextTreeItem.findElement(By.xpath("div/a/span")).getText()+nsep,TDate);
		        		  }
		        		  else
		        		  {
		        			  break;
		        		  }
		        	  }					
				}
			}
		}
		else{
			logger.info("Current treeItem is not a folder");
		}
		
	}
	private void traverseAndHighlightFolder(WebElement treeItem, String preceedingPath, String Folder_To_Highlight) throws Exception {
		logger.info("Traversing tree node " + treeItem.getTagName() + " preceedingPath="+preceedingPath);
		preceedingPath.replace("\\\\", "\\");
		logger.info("Traversing tree node " + treeItem.getTagName() + " preceedingPath="+preceedingPath);
		String folderName = null;
		if(isElementPresent(treeItem,By.xpath("div[contains(@class,'folder')]"))){
		  //if(isElementPresent(treeItem,By.xpath("div/img[@src='data:image/gif;base64,R0lGODlhAQABAID/AMDAwAAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==')]"))){
			logger.info("Current treeItem is a folder");
			folderName = treeItem.findElement(By.xpath("div/a/span")).getText();
			logger.info("Folder name is "+folderName);

			if(isElementPresent(treeItem,By.xpath("div[contains(@class,'collapsed')]"))){
				
				if(isElementPresent(treeItem,By.xpath("div/img[contains(@class,'plus')]"))){
					logger.info("Expanding folder - "+folderName);
					this.clickAndWaitForPageLoad(treeItem.findElement(By.xpath("div/img[contains(@class,'plus')]")), 1);
					waitForIndicator("Loading....",1,60);
					logger.info("Highlighting folder - "+folderName);
					this.clickAndWaitForPageLoad(treeItem.findElement(By.xpath("div")), 1);
					waitForIndicator("Loading....",1,60);
				}
				else
				{
					logger.info("Looks like the folder is already expanded. This should not happen");
				}
				if(Folder_To_Highlight.equals(preceedingPath+folderName)) {
					return;
				}

				if(isElementPresent(treeItem,By.xpath("ul/li"))){
		        	  for(int i =1; i< 100000;i++){
		        		  if(isElementPresent(treeItem,By.xpath("ul/li["+i+"]"))){
		        			  WebElement nextTreeItem = treeItem.findElement(By.xpath("ul/li["+i+"]"));
		        			  if(Folder_To_Highlight.startsWith(preceedingPath+nextTreeItem.findElement(By.xpath("div/a/span")).getText())) {
		        				  this.traverseAndHighlightFolder(nextTreeItem, preceedingPath+nextTreeItem.findElement(By.xpath("div/a/span")).getText()+nsep,Folder_To_Highlight);
		        				  return;
		        			  }
		        		  }
		        		  else
		        		  {
		        			  break;
		        		  }
		        	  }					
				}
			}
		}
		else{
			logger.info("Current treeItem is not a folder");
		}
			
	}
	public void printListItems(WebElement list) throws Exception
	{
		for(int i = 1; i< 100;i++){
			logger.info("PRINT:ul/li["+i+"]");
			if(isElementPresent(list,By.xpath("ul/li["+i+"]"))){
				logger.info("PRINT:"+list.findElement(By.xpath("ul/li["+i+"]/div")).getText());
			}
			else
			{
				logger.info("PRINT:Break: No more list items under given list");
				break;
			}
			
		}
	}
	
	public void getBackupPathsFromDB(int accountNumber,String TDate) throws Exception
	{
    	mapBackupPathID.clear();
    	QueryExecutor qe = new QueryExecutor(DatabaseServer.COMMON_SERVER, "DIRECTORY");
    	String query = "select name as path,NameId as id from PathNames where NameId in (select pathid from FileIndex where Account='"+accountNumber+"' and Tdate='"+TDate+"')";
    	if(TDate.equals("All")){
    		query = "select name as path,NameId as id from PathNames where NameId in (select pathid from FileIndex where Account='"+accountNumber+"')";
    	}
    	ResultSet res = qe.executeQuery(query);
    	while(res.next()){
    		mapBackupPathID.put(res.getString("path"),res.getString("id"));
    		logger.info("Path:"+res.getString("path")+"=ID:"+mapBackupPathID.get(res.getString("path")));
    	}
    	
	}
	
	public String[] getSubFolders(int account, String TDate, String folderPath) throws Exception
	{
		String[] subFolders = new String[mapBackupPathID.size()];
		logger.info("subFolders.length"+subFolders.length);
		int i = 0;
		/*QueryExecutor qe = new QueryExecutor(DatabaseServer.COMMON_SERVER, "DIRECTORY");
    	ResultSet res = qe.executeQuery("select nameid as id,name as path from PathNames where NameId in (select pathid from FileIndex where Account='"+account+"' and Tdate='"+TDate+"' and OrigSize=0 and FileName='.' and PathId>"+mapBackupPathID.get(folderPath));
    	while(res.next()){
    		mapBackupPathID.put(res.getString("path"),res.getString("id"));
    		logger.info("Path:"+res.getString("path")+"=ID:"+mapBackupPathID.get(res.getString("id")));
    	}*/
		logger.info("Getting subfolders for "+folderPath);
		for (String key : mapBackupPathID.keySet()) {
			logger.info(key+"="+mapBackupPathID.get(key));
			if(key.startsWith(folderPath) && !(key.equals(folderPath))){
				subFolders[i] = key.substring(folderPath.length(), key.indexOf(nsep, folderPath.length()));			
				logger.info(subFolders[i]);
				i++;
			}
		}
		
		return subFolders;
	}
	public void getFolderDetailsFromDB(int account,String TDate, String pathID) throws Exception
	{
		logger.info("Getting contents for "+pathID);
		mapTreeGridDataDB.clear();
		//multiMapTreeGridDataDB = new ArrayListMultimap<String, String[]>();
		multiMapTreeGridDataDB.clear();
		List<String> folderDetails = new ArrayList<String>();
		QueryExecutor qe = new QueryExecutor(DatabaseServer.COMMON_SERVER, "DIRECTORY");
		String query = "select filename as filename,PathId as pathId,OrigSize as size,Mdate as mdate from FileIndex where Account='"+account+"' and Tdate='"+TDate+"' and PathId="+pathID;
		if(TDate.equals("All")){
			query = "select filename as filename,PathId as pathId,OrigSize as size,Mdate as mdate from FileIndex where Account='"+account+"' and PathId="+pathID+" and Type!=4";
		}
		ResultSet res = qe.executeQuery(query);
		
		while(res.next()){
			
			if(res.getString("filename").equals(".")){
				//it is a folder in a folder
			    //folderDetails.add("folder");
			}else{
				folderDetails.add(res.getString("pathId"));
				folderDetails.add(res.getString("filename"));
				folderDetails.add(res.getString("size"));
				folderDetails.add(res.getString("mdate"));
				folderDetails.add("file");
				logger.info("Got FILE "+res.getString("filename")+" from DB");
				if(selectedDate.equals("All"))
				{
					logger.info("Adding it to multiMapDB");
					multiMapTreeGridDataDB.put(folderDetails.get(1),ListUtils.getStringListAsArray(folderDetails));
				}
				else
				{
					mapTreeGridDataDB.put(folderDetails.get(1),ListUtils.getStringListAsArray(folderDetails));
				}
				folderDetails.clear();
			}
			
    	}//end of while
		logger.info("Here are the folder contents");
		if(selectedDate.equals("All"))
		{
			for (Object key : multiMapTreeGridDataDB.keySet()) {
				logger.info(key+"="+multiMapTreeGridDataDB.get(key).toString());
				if(multiMapTreeGridDataDB.size(key) > 0){
					logger.info(key+"="+multiMapTreeGridDataDB.get(key));
				}
			}
		}
		else
		{
			for (String key : mapTreeGridDataDB.keySet()) {
				logger.info(key+"="+mapTreeGridDataDB.get(key).length);
				if(mapTreeGridDataDB.get(key).length > 0){
					logger.info(key+"="+mapTreeGridDataDB.get(key)[1]);
				}
			}
		}
	}
	
	public void getGridDataForFolderFromUI(String folder) throws Exception
	{
		WebElement gridRoot = findElement(driver,By.xpath("//div[@id='gridPanel']//div[@class='x-grid3-viewport']//div[@class='x-grid3-scroller']/div[@class='x-grid3-body']"));
		//multiMapTreeGridData = new ArrayListMultimap<String, String[]>();
		multiMapTreeGridData.clear();
		List<String> folderDetails = new ArrayList<String>();
		for(int i=1 ; i<100000 ; i++)
		{
			logger.info("isElementPresent(gridRoot, By.xpath(\"div["+i+"]/table/tbody/tr\"))="+isElementPresent(gridRoot, By.xpath("div["+i+"]/table/tbody/tr")));
			if(isElementPresent(gridRoot, By.xpath("div["+i+"]/table/tbody/tr")))
			{
				WebElement row = gridRoot.findElement(By.xpath("div["+i+"]/table/tbody/tr"));
				logger.info(row.getText());

				folderDetails.add(row.findElement(By.xpath("td[3]")).getText());//name
				folderDetails.add(row.findElement(By.xpath("td[4]")).getText());//size
				
				logger.info("Got ITEM "+row.findElement(By.xpath("td[3]")).getText()+" from UI");
				if(selectedDate.equals("All")){
					logger.info("Adding it to multimapUI");
					multiMapTreeGridData.put(row.findElement(By.xpath("td[3]")).getText(), ListUtils.getStringListAsArray(folderDetails));
				}
				else
				{
					mapTreeGridData.put(row.findElement(By.xpath("td[3]")).getText(), ListUtils.getStringListAsArray(folderDetails));
				}
				
				folderDetails.clear();
				
			}else{
				break;
			}
		}
	}
	public void compareUIAndDBGridData(String[] subFolders) throws Exception
	{
		logger.info("Comparing UI and DB Grid Data");
		if(selectedDate.equals("All")){
			for (Object key : multiMapTreeGridDataDB.keySet()) {
				logger.info("gridDataDB="+key+" ,multiMapTreeGridData.containsKey(key)="+multiMapTreeGridData.containsKey(key));
				
				if(multiMapTreeGridData.containsKey(key)){
					Collection<String[]> myco = multiMapTreeGridData.getCollection(key);
					logger.info("Size of myco="+myco.size());
					for (Iterator<String[]> it=myco.iterator(); it.hasNext(); ) {
						String[] ele = it.next();
					    logger.info("length = "+ele.length);
					    for(int i = 0 ; i < ele.length;i++){
					    	logger.info(i+"="+ele[i]);
					    }
					}					
					logger.info("multiMapTreeGridData.get(key)="+multiMapTreeGridData.get(key).toString()+" multiMapTreeGridDataDB.get(key)="+multiMapTreeGridDataDB.get(key).toString());
				}
				if(multiMapTreeGridData.containsKey(key))/* && mapTreeGridData.get(key)[1].equals(mapTreeGridDataDB.get(key)[2]))*/{
					logger.info("Found file " + key);
					if(multiMapTreeGridData.getCollection(key).size() == multiMapTreeGridDataDB.getCollection(key).size()){
						logger.info("Number of revisions match");
					}
					else{
						logger.error("Number of revisions do not match");
						Assert.assertEquals(multiMapTreeGridData.getCollection(key).size(), multiMapTreeGridDataDB.getCollection(key).size(), "Number of revisions do not match");
					}
						
				}
				if(!multiMapTreeGridData.containsKey(key)){
					logger.error("ERROR: Data item "+key+" exists in DB but not displayed on UI");
					Assert.assertEquals(multiMapTreeGridData.containsKey(key), true, "ERROR: Data item "+key+" exists in DB but not displayed on UI");
				}
			}
			for (String  folder: subFolders) {
				if((folder != null) && multiMapTreeGridData.containsKey(folder)){
					logger.info("Found folder " + folder);
				}
			}
		}
		else{
			for (String key : mapTreeGridDataDB.keySet()) {
				logger.info("gridDataDB="+key+" mapTreeGridData.containsKey(key)="+mapTreeGridData.containsKey(key));
				if(mapTreeGridData.containsKey(key)){
					logger.info("mapTreeGridData.get(key)[1]="+mapTreeGridData.get(key)[1]+" mapTreeGridDataDB.get(key)[2]="+mapTreeGridDataDB.get(key)[2]);
				}
				if(mapTreeGridData.containsKey(key))/* && mapTreeGridData.get(key)[1].equals(mapTreeGridDataDB.get(key)[2]))*/{
					logger.info("Found file " + key);
				}
				if(!mapTreeGridData.containsKey(key)){
					logger.error("ERROR: Data item "+key+" exists in DB but not displayed on UI");
					Assert.assertEquals(mapTreeGridData.containsKey(key),true,"ERROR: Data item "+key+" exists in DB but not displayed on UI");
				}
			}
			for (String  folder: subFolders) {
				if((folder != null) && mapTreeGridData.containsKey(folder)){
					logger.info("Found folder " + folder);
				}
			}
		}
	}
	
	public String getSelectedDateUI() throws Exception
	{
		WebElement dateDropDown = findElement(driver,By.id(getLocator("MyRoamPage.DateDropDown")));
		selectedDate = dateDropDown.getValue();
		logger.info("Selected Date = "+ selectedDate);
		
		return selectedDate;
	}
	public String getMostRecentDateUI() throws Exception
	{
	   	//Click on date drop down arrow to expand
    	//this.clickAndWaitForPageLoad(findElement(driver, By.xpath(getLocator("MyRoamPage.DateDropDownArrow"))),2);
    	this.clickAndWaitForPageLoad(findElement(driver, By.id(getLocator("MyRoamPage.DateDropDown"))),2);
    	
    	String dateList = this.getText(findElement(driver,By.xpath("//div[text()='Most Recent']/parent::div")));
    	logger.info("dateList="+dateList);

    	//Click on date drop down arrow to collapse
    	this.clickAndWaitForPageLoad(findElement(driver, By.id(getLocator("MyRoamPage.DateDropDown"))),2);
    	
    	if(dateList.equals(""))
    	{
    		return null;
    	}
    	
    	backupDates = this.getDates(dateList);
    	if(backupDates.length > 2){
    		logger.info("Most Recent Date is "+backupDates[backupDates.length - 1]);
    		return backupDates[backupDates.length - 1];
    	}
		return null;
	}
	
	public boolean isSearchButtonEnabled() throws Exception {
		WebElement searchButton = driver.findElement(By.id(getLocator("MyRoamPage.SearchButton")));
		if(searchButton.getAttribute("class").contains("disabled")) {
			return false;
		}
		return true;
	}
	public boolean isSearchBoxEnabled() throws Exception {
		WebElement searchBox = driver.findElement(By.id(getLocator("MyRoamPage.SearchBox")));
		if(searchBox.getAttribute("class").contains("disabled")) {
			return false;
		}
		return true;
	}
	public void clickOnRootNode() throws Exception {
		WebElement rootNode = driver.findElement(By.xpath(getLocator("MyRoamPage.RootNode")));
		clickAndWaitForPageLoad(rootNode,2);
		waitForIndicator("Loading....",1,60);
	}
	public void searchAndWait(String searchText,String contentSearchText, int seconds) throws Exception {
		WebElement searchBox = driver.findElement(By.id(getLocator("MyRoamPage.SearchBox")));
		WebElement contentSearchBox = driver.findElement(By.id(getLocator("MyRoamPage.ContentSearchBox")));
		searchBox.clear();
		searchBox.sendKeys(searchText);
		if(!contentSearchText.isEmpty()) {
			contentSearchBox.clear();
			contentSearchBox.sendKeys(contentSearchText);
		}
		
		WebElement searchButton = driver.findElement(By.id(getLocator("MyRoamPage.SearchButton")));
		clickAndWaitForPageLoad(searchButton,2);
		logger.info("Calling waitForIndicator");
		waitForIndicator("Searching...",1,seconds);
	}
	public MultiValueMap getSearchResults() throws Exception {
		MultiValueMap searchResults = new MultiValueMap();
		WebElement searchResultsRow;
		WebElement searchResultGrid = driver.findElement(By.xpath(getLocator("MyRoamPage.SearchResultGrid")));
		logger.info(getLocator("MyRoamPage.SearchResultGrid"));
		logger.info(searchResultGrid.getText());
		
		int i = 1;
		String[] rowItems;
		String iconSrc;
		while(isElementPresent(searchResultGrid,By.xpath("div["+i+"]"))) {
			searchResultsRow = searchResultGrid.findElement(By.xpath("div["+i+"]"));
			rowItems = searchResultsRow.getText().split("\n", 5);
			iconSrc = searchResultsRow.findElement(By.xpath("table/tbody/tr/td[6]/div/img")).getAttribute("src");
			if(iconSrc.equals("images/framework/file.ico")) {
				searchResults.put(rowItems[0], rowItems[0]+"|"+rowItems[1]+"|"+rowItems[2]+"|file");
				/*String[] arr = {rowItems[0],rowItems[1],rowItems[2],"file"};
				searchResults.put(rowItems[0], arr);*/
			}
			else if(iconSrc.equals("images/framework/folder.ico")) {
				searchResults.put(rowItems[0], rowItems[0]+"|"+rowItems[1]+"|"+rowItems[2]+"|folder");
				/*String[] arr = {rowItems[0],rowItems[1],rowItems[2],"folder"};
				searchResults.put(rowItems[0], arr);*/
			}
			else
			{
				logger.info("tag="+searchResultGrid.getTagName() + " class="+searchResultGrid.getAttribute("class"));
				logger.info("tag="+searchResultsRow.getTagName() + " class="+searchResultsRow.getAttribute("class"));
				logger.info("tag="+searchResultsRow.findElement(By.xpath("/table/tbody/tr/td[6]/div/img")).getTagName() + " class="+searchResultsRow.findElement(By.xpath("//td[6]/div/img")).getAttribute("class"));
				throw new Exception("Unrecognised backup item type in row " + i + " " + iconSrc + ". Expected file or folder type only");
			}
			i++;
		}

		return searchResults;
	}
	public String[] getSearchResultsHeader() throws Exception {
		WebElement searchResultsGridHeader = driver.findElement(By.xpath("//div[@id='searchGridPanel']//div[@class='x-grid3-header']"));
		String headerRow = searchResultsGridHeader.getText();
		return headerRow.split("\n");
		
	}
	public String getSearchPanelHeaderText() throws Exception {
		WebElement searchPanelHeader = driver.findElement(By.xpath("//div[@id='ResultsGridPanel']/div/span[@class='x-panel-header-text']"));
		return searchPanelHeader.getText();
	}
	public void clickAdvancedSearch() throws Exception {
		logger.info("clickAdvancedSearch");
		WebElement advancedSearchIcon = driver.findElement(By.id(getLocator("MyRoamPage.AdvancedSearchIcon")));
		advancedSearchIcon.click();
	}
	public void clickIncludeSubFolders() throws Exception {
		logger.info("clickIncludeSubFolders");
		WebElement includeSubFoldersCheckBox = driver.findElement(By.id(getLocator("MyRoamPage.IncludeSubFoldersCheckBox")));
		includeSubFoldersCheckBox.click();
	}
	public void clickCaseSensitive() throws Exception {
		logger.info("clickCaseSensitive");
		WebElement caseSensitiveCheckBox = driver.findElement(By.id(getLocator("MyRoamPage.CaseSensitiveCheckBox")));
		caseSensitiveCheckBox.click();
	}
	public void clickExcludeSubFolders() throws Exception {
		logger.info("clickExcludeSubFolders");
		WebElement excludeSubFoldersCheckBox = driver.findElement(By.id(getLocator("MyRoamPage.ExcludeFolderNamesCheckBox")));
		logger.info(excludeSubFoldersCheckBox.getValue());
		excludeSubFoldersCheckBox.click();
	}
	public void closeSearchResults() throws Exception {
		logger.info("Closing Search Results");
		WebElement closeSearchIcon = driver.findElement(By.xpath(getLocator("MyRoamPage.CloseSearchEnabled")));
		closeSearchIcon.click();
	}
	public KanawhaHomePage clickHomeLink() throws Exception {
		WebElement homeLink = driver.findElement(By.xpath(getLocator("MyRoamPage.HomeLink")));
		clickAndWaitForPageLoad(homeLink, 2);
		return (KanawhaHomePage) PageFactory.initElements(getDriver(), KanawhaHomePage.class);
		
	}
}
