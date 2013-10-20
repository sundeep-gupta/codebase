/*
 * Created on May 13, 2005
 */
package com.keylabs.monitoring.filecounter;

import java.io.File;

import com.keylabs.monitoring.Logger;
import com.keylabs.monitoring.FileIO;

final class GetFileCountAndDirectorySize {
    private static long lOFileCtr ;
    private static long lOFileSize ;

    private static long lFFileCtr ;
    private static long lFFileSize ;

    private static long lIFileCtr ;
    private static long lIFileSize ;


    public static void runFileCounting(File dir) {
        lOFileCtr = 0;
        lOFileSize = 0;
        lFFileCtr = 0;
        lFFileSize = 0;
        lIFileCtr = 0;
        lIFileSize = 0;
        recurseDirectory(dir);
    }

    /*
      * Visit all files and count stuff
      */
    private static void recurseDirectory(File dir) { // it will check wether the given file is single directory or it contain child directories if it contain child directories then it recursively call the same function utill it will get the single directory
        int i = 0;
        String[] children = null;
        try {
            // System.out.println(dir.getAbsolutePath());

            if (dir.isDirectory()) {
                children = dir.list();
                //  int j = (1/0);
                for (i = 0; i < children.length; i++) {
                    // System.out.println("Child "+i+" : "+children[i]);

                    if (children[i] == null) {
                        Logger.LogError("Failed in visitAllFiles: Breaking from Loop" + children[i]);
                        System.out.println("visitAllFiles: Got a null pointer?" + children[i]);
                        break;
                    }
                    recurseDirectory(new File(dir, children[i])); // this is to recursively check the directory
                }
            } else {
                countFilesAndFileSize(dir); // this is to if it is single directory then calculate the file count and and size of the directory
            }
        } catch (RuntimeException re) {
            System.out.println("visitAllFiles: Got a null pointer exception? : ");
            FileIO.writeStringToFile("Filecount.txt", "Path : " + dir.getAbsolutePath() + "\n", true);
            FileIO.writeStringToFile("Filecount.txt", "Child " + i + " : " + children[i] + "\n", true);
            Logger.LogError("Failed in visitAllFiles" + re.getMessage());
        }
        catch (Exception e) {
            System.out.println("Exception : ");
            FileIO.writeStringToFile("Filecount.txt", "Path : " + dir.getAbsolutePath() + "\n", true);
            FileIO.writeStringToFile("Filecount.txt", "Child " + i + " : " + children[i] + "\n", true);
            Logger.LogError("Failed in visitAllFiles" + e.getMessage());
        }
    }

    /*
      * Process the counts from visited files
      * @param dir
      */
    private static void countFilesAndFileSize(File dir) {  
        String f = dir.getAbsolutePath();
        if (f.indexOf("data_fixml") > 0) { // it will calculate the filecount-F and directory size-F of the data_fixml 
            lFFileCtr++;
            lFFileSize += dir.length();
        } else if (f.indexOf("data_index") > 0) { // it will calculate the filecount-I and directory size-I of the data_index 
            lIFileCtr++;
            lIFileSize += dir.length();
        } else {  // it will calculate the filecount-O and directory size-O of the /fast/datasearch 
            lOFileCtr++;
            lOFileSize += dir.length();
        }
    }
}



