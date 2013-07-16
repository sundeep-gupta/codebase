/*
 * Created on May 12, 2005
 * Chance Williams
 */
package com.keylabs.monitoring.rc;

import org.w3c.dom.Document;

import com.keylabs.monitoring.ExternalProgramExecutor;
import com.keylabs.monitoring.FileIO;
import com.keylabs.monitoring.MyXMLParser;
import com.keylabs.monitoring.TimeCollection;

public final class RCOutput {

     public static void launchRCTracking() {//this will give the number of  partition


        //GET CONFIG DATA FROM XML
        Document doc = MyXMLParser.parseXmlFile("NodeConfig.xml");//This would parse the NodeConfig.xml file
        String strExternalProgram = MyXMLParser.getElementAttr_ReturnValue(doc, "RCOutput", "ExternalProgram");//This stores the name of the perl script to be executed
        String strTempFile = MyXMLParser.getElementAttr_ReturnValue(doc, "RCOutput", "TempFile"); //This stores the value of the Tempfile in which the data is to be written
        String strDateTime = TimeCollection.getDateTimeStamp();// Gives the timestamp
        String strOutputPath = MyXMLParser.getElementAttr_ReturnValue(doc, "RCOutput", "OutputPath");//This stores the location of the output path
        String strLocationToWriteResults = MyXMLParser.getElementAttr_ReturnValue(doc, "RCOutput", "OutputFile");//This stores the name of the OutputFile

        ExternalProgramExecutor.executeProgram(strExternalProgram, "", false);//This would execute the perlscript and stores the result into the temp file

        String strRC = FileIO.ReadFileFromDisk(new StringBuilder().append(strOutputPath).append(strTempFile).toString());

        FileIO.writeStringToFile(strOutputPath + strLocationToWriteResults, strDateTime + "," + strRC + "\n", true);

            // pw.println( "RCOutput,"+addr.getHostName()+ "," + strDateTime + "," + strRC +"\n");
    }


}//END OF CLASS



