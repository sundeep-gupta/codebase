/*
 * Created on May 16, 2005
 * Author: Chance Williams
 */
package com.keylabs.monitoring.memory;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetAddress;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.w3c.dom.Document;

import com.keylabs.monitoring.*;


public final class MemoryStats {
    /*
      * launchCPUTracking()
      * THIS IS USED FOR STANDALONE USE NOT FOR INTEGRATION WITH MAINFRAME AND PANELS
      */
    public static void launchMemoryTracking(PrintWriter pw) {

              try {
        FileIO fIO = new FileIO();
        InetAddress addr = InetAddress.getLocalHost();//it will get the ip address of the local host where this jarlauncher is running
        BufferedReader in;
        String str;
        String[] strTmpBuffer = new String[100];
        String[] stat;
        String[] nodeName = null;
        String[] process = null;
        String[] virtMem = null;
        String[] wsMem = null;

         int COUNT = 0;
        in = new BufferedReader(new FileReader("WatchedProcesses.dat")); //store the WatchedProcesses.dat into a buffer then read and find the no of processes available on the lista
        while ((str = in.readLine()) != null) {
            COUNT++;
        }
        in.close();

        String[] strTmpfile = new String[(COUNT*2)+1]; // create a temporary string array size equal to 2*(no of process in the WatchedProcesses.dat)+1 and assign blank values
        for ( int i=0;i<strTmpfile.length ; i++){
                strTmpfile[i]=" ";
        }

        String strNodeName = "NodeName=" + addr.getHostName();
        //GET Config Parameters from XML
        Document doc = MyXMLParser.parseXmlFile("NodeConfig.xml");
        String strProcsToWatchFor = MyXMLParser.getElementAttr_ReturnValue(doc, "MemoryStats", "ProcsToWatchFor");
        String strTempFile = MyXMLParser.getElementAttr_ReturnValue(doc, "MemoryStats", "TempFile");

        String strExternalProgram = MyXMLParser.getElementAttr_ReturnValue(doc, "MemoryStats", "ExternalProgram");


        String strDateTime = TimeCollection.getDateTimeStamp();
        int count = 0;
        ExternalProgramExecutor.executeProgram(strExternalProgram, strTempFile, false);//this is where we would return HashSet

        Set lstProcsToWatchFor = new HashSet(fIO.ReadFileFromDiskReturnSet(strProcsToWatchFor)); //read the WatchedProcesses.dat file from the disk and stored it into a hashset
        ArrayList arListData = new ArrayList(readDataAndCreateArray(lstProcsToWatchFor, strTempFile, strNodeName)); //it will check the process in tmepfile against the WatchedProcesses.dat file and store the result into a array list
        String[] strTmp = MemStats_ListCleanUp.combineDuplicateEntries(arListData); // it will clean up the array list by deleting multiple instances of the processes after adding the values of those processes and stored it into a string arrayd

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
                        if (tmp[0].equals("VirtMem")) {
                            virtMem = aStat.split("=");
                        }
                        if (tmp[0].equals("WorkingSet")) {
                            wsMem = aStat.split("=");
                        }
                    }
                    int cnt = 0;
                    in = new BufferedReader(new FileReader("WatchedProcesses.dat")); // this is to get the CPUtime and CPUElapsed time for all porcesses in a node
                    while ((str = in.readLine()) != null) {
                        strTmpBuffer[cnt] = str;
                        count = ((cnt * 2) + 1);
                        if (strTmpBuffer[cnt].equals(process[1])) {
                            strTmpfile[count] = virtMem[1];
                            int next = count + 1;
                            strTmpfile[next] = wsMem[1];

                        }
                        cnt++;
                    }
                    in.close();
                }
            }


            String strFileContents = GenericUtilities.convertStringArrayToStringCSV(strTmpfile); //ii will convert string array to String CSV and then it into a string array
            pw.println("MemoryStats,"+addr.getHostName()+","+strFileContents+"\n"); // it will write these contents into the server-- means send these details to the server 
        }
        catch (Exception e) {
            e.printStackTrace();
        }

    }


    private static List readDataAndCreateArray(Set lstProcsToWatchFor, String strPSListFile, String strNodeName) {
        String str;
        List lstTemp = new ArrayList();
        try {
            BufferedReader in = new BufferedReader(new FileReader(strPSListFile));
            while ((str = in.readLine()) != null) { // it will remove the white spacesa and Parenthesis and format them then stored into a arraylist
                //REMOVE EXTRA WHITESPACE
                str = str.trim();
                str = GenericUtilities.removeExtraWhiteSpace(str);
                str = GenericUtilities.removeParens(str);
                //Parse string
                String[] strFields = str.split(" ");
                //	compare with set
                if (GenericUtilities.isProcessWeAreWatchingFor(strFields[0], lstProcsToWatchFor)) {
                    lstTemp.add(
                            strNodeName + " " +
                                    "Process=" + strFields[0] + " " +
                                    "VirtMem=" + strFields[5] + " " +
                                    "WorkingSet=" + strFields[6] + " endMark");

                }
            }
            in.close();
        } catch (IOException e) {
            String strTemp = "MemoryStats.java IOException in: readListAndCreateOutputFile()" + e.getMessage();
            System.out.println(strTemp);
            Logger.LogError(strTemp);// if any error messages are there it create a log into the local machine it self

        }
        return lstTemp;
    }



}//END OF CLASS
