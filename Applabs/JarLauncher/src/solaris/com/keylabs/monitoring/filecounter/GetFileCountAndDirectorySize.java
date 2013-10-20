/*
 * Created on May 13, 2005
 */
package com.keylabs.monitoring.filecounter;

import java.io.File;     /** We are importing all the inbuilt classes from java api*/

import com.keylabs.monitoring.Logger; /** We are importing the classes from other packages*/
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


    private static void recurseDirectory(File dir) { //this function visits all the files and then counts them
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
                    recurseDirectory(new File(dir, children[i]));
                }
            } else {
                countFilesAndFileSize(dir);
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
        if (f.indexOf("data_fixml") > 0) {//displays the file count(F,O,I) and diskspace(F,O,I)
            lFFileCtr++;
            lFFileSize += dir.length();
        } else if (f.indexOf("data_index") > 0) {
            lIFileCtr++;
            lIFileSize += dir.length();
        } else {
            lOFileCtr++;
            lOFileSize += dir.length();
        }
    }
}



