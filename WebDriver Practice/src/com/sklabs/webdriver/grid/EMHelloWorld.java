package com.sklabs.webdriver.grid;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.Set;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.Cookie;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;


public class EMHelloWorld {
	static WebDriver driver = null;
	public static void login() throws Exception {
		driver.findElement(By.id("j_username::content")).sendKeys("sysman");
		driver.findElement(By.id("j_password::content")).sendKeys("sysman");
		driver.findElement(By.id("login")).click();
		Thread.sleep(10000);
	}
	public static void gotoJobLibrary() throws Exception {
		driver.findElement(By.id("emT:grid")).click();
		Thread.sleep(1000);
		driver.findElement(By.id("emT:grid_job")).click();
		Thread.sleep(1000);
		driver.findElement(By.id("emT:grid_goto_job_library")).click();
		Thread.sleep(10000);
	}
	public static void selectUIXFrame() {
		driver.switchTo().frame(driver.findElement(By.id("emT:emUIXFrame::f")));
	}
	
	public static void logout() throws Exception {
		
		driver.findElement(By.id("emT:file_log_out")).click();
		Thread.sleep(10000);
	}
	public static void detectSecurityBugs() {
		Set<Cookie> allCookies = driver.manage().getCookies();
		/* Code in EM Selenium perl fwk
		 *  if(allCookies[i].search(/(JSESSION|orasso|s_cc|ORA_WX_SESSION|oracle.uix)/gi) == -1) {$
		 */
		System.out.println("The number of cookies are "+ allCookies.size());
		for(Cookie c : allCookies) {
			System.out.println("Cookie name : " + c.getName());
			if (c.getName().matches("JSESSION|orasso|s_cc|ORA_WX_SESSION|oracle.uix") || c.getValue().matches("JSESSION|orasso|s_cc|ORA_WX_SESSION|oracle.uix")) {
				System.out.println("Security issue found");
			}
		}
	}
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		driver = new FirefoxDriver();
		driver.get("https://slc01awb.us.oracle.com:4473/em");
		try {
			login();
			detectSecurityBugs();
			gotoJobLibrary();
			selectUIXFrame();
			if ( driver.findElement(By.xpath("//*[@id=\"jobsTable\"]/table[1]/tbody/tr/td/table/tbody/tr/td[1]/button[3]")) == null) {
				System.out.println("I don't see the edit button");
			}
			else {
				driver.findElement(By.xpath("//*[@id=\"jobsTable\"]/table[1]/tbody/tr/td/table/tbody/tr/td[1]/button[3]")).click();
				System.out.println("I see the edit button");
				Thread.sleep(10000);
			}
			driver.switchTo().defaultContent();
			detectSecurityBugs();
			logout();
			
		} catch(Exception ie) {
			ie.printStackTrace();
		} 
		driver.close();
	}

}
