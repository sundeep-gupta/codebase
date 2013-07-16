package com.ironmountain.kanawha.tests.myroam;

import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;

import org.apache.commons.collections.map.MultiValueMap;
import org.apache.log4j.Logger;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.ironmountain.kanawha.commons.CommonUtils;
import com.ironmountain.kanawha.pages.KanawhaHomePage;
import com.ironmountain.kanawha.pages.KanawhaLoginPage;
import com.ironmountain.kanawha.pages.MyRoamPage;
import com.ironmountain.kanawha.tests.KanawhaTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumUITest;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;

@SeleniumUITest
public class MyRoamSearchTest extends KanawhaTest{
	private static final Logger logger = Logger.getLogger(MyRoamSearchTest.class.getName());
	private static HashMap<String, String> testInput = new HashMap<String,String>();
	private static HashMap<String, String> testOutput = new HashMap<String,String>();
	
	@BeforeMethod(alwaysRun= true)
	public void startTest() throws Exception {
		logger.info("startTest");
		super.initKanawhaTest("firefox");
		logger.info("loadTestDataXML");
		TestDataProvider.loadTestDataXML(FileUtils.getBaseDirectory()+"/src/com/ironmountain/kanawha/tests/myroam/testdata", "myRoamSearch.xml");		
	}

	/**
	 * Tests to verify the myroam search functionality
	 * 
	 * @param Username
	 * @param Password
	 * @throws Exception
	 */
	@Parameters( {"username", "password"})
	@Test(enabled = true)
	public void search(String username, String password) throws Exception {	
		logger.info("Begin test search");
		testInput = TestDataProvider.getTestInput("search");
		KanawhaHomePage homePage = KanawhaLoginPage.login(username, password);
		homePage.waitForPageLoad();
		MyRoamPage myRoamPage = homePage.goToMyRoamPage();
		
		String deviceName = CommonUtils.getDeviceName(username);
		//myRoamPage.selectDevice(deviceName);
		String selectedDevice = myRoamPage.getSelectedDevice();
		Assert.assertEquals(selectedDevice, deviceName, "Unexpected device selected");
		
		//Verify the status of Search input box and button is disabled
		Assert.assertEquals(myRoamPage.isSearchBoxEnabled(), false, "Search Box must not be enabled");
		Assert.assertEquals(myRoamPage.isSearchButtonEnabled(), false, "Search Button must not be enabled");
		Assert.assertEquals(myRoamPage.isElementPresent("xpath:"+myRoamPage.getLocator("MyRoamPage.CloseSearchDisabled")),true,"Close Search icon not found or it should not be enabled");
		
		myRoamPage.clickOnRootNode();
		
		//Verify the status of Search input box and button is enabled
		Assert.assertEquals(myRoamPage.isSearchBoxEnabled(), true, "Search Box must be enabled");
		Assert.assertEquals(myRoamPage.isSearchButtonEnabled(), true, "Search Button must be enabled");
		Assert.assertEquals(myRoamPage.isElementPresent("xpath:"+myRoamPage.getLocator("MyRoamPage.CloseSearchDisabled")),true,"Close Search icon not found or it should not be enabled");
		
		//Enter the search criteria, click on Search button and wait
		logger.info("Searching for "+testInput.get("searchCriteria1"));
		myRoamPage.searchAndWait(testInput.get("searchCriteria1"), "", 10);
		
		validateSearchResultsLayout(myRoamPage);
		validateSearchResults(myRoamPage, "search", "searchCriteria1");
		Assert.assertEquals(myRoamPage.isElementPresent("xpath:"+myRoamPage.getLocator("MyRoamPage.CloseSearchEnabled")),true,"Close Search icon not found or it is not enabled");
		//Close Search Results
		myRoamPage.closeSearchResults();
	}
	
	@Parameters( {"username", "password"})
	@Test(enabled = true)
	public void advancedSearch(String username, String password) throws Exception {
		logger.info("Begin test advancedSearch");
		testInput = TestDataProvider.getTestInput("advancedSearch");
		KanawhaHomePage homePage = KanawhaLoginPage.login(username, password);
		homePage.waitForPageLoad();
		MyRoamPage myRoamPage = homePage.goToMyRoamPage();
		
		String deviceName = CommonUtils.getDeviceName(username);
		//myRoamPage.selectDevice(deviceName);
		String selectedDevice = myRoamPage.getSelectedDevice();
		Assert.assertEquals(selectedDevice, deviceName, "Unexpected device selected");
		
		//Verify the status of Search input box and button is disabled
		Assert.assertEquals(myRoamPage.isSearchBoxEnabled(), false, "Search Box must not be enabled");
		Assert.assertEquals(myRoamPage.isSearchButtonEnabled(), false, "Search Button must not be enabled");
		Assert.assertEquals(myRoamPage.isElementPresent("xpath:"+myRoamPage.getLocator("MyRoamPage.CloseSearchDisabled")),true,"Close Search icon not found or it should not be enabled");
		
		myRoamPage.clickOnRootNode();
		
		//Verify the status of Search input box and button is enabled
		Assert.assertEquals(myRoamPage.isSearchBoxEnabled(), true, "Search Box must be enabled");
		Assert.assertEquals(myRoamPage.isSearchButtonEnabled(), true, "Search Button must be enabled");
		Assert.assertEquals(myRoamPage.isElementPresent("xpath:"+myRoamPage.getLocator("MyRoamPage.CloseSearchDisabled")),true,"Close Search icon not found or it should not be enabled");

		myRoamPage.clickAdvancedSearch();
		
		validateAdvancedSearchPanel(myRoamPage);
		
		//Enter the search criteria, click on Search button and wait
		logger.info("Searching for "+testInput.get("searchCriteria1"));
		myRoamPage.searchAndWait(testInput.get("searchCriteria1"), "", 10);
		validateSearchResultsLayout(myRoamPage);
		validateSearchResults(myRoamPage, "advancedSearch", "searchCriteria1");
		
		//Close Search Results
		myRoamPage.closeSearchResults();
		
		myRoamPage.highlightFolder(testInput.get("searchDataFolder"));
		
		//Perform Case Sensitive search only
		logger.info("Perform Case Sensitive search only"); 
		myRoamPage.clickIncludeSubFolders();//uncheck the include sub folders option
		myRoamPage.clickCaseSensitive();// check the case sensitive option
		logger.info("Searching for "+testInput.get("caseSensitive"));
		
		
		myRoamPage.searchAndWait(testInput.get("caseSensitive"), "", 10);
		
		validateSearchResultsLayout(myRoamPage);
		
		validateSearchResults(myRoamPage, "advancedSearch", "caseSensitive");
		
		//Perform exclude sub folders search only
		logger.info("Perform exclude sub folders search only");
		myRoamPage.clickCaseSensitive();// uncheck the case sensitive option
		myRoamPage.clickExcludeSubFolders(); //check the exclude sub folders option
		logger.info("Searching for "+testInput.get("excludeFolderNames"));
		myRoamPage.searchAndWait(testInput.get("excludeFolderNames"), "", 10);
		validateSearchResultsLayout(myRoamPage);
		validateSearchResults(myRoamPage, "advancedSearch", "excludeFolderNames");
		
		//Goto Home Page and return back
		homePage = myRoamPage.clickHomeLink();
		homePage.waitForPageLoad();
		myRoamPage = homePage.goToMyRoamPage();
		
		//Uncheck all three options
		logger.info("Perform search with all three options unchecked");
		myRoamPage.clickExcludeSubFolders();//uncheck exclude subfolders
		logger.info("Searching for " + testInput.get("noOptionsSelected"));
		myRoamPage.searchAndWait(testInput.get("noOptionsSelected"), "", 10);
		validateSearchResultsLayout(myRoamPage);
		validateSearchResults(myRoamPage, "advancedSearch", "noOptionsSelected");
		
		//Close Search Results
		myRoamPage.closeSearchResults();
	}
	
	@Parameters( {"username", "password"})
	@Test(enabled = true)
	public void contentSearch(String username, String password) throws Exception {
		logger.info("Begin test contentSearch");
		testInput = TestDataProvider.getTestInput("contentSearch");
		KanawhaHomePage homePage = KanawhaLoginPage.login(username, password);
		homePage.waitForPageLoad();
		MyRoamPage myRoamPage = homePage.goToMyRoamPage();
		
		String deviceName = CommonUtils.getDeviceName(username);
		//myRoamPage.selectDevice(deviceName);
		String selectedDevice = myRoamPage.getSelectedDevice();
		Assert.assertEquals(selectedDevice, deviceName, "Unexpected device selected");
		
		//Verify the status of Search input box and button is disabled
		Assert.assertEquals(myRoamPage.isSearchBoxEnabled(), false, "Search Box must not be enabled");
		Assert.assertEquals(myRoamPage.isSearchButtonEnabled(), false, "Search Button must not be enabled");
		Assert.assertEquals(myRoamPage.isElementPresent("xpath:"+myRoamPage.getLocator("MyRoamPage.CloseSearchDisabled")),true,"Close Search icon not found or it should not be enabled");
		
		myRoamPage.clickOnRootNode();
		
		//Verify the status of Search input box and button is enabled
		Assert.assertEquals(myRoamPage.isSearchBoxEnabled(), true, "Search Box must be enabled");
		Assert.assertEquals(myRoamPage.isSearchButtonEnabled(), true, "Search Button must be enabled");
		Assert.assertEquals(myRoamPage.isElementPresent("xpath:"+myRoamPage.getLocator("MyRoamPage.CloseSearchDisabled")),true,"Close Search icon not found or it should not be enabled");

		myRoamPage.highlightFolder(testInput.get("searchDataFolder"));
		
		myRoamPage.clickAdvancedSearch();
		
		validateAdvancedSearchPanel(myRoamPage);
		
		//Enter the search criteria, click on Search button and wait
		logger.info("Searching for "+testInput.get("searchCriteria1"));
		myRoamPage.searchAndWait("", testInput.get("searchCriteria1"),60);
		validateSearchResultsLayout(myRoamPage);
		validateSearchResults(myRoamPage, "contentSearch", "searchCriteria1");
		
		//Close Search Results
		myRoamPage.closeSearchResults();

	}

	private void validateSearchResultsLayout(MyRoamPage myRoamPage) throws Exception {
		Assert.assertEquals(myRoamPage.getSearchPanelHeaderText(),"Search Results","Unexpected Search Panel Header Text");
		String[] expSearchResultsHeader = {"Type","Name","In Folder","Size","Date Modified"};
		String[] actualSearchResultsHeader = myRoamPage.getSearchResultsHeader();
		Assert.assertEquals(actualSearchResultsHeader.length,expSearchResultsHeader.length , "There may be a column(s) missing or added in the Search Results\n"+actualSearchResultsHeader);
		for(int i=0; i < expSearchResultsHeader.length ; i++) {
			Assert.assertEquals(actualSearchResultsHeader[i], expSearchResultsHeader[i], expSearchResultsHeader[i] + " column missing in Search Results");
		}
		Assert.assertEquals(myRoamPage.isElementPresent("xpath:"+myRoamPage.getLocator("MyRoamPage.CloseSearchEnabled")),true,"Close Search icon not found or it is not enabled");
	}
	
	private void validateAdvancedSearchPanel(MyRoamPage myRoamPage) throws Exception {
		Assert.assertEquals(myRoamPage.isElementPresent("id:"+myRoamPage.getLocator("MyRoamPage.AdvancedSearchIcon")),true,"Advanced Search expand/collapse icon not found");
		Assert.assertEquals(myRoamPage.isElementPresent("xpath:"+myRoamPage.getLocator("MyRoamPage.ContentSearchLabel")),true,"Advanced Search content search label not found");
		Assert.assertEquals(myRoamPage.isElementPresent("id:"+myRoamPage.getLocator("MyRoamPage.ContentSearchInputBox")),true,"Advanced Search content search input box not found");
	}	
	@SuppressWarnings("unchecked")
	private void validateSearchResults(MyRoamPage myRoamPage, String testName, String criteria) throws Exception {
		logger.info("Validating Search Results for criteria " + criteria);
		MultiValueMap actSearchResults = myRoamPage.getSearchResults();
		logger.info("Size of actSearchResults = "+actSearchResults.size());
		MultiValueMap searchOutput = TestDataProvider.getMultiValueTestOutput(testName,criteria);
		logger.info("Size of searchOutput = "+searchOutput.size());
		
		for (Object key : searchOutput.keySet()) {
			logger.info("key="+key.toString());
			logger.info(searchOutput.getCollection(key).size());
			Collection<String> col = searchOutput.getCollection(key);
			for(Iterator<String> it = col.iterator(); it.hasNext();) {
				String str = it.next();
				logger.info(str);
				String regex = "\\|";
				String[] fileInfo = str.split(regex);
				logger.info(fileInfo.length);
				logger.info(fileInfo[0]);
				Assert.assertEquals(actSearchResults.containsKey(fileInfo[0]),true,fileInfo[0]+" not found in the Search Results on UI");
				//TBD: Compare each column value in search results rows
			}
		}
	}

	@AfterMethod(alwaysRun= true)
	public void stopTest() throws Exception {
		super.stopWebDriverTest();
	}

}
