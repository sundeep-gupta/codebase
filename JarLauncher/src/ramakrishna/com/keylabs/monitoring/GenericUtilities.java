/*
 * Created on Jun 3, 2005
 * @author Chance Williams
 */

package com.keylabs.monitoring;

import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public final class GenericUtilities {

    public static String removeExtraWhiteSpace(String inputStr) {
        String patternStr = "\\s+";
        String replaceStr = " ";
        Pattern pattern = Pattern.compile(patternStr);
        Matcher matcher = pattern.matcher(inputStr);
        return matcher.replaceAll(replaceStr);
    }

    public static String removeParens(String inputStr) {
        String patternStr = "\\(";
        String replaceStr = "";
        Pattern pattern = Pattern.compile(patternStr);
        Matcher matcher = pattern.matcher(inputStr);
        String strTemp = matcher.replaceAll(replaceStr);
        patternStr = "\\)";
        replaceStr = "";
        pattern = Pattern.compile(patternStr);
        matcher = pattern.matcher(strTemp);
        strTemp = matcher.replaceAll(replaceStr);
        return strTemp;

    }

    public static boolean isProcessWeAreWatchingFor(String strProcessName, Set lstProcsToWatchFor) {
        boolean isMatch = false;
        // Iterating over the elements in the set
        for (Object aLstProcsToWatchFor : lstProcsToWatchFor) {
            // Get element
            String strElement = aLstProcsToWatchFor.toString().trim();
            if (strElement.equalsIgnoreCase(strProcessName)) {
                return true;
            }
        }
        return isMatch;
    }

    /*
    *  Find the platform this program is running on.
    */
    public static String findPlatform() {
        String platform = null;
        String[] oses =
                {
                        "SunOS", "Linux",
                        "Windows 95", "Windows 98", "Windows ME",
                        "Windows NT", "Windows 2000", "Windows XP", "Windows 2003"
                };
        String[] platforms =
                {
                        "Unix SunOS", "Linux 1",
                        "Windows 1 95", "Windows 1 98", "Windows 1 ME",
                        "Windows 2 NT", "Windows 2 2000", "Windows 2 XP", "Windows 2 2003"
                };

        String os = System.getProperty("os.name");

        for (int i = 0; i < oses.length; i++) {
            if (os.equals(oses[i])) platform = platforms[i];
        }
        if (platform == null) {
            System.err.println("Unsupported operating system: " + os);
            System.exit(1);
        }
        return platform;
    }

    public static String convertStringArrayToString(String[]strArray) {
        StringBuffer sbTmp = new StringBuffer();
        for (String aStrArray : strArray) {
            if (aStrArray != null)
                sbTmp.append(aStrArray);
            sbTmp.append("\n");
        }
        return sbTmp.toString();
    }

    public static String convertStringArrayToStringCSV(String[]strArray) {
        StringBuffer sbTmp = new StringBuffer();
        for (String aStrArray : strArray) {
            if (aStrArray != null)
                sbTmp.append(aStrArray);
            sbTmp.append(",");
        }
        return sbTmp.toString();
    }

}
