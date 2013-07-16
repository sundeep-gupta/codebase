/*
 * Created on May 12, 2005
 * Chance Williams
 */
package com.keylabs.monitoring;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;


public final class FileIO {


    public static String ReadFileFromDisk(String strFileToRead) {
        StringBuffer strTmpBuffer = new StringBuffer();
        try {
            BufferedReader in = new BufferedReader(new FileReader(strFileToRead));
            String str;
            while ((str = in.readLine()) != null) {
                strTmpBuffer.append(str);
                strTmpBuffer.append("\n");
            }
            in.close();
        } catch (IOException e) {
            System.out.println("!!!!!!!Sorry. Failed to read: " + strFileToRead + "\n Because: " + e.getMessage());
            e.printStackTrace();
            Logger.LogError(strFileToRead);
        }
        return strTmpBuffer.toString().trim();
    }

    public static String ReadLastLineOfFileFromDisk(String strFileToRead) {
        String strTmp = "";
        try {
            BufferedReader in = new BufferedReader(new FileReader(strFileToRead));
            String str;
            while ((str = in.readLine()) != null) {
                strTmp = str + "\n";
            }
            in.close();
        } catch (IOException e) {
            System.out.println("!!!!!!!Sorry. Failed to read: " + strFileToRead + "\n Because: " + e.getMessage());
            e.printStackTrace();
            Logger.LogError(strFileToRead);
        }
        return strTmp;
    }

    public static Set ReadFileFromDiskReturnSet(String strFileToRead) {
        Set set = new HashSet();
        try {
            BufferedReader in = new BufferedReader(new FileReader(strFileToRead));
            String str;
            while ((str = in.readLine()) != null) set.add(str);
            in.close();
        } catch (IOException e) {
            System.out.println("!!!!!!!Sorry. Failed to read: " + strFileToRead + "\n Because: " + e.getMessage());
            e.printStackTrace();
            Logger.LogError(strFileToRead);
        }
        return set;
    }


    public static ArrayList ReadFileFromDiskReturnArrayList(String strFileToRead) {
        ArrayList arList = new ArrayList();
        try {
            BufferedReader in = new BufferedReader(new FileReader(strFileToRead));
            String str;
            while ((str = in.readLine()) != null) {
                arList.add(str);
            }
            in.close();
        } catch (IOException e) {
            System.out.println("!!!!!!!Sorry. Failed to read: " + strFileToRead + "\n Because: " + e.getMessage());
            e.printStackTrace();
            Logger.LogError(strFileToRead);
        }
        return arList;
    }


    public static boolean writeStringToFile(String destFile, String strFilesContents, boolean bAppend) {
        boolean bSuccess;
        if (destFile.startsWith("ftp:")) {
            bSuccess = writeFileToServer(destFile, strFilesContents);
        } else {
            bSuccess = WriteFileToDisk(destFile, strFilesContents, bAppend);
        }
        return bSuccess;

    }

    /*
      * WriteFileToDisk()
      */
    private static boolean WriteFileToDisk(String destFile, String strFilesContents, boolean bAppend) {
        BufferedWriter out = null;

        try {
            out = new BufferedWriter(new FileWriter(destFile, bAppend));
            out.write(strFilesContents);
        } catch (IOException e) {
            String strTemp = "!!!!!Sorry. Failed to write: " + destFile + "\n Because: " + e.getMessage();
            e.printStackTrace();
            System.out.println(strTemp);
            Logger.LogError(strTemp);
            return false;
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
                Logger.LogError(strTemp);
                return false;
            }
        }
        return true;
    }

    /*
      * 		Get a file from an IP Address
      *
      */
    private static boolean writeFileToServer(String strIPAddress, String strFileContents) {
        //  "ftp://user:pwd@10.0.4.15/<machName>BridgeWater.txt;type=a"

        URL url;
        OutputStream out = null;
        try {
            url = new URL(strIPAddress + ";type=i");
            URLConnection urlc = url.openConnection();
            out = urlc.getOutputStream(); // To upload
            out.write(strFileContents.getBytes());
            out.flush();
        } catch (MalformedURLException e) {
            String strTemp = "!!!!!Sorry. Failed on file: " + strIPAddress + "\n Because: " + e.getMessage();
            e.printStackTrace();
            System.out.println(strTemp);
            Logger.LogError(strTemp);
            return false;
        } catch (IOException e) {
            String strTemp = "!!!!!Sorry. Failed on file: " + strIPAddress + "\n Because: " + e.getMessage();
            e.printStackTrace();
            System.out.println(strTemp);
            Logger.LogError(strTemp);
            return false;
        }
        finally {
            try {
                assert out != null;
                out.close();
            }
            catch (Exception e1) {
                String strTemp = "!!!!!Sorry. Failed to close file: " + strIPAddress + "\n Because: " + e1.getMessage();
                e1.printStackTrace();
                System.out.println(strTemp);
                Logger.LogError(strTemp);
                return false;
            }
        }
        return true;

    }

}
