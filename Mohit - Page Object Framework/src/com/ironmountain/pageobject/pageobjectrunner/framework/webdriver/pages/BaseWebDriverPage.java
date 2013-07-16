package com.ironmountain.pageobject.pageobjectrunner.framework.webdriver.pages;

import org.openqa.selenium.NoSuchFrameException;
import org.openqa.selenium.NoSuchWindowException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Select;
/**
 * 
 * @author Pradeep Kote
 *
 */
public class BaseWebDriverPage {	
	
	private static long TIMEOUT = 5000;//   5 seconds  
	private static long INTERVAL = 200; 
	
	private WebDriver webDriver = null; 
	
	public BaseWebDriverPage (WebDriver webDrive) {		
		this.webDriver = webDrive;		
	}

	public WebDriver getWebDriver() {
		return webDriver;
	}

	public void setWebDriver(WebDriver webDriver) {
		this.webDriver = webDriver;
	}
	

	/**
	 * From given Select element it will return Option webelement having text as optiontext  
	 * @param select
	 * @param optionText
	 * @return
	 * @throws Exception
	 */
	public WebElement getOptionByText (Select select, String optionText) throws Exception {
		for (WebElement option : select.getOptions()) {
			if (option.getText().equalsIgnoreCase(optionText)) {
				return option;
			}
		}
		return null;
	}
	
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
				frameDriver = getWebDriver().switchTo().frame(index);
				break;
			}
			catch(NoSuchFrameException nse){
				if(System.currentTimeMillis()- start>= TIMEOUT){
					nse.printStackTrace();
				}
				else{
					try {
						synchronized(this){
							wait(INTERVAL);
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
				frameDriver = getWebDriver().switchTo().frame(nameOrIdOrIndex);
				break;
			}
			catch(NoSuchFrameException nse){
				if(System.currentTimeMillis()-start>= TIMEOUT){
					nse.printStackTrace();
				}
				else{
					try {
						synchronized(this){
							wait(INTERVAL);
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
				windowDriver = getWebDriver().switchTo().window(nameOrHandle);
				break;
			}
			catch(NoSuchWindowException nse){
				if(System.currentTimeMillis()-start>= TIMEOUT){
					nse.printStackTrace();
				}
				else{
					try {
						synchronized(this){
							wait(INTERVAL);
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
		return getWebDriver().switchTo().defaultContent();	
	}

	/**
	 * Switches to the element that currently has focus, or the body element if this cannot be detected. 
	 * @return The WebElement with focus, or the body element if no element with focus can be detected.
	 */
	public WebElement switchToActiveElement() {
		return getWebDriver().switchTo().activeElement();	
	}
}
