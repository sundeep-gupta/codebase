package com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebDriverBackedSelenium;

import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;

/**
 * 
 * @author spozdnyakov
 *
 */

public class WebDriverSeleniumPage extends SeleniumPage {

	/**
	 * Get the underlying WebDriver implementation back 
	 * @return WebDriver
	 */
	public WebDriver getWebDriver(){
		WebDriver driverInstance = ((WebDriverBackedSelenium) selenium).getUnderlyingWebDriver();
		return driverInstance;
	}
	

}
