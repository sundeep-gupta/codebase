package com.ironmountain.pageobject.webobjects.connected.actions.testrunner.agent;

import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.utils.DateUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.webobjects.connected.actions.testrunner.ActionRunner;

public class CompactAccount extends ActionRunner{
	
	private static String CompactorXmlPath = FileUtils.getBaseDirectory() + "\\" + PropertyPool.getProperty("testrunnerfilepath");
	

	public static void runCompactor(String actionXml){
		run(actionXml);
	}
	public static void runCompactor(){
		run(CompactorXmlPath + "\\AccCleanup.xml");
	}
}
