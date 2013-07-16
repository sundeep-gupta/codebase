package com.ironmountain.pageobject.webobjects.connected.actions.testrunner;

import java.io.IOException;

import org.apache.log4j.Logger;

import com.ironmountain.digital.qa.automation.TestRunner.Runner;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;

public class ActionRunner {

	private static Logger  logger      = Logger.getLogger("com.imd.connected.webuitest.library.actions.testrunner.ActionRunner");
	private static String XmlPath = FileUtils.getBaseDirectory() + "\\" + PropertyPool.getProperty("testrunnerfilepath");
	
	//Added support to directly run the XML file using ActionRunner Class
	public static void run(String actionXml){
		logger.debug("The TestRunner xml file is: " + actionXml);
		actionXml = (XmlPath + "\\" + actionXml);
		Runner runner = new Runner();
		runner.setXMLFile(actionXml);
		try {
			runner.parseXMLFile();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		runner.run();
	}
		
}	

