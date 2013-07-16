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

public final class FileCounter { /** We are importing all the inbuilt classes from java api*/

 
    public static void executeFileCounting(PrintWriter pw) throws UnknownHostException {

        InetAddress addr = InetAddress.getLocalHost();//get the ipaddress of the host

        String[] strDisk;
        //GET CONFIG DATA FROM XML
        Document doc = MyXMLParser.parseXmlFile("NodeConfig.xml"); // reads the nodeconfig.xml file
        String strTempFile = MyXMLParser.getElementAttr_ReturnValue(doc, "FileCounter", "TempFile");
        String strExternalProgram = MyXMLParser.getElementAttr_ReturnValue(doc, "FileCounter", "ExternalProgram"); //stores the name of the external program (i.e, perl script)
        String strDateTime = TimeCollection.getDateTimeStamp();//gets the time stamp
        ExternalProgramExecutor.executeProgram(strExternalProgram, "", true);//executes the perl script programme


        String strFile = FileIO.ReadFileFromDisk(strTempFile); //reads from the temp file generated by the execution of the perl script
        strDisk = strFile.split(","); //stores the contents of the file into the array
        String strResults = strDateTime +
                "," + strDisk[0] +           // prints the elements of the array separated by comma
                "," + strDisk[1] +
                "," + strDisk[2] +
                "," + strDisk[3] +
                "," + strDisk[4] +
                "," + strDisk[5] +
                "," + strDisk[6] +
                "," + strDisk[7];

            pw.println( "FileCounter,"+addr.getHostName()+","+strResults +"\n");


    }


}//END OF CLASS
	


