package com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium;

import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.testng.Assert;


/**
 * 
 * @author spozdnyakov
 *
 */

public class WebDriverElement{

	private long timeout;  
	private long interval; 

	public WebDriverElement() {
		this.timeout = 5000; //   5 seconds
		this.interval = 200; // 0.2 seconds
	}

	/**
	 * Amount of time to wait for an element to appear on the page before 
	 * throwing an "ElementNotFoundException"   
	 * 
	 * @return Time in milliseconds
	 */
	public long getTimeout() {
		return timeout;
	}

	/**
	 * Amount of time to wait for an element to appear on the page before 
	 * throwing an "ElementNotFoundException" 
	 * Specify time in milliseconds
	 * @param timeout
	 */
	public void setTimeout(long timeout) {
		this.timeout = timeout;
	}

	/**
	 * Interval of time to wait before looking for an element again 
	 * 
	 * @return Time in milliseconds
	 */
	public long getInterval() {
		return interval;
	}

	/**
	 * Interval of time to wait before looking for an element again 
	 * Specify time in milliseconds
	 * @param interval
	 */
	public void setInterval(long interval) {
		this.interval = interval;
	}


	/**
	 * Clear the value of text element
	 * @param element
	 */
	public void clear(WebElement element){
		long start = System.currentTimeMillis();
		while(true){
			try{
				element.clear();
				break;
			}
			catch(NoSuchElementException nse){
				if(System.currentTimeMillis()-start>=timeout){
					nse.printStackTrace();
					Assert.fail("Element Not Found");
				}
				else{
					try {
						synchronized(this){
							wait(interval);
						}
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}


	/**
	 * Click this element
	 * 
	 * If click() causes a new page to be loaded via an event or is done by 
	 * sending a native event (which is a common case on Firefox, IE on Windows) 
	 * then the method will *not* wait for it to be loaded and the caller should 
	 * verify that a new page has been loaded.
	 * 
	 * Use  clickAndWaitForPageLoad(WebElement element, int numOfSeconds) method if page 
	 * to be loaded after click takes more time then current timeout period ( default is 5 seconds ) 
	 * 
	 * @param element
	 */

	public void click(WebElement element){
		long start = System.currentTimeMillis();

		while(true){
			try{
				element.click();
				break;
			}
			catch(NoSuchElementException nse){
				if(System.currentTimeMillis()-start>=timeout){
					nse.printStackTrace();
					Assert.fail("Element Not Found");
				}
				else{
					try {
						synchronized(this){
							wait(interval);
						}
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}


	/**
	 * Click this element and wait for numOfSeconds 
	 * 
	 * @param element
	 * @param numOfSeconds
	 */
	public void clickAndWaitForPageLoad(WebElement element, int numOfSeconds) {
		long start = System.currentTimeMillis();

		while(true){
			try{
				element.click();
				break;
			}
			catch(NoSuchElementException nse){
				if(System.currentTimeMillis()-start>=timeout){
					nse.printStackTrace();
					Assert.fail("Element Not Found");
				}
				else{
					try {
						synchronized(this){
							wait(interval);
						}
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		}

		try {
			Thread.sleep(numOfSeconds * 1000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}


	/**
	 * Right click on element
	 * @param element
	 */
	public void rightClick(WebElement element){
		long start = System.currentTimeMillis();
		while(true){
			try{
				element.sendKeys(Keys.chord(Keys.SHIFT, Keys.F10));
				break;
			}
			catch(NoSuchElementException nse){
				if(System.currentTimeMillis()-start>=timeout){
					nse.printStackTrace();
					Assert.fail("Element Not Found");
				}
				else{
					try {
						synchronized(this){
							wait(interval);
						}
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}


	/**
	 * Get the value of a the given attribute of the element. Will return the 
	 * current value, even if this has been modified after the page has been 
	 * loaded. Note that the value of the attribute "checked" will return "checked" 
	 * if the element is a input of type checkbox and there is no explicit 
	 * "checked" attribute, and will also return "selected" for an option that is 
	 * selected even if there is no explicit "selected" attribute. The expected 
	 * value of "disabled" is also returned.
	 * 
	 * @param element
	 * @param attributeName
	 * @return The attribute's current value or null if the value is not set.
	 */
	public String getAttribute(WebElement element, String attributeName) {
		long start = System.currentTimeMillis();
		String value = "";

		while(true){
			try{
				value = element.getAttribute(attributeName);
				break;
			}
			catch(NoSuchElementException nse){
				if(System.currentTimeMillis()-start>=timeout){
					nse.printStackTrace();
					Assert.fail("Element Not Found");
				}
				else{
					try {
						synchronized(this){
							wait(interval);
						}
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return value;
	}


	/**
	 * Get the tag name of this element. Not the value of the name attribute: will 
	 * return "input" for the element {@code<input name="foo" />}.
	 * 
	 * @param element
	 * @return The tag name of this element.
	 */
	public String getTagName(WebElement element) {
		String tagName = "";
		long start = System.currentTimeMillis();
		while(true){
			try{
				tagName = element.getTagName();
				break;
			}
			catch(NoSuchElementException nse){
				if(System.currentTimeMillis()-start>=timeout){
					nse.printStackTrace();
					Assert.fail("Element Not Found");
				}
				else{
					try {
						synchronized(this){
							wait(interval);
						}
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return tagName;
	}

	/**
	 * Find all elements within the current context using the given mechanism.
	 * @param element
	 * @return The innerText of this element.
	 */
	public String getText(WebElement element) {
		String innerText = "";
		long start = System.currentTimeMillis();
		while(true){
			try{
				innerText = element.getText();
				break;
			}
			catch(NoSuchElementException nse){
				if(System.currentTimeMillis()-start>=timeout){
					nse.printStackTrace();
					Assert.fail("Element Not Found");
				}
				else{
					try {
						synchronized(this){
							wait(interval);
						}
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return innerText;
	}

	/**
	 * Get the value of the element's "value" attribute. If this value has been 
	 * modified after the page has loaded (for example, through javascript) then 
	 * this will reflect the current value of the "value" attribute.
	 * 
	 * @param element
	 * @return The value of the element's "value" attribute.
	 */
	public String getValue(WebElement element) {
		String attrValue = "";
		long start = System.currentTimeMillis();
		while(true){
			try{
				attrValue = element.getValue();
				break;
			}
			catch(NoSuchElementException nse){
				if(System.currentTimeMillis()-start>=timeout){
					nse.printStackTrace();
					Assert.fail("Element Not Found");
				}
				else{
					try {
						synchronized(this){
							wait(interval);
						}
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return attrValue;
	}

	/**
	 * Is the element currently enabled or not? This will generally return true 
	 * for everything but disabled input elements.
	 * 
	 * @param element
	 * @return True if the element is enabled, false otherwise.
	 */
	public boolean isEnabled(WebElement element) {
		boolean state = false;
		long start = System.currentTimeMillis();
		while(true){
			try{
				state = element.isEnabled();
				break;
			}
			catch(NoSuchElementException nse){
				if(System.currentTimeMillis()-start>=timeout){
					nse.printStackTrace();
					Assert.fail("Element Not Found");
				}
				else{
					try {
						synchronized(this){
							wait(interval);
						}
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return state;
	}

	/**
	 * Determine whether or not this element is selected or not. This operation only applies 
	 * to input elements such as checkboxes, options in a select and radio buttons.
	 * 
	 * @param element
	 * @return True if the element is currently selected or checked, false otherwise.
	 */
	public boolean isSelected(WebElement element) {
		boolean state = false;
		long start = System.currentTimeMillis();
		while(true){
			try{
				state = element.isSelected();
				break;
			}
			catch(NoSuchElementException nse){
				if(System.currentTimeMillis()-start>=timeout){
					nse.printStackTrace();
					Assert.fail("Element Not Found");
				}
				else{
					try {
						synchronized(this){
							wait(interval);
						}
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return state;
	}


	/**
	 * Simulate typing into an element
	 * @param element
	 * @param text
	 */
	public void sendKeys(WebElement element, String text){
		long start = System.currentTimeMillis();
		while(true){
			try{
				element.sendKeys(text);
				break;
			}
			catch(NoSuchElementException nse){
				if(System.currentTimeMillis()-start>=timeout){
					nse.printStackTrace();
					Assert.fail("Element Not Found");
				}
				else{
					try {
						synchronized(this){
							wait(interval);
						}
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}


	/**
	 * Select an element. This method will work against radio buttons, "option" elements 
	 * within a "select" and checkboxes
	 * @param element
	 */
	public void setSelected(WebElement element) {
		long start = System.currentTimeMillis();
		while(true){
			try{
				element.setSelected();
				break;
			}
			catch(NoSuchElementException nse){
				if(System.currentTimeMillis()-start>=timeout){
					nse.printStackTrace();
					Assert.fail("Element Not Found");
				}
				else{
					try {
						synchronized(this){
							wait(interval);
						}
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}

	/**
	 * If this current element is a form, or an element within a form, then this will be 
	 * submitted to the remote server. If this causes the current page to change, then 
	 * this method will block until the new page is loaded.
	 * 
	 * @param element
	 * @throws NoSuchElementException - If the given element is not within a form
	 */
	public void submit(WebElement element) throws NoSuchElementException {
		long start = System.currentTimeMillis();
		while(true){
			try{
				element.submit();
				break;
			}
			catch(NoSuchElementException nse){
				if(System.currentTimeMillis()-start>=timeout){
					nse.printStackTrace();
					Assert.fail("Element Not Found");
				}
				else{
					try {
						synchronized(this){
							wait(interval);
						}
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}

	/**
	 * If the element is a checkbox this will toggle the elements state from selected to 
	 * not selected, or from not selected to selected.
	 * 
	 * @param element
	 * @return Whether the toggled element is selected (true) or not (false) after 
	 * this toggle is complete
	 */
	public boolean toggle(WebElement element){
		boolean state = false;
		long start = System.currentTimeMillis();
		while(true){
			try{
				state = element.toggle();
				break;
			}
			catch(NoSuchElementException nse){
				if(System.currentTimeMillis()-start>=timeout){
					nse.printStackTrace();
					Assert.fail("Element Not Found");
				}
				else{
					try {
						synchronized(this){
							wait(interval);
						}
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return state;
	}



	/**
	 * Find all elements within the current context using the given mechanism
	 * 
	 * @param element
	 * @param by - The locating mechanism to use
	 * 
	 * @return  list of all WebElements, or an empty list if nothing matches
	 */
	public List<WebElement> findElements(WebElement element, By by) {
		List<WebElement> listOfElements = null;
		long start = System.currentTimeMillis();
		while(true){
			try{
				listOfElements  = element.findElements(by);
				break;
			}
			catch(NoSuchElementException nse){
				if(System.currentTimeMillis()-start>=timeout){
					nse.printStackTrace();
					Assert.fail("Element Not Found");
				}
				else{
					try {
						synchronized(this){
							wait(interval);
						}
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return listOfElements;
	}



	/**
	 * Find the first WebElement using the given mechanism
	 * @param element
	 * @param by - The locating mechanism
	 * @return The first matching element on the current context
	 */
	public WebElement findElement(WebElement element, By by) {
		WebElement newElement = null;
		long start = System.currentTimeMillis();
		while(true){
			try{
				newElement = element.findElement(by);
				break;
			}
			catch(NoSuchElementException nse){
				if(System.currentTimeMillis()-start>=timeout){
					nse.printStackTrace();
					Assert.fail("Element Not Found");
				}
				else{
					try {
						synchronized(this){
							wait(interval);
						}
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return newElement;
	}
	
	/**
	 * Find the first WebElement using the given mechanism
	 * @param element
	 * @param by - The locating mechanism
	 * @return The first matching element on the current context
	 */
	public WebElement findElement(WebDriver driver, By by) {
		WebElement newElement = null;
		long start = System.currentTimeMillis();
		while(true){
			try{
				newElement = driver.findElement(by);
				break;
			}
			catch(NoSuchElementException nse){
				if(System.currentTimeMillis()-start>=timeout){
					nse.printStackTrace();
					Assert.fail("Element Not Found");
				}
				else{
					try {
						synchronized(this){
							wait(interval);
						}
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return newElement;
	}


///
/**
 * Find the status of the WebElement using the given mechanism
 * @param element
 * @param by - The locating mechanism
 * @return The first matching element on the current context
 */
	public boolean isElementPresent(WebDriver driver, By by) {

		try{
			driver.findElement(by);
			return true;
		}
		catch(Exception e){
			//e.printStackTrace();
			return false;
		}
	}
	/**
	 * Find the first WebElement using the given mechanism
	 * @param element
	 * @param by - The locating mechanism
	 * @return The first matching element on the current context
	 */
	public boolean isElementPresent(WebElement element, By by) {
		try{
			element.findElement(by);
			return true;
		}
		catch(Exception e){
			//e.printStackTrace();
			return false;
		}
	}	
}