/*
 * Created on May 23, 2005
 * @author Chance Williams
 */
package com.keylabs.monitoring.memory;

import java.util.ArrayList;

final class MemStats_ListCleanUp {

    public static String[] combineDuplicateEntries(ArrayList arIncomingList) {
        //	NodeName=Dell4  Process=  VirtMem=  WorkingSet=
        String[] strOriginalList = (String[]) arIncomingList.toArray(new String[0]);
        int nNewListIndex = 0;
        int nIndexOfDuplicate = -1;
        String[] strNewList = new String[strOriginalList.length];
        for (String aStrOriginalList : strOriginalList) {
            if (strNewList[0] != null)//if no values in new list, don't check it
                nIndexOfDuplicate = isThisProcessAlreadyInThere(strNewList, aStrOriginalList, nNewListIndex);
            if (nIndexOfDuplicate > -1) {//if duplicate, add values
                strNewList = combineProcessValues(aStrOriginalList, strNewList, nIndexOfDuplicate);
            }

            else {
                strNewList[nNewListIndex++] = aStrOriginalList;//no duplicate, just transfer
            }
        }
        return strNewList;

    }


    private static String[] combineProcessValues(String strOriginalList, String[] strNewList, int nIndex) {
        // get values from both strings
        // NodeName=Dell4  Process=  VirtMem=  WorkingSet=
        // NodeName=Dell1 Process=services Read=125617 Other=138963

        String strFirstValue = strOriginalList.substring(
                strOriginalList.indexOf("VirtMem=") + 8, strOriginalList.indexOf("WorkingSet")).trim();
        String strSecondValue = strNewList[nIndex].substring(
                strNewList[nIndex].indexOf("VirtMem=") + 8, strNewList[nIndex].indexOf("WorkingSet")).trim();
        String strNewValue = String.valueOf(Long.parseLong(strFirstValue) + Long.parseLong(strSecondValue));
        strNewList[nIndex] = strNewList[nIndex].replaceFirst("VirtMem=" + strSecondValue, "VirtMem=" + strNewValue + " ");

        strFirstValue = strOriginalList.substring(
                strOriginalList.indexOf("WorkingSet=") + 11, strOriginalList.indexOf("endMark")).trim();
        strSecondValue = strNewList[nIndex].substring(
                strNewList[nIndex].indexOf("WorkingSet=") + 11, strNewList[nIndex].indexOf("endMark")).trim();
        strNewValue = String.valueOf(Long.parseLong(strFirstValue) + Long.parseLong(strSecondValue));
        strNewList[nIndex] = strNewList[nIndex].replaceFirst("WorkingSet=" + strSecondValue, "WorkingSet=" + strNewValue + " ");

        //Return the modified new list
        return strNewList;
    }

    private static int isThisProcessAlreadyInThere(String[] strNewPSList, String strOrgLst, int nNewListIndex) {
        //	NodeName=Dell4  Process=  VirtMem=  WorkingSet=
        int nIndex = -1;
        String strProcToFind = strOrgLst.substring(strOrgLst.indexOf("Process="), strOrgLst.indexOf("VirtMem="));
        for (int i = 0; i < nNewListIndex; i++) {//
            if (strNewPSList[i].indexOf(strProcToFind) > -1) {
                nIndex = i;
                return nIndex;
            }
        }

        return nIndex;
    }
}
