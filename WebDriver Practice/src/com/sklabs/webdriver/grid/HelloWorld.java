package com.sklabs.webdriver.grid;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;

public class HelloWorld {

	/**
	 * @param args
	 */
	public static void main(String[] args)  throws MalformedURLException{
		// TODO Auto-generated method stub
		/*
		WebDriver driver = new FirefoxDriver();
		driver.get("http://www.google.com/");
		try {
			Thread.sleep(10000);
		} catch(InterruptedException ie) {
			
		}
		driver.close();
		*/
		DesiredCapabilities capability = DesiredCapabilities.firefox();
		WebDriver driver = null;
		try {
			driver = new RemoteWebDriver(new URL("http://127.0.0.1:4444/wd/hub"), capability);
		} catch (MalformedURLException mfue) {
			System.out.println("The URL is incorrect.");
			return;
		}
		try {
		driver.manage().timeouts().implicitlyWait(20, TimeUnit.SECONDS);
		driver.manage().timeouts().pageLoadTimeout(30, TimeUnit.SECONDS);
		driver.manage().window().setSize(new Dimension(1920, 1080));
		driver.get("http://www.google.com/");
		driver.findElement(By.xpath("(//input[@name='q'])[last()]"));
		
			Thread.sleep(10000);
		} catch(InterruptedException ie) {
			
		} finally {
			driver.close();
		}
	}

}
