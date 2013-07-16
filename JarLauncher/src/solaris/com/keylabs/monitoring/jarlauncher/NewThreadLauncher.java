/* This is the main package in which the main class is present.This class initiates all the other modules like cpu
cpuusage,filecounter,memory,rc and tcp
 * Created on Jul 13, 2005
 * @author Chance Williams */
package com.keylabs.monitoring.jarlauncher;

import java.net.InetAddress;  /** We are importing all the inbuilt classes from java api*/
import java.net.Socket;
import java.util.ArrayList;
import java.util.Timer;
import java.util.TimerTask;
import java.io.*;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.keylabs.monitoring.tcp.TCPThread; /** We are importing the classes from other packages*/
import com.keylabs.monitoring.TimeCollection;
import com.keylabs.monitoring.MyXMLParser;
import com.keylabs.monitoring.cpuusage.CPUUsage;
import com.keylabs.monitoring.rc.RCOutput;
import com.keylabs.monitoring.sun.SunStats;
import com.keylabs.monitoring.filecounter.FileCounter;



final class NewThreadLauncher extends Thread { // this checks for the object and if it finds the match it would initiate that particular module

    private static void jarLauncher(final Timer t, final Object o, final int dely, final PrintWriter pw) {
        t.scheduleAtFixedRate(new TimerTask() {
            public void run() {
                try {  //This would check for the object if it is SunStats ,CPUStats etc and then calls the respective function and if not it throws the exception
                    if (o instanceof SunStats) {
                        SunStats.launchSunStats(pw);
                        System.out.println("Ran SunStats - Delay was: " + String.valueOf(dely));
                    } else if (o instanceof CPUUsage) {
                        CPUUsage.launchCPUUsageTracking(pw);
                        System.out.println("Ran CPUUsage - Delay was: " + String.valueOf(dely));
                    } else if (o instanceof FileCounter) {
                        FileCounter.executeFileCounting(pw);
                        System.out.println("Ran FileCounter - Delay was: " + String.valueOf(dely));
                    } else {
                        System.out.println("Invalid Object. Should be an instance of SunStats,CPUUsage or FileCounter");
                    }

                } catch (Exception e) {

                    // e.printStackTrace();
                    System.out.println("Restarting Thread " + o.getClass().getName() + "....");
                    jarLauncher(t, o, dely, pw);

                }
            }
        }, 0, dely);
    }


    private static void launchAllNodeJars() { // This class initiates all the other modules*/
        Document doc = MyXMLParser.parseXmlFile("NodeConfig.xml"); /** This line parses the file NodeConfig.xml in the
     path /home/fast/NewMonitor/NodeConfig.xml and stores the output in a document named doc*/
        Element element = MyXMLParser.getElementFromDoc(doc, "JarLauncher");
        ArrayList lAttributeValues = MyXMLParser.getAllAttributeValuesOfAnElement(element); //This stores all the attribute
        //values after the word JarLauncher in an array

        BufferedReader in; /** To read a text from a character input stream,buffering characters so as to provide
     efficient reading*/
        BufferedWriter out;
        String str;
        String[] strTmpBuffer = new String[100];
        String[] strPort = null;
        String[] part = null;
        String[] index = null;
        int cnt = 0;

        SunStats sun = new SunStats();  // creating objects for all the modules*/
        CPUUsage cpuu = new CPUUsage();
        FileCounter fc = new FileCounter();
        final RCOutput rc = new RCOutput();

        Timer timerSunStats = new Timer();  //creating timers for all the modules/
        Timer timerFileCounter = new Timer();
        Timer timerRCOutput = new Timer();
        Timer timerCPUUsage = new Timer();

        Socket echoSocket;
        PrintWriter pw = null;

        try {

            InetAddress addr = InetAddress.getLocalHost();  //To get the hostname of the admin node/
            String IPAddress = addr.getHostName();
            int noOfIndexer = 0;
            int noOfPart = 0;

            in = new BufferedReader(new FileReader("Config.dat"));//To read the values of the config.dat file/
            while ((str = in.readLine()) != null) {
                strTmpBuffer[cnt] = str;
                cnt++;
            }
            in.close();

            if ((strTmpBuffer[cnt - 1] != null) && (!strTmpBuffer[cnt - 1].equals(" "))) // Storing the last row of the config.dat file
                part = strTmpBuffer[cnt - 1].split("-");

            if ((strTmpBuffer[cnt - 2] != null) && (!strTmpBuffer[cnt - 2].equals(" ")))
                index = strTmpBuffer[cnt - 2].split("-");   //Storing the values of last but one row of the config.dat file

            if ((index[1] != null) && (!index[1].equals(" ")) && (part[1] != null) && (!part[1].equals(" "))) {
                noOfIndexer = Integer.parseInt(index[1]);  //stores the value of number of indexers and number of partitions
                noOfPart = Integer.parseInt(part[1]);
            }

            if ((strTmpBuffer[0] != null) && (!strTmpBuffer[0].equals(" ")))
                strPort = strTmpBuffer[0].split("-"); //this stores the name of the admin node

            if ((strPort[0] != null) && (strPort[1] != null) && (strPort[0].equals(IPAddress)) && (strPort[1].equals("admin")))
            {
                System.out.println("Starting the TCP server .........");// if the admin node is equal to the host name
                //stored previously then start the TCP server/
                new TCPThread(); //now the inbuilt function TCPThread is invoked
                String time = TimeCollection.getTimeStamp();
                boolean exists = (new File("/fast/datasearch/bin/rc")).exists(); //checks whether the rc file is present or not/
                if (exists) {  //if it is present enters in to the loop/

                    //This would write headers into the empty file using the inbuilt class StringBuilder
                    out = new BufferedWriter(new FileWriter("RCOutput_"+time+".csv", true));
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

                    if (lAttributeValues.contains("RCOutput")) { //checks whether the AttributeValues array from the config.dat file
                        //consists of the string "RCOutput/"
                        final int nTimeDelay1 = getDelayTime(doc, "RCOutput"); //will call the getDelayTime function/
                        int sec = TimeCollection.getSeconds(); //calls the getSeconds function which will return the number of seconds/
                        Thread.sleep((60 - sec) * 1000); //This would make the thread to sleep for the specified time for time sync purpose

                        timerRCOutput.scheduleAtFixedRate(new TimerTask() {  //This would specify the scheduled time for which the data is to be collected
                            public void run() {
                                try {
                                    rc.launchRCTracking(); //This would instantiate the RCOutput module
                                    System.out.println("Ran RCOutput - Delay was: " + String.valueOf(nTimeDelay1)); //Prints out the value of the delay time
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            }
                        }, 0, nTimeDelay1);

                    }
                }
            }
            if (lAttributeValues.contains("SunStats")) {//checks whether the AttributeValues array from the config.dat file
                        //consists of the string "SunStats/"
                System.out.println(strPort[0]);
                if ((strPort[0] != null) && (strPort[1].equals("admin"))) {  // if the admin node is equal to the ip address
                //stored previously then start the TCP server/
                    echoSocket = new Socket(strPort[0], 8889); // connects to the server through the port 8889 and waits for the permission
                    pw = new PrintWriter(echoSocket.getOutputStream(), true);  //This would accept the handshake from the respective module.
                }

                final int nTimeDelay1 = getDelayTime(doc, "SunStats"); //This would give the delay time value from the nodeconfig.xml file
                Object o;
                o = sun;

                try {
                    int sec = TimeCollection.getSeconds();//This would give the current time in seconds
                    Thread.sleep((60 - sec) * 1000); //This makes the thread sleep for the specified amount of time for time sync purpose
                    jarLauncher(timerSunStats, o, nTimeDelay1, pw); //This invokes the jarlauncher method
                }
                catch (Exception e) {
                    System.out.println("Failed to launch jarLauncher for SunStats");
                    e.printStackTrace();
                }
            }

            if (lAttributeValues.contains("CPUUsage")) { //checks whether the AttributeValues array from the config.dat file
                        //consists of the string "CPUUsage/"

                if ((strPort[0] != null) && (strPort[1].equals("admin"))) {  // if the admin node is equal to the ip address
                //stored previously then start the TCP server/
                    echoSocket = new Socket(strPort[0], 8889); // connects to the server
                    pw = new PrintWriter(echoSocket.getOutputStream(), true); //this will write through the tcp port into the admin node

                }

                final int nTimeDelay1 = getDelayTime(doc, "CPUUsage"); //gives the delay time
                Object o;
                o = cpuu;

                try {
                    int sec = TimeCollection.getSeconds();
                    Thread.sleep((60 - sec) * 1000);
                    jarLauncher(timerCPUUsage, o, nTimeDelay1, pw);
                }
                catch (Exception e) {
                    System.out.println("Failed to launch jarLauncher for CPUUsage");
                    e.printStackTrace();
                }
            }

            if (lAttributeValues.contains("FileCounter")) { //checks whether the AttributeValues array from the config.dat file
                        //consists of the string "FileCounter/"
                // System.out.println(strPort[0]);
                if ((strPort[0] != null) && (strPort[1].equals("admin"))) {
                    echoSocket = new Socket(strPort[0], 8889); // connects to the server
                    pw = new PrintWriter(echoSocket.getOutputStream(), true);
                }

                final int nTimeDelay4 = getDelayTime(doc, "FileCounter");
                Object o;
                o = fc;

                try {
                    int sec = TimeCollection.getSeconds();
                    Thread.sleep((60 - sec) * 1000);
                    jarLauncher(timerFileCounter, o, nTimeDelay4, pw);
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
                launchAllNodeJars();
            } catch (InterruptedException e1) {
                //e1.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
            }
        }
    }

    private static int getDelayTime(Document doc, String strAttribute) { //This would return the value of the timedelay in milliseconds from the nodeconfig.xml file
        int nTimeDelay;
        nTimeDelay = (Integer.valueOf(MyXMLParser.getElementAttr_ReturnValue(doc, strAttribute, "delay"))) * 1000;
        return nTimeDelay;
    }

    public static void main(String[] args) {   //This is the main function which would initiate all the modules like CPUUsage,Filecounter,RCOutput,Sunstats
        launchAllNodeJars();
    }
}
