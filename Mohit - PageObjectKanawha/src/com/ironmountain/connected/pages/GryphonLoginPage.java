package com.ironmountain.connected.pages;

import java.sql.Driver;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.PageFactory;

import com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium.WebDriverPage;


import com.thoughtworks.selenium.Selenium;

public class GryphonLoginPage extends WebDriverPage {

	protected String HOME_PAGE_REF = "HomePage.";
	protected String LOGIN_PAGE_REF = "LoginPage.";
	
	public GryphonLoginPage()
	{
		super();
	}
	
	/**
	 * Use it for login into application by passing the credentials
	 * @param email
	 * @param password
	 * @return GryphonHomePage page
	 * @throws Exception
	 */
	public static GryphonHomePage login (String email, String password) throws Exception {
		GryphonLoginPage gryLoginPage = new GryphonLoginPage(); 
		gryLoginPage.typeEmailAddress(email);
		gryLoginPage.typePassword(password);		
		return gryLoginPage.clickOnLogInButton();
	}
	
	/**
	 * Use it for putting email address
	 * @param emailAddress
	 */
	public void typeEmailAddress(String emailAddress) {
		String loc = getLocator(LOGIN_PAGE_REF+"Username");
		sendKeys(findElement(getDriver(), By.id(loc)), emailAddress);
	}
	
	/**
	 * Use it for putting password
	 * @param password
	 */
	public void typePassword(String password) {
		String loc = getLocator(LOGIN_PAGE_REF+"Password");
		sendKeys(findElement(getDriver(), By.id(loc)), password);
	}
		
	/**
	 * Use it for clicking the Login button
	 * @return GryphonhomePage
	 * @throws Exception
	 */	
	public GryphonHomePage clickOnLogInButton() throws Exception {
			String loc = getLocator(LOGIN_PAGE_REF+"LoginBtn");
			clickAndWaitForPageLoad(getDriver().findElement(By.xpath(loc)),20);
			//waitforElementuntilitisrendered(getDriver(), By.xpath(com.ironmountain.pageobject.pageobjectrunner.framework.LocatorPool.getLocator(HOME_PAGE_REF+"Home")));
			return (GryphonHomePage) PageFactory.initElements(getDriver(), GryphonHomePage.class); 
	}
	
	
}
