/*
 * Created on May 12, 2005
 * Chance Williams
 */
package com.keylabs.monitoring.cpuusage;

import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.UnknownHostException;

import org.w3c.dom.Document;

import com.keylabs.monitoring.ExternalProgramExecutor;
import com.keylabs.monitoring.FileIO;
import com.keylabs.monitoring.MyXMLParser;
import com.keylabs.monitoring.TimeCollection;

public final class CPUUsage {

     public static void launchCPUUsageTracking(PrintWriter pw) throws UnknownHostException {

        InetAddress addr = InetAddress.getLocalHost(); // it will get the ip address of the local host

        //GET CONFIG DATA FROM XML
        Document doc = MyXMLParser.parseXmlFile("NodeConfig.xml"); //it will parses the NodeConfig.xml file and stored it into a document object
        String strExternalProgram = MyXMLParser.getElementAttr_ReturnValue(doc, "CPUUsage", "ExternalProgram"); // it will take the externalprogram  and stored it into a string variable  
        String strDateTime = TimeCollection.getDateTimeStamp();
        ExternalProgramExecutor.executeProgram(strExternalProgram, "", true); // it will execute the perl sript and stores the details into a temporary html format

        String strCPU = FileIO.ReadFileFromDisk("CPUUsage.html");  // it will read temp file from the disk

            pw.println( "CPUUsage,"+addr.getHostName()+ "," + strDateTime + "," + strCPU +"\n"); // it will send the data to  the server


    }


}//END OF CLASS



