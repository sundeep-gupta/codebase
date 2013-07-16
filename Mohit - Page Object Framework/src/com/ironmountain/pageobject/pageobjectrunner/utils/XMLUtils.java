package com.ironmountain.pageobject.pageobjectrunner.utils;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintStream;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.log4j.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;

import com.ironmountain.pageobject.pageobjectrunner.framework.TestException;

/**
 * @author Jinesh Devasia
 * 
 */
public class XMLUtils {

	private static final Logger logger = Logger
			.getLogger("com.imd.connected.webuitest.utils.XMLUtils");

	private static DocumentBuilderFactory dbf = null;
	private static DocumentBuilder db = null;
	private static Document doc = null;

	public static Document GetXmlDocument(String xmlFile) {
		logger.info("Loading and Parsing "+xmlFile);
		dbf = DocumentBuilderFactory.newInstance();
		try {
			db = dbf.newDocumentBuilder();
			doc = db.parse(new File(xmlFile));
		} catch (Exception e) {
			e.printStackTrace();
			throw new TestException("Unable to Parse File, ", e);
		}
		doc.getDocumentElement().normalize();
		logger.info(doc.getFirstChild().getNodeName());
		return doc;
	}
	
	public static Map<String, String> parseXmlAsProperties(String xmlFile) {
		Map<String, String> elementPool = new HashMap<String, String>();
		dbf = DocumentBuilderFactory.newInstance();
		try {
			db = dbf.newDocumentBuilder();
			doc = db.parse(new File(xmlFile));
		} catch (Exception e) {
			e.printStackTrace();
			throw new TestException("Unable to Parse File, ", e);
		}
		doc.getDocumentElement().normalize();
		
		NodeList list = doc.getElementsByTagName("*");
		for (int i = 1; i < list.getLength(); i++) {
			Element element = (Element) list.item(i);
			elementPool.put(element.getNodeName(), element.getTextContent());
		}
		return elementPool;
	}

	public static Map<String, String> parseXmlAsPropertiesAndAddToPool(
			String xmlFile, Map<String, String> elementPool) {
		dbf = DocumentBuilderFactory.newInstance();
		try {
			db = dbf.newDocumentBuilder();
			doc = db.parse(new File(xmlFile));
		} catch (Exception e) {
			e.printStackTrace();
			throw new TestException("Unable to Parse File, ", e);

		}
		doc.getDocumentElement().normalize();
		NodeList list = doc.getElementsByTagName("*");
		for (int i = 1; i < list.getLength(); i++) {
			Element element = (Element) list.item(i);
			elementPool.put(element.getNodeName(), element.getTextContent());
		}
		return elementPool;
	}

	/**
	 * This method created new tags with values.
	 * 
	 * @author pjames
	 * @param xmlFile
	 * @param locatorName
	 * @param locatorValue
	 */
	public static Document createNewXMLTagAndValue(String xmlFile,
			String tagName, String tagValue) {
		dbf = DocumentBuilderFactory.newInstance();
		try {
			db = dbf.newDocumentBuilder();
			doc = db.parse(new File(xmlFile));
			doc.getDocumentElement().normalize();
			Node locatorNode = doc.getFirstChild();
			Element child = doc.createElement(tagName);
			locatorNode.appendChild(child);
			org.w3c.dom.Text text = doc.createTextNode(tagValue);
			child.appendChild(text);
		} catch (Exception e) {
			e.printStackTrace();
			throw new TestException("Unable to Parse File, ", e);

		}
		return doc;
	}

	public static void createNewXmlTagAndValue(String filePath, String tagName,
			String value) {

		Map<String, String> elementPool = new HashMap<String, String>();
		dbf = DocumentBuilderFactory.newInstance();
		try {
			db = dbf.newDocumentBuilder();
			doc = db.parse(new File(filePath));
			doc.getDocumentElement().normalize();
		} catch (Exception e1) {
			logger.error("Error occured while building the document");
		}
		elementPool = XMLUtils.parseXmlAsProperties(filePath);

		if (elementPool.containsKey(tagName)) {
			NodeList nodeList1 = doc.getElementsByTagName(tagName);
			Element child = (Element) nodeList1.item(0);
			child.setNodeValue(value);
			child.setTextContent(value);
		} else {
			doc = createNewXMLTagAndValue(filePath, tagName, value);
		}
		TransformerFactory tFactory = TransformerFactory.newInstance();
		Transformer transformer = null;
		try {
			transformer = tFactory.newTransformer();
		} catch (TransformerConfigurationException e) {
			logger.error("Error occured while creating the Trasformer");
		}

		StringWriter sw = new StringWriter();
		StreamResult result = new StreamResult(sw);
		DOMSource source = new DOMSource(doc);
		try {
			transformer.transform(source, result);
		} catch (TransformerException e) {
			logger.error("Error occured while transforming the Dom source");
		}
		String xmlString = sw.toString();
		OutputStream fOut = null;
		byte buf[] = xmlString.getBytes();
		try {
			fOut = new FileOutputStream(filePath);
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

	public static void createXmlFileFromPool(String xmlFilePath, Map<String, String> elementPool, String parentElement){
		String xmlStandard = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
		FileOutputStream out = null;
		PrintStream write = null;
		try {
			out = new FileOutputStream(xmlFilePath);
			write = new PrintStream(out) ; 
		    write.println(xmlStandard);
		    write.println("<" + parentElement +  ">");
		    Set<String> keys = elementPool.keySet();
		    for(String key:keys){
			   try{
				    write.println("<" + key + ">" + elementPool.get(key) + "</" + key + ">");			 
			    }
			    catch (Exception e) {
				    e.printStackTrace();
				    throw new TestException("Unable to create property file: " + e.getMessage());
			    }
		    }
		    write.println("</" + parentElement +  ">");
		}		
		catch (FileNotFoundException e) {
				e.printStackTrace();
		}	
		finally{
			try {
				out.close();
			} catch (IOException e) {
				logger.error("Error occured while closing the file stream");
			}
			write.close();
		}		
	}

}
