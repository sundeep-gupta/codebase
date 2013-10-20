package com.ironmountain.pageobject.pageobjectrunner.framework.webdriver.drivers;

import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchFrameException;
import org.openqa.selenium.NoSuchWindowException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.ie.InternetExplorerDriver;
import org.openqa.selenium.internal.FindsByCssSelector;
import org.openqa.selenium.internal.FindsById;
import org.openqa.selenium.internal.FindsByLinkText;
import org.openqa.selenium.internal.FindsByName;
import org.openqa.selenium.internal.FindsByTagName;
import org.openqa.selenium.internal.FindsByXPath;

/**
 * 
 * @author Pradeep Kote
 *
 */

public class CommonInternetExplorerDriver extends InternetExplorerDriver 
	implements FindsById, FindsByName, FindsByCssSelector, FindsByLinkText, 
		FindsByTagName, FindsByXPath {
    private static final int INTERVAL = 1 * 1000;
    private static final int TIMEOUT = 20 * 1000;
	
	@Override
	public void waitForLoadToComplete() {
		super.waitForLoadToComplete();
	}
	
	public void clickAndWaitForPageToLoad (WebElement webElement) {
		webElement.click();
		waitForLoadToComplete();
	}

	@Override
	public WebElement findElementById(String id) {
		return findElement(By.id(id));
	}

	@Override
	public List<WebElement> findElementsById(String id) {
		return findElements(By.id(id));
	}
	
	@Override
	public WebElement findElementByName(String name) {
		return findElement(By.name(name));
	}

	@Override
	public List<WebElement> findElementsByName(String name) {
		return findElements(By.name(name));
	}

	@Override
	public WebElement findElementByCssSelector(String cssSelector) {
		return findElement(By.cssSelector(cssSelector));
	}

	@Override
	public List<WebElement> findElementsByCssSelector(String cssSelector) {
		return findElements(By.cssSelector(cssSelector));
	}

	@Override
	public WebElement findElementByLinkText(String linkText) {
		return findElement(By.linkText(linkText));
	}

	@Override
	public WebElement findElementByPartialLinkText(String partialLinkText) {
		return findElement(By.partialLinkText(partialLinkText));
	}

	@Override
	public List<WebElement> findElementsByLinkText(String linkText) {
		return findElements(By.linkText(linkText));
	}

	@Override
	public List<WebElement> findElementsByPartialLinkText(String partialLinkText) {
		return findElements(By.partialLinkText(partialLinkText));
	}

	@Override
	public WebElement findElementByTagName(String tagName) {
		return findElement(By.tagName(tagName));	
	}

	@Override
	public List<WebElement> findElementsByTagName(String tagName) {
		return findElements(By.tagName(tagName));		
	}

	@Override
	public WebElement findElementByXPath(String xpath) {
		return findElement(By.xpath(xpath));	
	}

	@Override
	public List<WebElement> findElementsByXPath(String xpath) {
		return findElements(By.xpath(xpath));
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

    public WebDriver switchToFrame(String nameOrIdOrIndex) throws Exception {
        long start = System.currentTimeMillis();
        WebDriver frameDriver;
        while(true){
            try{
                frameDriver = switchTo().frame(nameOrIdOrIndex);
                break;
            }
            catch(NoSuchFrameException nse){
                if(System.currentTimeMillis()-start>=TIMEOUT){
                    nse.printStackTrace();
                    throw new Exception("Element Not Found");
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
    public WebDriver switchToWindow(String nameOrHandle) throws Exception  {
        long start = System.currentTimeMillis();
        WebDriver windowDriver;
        while(true){
            try{
                windowDriver = switchTo().window(nameOrHandle);
                break;
            }
            catch(NoSuchWindowException nse){
                if(System.currentTimeMillis()-start>= TIMEOUT){
                    nse.printStackTrace();
                    throw new Exception("Element Not Found");
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
}
	
	
