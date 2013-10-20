package com.keylabs.monitoring.tcp;

import java.io.*;
import java.net.*;

import com.keylabs.monitoring.TimeCollection;

public final class TCPThread extends Thread { //This would create the connection via tcp socket

    private final ServerSocket dateServer;
    private final String[] strTmpBuffer = new String[100];
    private final String[] strNodeName = new String[100];
    private static String strConfigName = null;
    private static String time = null;

/*    public static void main(String argv[]) throws Exception {
        new TCPThread();
    }
  */

    public TCPThread() throws Exception {

        time = TimeCollection.getTimeStamp();//This would get the timestamp
        int cnt = 0;
        BufferedReader in;

        in = new BufferedReader(new FileReader("/export/home/fast/NewMonitor/Perl-Jar/Config.dat"));//This reads the config.dat file
        String str;
        while ((str = in.readLine()) != null) {//This loop would continue till the last line
            if (str.indexOf("-") > 0) {
                String[] strTmpNode = str.split("-");//This would store the values of config.dat value in an array

                if (strTmpNode[0] != null && !strTmpNode[0].equals(" ") && strTmpNode[1] != null && !strTmpNode[1].equals(" "))
                {
                    if (!strTmpNode[0].equals("Partitions") && !strTmpNode[0].equals("Indexers")) {
                        strNodeName[cnt] = strTmpNode[0];//This would store the values of the config.dat file except for the information abt number of indexers and number of partitions
                        cnt++;
                    }
                }
            } else {
                strConfigName = str;//The name of the test is being stored here
            }
        }
        in.close();


        cnt = 0;
        in = new BufferedReader(new FileReader("WatchedProcesses.dat"));//This parses the file WatchedProcesses.dat
        while ((str = in.readLine()) != null) {
            strTmpBuffer[cnt] = str;//The values are stored in the strTmoBuffer
            cnt++;
        }
        in.close();

        BufferedWriter out = new BufferedWriter(new FileWriter(strConfigName + "_SunStats_" + time + ".csv", true));//This would create the file SunStats.csv with current time and test name
        String header = "";
        for (String bstrNodeName : strNodeName) {
            if (bstrNodeName != null) {
                header = header.concat("Time_" + bstrNodeName + ",");//This would create a header with values time+nodename
                for (String aStrTmpBuffer : strTmpBuffer) {
                    if (aStrTmpBuffer != null) {
                        String strTmp = "CPUTime_" + aStrTmpBuffer + "_" + bstrNodeName + ",VirtMemory_" + aStrTmpBuffer + "_" + bstrNodeName + ",WorkingSetMemory_" + aStrTmpBuffer + "_" + bstrNodeName + ",";
                        header = header.concat(strTmp); //The headers for CPUTime ,VERT Memory and WorkingSet Memory are being created for all the machines
                    }
                }
            }
        }
        // System.out.println("Header : "+header);
        out.write(header); //The headers are written in the file
        out.write("\n"); //The control is transferred to the next line
        out.close();

        out = new BufferedWriter(new FileWriter(strConfigName + "_FileCounter_" + time + ".csv", true));//This would create the file named FileCounter.csv with current time and Test name
        header = "";
        for (String bstrNodeName : strNodeName) {
            if (bstrNodeName != null) {
                header = header.concat("Time_" + bstrNodeName); //Header is created with time+machine name
                String strTmp = ",FilesI_" + bstrNodeName + ",BytesI_" + bstrNodeName + ",FilesF_" + bstrNodeName + ",BytesF_" + bstrNodeName + ",FilesO_" + bstrNodeName + ",BytesO_" + bstrNodeName + ",Files_" + bstrNodeName + ",Bytes_" + bstrNodeName + ",";
                header = header.concat(strTmp); //The headers for FileCount(I,O,F) and Bytes(I,O,F) are being created for all the machines
            }
        }
        out.write(header);
        out.write("\n");
        out.close();

        out = new BufferedWriter(new FileWriter(strConfigName + "_CPUUsage_" + time + ".csv", true)); //This would create the CPUUsage.csv file
        header = "";
        // System.out.println("Header : "+header);
        for (String bstrNodeName : strNodeName) {
            if (bstrNodeName != null) {
                header = header.concat("Time_" + bstrNodeName);
                String strTmp = ",LoadAverage_" + bstrNodeName + ",CPUUsage_" + bstrNodeName + "%,";
                header = header.concat(strTmp); //The headers for CPUUsage are being created for all the machines
            }
        }
        out.write(header);//The headers are written in the file
        out.write("\n"); //The control is transferred to the next line
        out.close();

        dateServer = new ServerSocket(8889); //This would open the socket port 8889
        System.out.println("Server listening on port 8889.");
        this.start();
    }

    public void run() {

        while (true) {
            try {
                System.out.println("Waiting for connections.");
                Socket client = dateServer.accept();//This would accept the connection from either the CPUUSage,Filecounter,sunstat module
                System.out.println("Accepted a connection from: " +
                        client.getInetAddress());
                new ConnectThread(client, time);//This would establish a connection to the module and then retrieves the data from the module

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
    private static final String strTmpFile = "/export/home/fast/NewMonitor/Perl-Jar/tmp/";
    private static int config = 0;
    private static String strConfigName = null;
    private static String time = null;

    static {
        strConfigName = null;
    }

    public ConnectThread() {
    }

    public ConnectThread(Socket clientSocket, String time) {//This would provoke the thread and write the values
        client = clientSocket;
        try {
            ois = new PrintWriter(client.getOutputStream(), true);//This would write the values from the modules to the server
            oos = new BufferedReader(
                    new InputStreamReader(client.getInputStream()));//This would read the values from the modules

            int cnt = 0;
            String str;

            BufferedReader in = new BufferedReader(new FileReader("/export/home/fast/NewMonitor/Perl-Jar/Config.dat")); //Parses the file config.dat file

            while ((str = in.readLine()) != null) {
                if (str.indexOf("-") > 0) {
                    String[] strTmpNode = str.split("-");
                    if (strTmpNode[0] != null && !strTmpNode[0].equals(" ") && strTmpNode[1] != null && !strTmpNode[1].equals(" "))
                    {
                        if (!strTmpNode[0].equals("Partitions") && !strTmpNode[0].equals("Indexers")) {
                            strNodeName[cnt] = strTmpNode[0];//writes the values of the file config.dat which are not indexers and partitions
                            cnt++;
                        }
                    }
                } else {
                    strConfigName = str;
                }
            }
            in.close();

            this.config = cnt;  //Now config consists of the number of nodes for the particular test
            this.time = time;

        } catch (Exception e1) { //This would catch any exception throwed in the processes and prints the mssg thrown by the exception
            e1.printStackTrace();
            try {
                client.close();
            } catch (Exception e) {
                System.out.println(e.getMessage());
                e.printStackTrace();
            }
            return;
        }

        this.start();
    }


    private static void WriteFileToDisk(String destFile, String strFilesContents, boolean bAppend) { //This function would write to the specified destination file in append mode
        BufferedWriter out = null;

        try {
            out = new BufferedWriter(new FileWriter(destFile, bAppend));
            out.write(strFilesContents);
        } catch (IOException e) { //If there is any exception it is caught here and printed
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


    private static String ReadFileFromDisk(String strFileToRead) {//This would read the temp file and store the contents
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
            System.out.println("!!!!!!!Sorry. Failed to read: " + strFileToRead + "\n Because: " + e.getMessage());
            e.printStackTrace();
        }
        return strTmpBuffer.toString().trim();
    }

    public void run() {

        try {
            String inputLine;
            String output[];

            while ((inputLine = oos.readLine()) != null) { // returns null when connection closed
                if (!inputLine.equals("\n") && !inputLine.equals("")) {
//                    System.out.println("Received: " + inputLine);
                    output = inputLine.split(",");
                    generateCSVFiles(output);//This would write the values from the temp files into the csv file

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

    private static void generateCSVFiles(String[] output) {

        try {
            String[] strCPUContents = new String[config]; //This would store the size of the array (i.e., number of machines)
            String[] strFileCContents = new String[config];
            String[] strCPUUContents = new String[config];
            int total;
            String fileOutput;

            for (int i = 0; i < config; i++) { //This would write the contents of all the counters for all the machines
                if (output[0] != null && !output[0].equals(" ") && output[1] != null && !output[1].equals(" ") && strNodeName[i] != null && !strNodeName[i].equals(" "))
                {
                    if (output[0].equals("SunStats") && output[1].equals(strNodeName[i])) {  //This takes the values from the module SunStats and write them to the temp file and then to the .csv file
                        strCPUContents[i] = "";
  //                      System.out.println("Got SunStats from " + strNodeName[i] + "\n");
                        for (int j = 2; j < output.length; j++) {
                            String strTmp = output[j] + ",";
                            strCPUContents[i] = strCPUContents[i].concat(strTmp);
                        }
                        WriteFileToDisk(new StringBuilder().append(strTmpFile).append("SunStats_").append(strNodeName[i]).append(".tmp").toString(), strCPUContents[i] + "\n", false);
                    }

                    if (output[0].equals("FileCounter") && output[1].equals(strNodeName[i])) {
                        strFileCContents[i] = "";
    //                    System.out.println("Got FileCounter from " + strNodeName[i] + "\n");
                        for (int j = 2; j < output.length; j++) {
                            String strTmp = output[j] + ",";
                            strFileCContents[i] = strFileCContents[i].concat(strTmp);
                        }
                        WriteFileToDisk(new StringBuilder().append(strTmpFile).append("FileCounter_").append(strNodeName[i]).append(".tmp").toString(), strFileCContents[i] + "\n", false);
                    }

                    if (output[0].equals("CPUUsage") && output[1].equals(strNodeName[i])) {
                        strCPUUContents[i] = "";
      //                  System.out.println("Got CPUUsage from " + strNodeName[i] + "\n");
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
            for (int i = 0; i < config; i++) {
                boolean exists = (new File(strTmpFile + "SunStats_" + strNodeName[i] + ".tmp")).exists();
                if (exists) {
                    strCPUContents[i] = ReadFileFromDisk(strTmpFile + "SunStats_" + strNodeName[i] + ".tmp");
                    fileOutput = fileOutput.concat(strCPUContents[i]);
                    total++;
                }
            }
            if (config == total) {
                WriteFileToDisk(strConfigName + "_SunStats_" + time + ".csv", new StringBuilder().append(fileOutput).append("\n").toString(), true);
                for (int i = 0; i < config; i++)
                    (new File(strTmpFile + "SunStats_" + strNodeName[i] + ".tmp")).delete();
            }

            total = 0;
            fileOutput = "";
            for (int i = 0; i < config; i++) {
                boolean exists = (new File(strTmpFile + "FileCounter_" + strNodeName[i] + ".tmp")).exists();
                if (exists) {
                    strFileCContents[i] = ReadFileFromDisk(strTmpFile + "FileCounter_" + strNodeName[i] + ".tmp");
                    fileOutput = fileOutput.concat(strFileCContents[i]);
                    total++;
                }
            }
            if (config == total) {
                WriteFileToDisk(strConfigName + "_FileCounter_" + time + ".csv", new StringBuilder().append(fileOutput).append("\n").toString(), true);
                for (int i = 0; i < config; i++)
                    (new File(strTmpFile + "FileCounter_" + strNodeName[i] + ".tmp")).delete();
            }

            total = 0;
            fileOutput = "";
            for (int i = 0; i < config; i++) {
                boolean exists = (new File(strTmpFile + "CPUUsage_" + strNodeName[i] + ".tmp")).exists();
                if (exists) {
                    strCPUUContents[i] = ReadFileFromDisk(strTmpFile + "CPUUsage_" + strNodeName[i] + ".tmp");
                    fileOutput = fileOutput.concat(strCPUUContents[i]);
                    total++;
                }
            }
            if (config == total) {
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



