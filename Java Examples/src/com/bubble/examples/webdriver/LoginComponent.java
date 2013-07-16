package com.istack.examples;

import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.Point;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.LoadableComponent;

public class LoginComponent extends LoadableComponent<LoginComponent> {
    WebDriver driver = null;
    
    @FindBy(id="j_username::content")
    WebElement username;
    
    @FindBy(id="j_password::password")
    WebElement password;
    
    @FindBy(id="login") 
    WebElement loginBtn;
    		
	public LoginComponent(WebDriver driver ) {
		this.driver = driver;
		PageFactory.initElements(driver, this);
	}
	protected void load() {
		
	}
	
	protected void isLoaded() throws Error {
		
	}
}
