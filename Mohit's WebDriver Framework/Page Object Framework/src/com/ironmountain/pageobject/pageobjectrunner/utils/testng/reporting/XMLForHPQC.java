package com.ironmountain.pageobject.pageobjectrunner.utils.testng.reporting;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintStream;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Templates;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.apache.log4j.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import com.ironmountain.pageobject.pageobjectrunner.utils.XMLUtils;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.TestException;

/**
 * @author Princy James
 * This Class creates a test XML file with the tags needed for HPQC 
 * and also updates the XML file with the right values.
 * This object is the 'test' section of the common IMD Test Results File format.
 * 
 * Example:
 * 			      <test>
 *		            <testpath></testpath>
 *		            <testset></testset>
 *		            <testname></testname>
 *		            <runname></runname>
 *		            <status></status>
 *		            
 *		            <starttime></starttime>
 *		            <stoptime></stoptime>
 *							            
 *					<resultdetail></resultdetail>
 *		            <customfield name="" type=""></customfield>
 *					<attachedfile location=””>filename</attachedfile>
 *					<host></host>
 *					<platform></platform>
 *					<osversion></osversion>
 *		      </test>
 *
 */
public class XMLForHPQC {
	
	private static final Logger logger = Logger.getLogger(XMLForHPQC.class.getName());

	/*static AttachedFile attachedFile;
	static CustomField customField;*/
	static TestResultsFile trf;
	private static DocumentBuilderFactory documentBuilderFactory = null;
	private static DocumentBuilder documentBuilder = null;
	private static Document document = null;
	static String qcmachine = null;
	static String sandbox = null;
	static String productName = null;
	static String productVersion = null;
	static String TESTSET = null;
	static String TESTPATH = null;
	static String TESTNAME = null;
	static String RUNNAME = null;
	static String STATUS = null;
	static String STARTTIME = null;
	static String STOPTIME = null;
	static String RESULTDETAIL = null;
	static String HOST = null;
	static String PLATFORM = null;
	static String OSVERSION = null;
	static String ATTACHEDFILE = null;
	static String NAME = null;
	static String TYPE = null;
	static String TESTCYCLE = PropertyPool.getProperty("testcycle");
	static String CONFIGURATION = PropertyPool.getProperty("configuration");
	static String BROWSER = PropertyPool.getProperty("browsertypewithversion");
	
	public static void getElements(Map<String,String> ep){
		TESTSET = ep.get("testset");
		TESTPATH = ep.get("testpath");
		TESTNAME = ep.get("testname");
		RUNNAME = ep.get("runname");
		STATUS = ep.get("status");
		STARTTIME = ep.get("starttime");
		STOPTIME = ep.get("stoptime");
		RESULTDETAIL = ep.get("resultdetail");
		HOST = ep.get("host");
		PLATFORM = ep.get("platform");
		OSVERSION = ep.get("osversion");
	}
	
	
	
	public static void createSampleXml(String filePath) {
		try{
		documentBuilderFactory = DocumentBuilderFactory.newInstance();
		documentBuilder = documentBuilderFactory.newDocumentBuilder();
		document = documentBuilder.newDocument();
		Element rootElement = (Element) document.createElement("testresults");
		rootElement.setAttribute("product", PropertyPool.getProperty("productname"));
		rootElement.setAttribute("version", PropertyPool.getProperty("productversion"));
		document.appendChild(rootElement);
		Element qc = document.createElement("QCmachine");
		qc.appendChild(document.createTextNode(PropertyPool.getProperty("qcmachine")));
		rootElement.appendChild(qc);
		Element sbox = document.createElement("sandbox");
		sbox.appendChild(document.createTextNode(PropertyPool.getProperty("sandbox")));
		rootElement.appendChild(sbox);
		} catch (Exception e1) {
		logger.error("Error occured while creating the Trasformer");
		}
		writeXML(filePath, document);
	}
	

	public static void updateElementPool(String filePath, Map<String, String> ep){
		XMLForHPQC.getElements(ep);
		documentBuilderFactory = DocumentBuilderFactory.newInstance();
		try {
			documentBuilder = documentBuilderFactory.newDocumentBuilder();
			document = documentBuilder.parse(new File(filePath));
			document.getDocumentElement().normalize();
		NodeList nodeList1 = document.getElementsByTagName("testresults");
		Element root = (Element) nodeList1.item(0);
		Element test =  document.createElement("test");
		root.appendChild(test);
		Element em = document.createElement("testpath");
		em.appendChild(document.createTextNode(TESTPATH));
		test.appendChild(em);
		em = document.createElement("testset");
		em.appendChild(document.createTextNode(TESTSET));
		test.appendChild(em);
		em = document.createElement("testname");
		em.appendChild(document.createTextNode(TESTNAME));
		test.appendChild(em);
		em = document.createElement("runname");
		em.appendChild(document.createTextNode(RUNNAME));
		test.appendChild(em);
		em = document.createElement("status");
		em.appendChild(document.createTextNode(STATUS));
		test.appendChild(em);
		em = document.createElement("starttime");
		em.appendChild(document.createTextNode(STARTTIME));
		test.appendChild(em);
		em = document.createElement("stoptime");
		em.appendChild(document.createTextNode(STOPTIME));
		test.appendChild(em);
		em = document.createElement("resultdetail");
		em.appendChild(document.createTextNode(RESULTDETAIL));
		test.appendChild(em);
		em = document.createElement("host");
		em.appendChild(document.createTextNode(HOST));
		test.appendChild(em);
		em = document.createElement("platform");
		em.appendChild(document.createTextNode(PLATFORM));
		test.appendChild(em);
		em = document.createElement("osversion");
		em.appendChild(document.createTextNode(OSVERSION));
		test.appendChild(em);
		em = document.createElement("testcycle");
		em.appendChild(document.createTextNode(TESTCYCLE));
		test.appendChild(em);
		em = document.createElement("configuration");
		em.appendChild(document.createTextNode(CONFIGURATION));
		test.appendChild(em);
		em = document.createElement("browser");
		em.appendChild(document.createTextNode(BROWSER));
		test.appendChild(em);		
		} catch (Exception e1) {
		logger.error("Error occured while creating the Trasformer");
		}
		writeXML(filePath, document);	
	}
	
	public static void writeXML(String FilePath, Document document){
		TransformerFactory tFactory = TransformerFactory.newInstance();
		Transformer transformer = null;
		try {
			transformer = tFactory.newTransformer();
		} catch (TransformerConfigurationException e) {
			logger.error("Error occured while creating the Transformer");
		}

		StringWriter sw = new StringWriter();
		StreamResult result = new StreamResult(sw);
		DOMSource source = new DOMSource(document);
		try {
			transformer.transform(source, result);
		} catch (TransformerException e) {
			logger.error("Error occured while transforming the Dom source");
		}
		String xmlString = sw.toString();
		System.out.println(xmlString);
		OutputStream fOut = null;
		byte buf[] = xmlString.getBytes();
		try {
			fOut = new FileOutputStream(FilePath);
			for (int i = 0; i < buf.length; i++) {
				fOut.write(buf[i]);
			}
		} catch (Exception e) {
			logger.error("Error occured while wrtign the tag to the xmlfile");
		} finally {
			try {
				buf = null;
				fOut.close();
			} catch (IOException e) {
				logger.error("Error occured while closing the file stream");
			}
		}
	}
		
}
