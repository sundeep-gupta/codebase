/*
 * Created on May 12, 2005
 * Chance Williams
 */
package com.keylabs.monitoring.cpuusage;

import java.io.PrintWriter;   /** We are importing all the inbuilt classes from java api*/
import java.net.InetAddress;
import java.net.UnknownHostException;

import org.w3c.dom.Document;

import com.keylabs.monitoring.ExternalProgramExecutor;   /** We are importing the classes from other packages*/
import com.keylabs.monitoring.FileIO;
import com.keylabs.monitoring.MyXMLParser;
import com.keylabs.monitoring.TimeCollection;

public final class CPUUsage {  //this function collects the values of CPU usage from CPUUsage.html file and displays the result

     public static void launchCPUUsageTracking(PrintWriter pw) throws UnknownHostException {

        InetAddress addr = InetAddress.getLocalHost();//This will get the host name and stores in a variable called addr


        Document doc = MyXMLParser.parseXmlFile("NodeConfig.xml");//Get the data from the config.dat file
        String strExternalProgram = MyXMLParser.getElementAttr_ReturnValue(doc, "CPUUsage", "ExternalProgram");
        String strDateTime = TimeCollection.getDateTimeStamp();  //this will return the time stamp
        ExternalProgramExecutor.executeProgram(strExternalProgram, "", true); //this will  execute the perl script

        String strCPU = FileIO.ReadFileFromDisk("CPUUsage.html");  //This reads the data from the file CPUUsage.html

            pw.println( "CPUUsage,"+addr.getHostName()+ "," + strDateTime + "," + strCPU +"\n");  //it puts the output throught the tcp port


    }


}//END OF CLASS



