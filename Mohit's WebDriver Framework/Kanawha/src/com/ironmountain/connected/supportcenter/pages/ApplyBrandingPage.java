package com.ironmountain.connected.supportcenter.pages;

import org.apache.log4j.Logger;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.PageFactory;

import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium.WebDriverPage;

public class ApplyBrandingPage extends WebDriverPage{
	private static final Logger logger = Logger.getLogger(ApplyBrandingPage.class.getName());
		
	public ApplyBrandingPage () throws Exception {
		super();
	}
	
	public void waitForPageLoad() throws Exception {
		waitForElementPresent("id:AcntMgmtSiteLogo", 1, 20);
	}
	public void typeSiteName(String siteName) {
		findElement(getDriver(), By.id("AcntMgmtSiteName")).clear();
		findElement(getDriver(), By.id("AcntMgmtSiteName")).sendKeys(siteName);
	}
	public void typeSiteHeaderImagePath(String imagePath) {
		findElement(getDriver(), By.id("AcntMgmtSiteLogo")).clear();
		findElement(getDriver(), By.id("AcntMgmtSiteLogo")).sendKeys(imagePath);
	}
	public void clickApply() {
		findElement(getDriver(), By.id("ApplyBrandingBtn")).click();
	}
	public Boolean getResetButtonStatus() {
		WebElement resetButton = findElement(getDriver(),By.xpath("//input[@value='Reset to Default Branding']"));
		logger.info(resetButton.getAttribute("disabled"));
		if(resetButton.getAttribute("disabled").equals("true")) {
			logger.info("Reset Button disabled. Community not branded");
			return false;
		}
		return true;
	}
	public void clickResetBranding() {
		WebElement resetButton = findElement(getDriver(),By.xpath("//input[@value='Reset to Default Branding']"));
		logger.info(resetButton.getAttribute("disabled"));
		if(resetButton.getAttribute("disabled").equals("true")) {
			logger.info("Reset Button disabled. Community not branded");
			return;
		}
		resetButton.click();
		/*findElement(getDriver(),By.name("212"));
		goTo(PropertyPool.getProperty("scprotocol")+"://"+PropertyPool.getProperty("schost")+"/supportcenter/nodeview.asp");*/
	}
	
	public void setPoweredByLogo() throws Exception {
		WebElement poweredByLogoCheckBox = findElement(getDriver(),By.id("chkPoweredBy"));
		logger.info("poweredByLogoCheckBox.getValue()="+poweredByLogoCheckBox.getValue());
		if(poweredByLogoCheckBox.getValue().equals("off")) {
			poweredByLogoCheckBox.click();
		}
	}
	
	public void unsetPoweredByLogo() throws Exception {
		WebElement poweredByLogoCheckBox = findElement(getDriver(),By.id("chkPoweredBy"));
		logger.info("poweredByLogoCheckBox.getValue()="+poweredByLogoCheckBox.getValue());
		if(poweredByLogoCheckBox.getValue().equals("on")) {
			poweredByLogoCheckBox.click();
		}
	}
}
