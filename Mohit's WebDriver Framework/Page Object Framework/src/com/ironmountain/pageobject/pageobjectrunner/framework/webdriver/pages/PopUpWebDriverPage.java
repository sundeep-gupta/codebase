package com.ironmountain.pageobject.pageobjectrunner.framework.webdriver.pages;

import org.openqa.selenium.WebDriver;

import com.ironmountain.pageobject.pageobjectrunner.framework.webdriver.pages.BaseWebDriverPage;
/**
 * 
 * @author Pradeep Kote
 *
 */
public class PopUpWebDriverPage extends BaseWebDriverPage {
	/**
	 * This holds the handle of parent window from which this popup is invoked
	 * This handle is used while switching between windows  
	 */	
	private String parentWindowHandle = null;
	
	public PopUpWebDriverPage (WebDriver webDriver, String parentWindowHandle) {
		super (webDriver);
		this.parentWindowHandle = parentWindowHandle;
	}
	
	public String getParentWindowHandle() {
		return parentWindowHandle;
	}
	
	public void setParentWindowHandle(String parentWindowHandle) {
		this.parentWindowHandle = parentWindowHandle;
	}
}
