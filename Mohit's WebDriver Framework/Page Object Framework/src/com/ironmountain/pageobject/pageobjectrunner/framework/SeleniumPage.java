package com.ironmountain.pageobject.pageobjectrunner.framework;


import org.apache.log4j.Logger;

import com.thoughtworks.selenium.Selenium;


/**
 * @author Jinesh Devasia
 *
 */
public class SeleniumPage {

	private static final Logger logger = Logger.getLogger("com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage");

	public Selenium selenium = null;
	public String pageLoadDelay = "1200000"; 
	public int waitSeconds = 60;
	
	/**
	 * Set the selenium object
	 * 
	 * @param sel
	 */
	public void setSelenium(Selenium sel){
		logger.debug("Setting the selenium session object..:" + sel);
		this.selenium = sel;
		if(selenium != null){
			setTimeOut(300);
			if(PropertyPool.getProperty("pageloaddelay") != null){
				this.pageLoadDelay = PropertyPool.getProperty("pageloaddelay");
			}
			
			if(PropertyPool.getProperty("waitseconds") != null){
				this.waitSeconds = Integer.parseInt(PropertyPool.getProperty("waitseconds"));
			}	
		}	
	}	
	
	/**
	 * Get the current Selenium object
	 * 
	 * @return Selenium
	 */
	public Selenium getSelenium(){
		return selenium ;
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


	/**
	 * Check a radio button or checkbox, Its always safe to use clicks for checking fields since
	 * Java scripts may not work correctly with the selenium's check methods 
	 * @param locator
	 */
	public void check(String locator){
		String element = getLocator(locator);
		if(! isChecked(element))
			click(element);
	}

	/**
	 * Clicks on a link, button, checkbox or radio button. Provided by the locator id.
	 * 
	 * @param locator
	 */
	public void click(String locator)
	{
		String element = getLocator(locator);
		if(isElementPresentFailOnNotFound(element, false))
		{
			selenium.click(element);
			
		}		
	}
	/**
	 * Clicks on a link, button..etc and waits for the page to load after the click.
	 * This is useful when you have page loads after click.
	 * 
	 * @param locator
	 */
	public void clickAndWaitForPageLoad(String locator)
	{
		String element = getLocator(locator);
		if(isElementPresentFailOnNotFound(element, false))
		{
			selenium.click(element);
			waitForPageLoad();
		}		
	}
	/**
	 * Simulates the user clicking the "close" button in the titlebar of a popup window or tab.
	 */
	public void close()
	{
		selenium.close();
	}
	/**
	 * This options closes a popup window or sub window opened and selects the main window.
	 */
	public void closeWindow()
	{
		close();
		selectMainWindow();		
	}
	/**
	 * Explicitly simulate an event, to trigger the corresponding "onevent" handler.
	 * 
	 * @param locator
	 * @param eventName
	 */
	public void fireEvent(String locator, String eventName)
	{
		String element = getLocator(locator);
		if(isElementPresentFailOnNotFound(element, false)){
			selenium.fireEvent(element, eventName);
		}
	}
	/**
	 *  Gets the result of evaluating the specified JavaScript snippet
	 *  
	 * @param script
	 * @return java.lang.String
	 */
	public String getEval(String script)
	{
		return selenium.getEval(script);
	}
	
	/**
	 * Gets the absolute URL of the current page.
	 * @return java.lang.String
	 */
	public String getLocation()
	{
		return selenium.getLocation();
	}
	/**
	 * Gets the absolute URL of the current page.
	 * @return java.lang.String
	 */
	public String getAttribute(String locator)
	{
		String element = getLocator(locator);
		return selenium.getAttribute(element);
	}
	
	/**
	 * Gets option label (visible text) for selected option in the specified select element.
	 * 
	 * @param locator
	 * @return java.lang.String
	 */
	public String getSelectedLabel(String locator)
	{
		String element = getLocator(locator);
		if(isElementPresentFailOnNotFound(element, false)){
			return selenium.getSelectedLabel(element);
		}
		return "";
	}
	/**
	 * Return all the select options from a drop down/options list
	 * 
	 * @param locator
	 * @return
	 */
	public String[] getSelectOptions(String locator){
		String element = getLocator(locator);
		if(isElementPresentFailOnNotFound(element, false)){
			return selenium.getSelectOptions(element);
		}
		return null;				
	}
	/**
	 * Gets option label (visible text) for selected option in the specified select element.
	 * 
	 * @param locator
	 * @return
	 */
	public String getSelectedValue(String locator)
	{
		String element = getLocator(locator);
		if(isElementPresentFailOnNotFound(element, false)){
			return selenium.getSelectedValue(element);
		}
		return "";
	}
	
	/**
	 *  Gets the text of an element.
	 *  
	 * @param locator
	 * @return
	 */
	public String getText(String locator)
	{
		String element = getLocator(locator);
		if(isElementPresentFailOnNotFound(element, false)){
			return selenium.getText(element);
		}
		return "";
	}
	/**
	 * Gets the title of the current page.
	 * 
	 * @return
	 */
	public String getTitle()
	{
		return selenium.getTitle();
	}
	
	/**
	 * Gets the (whitespace-trimmed) value of an input field (or anything else with a value parameter).
	 * 
	 * @param locator
	 * @return
	 */
	public String getValue(String locator)
	{
		String element = getLocator(locator);
		if(isElementPresentFailOnNotFound(element, false)){
			return selenium.getValue(element);
		}
		return "";
	}
	/**
	 *  Returns the number of nodes that match the specified xpath.
	 * 
	 * @param xpath
	 * @return
	 */
	public Number getXpathCount(String xpath)
	{
		String element = getLocator(xpath);
		if(isElementPresentFailOnNotFound(element, false)){
			return selenium.getXpathCount(element);
		}
		return 0;
		
	}	

	/**
	 *  Gets whether a toggle-button (checkbox/radio) is checked.
	 *  
	 * @param locator
	 * @return 
	 */
	public boolean isChecked(String locator)
	{		
		String element = getLocator(locator);
		if(isElementPresentFailOnNotFound(element, false)){
			return selenium.isChecked(element);
		}	
		else
			return false;
	}
	/**
	 * Determines whether the specified input element is editable, ie hasn't been disabled.
	 * 
	 * @param locator
	 * @return
	 */
	public boolean isEditable(String locator)
	{		
		String element = getLocator(locator);
		if(isElementPresentFailOnNotFound(element, false)){
			return selenium.isEditable(element);
		}	
		else
			return false;
	}

	/**
	 * Verifies the specified locator is present in the page.
	 * 
	 * @param locator
	 * @return true if the locator is present
	 */
	public boolean isElementPresent(String locator)
	{
		String element = getLocator(locator);
		for (int i=0; ; i++)
		{
			if(selenium.isElementPresent(element)){
				return true;
			}
			else if(i>=waitSeconds){
				return false;	
			}
			waitForSecond();
		}
	}	
	public boolean isElementPresent(String locator, int waitSeconds)
	{
		String element = getLocator(locator);
		for (int i=0; ; i++)
		{
			if(selenium.isElementPresent(element)){
				return true;
			}
			else if(i>=waitSeconds){
				return false;	
			}
			waitForSecond();
		}
	}	
	/**
	 * Overloaded version of the previous one, here we can specify if you need a LocatorPool look for the locator.
	 * 
	 * @param locator
	 * @param islocatorMapLookupNeeded
	 * @return true if the locator is present else false
	 */
	public boolean isElementPresent(String locator, boolean islocatorMapLookupNeeded)
	{
		if(islocatorMapLookupNeeded){
			return isElementPresent(locator);
		}
		else{
			for (int i=0; ; i++)
			{
				if(selenium.isElementPresent(locator)){
					return true;
				}
				else if(i>=waitSeconds){
					return false;	
				}
				waitForSecond();
			}
		}
	}	
	/**
	 * Verifies the specified locator is present in the page, fail if not found
	 * 
	 * @param locator
	 * @return true if present else false
	 */
	public boolean isElementPresentFailOnNotFound(String locator)
	{
		try {
			String element = getLocator(locator);

			for (int i=0; ; i++)
			{
				if(selenium.isElementPresent(element)){
						return true;
				}
				else if(i>=waitSeconds){
					Asserter.fail("The locator: " + locator + " not found");
				}
				waitForSecond();
			}
		} catch (Exception e) {
			logger.debug("Exception: " + e);
		}		
		return false;
	}
	/**
	 * Verifies the specified locator is present in the page, checks for the element for a specified time period
	 * 
	 * @param locator
	 * @param waitSeconds
	 * @return
	 */
	public boolean isElementPresentFailOnNotFound(String locator, int waitSeconds)
	{
		String element = getLocator(locator);
	
		for (int i=0; ; i++)
		{
			if(selenium.isElementPresent(element)){
					return true;
			}
			else if(i>=waitSeconds){
				Asserter.fail("The locator: " + locator + " not found");	
			}
			waitForSecond();
		}		
	}
	public boolean isElementPresentFailOnNotFound(String locator, boolean islocatorMapLookupNeeded)
	{
		try {
			if (islocatorMapLookupNeeded) {
				return isElementPresentFailOnNotFound(locator);
			} else {
				for (int i = 0;; i++) {
					if (selenium.isElementPresent(locator)) {
						return true;
					} else if (i >= waitSeconds) {
						Asserter.fail("The locator: " + locator + " not found");
					}
					waitForSecond();
				}
			}
		} catch (Exception e) {
			logger.debug("Exception: " + e);
		}
		return false;
	}
	/**
	 * Search for a text in the page till a pre-defined time limit reaches
	 * return true if the text is present else false
	 * @param text
	 * @return boolean
	 */
	public boolean isTextPresent(String text)
	{		
		String element = getLocator(text);
		
		for (int i=0; ; i++)
		{
			if(selenium.isTextPresent(element))
				return true;
			if(i>=waitSeconds)
				return false;	
			waitForSecond();
		}
	}
	/**
	 * Default isTextPresent method will have a locator map lookup.
	 * This method we need to specify the lookup is needed or not.
	 * 
	 * @param text
	 * @param islocatorMapLookupNeeded
	 * @return
	 */
	public boolean isTextPresent(String text, boolean islocatorMapLookupNeeded)
	{	
		if(islocatorMapLookupNeeded)
		{			
			return isTextPresent(text);
		}
		else
			for (int i=0; ; i++)
			{
				if(selenium.isTextPresent(text))
					return true;
				if(i>=waitSeconds)
					return false;		
				waitForSecond();
			}
	}
	/**
	 * Search for a text in the page, user can specify the time limit
	 * 
	 * @param text
	 * @param waitSeconds
	 * @return boolean
	 */
	public boolean isTextPresent(String text, int waitSeconds)
	{		
		String element = getLocator(text);
		for (int i=0; ; i++)
		{
			if(selenium.isTextPresent(element))
				return true;
			if(i>=waitSeconds)
				return false;	
			waitForSecond();
		}
	}
	/**
	 * Search for a text in the page Fail if the text not found in the page
	 * 
	 * @param text
	 * @return
	 */
	public boolean isTextPresentFailOnNotFound(String text)
	{		
		String element = getLocator(text);
		for (int i=0; ; i++)
		{
			if(selenium.isTextPresent(element))
				return true;
			if(i>=waitSeconds)
				Asserter.fail("Text '" + element + "' not found in the page");		
			waitForSecond();
		}
	}
	
	/**
	 * The locator map reference is done using a prepend and append texts,
	 * Useful in situations when the user need to pass some dynamic texts
	 * 
	 * @param prependText
	 * @param dynamicText
	 * @param appendText
	 * @return
	 */
	public boolean isTextPresentFailOnNotFound(String prependText, String dynamicText, String appendText)
	{		
		String element1 = getLocator(prependText);
		String element2 = getLocator(appendText);
		String element = element1 + dynamicText + element2;;		
		for (int i=0; ; i++)
		{
			if(selenium.isTextPresent(element))
				return true;
			if(i>=waitSeconds)
				Asserter.fail("Text '" + element + "' not found in the page");		
			waitForSecond();
		}
	}
	public boolean isTextPresentFailOnNotFound(String text, boolean islocatorMapLookupNeeded)
	{		
		if(islocatorMapLookupNeeded){
			return isTextPresentFailOnNotFound(text);
		}
		else
		{
			for (int i=0; ; i++)
			{
				if(selenium.isTextPresent(text))
					return true;
				if(i>=waitSeconds)
					Asserter.fail("Text '" + text + "' not found in the page");		
				waitForSecond();
			}
		}		
	}
	/**
	 * Search for a text in the page, User can specify the time limit.
	 * 
	 * @param text
	 * @param waitSeconds
	 * @return
	 */
	public boolean isTextPresentFailOnNotFound(String text, int waitSeconds)
	{		
		String element = getLocator(text);
		for (int i=0; ; i++)
		{
			if(selenium.isTextPresent(element))
				return true;
			if(i>=waitSeconds)
				Asserter.fail("Text '" + element + "' not found in the page");	
			waitForSecond();
		}
	}
	/**
	 * To verify the page title is correct.
	 * 
	 * @param title
	 * @return
	 */
	public boolean isTitlePresent(String title)
	{		
		String element = getLocator(title);
		for (int i=0; ; i++)
		{
			if(selenium.getTitle().equalsIgnoreCase(element))
				return true;
			if(i>=waitSeconds)
				return false;	
			waitForSecond();
		}
	}
	/**
	 * To verify the title of the page, fail if not found or correct.
	 * 
	 * @param title
	 * @return
	 */
	public boolean isTitlePresentFailOnNotFound(String title)
	{		
		String element = getLocator(title);
		for (int i=0; ; i++)
		{
			if(selenium.getTitle().contains(element))
				return true;
			if(i>=waitSeconds)
				Asserter.fail("Page titlespecified '" + element + "' not found in the page");;	
			waitForSecond();
		}
	}
	/**
	 * Determines if the specified element is visible.
	 * 
	 * @param locator
	 * @return
	 */
	public boolean isVisible(String locator)
	{		
		String element = getLocator(locator);
		if(isElementPresentFailOnNotFound(element, false)){
			return selenium.isVisible(element);
		}	
		else
			return false;
	}
	/**
	 * Opening the specified url. This method will also wait to load the page.
	 * 
	 * @param url
	 */
	public void open(String locator)
	{
		try{
		String element = getLocator(locator);
		selenium.open(element);
		waitForPageLoad();
		}
		catch (Exception e){
			System.out.println(e);
		}
	}
	/**
	 * To open a custom window as popup
	 * 
	 * @param url
	 * @param windowid
	 */
	public void openWindow(String url, String windowid){
		selenium.openWindow(url, windowid);
	}
	/**
	 * Simulates the user clicking the "Refresh" button on their browser.
	 */
	public void refreshPage()
	{
		selenium.refresh();
	}
	/**
	 * Select an option from a drop-down using an option locator.
	 * 
	 * @param locator
	 * @param option
	 */
	public void select(String locator, String option)
	{
		String element = getLocator(locator);
		if(isElementPresentFailOnNotFound(element, false)){
			selenium.select(element, option);
		}		
	}
	/**
	 * Selects a frame within the current window.
	 * 
	 * @param locator
	 */
	public void selectFrame(String locator)
	{
		String element = getLocator(locator);
		if(isElementPresentFailOnNotFound(element, false)){
			selenium.selectFrame(element);
		}		
	}
	/**
	 * Selects a frame which is relatively up to the current frame, ie selects a parent frame
	 */
	public void selectRelativeUpFrame()
	{
		selenium.selectFrame("relative=up");
	}
	/**
	 * If we are already in a pop-up window, and want to go back to the main window then use this method.
	 * 
	 */
	public void selectMainWindow()
	{
		selenium.selectWindow(null);
	}
	/**
	 * To select a window
	 * 
	 * @param windowID
	 */
	public void selectWindow(String windowID)
	{
		String element = getLocator(windowID);
		selenium.selectWindow(element);
	}
	/**
	 * Our check methods are doing click instead of check.
	 * This method will do the actual selenium.check for chekcing check boxes
	 * 
	 * @param locator
	 */
	public void seleniumCheck(String locator){
		String element = getLocator(locator);
		if(isChecked(element))
			selenium.check(element);
	}		
	/**
	 * Set the timeout for selenium object
	 * 
	 * @param timoutMinitues
	 */

	public void setTimeOut(int timoutMinitues)
	{
		long time = (timoutMinitues * 60) * 1000 ;
		String timeInMillis = Long.toString(time);
		selenium.setTimeout(timeInMillis);
	}	
	
	/**
	 *  Sets the value of an input field, as though you typed it in.
	 *  
	 * @param locator
	 * @param value
	 */
	public void type(String locator, String value)
	{
		String element = getLocator(locator);
		if(isElementPresentFailOnNotFound(element, false))
		{
			selenium.type(element, value);
		}
	}
	/**
	 * un-Check a radio button or checkbox
	 * 
	 * @param locator
	 */
	public void unCheck(String locator){
		String element = getLocator(locator);
		if(isChecked(element))
			click(element);
	}	
	
	/**
	 * Make the selenium to wait for the page to load.
	 * This method uses a constant delay hard-coded in the class.
	 * 
	 */
	public void waitForPageLoad()
	{
		selenium.waitForPageToLoad(pageLoadDelay);
	}
	/**
	 * This is an overloaded version of the previous one, this method will take the delay time as a parameter.
	 * 
	 * @param delay
	 */
	public void waitForPageLoad(String delay)
	{
		selenium.waitForPageToLoad(delay);
	}
	/**
	 * Waits for a popup window to load
	 * 
	 * @param windowid
	 */
	public void waitForPopUp(String windowid)
	{
		String element = getLocator(windowid);
		selenium.waitForPopUp(element, pageLoadDelay);
	}
	/**
	 * To make the execution wait for 1 second by sleeping
	 */
	
	public void waitForSecond()
	{
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}	
	/**
	 *Sleeps the current thread for specified seconds 
	 * @param seconds
	 */
	public void waitForSeconds(int seconds)
	{
		try {
			Thread.sleep(1000 * seconds);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
	
	public void setSpeed(String speed)
	{
		selenium.setSpeed(speed);
	}
	
	public boolean isAlertPresent(){
		return selenium.isAlertPresent();
	}
	
	public String getAlert(){
		String text = null;
		try{
		while (!isAlertPresent()){
			Thread.sleep(1000);
		}
		text = selenium.getAlert();
		
		} catch( Exception e){
			e.printStackTrace();
		}
		return text;
		
	}
}
