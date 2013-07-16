package com.ironmountain.pageobject.webobjects.connected.pages.amws;

import com.ironmountain.pageobject.pageobjectrunner.framework.SeleniumPage;
import com.thoughtworks.selenium.Selenium;

public class HelpPage extends SeleniumPage {
	
	public HelpPage(Selenium sel){
		selenium =sel;
	}

	public void closeHelp(){
		close();
		selectMainWindow();
	}
}

