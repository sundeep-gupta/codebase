package com.ironmountain.pageobject.pageobjectrunner.framework;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;


import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.DefaultLogger;
import org.apache.tools.ant.Project;
import org.apache.tools.ant.ProjectHelper;
import org.testng.SuiteRunner;
import org.testng.TestNG;
import org.testng.xml.Parser;
import org.testng.xml.XmlSuite;
import org.xml.sax.SAXException;

import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;
import com.ironmountain.pageobject.pageobjectrunner.utils.StringUtils;

public class SeleniumTestRunner {

	private static Logger logger = Logger
			.getLogger("com.ironmountain.pageobject.pageobjectrunner.framework.TestngRunner");

	private String suiteFolder = FileUtils.getBaseDirectory() +  File.separator ;
	private String suitePath = "testng.xml";
	private TestNG tng = null;
	private static final String START_SELENIUM_SERVER_TASK = "startSeleniumServer";

	private final TestNG getTestNG() {
		if (tng == null) {
			tng = new TestNG();
		} else {
			throw new TestException("TestNG is already running!!!!...");
		}
		return tng;
	}

	public void executeTestSuite(String xmlSuite) {

		suitePath = suiteFolder + xmlSuite;
		FileInputStream fis = null;
		try {
			System.out.println(xmlSuite);
			logger.debug("Test suite file is: " + suitePath);
			fis = new FileInputStream(suitePath);
		} catch (FileNotFoundException fnfe) {
			fnfe.printStackTrace();
			logger
					.error("File Nof found check you have given the suite path correctly");
		}
		try {
			final List<XmlSuite> xmlSuiteList = new Parser(fis).parseToList();
			tng = getTestNG();
			final List<String> suites = new ArrayList<String>();
			for (int i = 0; i < xmlSuiteList.size(); i++) {
				if (xmlSuiteList.get(i).getFileName() != null) {
					suites.add(xmlSuiteList.get(i).getFileName());
				}
			}
			if (suites.size() == 0) {
				tng.setXmlSuites(xmlSuiteList);
			} else {
				tng.setTestSuites(suites);
			}
			tng.run();

		} catch (SAXException e) {
			e.printStackTrace();
			logger.error("Unable to parse testng xml suite file: " + suitePath);
			logger.error(e.getMessage());
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
			logger.error("Unable to parse testng xml suite file: " + suitePath);
			logger.error(e.getMessage());
		} catch (IOException e) {
			e.printStackTrace();
			logger.error("Unable to parse testng xml suite file: " + suitePath);
			logger.error(e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			logger
					.error("Exception occured while running testng xml suite file: "
							+ suitePath);
			logger.error(e.getMessage());
		}
	}

	public void executeAntTarget(String targetName){
		Project project = null;
		try {
			project = new Project();
			project.init();
			File buildFile = new File( FileUtils.getBaseDirectory(), "build.xml");
			ProjectHelper.configureProject( project, buildFile);
			DefaultLogger consoleLogger = new DefaultLogger();
			consoleLogger.setErrorPrintStream(System.err);
			consoleLogger.setOutputPrintStream(System.out);
			consoleLogger.setMessageOutputLevel(Project.MSG_INFO);
			project.addBuildListener( consoleLogger); 
			project.executeTarget( targetName);
			project.fireBuildFinished(null);
			logger.debug("Project finished...");

		} catch (BuildException e) {
			logger.error("Error occured while executing the build.." + e.getMessage());
			e.printStackTrace();
			project.fireBuildFinished(e);
		} 	
	}
	
	
	public static void main(String[] args) {

		final SeleniumTestRunner runner = new SeleniumTestRunner();	
		runner.loadProperties();
		int noOfArgs = args.length;
		try {
			if (noOfArgs > 0) {	
				if (noOfArgs == 1) {					
					String arg1 = args[0];
					String task = PropertyPool.getProperty("defaultanttask");
					if(arg1.equalsIgnoreCase("Ant")){						
						logger.debug("Executing Ant Task: " +task);
						runner.executeAntTarget(task);
						System.exit(1);
					}
					else if(arg1.equalsIgnoreCase("Testng")){
						//execute default suite from testconfig.xml		
						String suitename = PropertyPool.getProperty("testsuitename");
						String testDir = PropertyPool.getProperty("testsuitedir");
						if(suitename.equalsIgnoreCase("*.xml")){
							System.out.println("Error in TestNG suite name specified in testconfig!!!, SeleniumtestRunner cannot run all suites specified by *.xml");
							System.out.println("Specify a single suite name in config\testconfig.xml file..or use Ant to run all the suites");
							System.out.println("type \"-Help\" to see the run options");
							System.exit(1);
						}
						String suitePath = runner.suiteFolder + testDir + "\\"+ suitename;
						logger.debug("Executing Testng suite form testconfig: " + suitePath);
						runner.executeAntTarget(START_SELENIUM_SERVER_TASK);
						runner.executeTestSuite(suitePath);
					}
					else if(arg1.equalsIgnoreCase("-Help")){
						//execute default suite from testconfig.xml
						printHelpMessage();
						System.exit(1);
					}					
			   } else if (noOfArgs == 2){
					String arg1 = args[0];
					String arg2 = args[1];					
					if(arg1.equalsIgnoreCase("Ant")){
						//execute specified ant task
						logger.debug("Ant task is: "+ arg2);
						runner.executeAntTarget(arg2);
						logger.debug("Ant finished");
						System.exit(1);
					}
					else if(arg1.equalsIgnoreCase("Testng")){
						if(! arg2.endsWith(".xml")){
							logger.debug("TestNG suite name is: "+ arg2);
							System.out.println("Error in TestNG suite name!!!, You need to provide a proper TestNG suite name, type \"-Help\" to see the run options");
							System.exit(1);
						}
						ArrayList<String> suitesList = StringUtils.toStringArrayList(arg2);
						//Execute testng suite
						for (String testngSuite : suitesList) {
							logger.debug("Executing Testng suite " + testngSuite);
							runner.executeAntTarget(START_SELENIUM_SERVER_TASK);
							runner.executeTestSuite(testngSuite);
						}						
					}
				}
				else if(noOfArgs >2){
					System.out.println("Wrong number of args, type \"-Help\" to see the run options");
					System.exit(1);
				}
			} else {
				System.out.println("Executing the test Build....");
				System.out.println("If you do not want to do this, stop the build and type \"-Help\" to display the help contents....");
				runner.executeAntTarget(PropertyPool.getProperty("defaultanttask"));
				System.exit(1);
			}
		} catch (Exception e) {
			logger.error("Error while executing the commands");
		}
	}

	public static void printHelpMessage(){
		System.out.println("Help Contents");
		System.out.println("----------------------------------------------------------------------------------------------------------");
		System.out.println("You can run the following tasks usign the SeleniumTests.jar file...\n");
		System.out.println("1. No arguments/task specified, This will run the default Ant target.");
		System.out.println("2. Run the default Ant target by typing \"Ant\", Note that this will execute the default target from ant file.");
		System.out.println("3. Run a specific Ant target from projects build file by typing \"Ant\" \"targetname\".");
		System.out.println("   Here the build will execute the suite file specified in the testconfig.xml");
		System.out.println("4. Run the default TestNG test suite by typing \"Testng\", Note that this will execute the suite file specified in the testconfig.xml");
		System.out.println("5. Run a specific TestNG test suite file by typing \"Testng\" \"suitename\".");
		System.out.println("6. Run a list of TestNG test suites separated by comma \",\" by typing \"Testng\" \"suite1\",\"suite2\",\"suite3\" etc..");
		System.out.println("7. Type \"Help\" to show this help content.");
		System.out.println("----------------------------------------------------------------------------------------------------------");
	}
	

	private final void loadProperties() {
        System.out.println("Setting properties.......");
        try {
			PropertyConfigurator.configure(FileUtils.getConfigDirectory() + "\\log4j.properties");
			logger.debug("log4j property is loaded");
		} catch (Exception e) {
			logger.error("Unable to load log4j properties...." + e.getMessage());
			e.printStackTrace();
		}
		logger.debug("Loading property files");
        PropertyPool.loadProperties();
    }
	
	

}
