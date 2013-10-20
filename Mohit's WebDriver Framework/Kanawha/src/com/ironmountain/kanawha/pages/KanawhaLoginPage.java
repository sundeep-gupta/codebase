package com.ironmountain.kanawha.pages;

import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.PageFactory;

import com.ironmountain.kanawha.tests.settings.SettingsTest;
import com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium.WebDriverPage;

/** Kanawha Login Page
 * @author pjames
 *
 */
public class KanawhaLoginPage extends WebDriverPage{
	private static final Logger logger = Logger.getLogger(KanawhaLoginPage.class.getName());
	protected String HOME_PAGE_REF = "HomePage.";
	protected String LOGIN_PAGE_REF = "KaLoginPage."; 

	public KanawhaLoginPage () throws Exception {
		super();
	}
	
	/** Login to the Kanawha Application
	 * @param username
	 * @param password
	 * @return Instance of SSWS Home Page Object.
	 * @throws Exception
	 */
	public static KanawhaHomePage login (String username, String password) throws Exception {
		KanawhaLoginPage sswsLoginPage = new KanawhaLoginPage();
		sswsLoginPage.typeUserName(username);
		sswsLoginPage.typePassword(password);
		Thread.sleep(1000);
		return sswsLoginPage.clickOnLogInBtn();
	}
	public static KanawhaHomePage login (KanawhaLoginPage sswsLoginPage, String username, String password) throws Exception {
		
		sswsLoginPage.typeUserName(username);
		sswsLoginPage.typePassword(password);
		return sswsLoginPage.clickOnLogInBtn();
	}
	/** Type Username
	 * @param username
	 * @throws InterruptedException 
	 */
	public void typeUserName(String username) throws InterruptedException {
		String loc = getLocator(LOGIN_PAGE_REF+"UserName");
		logger.info("Wait for User name field");
		waitForElementPresent("id:"+getLocator(LOGIN_PAGE_REF+"UserName"), 1, 60);
		WebElement usernameInput = findElement(getDriver(), By.id(loc));
		sendKeys(usernameInput, username);
		if(!usernameInput.getValue().equals(username)) {
			usernameInput.clear();
			sendKeys(usernameInput, username);
		}
	}
	
	/** Type Password
	 * @param password
	 */
	public void typePassword(String password) {
		String loc = getLocator(LOGIN_PAGE_REF+"Password");
		sendKeys(findElement(getDriver(), By.name(loc)), password);
	}
	
	/** Click on Login Button
	 * @return
	 * @throws Exception
	 */
	public KanawhaHomePage clickOnLogInBtn() throws Exception {
		String loc = getLocator(LOGIN_PAGE_REF+"LoginBtn");
		clickAndWaitForPageLoad(getDriver().findElement(By.xpath(loc)),10);
		return (KanawhaHomePage) PageFactory.initElements(getDriver(), KanawhaHomePage.class);
	}
	
	
}
