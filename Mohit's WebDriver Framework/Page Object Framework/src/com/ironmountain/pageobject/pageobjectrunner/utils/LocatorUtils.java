package com.ironmountain.pageobject.pageobjectrunner.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.log4j.Logger;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import com.ironmountain.pageobject.pageobjectrunner.utils.XMLUtils;


/** This class has methods that can be used to add new locator values to the locator file.
 * @author pjames
 *
 */
public class LocatorUtils {
	
	private static final Logger logger = Logger.getLogger("com.imd.connected.webuitest.utils.LocatorUtils");
	
	private static DocumentBuilderFactory dbf = null;
	private static DocumentBuilder db = null;
	private static Document doc = null;
	
	
	/** This method sets the locator Value.
	 * @param xmlFile
	 * @param locatorName
	 * @param locatorValue
	 */
	public static void setLocatorValue(String xmlFile, String locatorName, String locatorValue){

		Map<String, String> elementPool= new HashMap<String, String>();
		dbf = DocumentBuilderFactory.newInstance();
		String locatorPath = getLocatorPath(xmlFile);
		try {
			db = dbf.newDocumentBuilder();
			doc = db.parse(new File(locatorPath));
			doc.getDocumentElement().normalize();
			elementPool = XMLUtils.parseXmlAsProperties(locatorPath);
		    
		    if (elementPool.containsKey(locatorName)){
					NodeList nodeList1=doc.getElementsByTagName(locatorName);
					Element child = (Element)nodeList1.item(0);
					child.setNodeValue(locatorValue);
					child.setTextContent(locatorValue);
				} else{
		           doc = XMLUtils.createNewXMLTagAndValue(locatorPath, locatorName, locatorValue);
			}
			
			//set up a transformer
			TransformerFactory transfac = TransformerFactory.newInstance();
			Transformer trans = transfac.newTransformer();


			//create string from xml tree
			StringWriter sw = new StringWriter();
			StreamResult result = new StreamResult(sw);
			DOMSource source = new DOMSource(doc);
			trans.transform(source, result);
			String xmlString = sw.toString();

			OutputStream f0;
			byte buf[] = xmlString.getBytes();
			f0 = new FileOutputStream(locatorPath);
			for(int i=0;i<buf .length;i++) {
				f0.write(buf[i]);
			}
			f0.close();
			buf = null;

		} catch (Exception e) {		
			e.printStackTrace();
		}	    
	}
	
	
	/** Get the absolute path of the locator.
	 * @param xmlFile
	 * @return
	 */
	public static String getLocatorPath(String xmlFile){
			String path = null;
			String pageDirectory = FileUtils.getPageBaseDirectory();
			File pageDir = new File(pageDirectory);
			List<File> listOfFiles = FileUtils.getAllFilesFromDirectory(pageDir);
			for(File file:listOfFiles){
				if(file.getName().contains(xmlFile)){
					path = file.getAbsolutePath();
				}	 
			}
			return path;
	}
}
