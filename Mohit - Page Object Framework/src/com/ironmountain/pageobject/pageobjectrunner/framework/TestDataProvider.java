package com.ironmountain.pageobject.pageobjectrunner.framework;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.collections.map.MultiValueMap;
import org.apache.log4j.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.ironmountain.pageobject.pageobjectrunner.framework.utils.TestDataFileFilter;
import com.ironmountain.pageobject.pageobjectrunner.utils.XMLUtils;

/**
 * This class is a way to provide some test data information to the tests
 * For example testNG can take only single string parameters, but if you want to take a String
 * which has different special characters like (;,.%,*..etc) TestNG's xml parser will not be able to parse them.
 * In such cases the test date can provide using defining a simple XML file with a right name.
 * This class works same as LocatorPool...
 * 
 * @author Jinesh Devasia
 *
 */
public class TestDataProvider {

	private static final Logger logger = Logger.getLogger("com.ironmountain.pageobject.pageobjectrunner.framework.TestDataProvider");
	
	private static HashMap<String, String> dataProvider= null;
	private static HashMap<String, String> input = new HashMap<String,String>();
	private static HashMap<String, String> output = new HashMap<String,String>();
	private static MultiValueMap multiValueInput = new MultiValueMap();
	//private static MultiValueMap multiValueOutput = new MultiValueMap();
	
	private static Document doc = null;
	public static boolean isTestDataLoaded = false;
	public static boolean isTestDataXMLLoaded = false;
	private static final String TEST_DATE_XML_FILE_ROOT_ELEMENT = "testdata";
	
	public static void createTestDataProvider()
	{
		if(dataProvider==null)
		{
			dataProvider = new HashMap<String, String>();
		}
	}		

	public static void loadTestData(String dataFolder)
	{		
		if(!isTestDataLoaded)
		{			
			createTestDataProvider();
			ArrayList<String> testDataFilesList = (ArrayList<String>) TestDataFileFilter.getAllTestDataFiles(dataFolder);
			if(testDataFilesList.isEmpty()){
				logger.info("Test Data File not found.. file list is empty");
		    }
			else{
				
				for(String str:testDataFilesList){				
					try{						
						loadTestDataFiles(str, dataProvider);
						logger.debug("Test Data succesfully loaded "+ str);
					}
					catch (Exception e) {
						logger.error("Failed to load Test Data File", e);
						throw new TestException("Could not load test data from file "+ str
								+" Roolt Cause is: "+  e.getMessage()+ "Check the file path is correct");
					}
				} 	
				isTestDataLoaded = true;
			}			
		}			
	}
	public static void loadTestDataXML(String dataFolder, String xmlFile)
	{
			String testDataFile = TestDataFileFilter.getTestDataFile(dataFolder, xmlFile);
			if(testDataFile.isEmpty() || testDataFile.equals(null)){
				logger.info("Test Data File not found.. file list is empty");
		    }
			else{
					try{						
						loadTestDataXMLFile(testDataFile);
						logger.info("Test Data succesfully loaded "+ testDataFile);
					}
					catch (Exception e) {
						logger.error("Failed to load Test Data File", e);
						throw new TestException("Could not load test data from file "+ testDataFile
								+" Root Cause is: "+  e.getMessage()+ "Check the file path is correct");
					}
				
			}		
	}
	
	public static void reloadTestData(String dataFolder)
	{
		isTestDataLoaded = false ;	
		loadTestData(dataFolder);
	}
	public static void reloadTestDataXML(String dataFolder,String xmlFile)
	{
		isTestDataXMLLoaded = false ;	
		loadTestDataXML(dataFolder, xmlFile);
	}	
	public static void loadTestDataFiles(String document, Map<String, String> pool) throws Exception
	{
		dataProvider = (HashMap<String, String>)XMLUtils.parseXmlAsPropertiesAndAddToPool(document, pool);		
	}
	
	public static void loadTestDataXMLFile(String testDataFile) throws Exception
	{
		doc = XMLUtils.GetXmlDocument(testDataFile);		
	}
	
	public static String getTestData(String testDataName)
	{		
		String value = null;
		if(dataProvider != null){
		    value = dataProvider.get(testDataName);
		    logger.debug("Test data:" + value);
		}
		else{
			logger.error(dataProvider + " Test Data Provider is not loaded, Please check you have loaded it in your test..");
			throw new TestException(" Test Data Provider is not loaded, Please check you have loaded it in your test..");
		}
		return value ;		
	}
	public static HashMap<String,String> getTestInput(String testName)
	{		
		logger.info("Getting test input for "+testName);
		input.clear();
		if(doc != null){
		    NodeList tests = doc.getElementsByTagName("test");
		    for(int i = 0 ; i < tests.getLength() ; i++) {
		    	logger.info("Checking "+tests.item(i).getAttributes().getNamedItem("name"));
		    	if(tests.item(i).getAttributes().getNamedItem("name").toString().equals("name=\""+testName+"\"")) {
		    		logger.info("Its the right test");
		    		
		    		NodeList childNodes = tests.item(i).getChildNodes();
		    		for(int j = 0 ; j < childNodes.getLength() ; j++) {
		    			logger.info("Checking child node "+childNodes.item(j).getNodeName());
		    			if(childNodes.item(j).getNodeName().equals("input")) {
		    				logger.info("Got input node");
		    				
		    				Node inputNode = childNodes.item(j);
		    				NodeList params = inputNode.getChildNodes();
		    				for(int k = 0 ; k<params.getLength();k++) {
		    					logger.info("Checking "+params.item(k).getNodeName().toString());
		    					if(params.item(k).getNodeName().toString().equals("param")) {
		    						logger.info(params.item(k).getAttributes().getNamedItem("name").toString()+"="+ params.item(k).getTextContent());
		    						String name = params.item(k).getAttributes().getNamedItem("name").toString();
		    						name = name.replace("name=\"", "");
		    						name = name.replace("\"","");
		    						String value = params.item(k).getTextContent();
		    						logger.info(name+"="+ value);
		    						input.put(name, value);
		    					}
		    				}
		    				j = childNodes.getLength();
		    				return input;
		    			}
		    		}
		    		i = tests.getLength();
			    }
		    }
		}
		else{
			logger.error(doc + " Test Data Provider is not loaded, Please check you have loaded it in your test..");
			throw new TestException(" Test Data Provider is not loaded, Please check you have loaded it in your test..");
		}
		return input;	
	}
	public static MultiValueMap getMultiValueTestInput(String testName)
	{		
		logger.info("Getting test input for "+testName);
		multiValueInput.clear();
		if(doc != null){
		    NodeList tests = doc.getElementsByTagName("test");
		    for(int i = 0 ; i < tests.getLength() ; i++) {
		    	logger.info("Checking "+tests.item(i).getAttributes().getNamedItem("name"));
		    	if(tests.item(i).getAttributes().getNamedItem("name").toString().equals("name=\""+testName+"\"")) {
		    		logger.info("Its the right test");
		    		
		    		NodeList childNodes = tests.item(i).getChildNodes();
		    		for(int j = 0 ; j < childNodes.getLength() ; j++) {
		    			logger.info("Checking child node "+childNodes.item(j).getNodeName());
		    			if(childNodes.item(j).getNodeName().equals("input")) {
		    				logger.info("Got input node");
		    				
		    				Node inputNode = childNodes.item(j);
		    				NodeList params = inputNode.getChildNodes();
		    				for(int k = 0 ; k<params.getLength();k++) {
		    					logger.info("Checking "+params.item(k).getNodeName().toString());
		    					if(params.item(k).getNodeName().toString().equals("param")) {
		    						logger.info(params.item(k).getAttributes().getNamedItem("name").toString()+"="+ params.item(k).getTextContent());
		    						String name = params.item(k).getAttributes().getNamedItem("name").toString();
		    						name = name.replace("name=\"", "");
		    						name = name.replace("\"","");
		    						String value = params.item(k).getTextContent();
		    						logger.info(name+"="+ value);
		    						multiValueInput.put(name, value);
		    					}
		    				}
		    				j = childNodes.getLength();
		    				return multiValueInput;
		    			}
		    		}
		    		i = tests.getLength();
			    }
		    }
		}
		else{
			logger.error(doc + " Test Data Provider is not loaded, Please check you have loaded it in your test..");
			throw new TestException(" Test Data Provider is not loaded, Please check you have loaded it in your test..");
		}
		return multiValueInput;	
	}
	public static HashMap<String,String> getTestOutput(String testName)
	{		
		logger.info("Getting test output for "+testName);
		output.clear();
		if(doc != null){
		    NodeList tests = doc.getElementsByTagName("test");
		    for(int i = 0 ; i < tests.getLength() ; i++) {
		    	logger.info("Checking "+tests.item(i).getAttributes().getNamedItem("name"));
		    	if(tests.item(i).getAttributes().getNamedItem("name").toString().equals("name=\""+testName+"\"")) {
		    		logger.info("Its the right test");
		    		
		    		NodeList childNodes = tests.item(i).getChildNodes();
		    		for(int j = 0 ; j < childNodes.getLength() ; j++) {
		    			logger.info("Checking child node "+childNodes.item(j).getNodeName());
		    			if(childNodes.item(j).getNodeName().equals("output")) {
		    				logger.info("Got output node");
		    				
		    				Node outputNode = childNodes.item(j);
		    				NodeList params = outputNode.getChildNodes();
		    				for(int k = 0 ; k<params.getLength();k++) {
		    					logger.info("Checking "+params.item(k).getNodeName().toString());
		    					if(params.item(k).getNodeName().toString().equals("param")) {
		    						logger.info(params.item(k).getAttributes().getNamedItem("name").toString()+"="+ params.item(k).getTextContent());
		    						String name = params.item(k).getAttributes().getNamedItem("name").toString();
		    						name = name.replace("name=\"", "");
		    						name = name.replace("\"","");
		    						String value = params.item(k).getTextContent();
		    						logger.info(name+"="+ value);
		    						output.put(name, value);
		    					}
		    				}
		    				j = childNodes.getLength();
		    				return output;
		    			}
		    		}
		    		i = tests.getLength();
			    }
		    }
		}
		else{
			logger.error(doc + " Test Data Provider is not loaded, Please check you have loaded it in your test..");
			throw new TestException(" Test Data Provider is not loaded, Please check you have loaded it in your test..");
		}
		return output;	
	}
	
	public static MultiValueMap getMultiValueTestOutput(String testName)
	{		
		logger.info("Getting test output for "+testName);
		MultiValueMap multiValueOutput = new MultiValueMap();
		if(doc != null){
		    NodeList tests = doc.getElementsByTagName("test");
		    for(int i = 0 ; i < tests.getLength() ; i++) {
		    	logger.info("Checking "+tests.item(i).getAttributes().getNamedItem("name"));
		    	if(tests.item(i).getAttributes().getNamedItem("name").toString().equals("name=\""+testName+"\"")) {
		    		logger.info("Its the right test");
		    		
		    		NodeList childNodes = tests.item(i).getChildNodes();
		    		for(int j = 0 ; j < childNodes.getLength() ; j++) {
		    			logger.info("Checking child node "+childNodes.item(j).getNodeName());
		    			if(childNodes.item(j).getNodeName().equals("output")) {
		    				logger.info("Got output node");
		    				
		    				Node outputNode = childNodes.item(j);
		    				NodeList params = outputNode.getChildNodes();
		    				for(int k = 0 ; k<params.getLength();k++) {
		    					logger.info("Checking "+params.item(k).getNodeName().toString());
		    					if(params.item(k).getNodeName().toString().equals("param")) {
		    						logger.info(params.item(k).getAttributes().getNamedItem("name").toString()+"="+ params.item(k).getTextContent());
		    						String name = params.item(k).getAttributes().getNamedItem("name").toString();
		    						name = name.replace("name=\"", "");
		    						name = name.replace("\"","");
		    						String value = params.item(k).getTextContent();
		    						logger.info(name+"="+ value);
		    						multiValueOutput.put(name, value);
		    					}
		    				}
		    				j = childNodes.getLength();
		    				return multiValueOutput;
		    			}
		    		}
		    		i = tests.getLength();
			    }
		    }
		}
		else{
			logger.error(doc + " Test Data Provider is not loaded, Please check you have loaded it in your test..");
			throw new TestException(" Test Data Provider is not loaded, Please check you have loaded it in your test..");
		}
		return multiValueOutput;	
	}
	public static MultiValueMap getMultiValueTestOutput(String testName, String criteria)
	{		
		logger.info("Getting test output for "+testName);
		MultiValueMap multiValueOutput = new MultiValueMap();
		if(doc != null){
		    NodeList tests = doc.getElementsByTagName("test");
		    for(int i = 0 ; i < tests.getLength() ; i++) {
		    	logger.info("Checking "+tests.item(i).getAttributes().getNamedItem("name"));
		    	if(tests.item(i).getAttributes().getNamedItem("name").toString().equals("name=\""+testName+"\"")) {
		    		logger.info("Its the right test");
		    		
		    		NodeList childNodes = tests.item(i).getChildNodes();
		    		for(int j = 0 ; j < childNodes.getLength() ; j++) {
		    			logger.info("Checking child node "+childNodes.item(j).getNodeName());
		    			if(childNodes.item(j).getNodeName().equals("output")) {
		    				logger.info("Got output node");
		    				
		    				Node outputNode = childNodes.item(j);
		    				NodeList params = outputNode.getChildNodes();
		    				for(int k = 0 ; k<params.getLength();k++) {
		    					logger.info("Checking "+params.item(k).getNodeName().toString());
		    					if(params.item(k).getNodeName().toString().equals("param")) {
		    						logger.info(params.item(k).getAttributes().getNamedItem("name").toString()+"="+ params.item(k).getTextContent());
		    						String name = params.item(k).getAttributes().getNamedItem("name").toString();
		    						name = name.replace("name=\"", "");
		    						name = name.replace("\"","");
		    						String value = params.item(k).getTextContent();
		    						logger.info(name+"="+ value);
		    						if(criteria.equals(name)) {
		    							logger.info(name + " matching criteria " + criteria);
		    							multiValueOutput.put(name, value);
		    						}
		    						else
		    						{
		    							logger.info(name + " not matching criteria " + criteria);
		    						}
		    					}
		    				}
		    				j = childNodes.getLength();
		    				return multiValueOutput;
		    			}
		    		}
		    		i = tests.getLength();
			    }
		    }
		}
		else{
			logger.error(doc + " Test Data Provider is not loaded, Please check you have loaded it in your test..");
			throw new TestException(" Test Data Provider is not loaded, Please check you have loaded it in your test..");
		}
		return multiValueOutput;	
	}
	public static void setTestData(String testDataName, String testDataValue)
	{
		if(dataProvider != null){
			dataProvider.put(testDataName, testDataValue);
		}
		else{
			throw new TestException("Test Data is not loaded yet.. Please load it first.");
		}
	}
	public static void setTestDataToXmlFile(String xmlFilePath, String testDataName, String testDataValue)
	{	
		setTestData(testDataName, testDataValue);
		XMLUtils.createXmlFileFromPool(xmlFilePath, dataProvider, TEST_DATE_XML_FILE_ROOT_ELEMENT);
		reloadTestData(xmlFilePath);
	}


}
