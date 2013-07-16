package com.keylabs.monitoring.tcp;

import java.io.*;
import java.net.*;

import com.keylabs.monitoring.TimeCollection;

public final class TCPThread extends Thread {

    private final ServerSocket dateServer;  // create ServerSocket to access the incoming requests and process then send the responses to the client
    private final String[] strTmpBuffer = new String[100];
    private final String[] strNodeName = new String[100];
    private static String strConfigName = null;
    private static String time = null;

/*    public static void main(String argv[]) throws Exception {
        new TCPThread();
    }
  */

    public TCPThread() throws Exception {

        time = TimeCollection.getTimeStamp();// it is used to get the time in timestatmp format (day_month_year_hrs_mins_seconds)
        int cnt = 0;
        BufferedReader in;

        in = new BufferedReader(new FileReader("/home/fast/NewMonitor/Perl-Jar/Config.dat")); // get the Config.dat contents into the buffer
        String str;
        while ((str = in.readLine()) != null) {  //this loop is to read the contents from the buffer and store all node names into an array and also configuration details into a variable
            if (str.indexOf("-") > 0) {
                String[] strTmpNode = str.split("-");

                if (strTmpNode[0] != null && !strTmpNode[0].equals(" ") && strTmpNode[1] != null && !strTmpNode[1].equals(" "))
                {
                    if (!strTmpNode[0].equals("Partitions") && !strTmpNode[0].equals("Indexers")) {
                        strNodeName[cnt] = strTmpNode[0];
                        cnt++;
                    }
                }
            } else {
                strConfigName = str;
            }
        }
        in.close(); //this is to close the buffer


        cnt = 0;
        in = new BufferedReader(new FileReader("WatchedProcesses.dat")); // this will read the contents of the WatchedProcesses.dat into buffer
        while ((str = in.readLine()) != null) {
            strTmpBuffer[cnt] = str; //store the all processes that are existed in the WatchedProcesses.dat file into a sring array
            cnt++;
        }
        in.close();  // then close that buffer

        BufferedWriter out = new BufferedWriter(new FileWriter(strConfigName + "_CPUStats_" + time + ".csv", true));// this is to create a file with .csv extension format is c3t1_CPUStats_01032006_101223.csv 
        String header = "";
        for (String bstrNodeName : strNodeName) {// this is to create a header for the above file by using all nodes and all processes for each node for Cputime and Cpuelapsed time
            if (bstrNodeName != null) {
                header = header.concat("Time_" + bstrNodeName + ",");
                for (String aStrTmpBuffer : strTmpBuffer) { // in a node for each process it will create the header of the following format format Time_dell1.klfast.com,CPUTime_contentdistributor_dell1.klfast.com,CPUElapsedTime_Contentdistributor_dell1.klfast.com
                    if (aStrTmpBuffer != null) {
                        String strTmp = "CPUTime_" + aStrTmpBuffer + "_" + bstrNodeName + ",CPUElapsedTime_" + aStrTmpBuffer + "_" + bstrNodeName + ",";;
                        // strTmp = "CPUTime_" + aStrTmpBuffer + "_" + bstrNodeName + ",";
                        header = header.concat(strTmp);
                    }
                }
            }
        }
        // System.out.println("Header : "+header);
        out.write(header);
        out.write("\n");
        out.close();

        out = new BufferedWriter(new FileWriter(strConfigName + "_MemoryStats_" + time + ".csv", true));  // this is to create a csv file for Memory statistics
        header = "";
        for (String bstrNodeName : strNodeName) { //this is to create a header for the above file by using all nodes and all processes for each node for Virtual Memroy and working set memory

            if (bstrNodeName != null) {
                header = header.concat("Time_" + bstrNodeName + ",");
                for (String aStrTmpBuffer : strTmpBuffer) { //in a node for each process it will create the header of the following format format Time_dell1.klfast.com,virtualMemory_contentdistributor_dell1.klfast.com,WorkingsetMemroy_Contentdistributor_dell1.klfast.com
                    if (aStrTmpBuffer != null) {
                        String strTmp = "VirtMemory_" + aStrTmpBuffer + "_" + bstrNodeName + ",WorkingSetMemory_" + aStrTmpBuffer + "_" + bstrNodeName + ",";
                        header = header.concat(strTmp);
                    }
                }
            }
        }
        // System.out.println("Header : "+header);
        out.write(header);
        out.write("\n");
        out.close();

        out = new BufferedWriter(new FileWriter(strConfigName + "_FileCounter_" + time + ".csv", true));//this is to create a csv file for FileCounter statistics
        header = "";
        for (String bstrNodeName : strNodeName) { //this is to create a header for the above file by using all nodes  for filecount( O,F,I) and Diskusage(O,F,I)
            if (bstrNodeName != null) {
                header = header.concat("Time_" + bstrNodeName);
                String strTmp = ",FilesI_" + bstrNodeName + ",BytesI_" + bstrNodeName + ",FilesF_" + bstrNodeName + ",BytesF_" + bstrNodeName + ",FilesO_" + bstrNodeName + ",BytesO_" + bstrNodeName + ",Files_" + bstrNodeName + ",Bytes_" + bstrNodeName + ",";
                header = header.concat(strTmp);
            }
        }
        out.write(header);
        out.write("\n");
        out.close();

        out = new BufferedWriter(new FileWriter(strConfigName + "_CPUUsage_" + time + ".csv", true));//this is to create a csv file for CPUusage and LoadAvarage statistics
        header = "";
        //System.out.println("Header : "+header);
        for (String bstrNodeName : strNodeName) { //this is to create a header for the above file by using all nodes  for LoadAvg and CPUUsage values
            if (bstrNodeName != null) {
                header = header.concat("Time_" + bstrNodeName);
                String strTmp = ",LoadAverage_" + bstrNodeName + ",CPUUsage_" + bstrNodeName + "%,";
                header = header.concat(strTmp);
            }
        }
        out.write(header);
        out.write("\n");
        out.close();

        dateServer = new ServerSocket(8889); // it will open a port and waiting for the connections
        System.out.println("Server listening on port 8889.");
        this.start();
    }

    public void run() {

        while (true) {
            try {
                System.out.println("Waiting for connections.");
                Socket client = dateServer.accept();
                System.out.println("Accepted a connection from: " +
                        client.getInetAddress());
                new ConnectThread(client, time);// this is to connect to the clients

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

final class ConnectThread extends Thread {
    private Socket client = null;
    private PrintWriter ois = null;
    private BufferedReader oos = null;
    private static final String[] strNodeName = new String[100];
    private static final String strTmpFile = "/home/fast/NewMonitor/Perl-Jar/tmp/";
    private static int config = 0;
    private static String strConfigName = null;
    private static String time = null;

    static {
        strConfigName = null;
    }

    public ConnectThread() {
    }

    public ConnectThread(Socket clientSocket, String time) {
        client = clientSocket;
        try {
            ois = new PrintWriter(client.getOutputStream(), true);
            oos = new BufferedReader(
                    new InputStreamReader(client.getInputStream()));

            int cnt = 0;
            String str;

            BufferedReader in = new BufferedReader(new FileReader("/home/fast/NewMonitor/Perl-Jar/Config.dat")); // it will read the content of the Config.dat file and stored it into a buffer

            while ((str = in.readLine()) != null) { // this is to store the machine names that are involved in the test into an array and configuration type into a variable
                if (str.indexOf("-") > 0) {
                    String[] strTmpNode = str.split("-");
                    if (strTmpNode[0] != null && !strTmpNode[0].equals(" ") && strTmpNode[1] != null && !strTmpNode[1].equals(" "))
                    {
                        if (!strTmpNode[0].equals("Partitions") && !strTmpNode[0].equals("Indexers")) {
                            strNodeName[cnt] = strTmpNode[0];
                            cnt++;
                        }
                    }
                } else {
                    strConfigName = str;
                }
            }
            in.close();

            this.config = cnt;
            this.time = time;

        } catch (Exception e1) {
            e1.printStackTrace();
            try {
                client.close();
            } catch (Exception e) {
                System.out.println(e.getMessage());
                e.printStackTrace();
            }
            return;
        }

        this.start(); // this is to start the thread
    }


    private static void WriteFileToDisk(String destFile, String strFilesContents, boolean bAppend) {
        BufferedWriter out = null;

        try {
            out = new BufferedWriter(new FileWriter(destFile, bAppend));
            out.write(strFilesContents);
        } catch (IOException e) {
            String strTemp = "!!!!!Sorry. Failed to write: " + destFile + "\n Because: " + e.getMessage();
            e.printStackTrace();
            System.out.println(strTemp);
        }
        finally {
            try {
                assert out != null;
                out.close();
            }
            catch (Exception e1) {
                String strTemp = "!!!!!Sorry. Failed to close file: " + destFile + "\n Because: " + e1.getMessage();
                e1.printStackTrace();
                System.out.println(strTemp);
            }
        }

    }


    private static String ReadFileFromDisk(String strFileToRead) {
        StringBuffer strTmpBuffer = new StringBuffer();
        try {
            BufferedReader in = new BufferedReader(new FileReader(strFileToRead));
            String str;
            while ((str = in.readLine()) != null) {
                strTmpBuffer.append(str);
                strTmpBuffer.append("\n");
            }
            in.close();
        } catch (Exception e) {
//            System.out.println("!!!!!!!Sorry. Failed to read: " + strFileToRead + "\n Because: " + e.getMessage());
//            e.printStackTrace();
        }
        return strTmpBuffer.toString().trim();
    }

    public void run() {

        try {
            String inputLine;
            String output[];

            while ((inputLine = oos.readLine()) != null) { // returns null when connection closed it will read input from the client and stored it into a sting array
                if (!inputLine.equals("\n") && !inputLine.equals("")) { // 
                    //  System.out.println("Received: " + inputLine);
                    output = inputLine.split(",");
                    generateCSVFiles(output);  // this is to generate the output CSV file

                }
            }
            ois.close();
            oos.close();
            client.close();

        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void generateCSVFiles(String[] output) { // this is to create the CSV files for data from the all client machine for Memorystats, CPUStats, Filecounter values and CPUUsage values into disk in the form of temporary file

        try {
            String[] strCPUContents = new String[config];
            String[] strMemoryContents = new String[config];
            String[] strFileCContents = new String[config];
            String[] strCPUUContents = new String[config];
            int total;
            String fileOutput;

            for (int i = 0; i < config; i++) {
                if (output[0] != null && !output[0].equals(" ") && output[1] != null && !output[1].equals(" ") && strNodeName[i] != null && !strNodeName[i].equals(" "))
                {
                    if (output[0].equals("CPUStats") && output[1].equals(strNodeName[i])) {
                        strCPUContents[i] = "";
                        //  System.out.println("Got CPUStats from " + strNodeName[i] + "\n");
                        for (int j = 2; j < output.length; j++) {
                            String strTmp = output[j] + ",";
                            strCPUContents[i] = strCPUContents[i].concat(strTmp);
                        }
                        WriteFileToDisk(new StringBuilder().append(strTmpFile).append("CPUStats_").append(strNodeName[i]).append(".tmp").toString(), strCPUContents[i] + "\n", false);
                    }
                    if (output[0].equals("MemoryStats") && output[1].equals(strNodeName[i])) {
                        strMemoryContents[i] = "";
                        //  System.out.println("Got MemoryStats from " + strNodeName[i] + "\n");
                        for (int j = 2; j < output.length; j++) {
                            String strTmp = output[j] + ",";
                            strMemoryContents[i] = strMemoryContents[i].concat(strTmp);
                        }
                        WriteFileToDisk(new StringBuilder().append(strTmpFile).append("MemoryStats_").append(strNodeName[i]).append(".tmp").toString(), strMemoryContents[i] + "\n", false);
                    }
                    if (output[0].equals("FileCounter") && output[1].equals(strNodeName[i])) {
                        strFileCContents[i] = "";
                        //  System.out.println("Got FileCounter from " + strNodeName[i] + "\n");
                        for (int j = 2; j < output.length; j++) {
                            String strTmp = output[j] + ",";
                            strFileCContents[i] = strFileCContents[i].concat(strTmp);
                        }
                        WriteFileToDisk(new StringBuilder().append(strTmpFile).append("FileCounter_").append(strNodeName[i]).append(".tmp").toString(), strFileCContents[i] + "\n", false);
                    }
                    if (output[0].equals("CPUUsage") && output[1].equals(strNodeName[i])) {
                        strCPUUContents[i] = "";
                        //  System.out.println("Got CPUUsage from " + strNodeName[i] + "\n");
                        for (int j = 2; j < output.length; j++) {
                            String strTmp = output[j] + ",";
                            strCPUUContents[i] = strCPUUContents[i].concat(strTmp);
                        }
                        WriteFileToDisk(new StringBuilder().append(strTmpFile).append("CPUUsage_").append(strNodeName[i]).append(".tmp").toString(), strCPUUContents[i] + "\n", false);
                    }
                }
            }

            total = 0;
            fileOutput = "";
            for (int i = 0; i < config; i++) { // this is to concat the CPUStats data from all the machines into a string variable
                boolean exists = (new File(strTmpFile + "CPUStats_" + strNodeName[i] + ".tmp")).exists();
                if (exists) {
                    strCPUContents[i] = ReadFileFromDisk(strTmpFile + "CPUStats_" + strNodeName[i] + ".tmp");
                    fileOutput = fileOutput.concat(strCPUContents[i]);
                    total++;
                }
            }
            if (config == total) { // this is to add the CPUStats data to the CSV file and then immediately delete the temp file from the disk
                WriteFileToDisk(strConfigName + "_CPUStats_" + time + ".csv", new StringBuilder().append(fileOutput).append("\n").toString(), true);
                for (int i = 0; i < config; i++)
                    (new File(strTmpFile + "CPUStats_" + strNodeName[i] + ".tmp")).delete();
            }

            total = 0;
            fileOutput = "";
            for (int i = 0; i < config; i++) { // this is to concat the Memorystats data from all the machines into a string variable
                boolean exists = (new File(strTmpFile + "MemoryStats_" + strNodeName[i] + ".tmp")).exists();
                if (exists) {
                    strMemoryContents[i] = ReadFileFromDisk(strTmpFile + "MemoryStats_" + strNodeName[i] + ".tmp");
                    fileOutput = fileOutput.concat(strMemoryContents[i]);
                    total++;
                }
            }
            if (config == total) { // this is to add the Memorystats data to the CSV file and then immediately delete the temp file from the disk
                WriteFileToDisk(strConfigName + "_MemoryStats_" + time + ".csv", new StringBuilder().append(fileOutput).append("\n").toString(), true);
                for (int i = 0; i < config; i++)
                    (new File(strTmpFile + "MemoryStats_" + strNodeName[i] + ".tmp")).delete();
            }

            total = 0;
            fileOutput = "";
            for (int i = 0; i < config; i++) { // this is to concat the FileCounter data from all the machines into a string variable
                boolean exists = (new File(strTmpFile + "FileCounter_" + strNodeName[i] + ".tmp")).exists();
                if (exists) {
                    strFileCContents[i] = ReadFileFromDisk(strTmpFile + "FileCounter_" + strNodeName[i] + ".tmp");
                    fileOutput = fileOutput.concat(strFileCContents[i]);
                    total++;
                }
            }
            if (config == total) { // this is to add the FileCounter data to the CSV file and then immediately delete the temp file from the disk
                WriteFileToDisk(strConfigName + "_FileCounter_" + time + ".csv", new StringBuilder().append(fileOutput).append("\n").toString(), true);
                for (int i = 0; i < config; i++)
                    (new File(strTmpFile + "FileCounter_" + strNodeName[i] + ".tmp")).delete();
            }

            total = 0;
            fileOutput = "";
            for (int i = 0; i < config; i++) { // this is to concat the CPUUsage data from all the machines into a string variable
                boolean exists = (new File(strTmpFile + "CPUUsage_" + strNodeName[i] + ".tmp")).exists();
                if (exists) {
                    strCPUUContents[i] = ReadFileFromDisk(strTmpFile + "CPUUsage_" + strNodeName[i] + ".tmp");
                    fileOutput = fileOutput.concat(strCPUUContents[i]);
                    total++;
                }
            }
            if (config == total) { // this is to add the CPUUsage data to the CSV file and then immediately delete the temp file from the disk
                WriteFileToDisk(strConfigName + "_CPUUsage_" + time + ".csv", new StringBuilder().append(fileOutput).append("\n").toString(), true);
                for (int i = 0; i < config; i++)
                    (new File(strTmpFile + "CPUUsage_" + strNodeName[i] + ".tmp")).delete();
            }

        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

}



