package com.istack.examples;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;


public class LoginPage {
	
	@FindBy(id="j_username::content")
	WebElement username;
	
	@FindBy(id="j_password::content")
	WebElement password;
	
	@FindBy(id="login")
	WebElement loginButton;
	
	public void login(String username, String password) throws InterruptedException {
		this.username.sendKeys(username);
		
		this.password.sendKeys(password);
		loginButton.click();	
		Thread.sleep(3000);
	}

}
