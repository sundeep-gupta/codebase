/*
 * Created on May 16, 2005
 * Author: Chance Williams
 */
package com.keylabs.monitoring.cpu;


import static com.keylabs.monitoring.FileIO.ReadFileFromDiskReturnSet;

import java.io.*;
import java.net.InetAddress;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;
import java.lang.System;


import org.w3c.dom.Document;

import com.keylabs.monitoring.ExternalProgramExecutor;
import com.keylabs.monitoring.GenericUtilities;
import com.keylabs.monitoring.Logger;
import com.keylabs.monitoring.MyXMLParser;
import com.keylabs.monitoring.TimeCollection;

public final class CPUStats {
    /*
      * launchCPUTracking()
      */
    public static void launchCPUTracking(PrintWriter pw) {
        try {
            CPUStats_CleanUp psListCleanUp = new CPUStats_CleanUp();
            InetAddress addr = InetAddress.getLocalHost();  //it will get the ip address of the local host where this jarlauncher is running
            BufferedReader in;
            String str;
            String[] strTmpBuffer = new String[100];
            String[] stat;
            String[] nodeName = null;
            String[] process = null;
            String[] pid = null;
            String[] cpuTime = null;
            String[] cpuETime = null;

            int COUNT = 0;
            in = new BufferedReader(new FileReader("WatchedProcesses.dat")); //store the WatchedProcesses.dat into a buffer then read and find the no of processes available on the lista
            while ((str = in.readLine()) != null) {
                COUNT++;
            }
            in.close();

            String[] strTmpfile = new String[(COUNT * 2) + 1]; // create a temporary string array size equal to 2*(no of process in the WatchedProcesses.dat)+1 and assign blank values
        for ( int i=0;i<strTmpfile.length ; i++){
                strTmpfile[i]=" ";
        }
            String strNodeName = "NodeName=" + addr.getHostName();
            //GET Config Parameters from XML file NodeConfig.xml
            String strConfigFile = "NodeConfig.xml";
            Document doc = MyXMLParser.parseXmlFile(strConfigFile); // it will parse the NodeConfig.xml and store the contents into a document object
            String strProcsToWatchFor = MyXMLParser.getElementAttr_ReturnValue(doc, "CPUStats", "ProcsToWatchFor"); // it will get the values for ProcsToWatchFor, TempFile and ExternalProgram 
            String strTempFile = MyXMLParser.getElementAttr_ReturnValue(doc, "CPUStats", "TempFile");

            String strExternalProgram = MyXMLParser.getElementAttr_ReturnValue(doc, "CPUStats", "ExternalProgram");

            ArrayList arListData;
            Set lstProcsToWatchFor = new HashSet(ReadFileFromDiskReturnSet(strProcsToWatchFor)); //read the WatchedProcesses.dat file from the disk and stored it into a hashset

            String strDateTime = TimeCollection.getDateTimeStamp(); // get the date and time in timestamp  format
            // System.out.println("Date: "+strDateTime);
            int count = 0;
            ExternalProgramExecutor.executeProgram(strExternalProgram, strTempFile, false); //it will execute the exeternal program (perl scripts) and get the system statistics then stored it into a temporary file 

            arListData = readPSListOutput_CreateList(lstProcsToWatchFor, strTempFile, strNodeName); //it will check the process in tmepfile against the WatchedProcesses.dat file and store the result into a array list
            String[] strTmp = psListCleanUp.listCleaner(arListData); // it will clean up the array list by deleting multiple instances of the processes after adding the values of those processes and stored it into a string array 


            strTmpfile[count] = strDateTime;
            for (String aStrTmp : strTmp) {
                if ((aStrTmp != null) && (!aStrTmp.equals(" "))) {
                    stat = aStrTmp.split("\\s");
                    for (String aStat : stat) {
                        // System.out.println(i+" : "+stat[i]);
                        String tmp[] = aStat.split("=");
                        if (tmp[0].equals("NodeName")) {
                            nodeName = aStat.split("=");
                        }
                        if (tmp[0].equals("Process")) {
                            process = aStat.split("=");
                        }
                        if (tmp[0].equals("PID")) {
                            pid = aStat.split("=");
                        }
                        if (tmp[0].equals("CPUTime")) {
                            cpuTime = aStat.split("=");
                        }
                        if (tmp[0].equals("CPUElapsedTime")) {
                            cpuETime = aStat.split("=");
                        }
                    }
                    int cnt = 0;
                    in = new BufferedReader(new FileReader("WatchedProcesses.dat")); // this is to get the CPUtime and CPUElapsed time for all porcesses in a node
                    while ((str = in.readLine()) != null) {
                        strTmpBuffer[cnt] = str;
//                        count = ((cnt * 1) + 1);
                        count = ((cnt * 2) + 1);
                        if (strTmpBuffer[cnt].equals(process[1])) {
                            String CPUTime = Float.toString(TimeCollection.breakTimeToSeconds(cpuTime[1]));
                            String CPUElapsedTime = Float.toString(TimeCollection.breakTimeToSeconds(cpuETime[1]));
                            strTmpfile[count] = CPUTime;
                            int next = count + 1;
                            strTmpfile[next] = CPUElapsedTime;

                        }
                        cnt++;
                    }
                    in.close();
                }
            }


            String strFileContents = GenericUtilities.convertStringArrayToStringCSV(strTmpfile); //ii will convert string array to String CSV and then it into a string array

            pw.println("CPUStats," + addr.getHostName() + "," + strFileContents + "\n"); // it will write these contents into the server-- means send these details to the server 
        }
        catch (Exception e) {
            e.printStackTrace();
        }

    }

    /*
          * GET THE PSList Information and return if in string form ready for upload
          */
    private static ArrayList readPSListOutput_CreateList(Set lstProcsToWatchFor, String strPSListFile, String strNodeName) {
//		IN:  pslist             3092  13   2   92    732     0:00:03.500     4:12:14.860
//		OUT: NodeName=dell1 Process=procserver PID=3092 CPUTime=0:00:03.500 CPUElapsedTime=4:12:14.860
        ArrayList lstTemp = new ArrayList();
        String str;
        try {
            BufferedReader in = new BufferedReader(new FileReader(strPSListFile)); // it will read the tempfile and stored it into buffer
            while ((str = in.readLine()) != null) { // it will remove the white spacesa and Parenthesis and format them then stored into a arraylist
                str = GenericUtilities.removeExtraWhiteSpace(str); 
                str = GenericUtilities.removeParens(str);
                String[] strFields = str.split(" ");

                if (GenericUtilities.isProcessWeAreWatchingFor(strFields[0], lstProcsToWatchFor)) {
                    lstTemp.add(
                            strNodeName + " " +
                                    "Process=" + strFields[0] + " " +
                                    "PID=" + strFields[1] + " " +
                                    "CPUTime=" + strFields[6] + " " +
                                    "CPUElapsedTime=" + strFields[7] + " endMark");
                }
            }
            in.close();
        } catch (IOException e) {
            System.out.println("CPUStats.Java IOException in: readPSListCreateOutputFile()");
            Logger.LogError("CPUStats.Java IOException in: readPSListCreateOutputFile()");

        }
        return lstTemp;
    }


}//END OF CLASS
