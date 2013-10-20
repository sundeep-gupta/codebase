// Decompiled by DJ v3.8.8.85 Copyright 2005 Atanas Neshkov  Date: 1/23/2006 4:51:56 PM
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   SunStats.java

package com.keylabs.monitoring.sun;

import static com.keylabs.monitoring.ExternalProgramExecutor.executeProgram;
import com.keylabs.monitoring.*;

import java.io.BufferedReader; /** We are importing all the inbuilt classes from java api*/
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

import com.keylabs.monitoring.GenericUtilities; /** We are importing the classes from other classese*/
import com.keylabs.monitoring.Logger;
import com.keylabs.monitoring.MyXMLParser;
import com.keylabs.monitoring.TimeCollection;


public final class SunStats {// This class gives the memory and cpu usage /

    public SunStats() {
    }

    public static void launchSunStats(PrintWriter pw) {
        try {
            SunStats_ListCleanUp sunListCleanUp = new SunStats_ListCleanUp();// This calls the clean up process which would remove the repeated values and add them and place in a new value
            InetAddress addr = InetAddress.getLocalHost(); //this will give the ip adrress
            BufferedReader in;
            String str;
            String[] strTmpBuffer = new String[100];
            String[] stat;
            String[] nodeName = null;
            String[] process = null;
            String[] pid = null;
            String[] cpuTime = null;
            String[] virtMem = null;
            String[] wsMem = null;

            int COUNT = 0;
            in = new BufferedReader(new FileReader("WatchedProcesses.dat"));//reads the file WatchedProcesses.dat
            while ((str = in.readLine()) != null) {
                COUNT++;  //Value of count gives the number of processes running
            }
            in.close();

            String[] strTmpfile = new String[(COUNT * 3) + 1];//This would store the size as (count*3) i.e., for all the 3 counters(CPUUsage,VERT memory and Working Set Memory) and +1 is for the time at which the values are taken
            for (int i = 0; i < strTmpfile.length; i++) {
                strTmpfile[i] = " ";
            }
            int count = 0;
            String strNodeName = "NodeName=" + addr.getHostName();//gets the host name
            String strConfigFile = "NodeConfig.xml";
            org.w3c.dom.Document doc = MyXMLParser.parseXmlFile(strConfigFile); //parses the NodeConfig.xml file
            String strProcsToWatchFor = MyXMLParser.getElementAttr_ReturnValue(doc, "SunStats", "ProcsToWatchFor");//Stores the value for ProcsToWatchFor for SunStats from NodeConfig.xml
            String strTempFile = MyXMLParser.getElementAttr_ReturnValue(doc, "SunStats", "TempFile");//Stores the value for TempFile for SunStats from NodeConfig.xml
            String strExternalProgram = MyXMLParser.getElementAttr_ReturnValue(doc, "SunStats", "ExternalProgram");//Stores the value for ExternalProgram for SunStats from NodeConfig.xml
            ArrayList arListData;
            Set lstProcsToWatchFor = new HashSet(FileIO.ReadFileFromDiskReturnSet(strProcsToWatchFor)); //This would create a new list for the values in watchedprocesses.dat (i.e. size equal to the contents of the file)
            executeProgram(strExternalProgram, strTempFile, false);//this would execute the external program prstat
            arListData = readPSListOutput_CreateList(lstProcsToWatchFor, strTempFile, strNodeName);//This would create the list of the processes in WatchedProcesses.dat
            String strTmp[] = sunListCleanUp.listCleanUp(arListData);//calls the function ListCleanup which would clean up the dataredundancy

            String strDateTime;
            strDateTime = TimeCollection.getDateTimeStamp(); //This would give u the current date and time
            strTmpfile[count] = strDateTime;
            for (String aStrTmp : strTmp) {
                if ((aStrTmp != null) && (!aStrTmp.equals(" "))) {
                    stat = aStrTmp.split("\\s");
                    for (String aStat : stat) {
                        // System.out.println(i+" : "+stat[i]);
                        String tmp[] = aStat.split("=");
                        if (tmp[0].equals("NodeName")) {  //splits the data and stores it into individual elements and stores the values of the individual elements(i.e.,lefthandside value of =)
                            nodeName = aStat.split("=");  //stores the value of nodename
                        }
                        if (tmp[0].equals("Process")) {
                            process = aStat.split("="); //stores the value of Processname
                        }
                        if (tmp[0].equals("PID")) {
                            pid = aStat.split("=");  //stores the value of PID
                        }
                        if (tmp[0].equals("CPUTime")) {
                            cpuTime = aStat.split("=");   //stores the value of CPUTime
                        }
                        if (tmp[0].equals("VirtMem")) {
                            virtMem = aStat.split("=");  //stores the value of Virtual Memory
                        }
                        if (tmp[0].equals("WorkingSet")) {
                            wsMem = aStat.split("=");   //stores the value of WorkingSetMemory
                        }
                    }
                    if (process[1] != null && !process[1].equals(" ")) {
                        int cnt = 0;
                        in = new BufferedReader(new FileReader("WatchedProcesses.dat"));//reads the WatchedProcesses.dat
                        while ((str = in.readLine()) != null) {
                            strTmpBuffer[cnt] = str;
                            count = ((cnt * 3) + 1);
                            if (strTmpBuffer[cnt].equals(process[1])) {
                                String CPUTime;
                                CPUTime = Float.toString(TimeCollection.breakTimeToSeconds(cpuTime[1]));//collects the CPUTime
                                strTmpfile[count] = CPUTime;
                                int next = count + 1;
                                strTmpfile[next] = virtMem[1];
                                next = next + 1;
                                strTmpfile[next] = wsMem[1];
                            }
                            cnt++;
                        }
                        in.close();
                    }
                }
            }


            String strFileContents = GenericUtilities.convertStringArrayToStringCSV(strTmpfile);
            pw.println("SunStats," + addr.getHostName() + "," + strFileContents + "\n");//this would send the data into the tcp server
        }
        catch (Exception e) {
            e.printStackTrace();
        }

    }

    private static ArrayList readPSListOutput_CreateList(Set lstProcsToWatchFor, String strPSListFile, String strNodeName) { //This would parse the nodeconfig.xml file and then stores the value of PID CPUTime,Virtmemory and Workset memory for all the processes in to an array
        ArrayList lstTemp = new ArrayList();
        try {
            BufferedReader in = new BufferedReader(new FileReader(strPSListFile));
            String str;
            while ((str = in.readLine()) != null) {
                str = GenericUtilities.removeExtraWhiteSpace(str);
                String strFields[] = str.split(" ");
                if (strFields[8].indexOf(':') > -1 && strFields[9].indexOf('%') > -1) {
                    strFields[10] = strFields[10].substring(0, strFields[10].indexOf("/"));
                    if (strFields[10].compareTo("contentdistribu") == 0)
                        strFields[10] = "contentdistributor";
                    if (GenericUtilities.isProcessWeAreWatchingFor(strFields[10], lstProcsToWatchFor)) {
                        strFields[3] = changeLetterToValue(strFields[3]);
                        strFields[4] = changeLetterToValue(strFields[4]);
                        // strFields[3] = String.valueOf(Long.parseLong(strFields[3]) - Long.parseLong(strFields[4]));
                        lstTemp.add(strNodeName + " " + "Process=" + strFields[10] + " " + "PID=" + strFields[1] + " " + "CPUTime=" + strFields[8] + " " + "VirtMem=" + strFields[3] + " " + "WorkingSet=" + strFields[4] + " endMark");
                    }
                }
            }
            in.close();
        }
        catch (IOException e) {  //If there is any exception is generated it is caught here and the mssg given by the exception is printed
            System.out.println("SunStats.Java IOException in: readPSListCreateOutputFile()" + e.getMessage());
            Logger.LogError("SunStats.Java IOException in: readPSListCreateOutputFile()" + e.getMessage());
        }
        return lstTemp;
    }

    private static String changeLetterToValue(String strTemp) {
        if (strTemp.indexOf('K') > -1) //This function will check for the first occurence of the character K and returns a unicode number(from 0 to XFFF)
            strTemp = strTemp.substring(0, strTemp.length() - 1) + "000";
        else if (strTemp.indexOf('M') > -1)
            strTemp = strTemp.substring(0, strTemp.length() - 1) + "000000";
        else if (strTemp.indexOf('G') > -1)
            strTemp = strTemp.substring(0, strTemp.length() - 1) + "000000000";
        return strTemp;
    }


}