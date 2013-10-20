/*
 * Created on May 17, 2005
 * Author: Chance Williams
 */
package com.keylabs.monitoring;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;

final class StreamGobbler extends Thread {
    private final InputStream is;
    private final String type;
    static final StringBuffer sbExecResults = new StringBuffer("");
    static final ArrayList arExecResults = new ArrayList();

    StreamGobbler(InputStream is, String type) {
        this.is = is;
        this.type = type;
    }

    public void run() {
        try {
            InputStreamReader isr = new InputStreamReader(is);
            BufferedReader br = new BufferedReader(isr);
            String line;
            while ((line = br.readLine()) != null) {
                System.out.println(type + " > " + line);
                arExecResults.add(line);
            }
        } catch (IOException ioe) {
            ioe.printStackTrace();
        }
    }
}
/*
 * 
 * @author Chance Williams
 *
 */

public final class ExternalProgramExecutor {

    private static String[] createCommandLine(String platform, String strCommand) {
        String[] strCmdLine;
//        System.out.println("OS Name : "+ platform+"\n");
//        System.out.println("Command e : "+ strCommand+"\n");
        if (platform.equals("Unix SunOS") && !strCommand.startsWith("prstat")) {
            strCmdLine = new String[]{"perl", strCommand};// taken: "sh", "-c", //this   -"./" +   -was in front of  strCommand
        } else if (platform.startsWith("Unix")) {
            strCmdLine = new String[]{"sh", "-c", strCommand};// taken: "sh", "-c", //this   -"./" +   -was in front of  strCommand
        } else if (platform.startsWith("Windows 1")) {
            strCmdLine = new String[]{"command.exe", "/c", strCommand};
        } else if (platform.startsWith("Windows 2")) {
            strCmdLine = new String[]{"cmd.exe", "/c", strCommand};
        } else strCmdLine = null;
        return strCmdLine;
    }

    public static ArrayList executeProgram(String strProgram, String strOutputFile, boolean bReturnOutput) {
        ArrayList arResults = new ArrayList();
        String[] cmd = null;
        try {
            String strPlatform = GenericUtilities.findPlatform();
            String strCommand;

            if (strPlatform.startsWith("Linux")) {
                strCommand = strProgram;

            } else {
                if (bReturnOutput) {
                    strCommand = strProgram;
                } else {
                    strCommand = strProgram + " > " + strOutputFile;

                }
            }

            cmd = createCommandLine(strPlatform, strCommand);

            Runtime rt = Runtime.getRuntime();
            Process proc = rt.exec(cmd);
            // any error message?
            StreamGobbler errorGobbler = new
                    StreamGobbler(proc.getErrorStream(), "ERROR");

            // any output?
            StreamGobbler outputGobbler = new
                    StreamGobbler(proc.getInputStream(), "OUTPUT");

            // kick them off
            errorGobbler.start();
            outputGobbler.start();

            // any error???
            int exitVal = proc.waitFor();
            arResults = StreamGobbler.arExecResults;
            System.out.println("ExitValue: " + exitVal);

            return arResults;
        } catch (Throwable t) {
            System.out.println("GoodWinExec has died!!!!!!!!!!!!!!!!!!!!! ");
            assert cmd != null;
            for (String aCmd : cmd) {
                System.out.print(aCmd + " ");
                FileIO.writeStringToFile("Executeprgm.txt", "Command : " + aCmd + "\n", true);
            }
            t.printStackTrace();
            FileIO.writeStringToFile("AbendFile.txt", "Gave up at: " + System.currentTimeMillis(), true);
            return arResults;
        }


    }

}
// Form a command line for running a given command under a suitable shell.
// Running under a shell allows familiar command-line facilities such as
// quoting, and the command itself can be a shell script or a shell
// built-in.  Not all the Windows versions have been tested.
