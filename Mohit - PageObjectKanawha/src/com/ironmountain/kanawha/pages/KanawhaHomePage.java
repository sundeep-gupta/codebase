package com.ironmountain.kanawha.pages;

import java.util.ArrayList;
import java.util.Set;

import org.apache.commons.lang.ArrayUtils;
import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.PageFactory;

import com.ironmountain.kanawha.tests.apitests.AccountMessagesTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium.WebDriverPage;
import com.thoughtworks.selenium.Selenium;

/** Kanawha Home Page
 * @author pjames
 *
 */
public class KanawhaHomePage extends WebDriverPage {
	
	private static final Logger logger = Logger.getLogger(KanawhaHomePage.class.getName());
	protected String HOME_PAGE_REF = "HomePage.";
	protected String LOGIN_PAGE_REF = "KaLoginPage."; 
	String loc = null;
	
	
	public KanawhaHomePage() throws Exception {
		super();
		driver = getDriver();
	}
	
	
	public MyRoamPage goToMyRoamPage() throws Exception{
		loc = getLocator(HOME_PAGE_REF+"MyRoamLink");
		clickAndWaitForPageLoad(findElement(driver, By.linkText(loc)), 4);
		waitForIndicator("Loading....",1,60);
		return (MyRoamPage) PageFactory.initElements(getDriver(), MyRoamPage.class);
	}
	
	
	/** Verifies for the header text
	 * @param welcometext
	 * @return true/false
	 */
	public boolean verifyHeaderText(String welcometext) {
		boolean res = false;
		String loc = getLocator(HOME_PAGE_REF+"HeaderClass");
		String txt = findElement(getDriver(), By.xpath(loc)).getText();
		if (txt.contains(welcometext)){
			res = true;
		} else {
			res = false;
		}
		return res;
	}
	
	/** Verifies for the correct dialog
	 * @return true/false
	 */
	public boolean verifyInvalidCredsWindow() {
		boolean res = false;
		loc = getLocator(LOGIN_PAGE_REF+"InvalidLoginDialogText");
		String searchtxt = findElement(getDriver(), By.xpath(loc)).getText();
		if (searchtxt.equalsIgnoreCase("Wrong Username or Password.")) {
			res = true;
		}
		return res;
	}
	
	/** Click on the OK button of the Invalid Credentials Window
	 * 
	 */
	public void clickOnOkOnInvalidCredsDialog(){
		loc = getLocator(LOGIN_PAGE_REF+"OKBtn");
		clickAndWaitForPageLoad(findElement(getDriver(), By.xpath(loc)), 5);
	}
	
	/** Get Account Messages Panel Header Text
	 * @return MessagePanelHeaderText
	 * @throws InterruptedException 
	 */
	public String getAccountMessagesHeaderText() throws InterruptedException {
		loc = getLocator(HOME_PAGE_REF+"MessagesPanelHeaderTextLoc");
		waitForElementPresent("xpath:"+loc, 1, 5);
		logger.info(findElement(getDriver(), By.xpath(loc)).getText());
		return findElement(getDriver(), By.xpath(loc)).getText();
	}
	
	/** Get Account Messages Panel Header Columns
	 * @return MessagePanelHeaderColumns
	 */
	public String[] getAccountMessagesHeaderColumns() {
		loc = getLocator(HOME_PAGE_REF+"MessagesPanelHeaderColumnsLoc");
		logger.info(findElement(getDriver(), By.xpath(loc)).getText().split("\n").toString());
		return findElement(getDriver(), By.xpath(loc)).getText().split("\n");
	}
	
	/** Get Account Messages From Kanawha webapp home page's messages panel
	 * @return AccountMessages
	 * @throws InterruptedException 
	 */
	public ArrayList<String[]> getAccountMessages() throws InterruptedException {
		Thread.sleep(5000);//To Be Removed once Loading indicator is available on homepage
		loc = getLocator(HOME_PAGE_REF+"MessagesTable");

		WebElement row;
		String[] rowText = new String[4];
		ArrayList<String[]> messages = new ArrayList<String[]>();
		
		//return findElement(getDriver(), By.xpath(loc+"")).getText().split("\n");
		for(int i = 1; i < 1000 ; i++) {
			if(isElementPresent(getDriver(), By.xpath(loc+"/div["+i+"]"))) {
				row = findElement(getDriver(),By.xpath(loc+"/div["+i+"]"));
				logger.info("row tag="+row.getTagName()+" class="+row.getAttribute("class")+ " text="+row.getText());
				logger.info("img tag="+row.findElement(By.xpath("table/tbody/tr/td[1]/div/img")).getTagName()+" src="+row.findElement(By.xpath("table/tbody/tr/td[1]/div/img")).getAttribute("src"));
				if(isElementPresent(row, By.xpath("table/tbody/tr/td[1]/div/img[@src='images/framework/info_16.png']"))) {
					rowText[0] = "info";
				}else if(isElementPresent(row, By.xpath("table/tbody/tr/td[1]/div/img[@src='images/framework/failed.png']"))) {
					rowText[0] = "failed";
				}
				else {
					rowText[0] = "unknown";
				}
				rowText[1] = row.findElement(By.xpath("table/tbody/tr/td[2]")).getText();//device
				rowText[2] = row.findElement(By.xpath("table/tbody/tr/td[3]")).getText();//date
				rowText[3] = row.findElement(By.xpath("table/tbody/tr/td[4]/div")).getText();//message
				
				messages.add(rowText);
				rowText = new String[4];
			}else{
				break;
			}
		}
		logger.info(messages.toString());
		return messages;
	}
	
	public KanawhaLoginPage logoff() {
		//clickAndWaitForPageLoad(findElement(getDriver(),By.linkText("Logout")),20);
		String logoffUrl = PropertyPool.getProperty("kanawhaprotocol") + PropertyPool.getProperty("kanawhaurl") + PropertyPool.getProperty("kanawhalogoffurl");
		getDriver().get(logoffUrl);
		return (KanawhaLoginPage) PageFactory.initElements(getDriver(), KanawhaLoginPage.class);
	}
	
	public void clickSortBy(String column, String order) throws Exception {
		logger.info("Clicking " + column + " column to sort in " + order + " order");
		findElement(getDriver(),By.xpath(getLocator(HOME_PAGE_REF + column + "SortIcon"))).click();
		Thread.sleep(500);
		if(order.equals("asc")) {
			findElement(getDriver(),By.xpath(getLocator(HOME_PAGE_REF + "FloatingSortMenu") + "/ul/li[1]")).click();
		}else if(order.equals("desc")) {
			findElement(getDriver(),By.xpath(getLocator(HOME_PAGE_REF + "FloatingSortMenu") + "/ul/li[2]")).click();
		}else {
			throw new Exception("Unrecognised sorting option specified");
		}
		
		Thread.sleep(500);
	}
	
	public void clickSortBy(String column) throws Exception {
		logger.info("Clicking " + column + " column to sort");
		findElement(getDriver(),By.xpath(getLocator(HOME_PAGE_REF + column + "SortIcon"))).click();
		Thread.sleep(500);
	}
	
	public KanawhaHomePage refreshPage() {
		this.refresh();
		return (KanawhaHomePage) PageFactory.initElements(getDriver(), KanawhaHomePage.class);
	}
	
	public void waitForPageLoad() throws InterruptedException {
		logger.info("Wait for Settings link on home page");
		waitForElementPresent("link:"+getLocator(HOME_PAGE_REF + "SettingsLink"),1,60);
	}
	
	public SettingsPage gotoSettingsPage() throws Exception {
		clickAndWaitForPageLoad(findElement(getDriver(),By.linkText(getLocator(HOME_PAGE_REF + "SettingsLink"))), 5);
		return (SettingsPage) PageFactory.initElements(getDriver(), SettingsPage.class);
	}
	
	public String getLogoImage() throws Exception {
		return findElement(getDriver(),By.id(getLocator(HOME_PAGE_REF + "logoImage"))).getAttribute("src");
	}
}
