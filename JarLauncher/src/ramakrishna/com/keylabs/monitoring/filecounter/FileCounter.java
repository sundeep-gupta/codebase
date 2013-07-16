/*
 * Created on May 12, 2005
 * Chance Williams
 */
package com.keylabs.monitoring.filecounter;

import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.UnknownHostException;

import org.w3c.dom.Document;

import com.keylabs.monitoring.ExternalProgramExecutor;
import com.keylabs.monitoring.FileIO;
import com.keylabs.monitoring.MyXMLParser;
import com.keylabs.monitoring.TimeCollection;

public final class FileCounter {

 
    public static void executeFileCounting(PrintWriter pw) throws UnknownHostException {

        InetAddress addr = InetAddress.getLocalHost();

        String[] strDisk;
        //GET CONFIG DATA FROM XML file from NodeConfig.xml
        Document doc = MyXMLParser.parseXmlFile("NodeConfig.xml"); // it parses the NodeConfig.xml and store that into a Document format
        String strTempFile = MyXMLParser.getElementAttr_ReturnValue(doc, "FileCounter", "TempFile"); //it will get the temporary file 
        String strExternalProgram = MyXMLParser.getElementAttr_ReturnValue(doc, "FileCounter", "ExternalProgram"); // it will get the ExternalProgram value
        String strDateTime = TimeCollection.getDateTimeStamp(); // get the current time in timestamp format
        ExternalProgramExecutor.executeProgram(strExternalProgram, "", true);// it will executes the perl script and collect the statistics and stored into a temp file


        String strFile = FileIO.ReadFileFromDisk(strTempFile);// this reads the temp file from the disk and stores the contents into a string array
        strDisk = strFile.split(",");
        String strResults = strDateTime +
                "," + strDisk[0] +
                "," + strDisk[1] +
                "," + strDisk[2] +
                "," + strDisk[3] +
                "," + strDisk[4] +
                "," + strDisk[5] +
                "," + strDisk[6] +
                "," + strDisk[7];



            pw.println( "FileCounter,"+addr.getHostName()+","+strResults +"\n"); // it will send the data to the server


    }


}//END OF CLASS
	


