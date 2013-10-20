package com.ironmountain.pageobject.pageobjectrunner.framework.httpjson;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.httpjson.HttpClientDriver;
import com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium.WebDriverTest;

/** Base Test for all Http Tests
 * @author pjames
 *
 */
public class HttpJsonAppTest {
	private static final Logger logger = Logger.getLogger(HttpJsonAppTest.class.getName());
	public static String url = null;
	
	protected final void inithttpTest()throws Exception {
		inithttpTest("");
		HttpClientDriver.initCookiesWithoutWebDriver();
	}
	
	protected final void inithttpTest(String browser)throws Exception {
		HttpClientDriver.initCookiesWithoutWebDriver();
	}
	
	protected final void stophttpTest(){
		HttpClientDriver.clearCookies();
	}
	

}
