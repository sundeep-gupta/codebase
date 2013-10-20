/*
 * Created on Jun 7, 2005
 * @author Chance Williams
 */
package com.keylabs.monitoring;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Attr;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

public final class MyXMLParser {
    public static Document parseXmlFile(String filename) {
        try {
            // Create a builder factory
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            factory.setValidating(false);

            // Create the builder and parse the file
            Document doc;
            doc = factory.newDocumentBuilder().parse(new File(filename));
            return doc;
        } catch (SAXException e) {
            // A parsing error occurred; the xml input is not valid
            System.out.println("Error: " + e.getMessage());
        } catch (ParserConfigurationException e) {
            e.getMessage();
        } catch (IOException e) {
            e.getMessage();
        }
        return null;
    }

    public static List parseDocToList(Document doc, String strElementName, String strAttrName) {
        List list = new ArrayList();
        // Get a list of all elements in the document
        NodeList nodeList = doc.getElementsByTagName(strElementName);
        for (int i = 0; i < nodeList.getLength(); i++) {
            // Get element
            Element element = (Element) nodeList.item(i);
            list.add(element.getAttribute(strAttrName));
        }
        return list;
    }

    /*
      *
      */
    public static HashMap getAllAttributesOfAnElement(Element element) {
        // Get all the attributes of an element in a map
        NamedNodeMap attrs = element.getAttributes();
        HashMap hmAttrAndValue = new HashMap();
        // Get number of attributes in the element
        int numAttrs = attrs.getLength();

        // Process each attribute
        for (int i = 0; i < numAttrs; i++) {
            Attr attr = (Attr) attrs.item(i);

            // Get attribute name and value
            hmAttrAndValue.put(attr.getNodeName(), attr.getNodeValue());
        }
        return hmAttrAndValue;
    }

    /*
      *
      */
    public static ArrayList getAllAttributeValuesOfAnElement(Element element) {
        // Get all the attributes of an element in a map
        NamedNodeMap attrs = element.getAttributes();
        ArrayList lAttributeValues = new ArrayList();
        // Get number of attributes in the element
        int numAttrs = attrs.getLength();

        // Process each attribute
        for (int i = 0; i < numAttrs; i++) {
            Attr attr = (Attr) attrs.item(i);

            // Get attribute name and value
            lAttributeValues.add(attr.getNodeValue());
        }
        return lAttributeValues;
    }

    /*
      * 	getElementAttributeAndReturnValue
      */
    public static String getElementAttr_ReturnValue(Document doc, String strElementName, String strAttrName) {
        String strTemp;
        NodeList list = doc.getElementsByTagName(strElementName);
        Element element = (Element) list.item(0);
        strTemp = element.getAttribute(strAttrName);
        return strTemp;
    }

    /*
      * 	getElementAttributeAndReturnValue
      */
    public static Element getElementFromDoc(Document doc, String strElementName) {
        NodeList list = doc.getElementsByTagName(strElementName);
        Element element;
        element = (Element) list.item(0);
        return element;
    }


}
