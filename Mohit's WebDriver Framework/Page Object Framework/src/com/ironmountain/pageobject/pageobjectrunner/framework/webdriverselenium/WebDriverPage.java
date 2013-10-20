package com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium;

import java.net.URL;
import java.util.Set;

import org.openqa.selenium.By;
import org.openqa.selenium.Cookie;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.NoSuchFrameException;
import org.openqa.selenium.NoSuchWindowException;
import org.openqa.selenium.RenderedWebElement;
import org.openqa.selenium.Speed;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.WebDriver.Timeouts;
import org.testng.Assert;

import com.ironmountain.pageobject.pageobjectrunner.framework.LocatorPool;



public class WebDriverPage extends WebDriverElement{


	protected WebDriver driver		= null;
	
	
	public WebDriverPage() {
		super();
		if(driver == null){
		driver = WebDriverTest.getDriver();
		}
	}
	
	
	/**
	 * 
	 * @return WebDriver instance
	 */
	public WebDriver getDriver(){
		return driver;
	}


	//               WEB DRIVER           //



	/**
	 * Load a new web page in the current browser window. 
	 * This is done using an HTTP GET operation, and the 
	 * method will block until the load is complete. This 
	 * will follow redirects issued either by the server or 
	 * as a meta-redirect from within the returned HTML. 
	 * Should a meta-redirect "rest" for any duration of time, 
	 * it is best to wait until this timeout is over, since 
	 * should the underlying page change while your test is 
	 * executing the results of future calls against this 
	 * interface will be against the freshly loaded page. 
	 * Synonym for WebDriverTest.goTo(String). 
	 */
	public void get(String url) {
		driver.get(url);

	}

	/**
	 * Get a string representing the current URL that the browser is looking at. 
	 * @return The URL of the page currently loaded in the browser
	 */
	public String getCurrentUrl() {
		return driver.getCurrentUrl();

	}

	/**
	 * The title of the current page. 
	 * @return The title of the current page, 
	 * with leading and trailing whitespace stripped, or null if one is not already set
	 */
	public String getTitle() {
		return driver.getTitle();
	}


	/**
	 * Get the source of the last loaded page. If the page has 
	 * been modified after loading (for example, by Javascript) 
	 * there is no guarentee that the returned text is that of 
	 * the modified page. Please consult the documentation of 
	 * the particular driver being used to determine whether 
	 * the returned text reflects the current state of the page 
	 * or the text last sent by the web server. The page source 
	 * returned is a representation of the underlying DOM: do 
	 * not expect it to be formatted or escaped in the same way 
	 * as the response sent from the web server. 
	 * @return The source of the current page
	 */
	public String getPageSource() {
		return driver.getPageSource();
	}

	/**
	 * Close the current window, quitting the browser if it's the 
	 * last window currently open. 
	 */
	public void close() {
		driver.close();
	}
	
	/**
	 * Quits this driver, closing every associated window
	 */
	public void quit(){
		driver.quit();
	}

	/**
	 * Return a set of window handles which can be used to iterate 
	 * over all open windows of this webdriver instance by passing 
	 * them to #switchTo().window(String) 
	 * @return A set of window handles which can be used to iterate 
	 * over all open windows.
	 */
	public Set<String> getWindowHandles() {
		return driver.getWindowHandles();
	}

	/**
	 * 
	 * @return Return an opaque handle to this window that uniquely 
	 * identifies it within this driver instance. This can be used 
	 * to switch to this window at a later date 
	 */
	public String getWindowHandle() {
		return driver.getWindowHandle();
	}



	//     NAVIGATION    //


	/**
	 * Move back a single "item" in the browser's history. 
	 */
	public void back() {
		driver.navigate().back();

	}

	/**
	 * Move a single "item" forward in the browser's history. 
	 * Does nothing if we are on the latest page viewed
	 */
	public void forward() {
		driver.navigate().forward();

	}

	/**
	 * Load a new web page in the current browser window. This is done using 
	 * an HTTP GET operation, and the method will block until the load is 
	 * complete. This will follow redirects issued either by the server or 
	 * as a meta-redirect from within the returned HTML. Should a meta-redirect 
	 * "rest" for any duration of time, it is best to wait until this timeout 
	 * is over, since should the underlying page change while your test is 
	 * executing the results of future calls against this interface will be 
	 * against the freshly loaded page. 
	 * @param url - The URL to load. It is best to use a fully qualified URL
	 */
	public void goTo(String url) {
		driver.navigate().to(url);

	}


	/**
	 * Overloaded version of goTo(String) that makes it easy to pass in a URL. 
	 * @param url - The URL to load.
	 */
	public void goTo(URL url) {
		driver.navigate().to(url);

	}

	/**
	 * Refresh the current page 
	 */
	public void refresh() {
		driver.navigate().refresh();
	}



	//     OPTIONS    //

	/**
	 * Add a specific cookie. If the cookie's domain name is left blank, 
	 * it is assumed that the cookie is meant for the domain of the 
	 * current document. 
	 * 
	 * @param cookie - The cookie to add.
	 */
	public void addCookie(Cookie cookie) {
		driver.manage().addCookie(cookie);
	}

	/**
	 * Delete the named cookie from the current domain. This is equivalent 
	 * to setting the named cookie's expiry date to some time in the past. 
	 * 
	 * @param name - The name of the cookie to delete
	 */
	public void deleteCookieNamed(String name) {
		driver.manage().deleteCookieNamed(name);
	}

	/**
	 * Delete a cookie from the browser's "cookie jar". The domain of the 
	 * cookie will be ignored. 
	 * 
	 * @param cookie 
	 */
	public void deleteCookie(Cookie cookie) {
		driver.manage().deleteCookie(cookie);

	}

	/**
	 * Delete all the cookies for the current domain
	 */
	public void deleteAllCookies() {
		driver.manage().deleteAllCookies();	
	}

	/**
	 * Get all the cookies for the current domain. This 
	 * is the equivalent of calling "document.cookie" and 
	 * parsing the result 
	 * 
	 * @return A Set of cookies for the current domain.
	 */
	public Set<Cookie> getCookies() {
		return driver.manage().getCookies();
	}

	/**
	 * Get a cookie with a given name.
	 * 
	 * @param name - the name of the cookie 
	 * @return the cookie, or null if no cookie with the given name is present
	 */
	public Cookie getCookieNamed(String name) {
		return driver.manage().getCookieNamed(name);
	}

	/**
	 * Gets the mouse speed for drag and drop 
	 */
	public Speed getSpeed() {
		return driver.manage().getSpeed();
	}

	/**
	 * Sets the speed for user input 
	 * 
	 * @param speed
	 */
	public void setSpeed(Speed speed) {
		driver.manage().setSpeed(speed);
	}

	/**
	 * Returns the interface for managing driver timeouts. 
	 */
	public Timeouts timeouts() {
		return driver.manage().timeouts();
	}


	//     TARGET LOCATOR    //



	/**
	 * Select a frame by its (zero-based) index. That is, if a page has 
	 * three frames, the first frame would be at index "0", the second at 
	 * index "1" and the third at index "2". Once the frame has been selected, 
	 * all subsequent calls on the WebDriver interface are made to that frame. 
	 * 
	 * @param index - (zero-based) index 
	 * 
	 * @return This driver focused on the given frame 
	 * 
	 * @throws NoSuchFrameException - If the frame cannot be found
	 * 
	 */

	public WebDriver switchToFrame(int index) {
		long start = System.currentTimeMillis();
		WebDriver frameDriver;
		while(true){
			try{
				frameDriver = driver.switchTo().frame(index);
				break;
			}
			catch(NoSuchFrameException nse){
				if(System.currentTimeMillis()-start>=getTimeout()){
					nse.printStackTrace();
					Assert.fail("Element Not Found");
				}
				else{
					try {
						synchronized(this){
							wait(getInterval());
						}
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return frameDriver;
	}


	/**
	 * Select a frame by its name, id or (zero-based) index. 
	 * To select sub-frames, simply separate the frame names/IDs/indexes 
	 * by dots. As an example "main.child" will select the frame with 
	 * the name "main" and then it's child "child". If the given string 
	 * represents an integer number, then it will be used to select a frame 
	 * by its (zero-based) index. 
	 * 
	 * @param nameOrIdOrIndex - the name of the frame window, 
	 * the id of the {@code<frame>} or {@code<iframe>} element, or the (zero-based) index 
	 * @return This driver focused on the given frame 
	 * @throws NoSuchFrameException - If the frame cannot be found
	 */

	public WebDriver switchToFrame(String nameOrIdOrIndex) {
		long start = System.currentTimeMillis();
		WebDriver frameDriver;
		while(true){
			try{
				frameDriver = driver.switchTo().frame(nameOrIdOrIndex);
				break;
			}
			catch(NoSuchFrameException nse){
				if(System.currentTimeMillis()-start>=getTimeout()){
					nse.printStackTrace();
					Assert.fail("Element Not Found");
				}
				else{
					try {
						synchronized(this){
							wait(getInterval());
						}
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return frameDriver;
	}


	/**
	 * Switch the focus of future commands for this driver 
	 * to the window with the given name/handle. 
	 * @param nameOrHandle - The name of the window or the handle as returned by WebDriver.getWindowHandle() 
	 * @return This driver focused on the given window 
	 * @throws NoSuchWindowException - If the window cannot be found
	 */
	public WebDriver switchToWindow(String nameOrHandle) {
		long start = System.currentTimeMillis();
		WebDriver windowDriver;
		while(true){
			try{
				windowDriver = driver.switchTo().window(nameOrHandle);
				break;
			}
			catch(NoSuchWindowException nse){
				if(System.currentTimeMillis()-start>=getTimeout()){
					nse.printStackTrace();
					Assert.fail("Element Not Found");
				}
				else{
					try {
						synchronized(this){
							wait(getInterval());
						}
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return windowDriver;
	}

	/**
	 * Selects either the first frame on the page, or the main document when a page contains iframes. 
	 * @return This driver focused on the top window/first frame.
	 */
	public WebDriver switchToDefaultContent() {
		return driver.switchTo().defaultContent();	
	}

	/**
	 * Switches to the element that currently has focus, or the body element if this cannot be detected. 
	 * @return The WebElement with focus, or the body element if no element with focus can be detected.
	 */
	public WebElement switchToActiveElement() {
		return driver.switchTo().activeElement();	
	}
	
	/**
	 * This method is a lookup method to the LocatorPool class, If the locator object is found in the LocatorPool,
	 * will return the actual locator object else it will return the default locator which is the locator name itself.
	 * 
	 * @param locator
	 * @return locator
	 */
	public String getLocator(String locatorName)
	{
		return LocatorPool.getLocator(locatorName, locatorName);
	}
	
	 /** Using Rendered WebElement to wait for asynchronous calls to be completed.
	  * This can be used when performing a UI action triggers an asynchronous call to load a new HTML page;
	  * The content of this HTML page is inserted as the content of an html element like div, 
	  * and this html element is verified if its visible. A maximum of 10 tries is used.
	  * This can be further changed to parameterise the number of tries also.
	 * @param driver
	 * @param by
	 * @param iterations
	 */
	public void waitForAsyncContentByHTMLElement(WebDriver driver, By by, int iterations) {
		   // Get a RenderedWebElement corresponding to our html element
		   RenderedWebElement e = (RenderedWebElement) driver.findElement(by);
		   // Up to 10 times
		   for( int i=0; i<iterations; i++ ) {
		     // Check whether our element is visible yet
		     if( e.isDisplayed() ) {
		       return;
		     }
		     try {
		       Thread.sleep(1000);
		     } catch( InterruptedException ex ) {
		       // Try again
		     }
		   }
	 }
	
	
	
	/** Using JavascriptExecutor 
	 * This interface can be used to execute arbitrary Javascript within the context of the browser.
	 * This allows us to use the state of javascript variables to control the test.
	 * This can be further changed to parameterise the number of tries also.
	 * @param driver
	 * @param JSScript
	 * @param iterations
	 */
	public void waitForAsyncContentByJSVarState(WebDriver driver, String JSScript, int iterations) {
		// Get a JavascriptExecutor
		JavascriptExecutor exec = (JavascriptExecutor) driver;
		// 10 times, or until element is visible
		for( int i=0; i<iterations; i++ ) {
			if( ! (Boolean) exec.executeScript(JSScript) ) {
				return;
			}
			try {
				Thread.sleep(1000);
			} catch( InterruptedException ex ) {
				// Try again
			}
		}
	}
	 /** Waits for the indicator to go away
	  * Exits silently if indicator goes away or specified iterations are performed
	 * @param text
	 * @param intervalSeconds - Number of seconds to wait at each interval
	 * @param iterations - Max number of iterations to perform while waiting for the Indicator to disappear 
	 */
	public void waitForIndicator(String text, int intervalSeconds,int iterations) throws Exception{
		
		int i = 0;
		while((i < iterations)) {
			if(isElementPresent(driver,By.xpath("//div[text()='"+text+"']"))) {
				Thread.sleep(intervalSeconds*1000);
				i++;
			}
			else {
				return;
			}
		}
	}
	/** Checks for the presence of an html element on the current page
	 * @param locatorText - Expects a locator text prefixed with the locator type - example - "xpath://div[2]"
	 */
	public boolean isElementPresent(String locatorText) {
		String locator = "";
		if(locatorText.startsWith("xpath:")) {
			locator = locatorText.replace("xpath:", "");
			return(isElementPresent(driver,By.xpath(locator)));
		}
		else if(locatorText.startsWith("id:")) {
			locator = locatorText.replace("id:","");
			return(isElementPresent(driver,By.id(locator)));
		}
		else if(locatorText.startsWith("link:")) {
			locator = locatorText.replace("link:","");
			return(isElementPresent(driver,By.linkText(locator)));
		}
		else if(locatorText.startsWith("name:")) {
			locator = locatorText.replace("name:","");
			return(isElementPresent(driver,By.name(locator)));
		}
		return false;
	}
	
	 /** Waits for an element to appear on the page
	  * Exits silently if element is found or specified iterations are performed
	 * @param locatorText - Expects a locator text prefixed with the locator type - example - "xpath://div[2]"
	 * @param intervalSeconds - Number of seconds to wait at each interval
	 * @param iterations - Max number of iterations to perform while waiting for the Indicator to disappear 
	 * @throws InterruptedException 
	 */
	public void waitForElementPresent(String locatorText,int intervalSeconds, int iterations) throws InterruptedException {
		int i = 0;
		while((i < iterations)) {
			if(isElementPresent(locatorText)) {
				return;
			}
			else {
				Thread.sleep(intervalSeconds*1000);
				i++;
			}
		}
		return;
	}
}
