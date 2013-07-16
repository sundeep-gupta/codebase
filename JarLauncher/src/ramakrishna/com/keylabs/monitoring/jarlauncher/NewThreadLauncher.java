/*
 * Created on Jul 13, 2005
 * @author Chance Williams */
package com.keylabs.monitoring.jarlauncher;

import java.net.InetAddress;
import java.net.Socket;
import java.util.ArrayList;
import java.util.Timer;
import java.util.TimerTask;
import java.io.*;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.keylabs.monitoring.tcp.TCPThread;
import com.keylabs.monitoring.TimeCollection;
import com.keylabs.monitoring.MyXMLParser;
import com.keylabs.monitoring.rc.RCOutput;
import com.keylabs.monitoring.cpuusage.CPUUsage;
import com.keylabs.monitoring.cpu.CPUStats;
import com.keylabs.monitoring.filecounter.FileCounter;
import com.keylabs.monitoring.memory.MemoryStats;


final class NewThreadLauncher extends Thread {

    private static void jarLauncher(final Timer t, final Object o, final int dely, final PrintWriter pw) {
        t.scheduleAtFixedRate(new TimerTask() {
            public void run() {
                try {
                    if (o instanceof CPUStats) {
                        CPUStats.launchCPUTracking(pw);// it will launch CPUStats Module after getting the statistics of the CPUStats and storing them into Printwriter
                        System.out.println("Ran CPUStats - Delay was: " + String.valueOf(dely)); // it will display this output to the console
                    } else if (o instanceof MemoryStats) {

                        MemoryStats.launchMemoryTracking(pw); // it will launch CPUStats Module after getting the statistics of the Memorystats and storing them into Printwriter
                        System.out.println("Ran MemoryStats - Delay was: " + String.valueOf(dely));//it will display this output to the console
                    } else if (o instanceof CPUUsage) {

                        CPUUsage.launchCPUUsageTracking(pw); // it will launch CPUStats Module after getting the statistics of the CPUUsage and storing them into Printwriter
                        System.out.println("Ran CPUUsage - Delay was: " + String.valueOf(dely));
                    } else if (o instanceof FileCounter) {

                        FileCounter.executeFileCounting(pw); // it will launch CPUStats Module after getting the statistics of the FileCounter and storing them into Printwriter
                        System.out.println("Ran FileCounter - Delay was: " + String.valueOf(dely)); //it will display this output to the console
                    } else {
                        System.out.println("Invalid Object. Should be an instance of CPUStats,MemoryStats or FileCounter");
                    }

                } catch (Exception e) {

                    // e.printStackTrace();
                    System.out.println("Restarting Thread " + o.getClass().getName() + "....");// if any problems are there while starting the thread it will again start the thread
                    jarLauncher(t, o, dely, pw);

                }
            }
        }, 0, dely);
    }


    private static void launchAllNodeJars() {
        Document doc = MyXMLParser.parseXmlFile("NodeConfig.xml");// it parses the NodeConfig.xml and stores them into a document object
        Element element = MyXMLParser.getElementFromDoc(doc, "JarLauncher");// it will assign JarLaunchr to a variable
        ArrayList lAttributeValues = MyXMLParser.getAllAttributeValuesOfAnElement(element); // it will get the contents of the JarLauncher into arraylist


        BufferedReader in;
        BufferedWriter out;
        String str;
        String[] strTmpBuffer = new String[100];
        String[] strPort = null;
        String[] part = null;
        String[] index = null;
        int cnt = 0;


        CPUStats cpu = new CPUStats(); // it is creating Objects for all modules( CPUStats, CPUUsage, MemoryStats, FileCounter, RCOutput)
        CPUUsage cpuu = new CPUUsage();
        MemoryStats mem = new MemoryStats();
        FileCounter fc = new FileCounter();
        final RCOutput rc = new RCOutput();

        Timer timerCPUStats = new Timer(); // it is creating timer objects for all modules(CPUStats, CPUUsage, MemoryStats, FileCounter, RCOutput)
        Timer timerMemoryStats = new Timer();
        Timer timerFileCounter = new Timer();
        Timer timerCPUUsage = new Timer();
        Timer timerRCOutput = new Timer();

        Socket echoSocket;
        PrintWriter pw = null;


        try {

            InetAddress addr = InetAddress.getLocalHost(); // it will get the ip address and hostname of the Local machine where this jarlauncher is running
            String IPAddress = addr.getHostName();
            int noOfIndexer = 0;
            int noOfPart = 0;

            in = new BufferedReader(new FileReader("Config.dat")); //it will open the Config.dat file read thoes values into the buffer later it will stores these values into an array
            while ((str = in.readLine()) != null) {
                strTmpBuffer[cnt] = str;
                cnt++;
            }
            in.close();

            if ((strTmpBuffer[cnt - 1] != null) && (!strTmpBuffer[cnt - 1].equals(" ")))
                part = strTmpBuffer[cnt - 1].split("-"); // it will stores the partitions into an array

            if ((strTmpBuffer[cnt - 2] != null) && (!strTmpBuffer[cnt - 2].equals(" ")))
                index = strTmpBuffer[cnt - 2].split("-"); // it will stores the index values into and array

            if ((index[1] != null) && (!index[1].equals(" ")) && (part[1] != null) && (!part[1].equals(" "))) {
                noOfIndexer = Integer.parseInt(index[1]); //it will stores the no of indexers values into and array
                noOfPart = Integer.parseInt(part[1]); //it will stores the no of partition values into and array
            }

            if ((strTmpBuffer[0] != null) && (!strTmpBuffer[0].equals(" ")))
                strPort = strTmpBuffer[0].split("-"); //it will stores admin node details into array

            final String time;
            if ((strPort[0] != null) && (strPort[1] != null) && (strPort[0].equals(IPAddress)) && (strPort[1].equals("admin")))// it will check wether the given node is admin and correct node
            {
                System.out.println("Starting the TCP server .........");
                new TCPThread(); // it will call the TCPThread module
                time = TimeCollection.getTimeStamp();
                boolean exists = (new File("/fast/datasearch/bin/rc")).exists();
                if (exists) {

                    out = new BufferedWriter(new FileWriter(new StringBuilder().append("RCOutput_").append(time).append(".csv").toString(), true));
                    String header = "Time,";
                    int i, j;
                    for (i = 0; i < noOfIndexer; i++) { 
                        for (j = 0; j < noOfPart; j++) {
                            String strTmp = new StringBuilder().append("Inder").append(i).append("_DocCount_Partition").append(j).append(",").toString();
                            header = header.concat(strTmp);
                        }
                    }
                    out.write(header);
                    out.write("\n");
                    out.close();

                    if (lAttributeValues.contains("RCOutput")) {
                        final int nTimeDelay1 = getDelayTime(doc, "RCOutput"); // it will the get the delay time for RCOutput from the document object
                        int sec = TimeCollection.getSeconds(); // it will get the seconds value according to the Gregarian calender and time zone
                        Thread.sleep((60 - sec) * 1000);

                        timerRCOutput.scheduleAtFixedRate(new TimerTask() { //it will schedule the RCOutput thread at fixed rate
                            public void run() {
                                try {
                                    rc.launchRCTracking("RCOutput_"+time+".csv");  // it will launch the rc thread
                                    System.out.println("Ran RCOutput - Delay was: " + String.valueOf(nTimeDelay1));
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            }
                        }, 0, nTimeDelay1);

                    }
                }
            }
            if (lAttributeValues.contains("CPUStats")) {
                System.out.println(strPort[0]);
                if ((strPort[0] != null) && (strPort[1].equals("admin"))) {
                    echoSocket = new Socket(strPort[0], 8889); // connects to the server using the given port 
                    pw = new PrintWriter(echoSocket.getOutputStream(), true); // get the output from the local host and stores it into printwriter
                }

                final int nTimeDelay1 = getDelayTime(doc, "CPUStats"); // get the time delay from the document object for CPUStats
                Object o;
                o = cpu;

                try {
                    int sec = TimeCollection.getSeconds(); // it will get the seconds value according to the Gregarian calender and time zone
                    Thread.sleep((60 - sec) * 1000);
                    jarLauncher(timerCPUStats, o, nTimeDelay1, pw); // start the jarlaucher for CPUStats
                }
                catch (Exception e) {
                    System.out.println("Failed to launch jarLauncher for CPUStats"); // if any problems while starting the jarlauncher it will thrown the exeception
                    e.printStackTrace();
                }
            }

            if (lAttributeValues.contains("MemoryStats")) {
                final int nTimeDelay3 = getDelayTime(doc, "MemoryStats"); // get the time delay from the document object for Memorystats
                Object o;
                o = mem;
                // System.out.println(strPort[0]);
                if ((strPort[0] != null) && (strPort[1].equals("admin"))) {
                    echoSocket = new Socket(strPort[0], 8889); // connects to the server using the given port
                    pw = new PrintWriter(echoSocket.getOutputStream(), true); // get the output from the local host and stores it into printwriter
                }

                try {
                    int sec = TimeCollection.getSeconds(); // it will get the seconds value according to the Gregarian calender and time zone
                    Thread.sleep((60 - sec) * 1000);
                    jarLauncher(timerMemoryStats, o, nTimeDelay3, pw); // start the jarlaucher for MemoryStats
                }
                catch (Exception e) {
                    System.out.println("Failed to launch jarLauncher for MemoryStats");
                    e.printStackTrace();
                }
            }

            if (lAttributeValues.contains("CPUUsage")) {

                if ((strPort[0] != null) && (strPort[1].equals("admin"))) {
                    echoSocket = new Socket(strPort[0], 8889); // connects to the server using the given port
                    pw = new PrintWriter(echoSocket.getOutputStream(), true); // get the output from the local host and stores it into printwriter

                }

                final int nTimeDelay1 = getDelayTime(doc, "CPUUsage"); // get the time delay from the document object for CPUUsage
                Object o;
                o = cpuu;

                try {
                    int sec = TimeCollection.getSeconds(); // it will get the seconds value according to the Gregarian calender and time zone
                    Thread.sleep((60 - sec) * 1000);
                    jarLauncher(timerCPUUsage, o, nTimeDelay1, pw); // start the jarlaucher for CPUUsage
                }
                catch (Exception e) {
                    System.out.println("Failed to launch jarLauncher for CPUUsage");
                    e.printStackTrace();
                }
            }

            if (lAttributeValues.contains("FileCounter")) {
                // System.out.println(strPort[0]);
                if ((strPort[0] != null) && (strPort[1].equals("admin"))) {
                    echoSocket = new Socket(strPort[0], 8889); // connects to the server using the given port
                    pw = new PrintWriter(echoSocket.getOutputStream(), true); // get the output from the local host and stores it into printwriter
                }

                final int nTimeDelay4 = getDelayTime(doc, "FileCounter"); // get the time delay from the document object for FileCounter
                Object o;
                o = fc;

                try {
                    int sec = TimeCollection.getSeconds(); // it will get the seconds value according to the Gregarian calender and time zone
                    Thread.sleep((60 - sec) * 1000);
                    jarLauncher(timerFileCounter, o, nTimeDelay4, pw); // start the jarlaucher for FileCounter
                }	
                catch (Exception e) {
                    System.out.println("Failed to launch jarLauncher for FileCounter");
                    e.printStackTrace();
                }
            }

        }
        catch (Exception e) {
            System.out.println("Re-Launching AllNodeJars .......... ");
            // e.printStackTrace();
            try {
                Thread.sleep(10000);
                launchAllNodeJars(); // it will again launch the jarlaucher for all modules after sleeping 10sec's
            } catch (InterruptedException e1) {
                //e1.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
            }
        }
    }

    private static int getDelayTime(Document doc, String strAttribute) {
        int nTimeDelay;
        nTimeDelay = (Integer.valueOf(MyXMLParser.getElementAttr_ReturnValue(doc, strAttribute, "delay"))) * 1000;
        return nTimeDelay;
    }

    public static void main(String[] args) {
        launchAllNodeJars(); //it will launch the jarlauncher intially
    }
}
