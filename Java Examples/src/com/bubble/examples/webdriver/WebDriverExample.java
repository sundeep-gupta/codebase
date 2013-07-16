package com.istack.examples;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.PageFactory;
import com.istack.examples.LoginPage;
public class WebDriverExample {

	/**
	 * @param args
	 * @throws InterruptedException 
	 */
    public static void main(String[] args) throws InterruptedException {
        // Create a new instance of the html unit driver
        // Notice that the remainder of the code relies on the interface, 
        // not the implementation.
        WebDriver driver = new FirefoxDriver();
        driver.get("https://blr2202007.idc.oracle.com:4473/em");
        
        LoginPage loginPage = PageFactory.initElements(driver, com.istack.examples.LoginPage.class);
        loginPage.login("TESTSUPERADMIN", "welcome1");
        // And now use this to visit Google
        Thread.sleep(3000);
        
        // Find the text input element by its name
        /*driver.findElement(By.id("j_username::content")).sendKeys("TESTSUPERADMIN");
        driver.findElement(By.id("j_password::content")).sendKeys("welcome1");
        driver.findElement(By.id("login")).click();
        Thread.sleep(10000);*/
        // Check the title of the page
        System.out.println("Page title is: " + driver.getTitle());
        
        driver.close();
            }
}
