package com.ironmountain.connected.supportcenter.pages;

import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.support.PageFactory;

import com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium.WebDriverPage;

/** SupportCenter Login Page
 * @author mohit
 *
 */
public class SCLoginPage extends WebDriverPage{
	private static final Logger logger = Logger.getLogger(SCLoginPage.class.getName());
	protected String LOGIN_PAGE_REF = "SCLoginPage."; 

	public SCLoginPage () throws Exception {
		super();
	}
	
	/** Login to the SupportCenter Application
	 * @param username
	 * @param password
	 * @return Instance of SC Home Page Object.
	 * @throws Exception
	 */
	public static SCHomePage login (String username, String password) throws Exception {
		SCLoginPage scLoginPage = new SCLoginPage();
		scLoginPage.typeUserName(username);
		scLoginPage.typePassword(password);
		return scLoginPage.clickOnLogInBtn();
	}
	
	/** Type Username
	 * @param username
	 * @throws InterruptedException 
	 */
	public void typeUserName(String username) throws InterruptedException {
		String loc = getLocator(LOGIN_PAGE_REF+"UserName");
		logger.info(loc);
		waitForElementPresent("xpath:"+loc,1,20);
		findElement(getDriver(), By.id(loc)).clear();
		sendKeys(findElement(getDriver(), By.id(loc)), username);
	}
	
	/** Type Password
	 * @param password
	 */
	public void typePassword(String password) {
		String loc = getLocator(LOGIN_PAGE_REF+"Password");
		sendKeys(findElement(getDriver(), By.id(loc)), password);
	}
	
	/** Click on Login Button
	 * @return
	 * @throws Exception
	 */
	public SCHomePage clickOnLogInBtn() throws Exception {
		String loc = getLocator(LOGIN_PAGE_REF+"LoginBtn");
		clickAndWaitForPageLoad(getDriver().findElement(By.xpath(loc)),5);
		return (SCHomePage) PageFactory.initElements(getDriver(), SCHomePage.class);
	}
	
	
}

