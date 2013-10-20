/*
 * Created on Jun 28, 2005
 * @author Chance Williams
 *  
*/
package com.keylabs.monitoring;

import static com.keylabs.monitoring.FileIO.*;
import org.w3c.dom.Document;


public final class Logger {

    public static void LogError(String strErrorMessage) {
        String strDateTime = TimeCollection.getDateTimeStamp();
        String strConfigFile = "NodeConfig.xml";
        Document doc = MyXMLParser.parseXmlFile(strConfigFile);
        String strErrorLogFile = MyXMLParser.getElementAttr_ReturnValue(doc, "NodeConfig", "ErrorLog");
        writeStringToFile(strErrorLogFile, strErrorMessage + " : " + strDateTime, true);
    }
}