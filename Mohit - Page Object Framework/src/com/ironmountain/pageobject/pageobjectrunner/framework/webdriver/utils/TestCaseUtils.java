package com.ironmountain.pageobject.pageobjectrunner.framework.webdriver.utils;

import java.io.File;
import java.io.IOException;
import java.util.Properties;

import org.apache.log4j.Logger;
import org.testng.internal.PropertiesFile;

import com.ironmountain.pageobject.pageobjectrunner.framework.webdriver.utils.TestCaseUtils;

/**
 * 
 * @author Pradeep Kote
 *
 */
public class TestCaseUtils {
	private static Logger log = Logger.getLogger(TestCaseUtils.class);

	/**
	 * Assuming that the project will have config folder and environment.properties file for having config related info
	 */
	private static final String AUTOMATION_ENV_FILE = "config/environment.properties";
	
	/**
	 * key which holds a value used to indicate on which environment we are running our test cases i.e. qa, dev
	 */
	private static final String ENV_KEY = "execution_env";
		
	/**
	 * key which holds test case specific properties files folder name
	 */
	private static final String TEST_CASE_PARAM_FOLDER = "param_folder";
	
	/**
	 * key which holds the Pre-fix for test case specific properties files location
	 */
	private static final String DEFAULT_PREFIX = "default_prefix";
	
		
	/**
	 * Loads the automation environment file.
	 * 
	 * @return Properties from the file.
	 * @throws IOException
	 */
	public static Properties loadEnvFile(String projectFolder) throws IOException {		
		PropertiesFile propertiesFile = new PropertiesFile(".." 
				+ File.separator + projectFolder 
				+ File.separator + AUTOMATION_ENV_FILE);
		Properties automationEnvProperties = propertiesFile.getProperties();		
		return automationEnvProperties;
	}
	
	/**
	 * This method returns the automation env.
	 * 
	 * @return automation env value.
	 * @throws IOException
	 */
	public static String getAutomationEnv(String projectFolder) throws Exception {		
		return loadEnvFile(projectFolder).getProperty(ENV_KEY).toLowerCase();
	}
	
	/**
	 * 
	 * @param projectFolder
	 * @return
	 * @throws Exception
	 */
	public static String getTestCaseParameterFolder(String projectFolder) throws Exception {		
		return loadEnvFile(projectFolder).getProperty(TEST_CASE_PARAM_FOLDER);
	}
		
	/**
	 * 
	 * @param projectFolder
	 * @return
	 * @throws Exception
	 */
	public static String getDefaultPrefix (String projectFolder) throws Exception {
		return loadEnvFile(projectFolder).getProperty(DEFAULT_PREFIX);
	}
	
	/**
	 * This will return properties file corresponding to the parameters suppiled  
	 * @param prefix
	 * @param testTypeParam 
	 * @param fileName
	 * @param projectFolder
	 * @return
	 * @throws Exception
	 */
	public static Properties getAllParameters (String prefix,  
			String testTypeParam, String fileName, String projectFolder) throws Exception {		
		
		PropertiesFile propertiesFile = new PropertiesFile(
				getFilePath(prefix, testTypeParam, fileName, projectFolder));		
		Properties properties = propertiesFile.getProperties();
		return properties;
	}
	
	/**
	 * Creates the file path with given parameters 
	 * @param prefixPath
	 * @param testType
	 * @param fileName
	 * @param projectFolder
	 * @return
	 * @throws Exception
	 */
	private static String getFilePath (String prefixPath, 
			String testType,  String fileName, String projectFolder) throws Exception {	
		StringBuilder filePathStr = new StringBuilder();   
		if(prefixPath != null) {
			filePathStr.append(prefixPath)
						.append(File.separator);
		}		
		filePathStr.append(getTestCaseParameterFolder(projectFolder))
					.append(File.separator)
					.append(testType)
					.append(File.separator)
					.append(fileName);					
		
		log.info("Loading the property file " + filePathStr.toString());		
	    return filePathStr.toString();
	}
	
	
}
