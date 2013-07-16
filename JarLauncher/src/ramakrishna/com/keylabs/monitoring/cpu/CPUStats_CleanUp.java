/*
 * Created on May 19, 2005
 * @author Chance Williams
 */
package com.keylabs.monitoring.cpu;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.keylabs.monitoring.TimeCollection;

final class CPUStats_CleanUp {
    private static final Map mProcessList = new HashMap();

    public String[] listCleaner(ArrayList alNewIncomingPSList) {// it will cleanup the array list bye deleting the duplicate names after adding the values of those values of the processes
//		NodeName=dell1 Process=procserver PID=123 CPUTime=0:00:03.500 CPUElapsedTime=4:12:14.860 
//		NodeName=dell1 Process=procserver PID=3310 CPUTime=0:00:03.671 CPUElapsedTime=4:12:14.860 
        ArrayList alNewPSList = new ArrayList(storeNewValues_ReturnCompleteList(alNewIncomingPSList)); //it will create array list
        String[] strIncomingPSList = (String[]) alNewPSList.toArray(new String[0]);
        int nNewListIndex = 0;
        int nIndexOfDuplicate = -1;
        String[] strNewPSList = new String[strIncomingPSList.length];
        for (String aStrIncomingPSList : strIncomingPSList) {
            if (strNewPSList[0] != null)//if no values in new list, don't check it
                nIndexOfDuplicate = isProcessAlreadyInList(strNewPSList, aStrIncomingPSList, nNewListIndex);// it will check that the process is already exist or not
            if (nIndexOfDuplicate > -1) {//if duplicate, add values
                strNewPSList = addTimeToExistingProcess(aStrIncomingPSList, strNewPSList, nIndexOfDuplicate);
            }

            else {
                strNewPSList[nNewListIndex++] = aStrIncomingPSList;//no duplicate, just transfer
            }
        }
        return strNewPSList;

    }

    private ArrayList storeNewValues_ReturnCompleteList(ArrayList alNewIncomingPSList) {
//		NodeName=dell1 Process=procserver PID=123 CPUTime=0:00:03.500 CPUElapsedTime=4:12:14.860 
//		NodeName=dell1 Process=procserver PID=3310 CPUTime=0:00:03.671 CPUElapsedTime=4:12:14.860 
        //iterate through the 'al'
        ArrayList alNewList = new ArrayList();
        for (Object anAlNewIncomingPSList : alNewIncomingPSList) {
            String strTemp = anAlNewIncomingPSList.toString();
            String strKey = createKey(strTemp);

            if (mProcessList.containsKey(strKey)) {
                // if 'key' already in Hashmap -  REPLACE (not munge) with new value
                mProcessList.remove(strKey);
            }
            mProcessList.put(strKey, strTemp);
        }
        //return ENTIRE hashmap as 'al' without key
        for (Object o : mProcessList.values()) {
            alNewList.add(o.toString());
        }
        return alNewList;
    }

    private static String createKey(String strTemp) {
//		NodeName=dell1 Process=procserver PID=3310 CPUTime=0:00:03.375 CPUElapsedTime=4:12:14.860 
        String strProcess = strTemp.substring(strTemp.indexOf("Process=") + 8, strTemp.indexOf("PID=")).trim();
        String strPID = strTemp.substring(strTemp.indexOf("PID=") + 4, strTemp.indexOf("CPUTime=")).trim();
        return strProcess + strPID;
    }


    private static String[] addTimeToExistingProcess(String strPSListOrg, String[] strNewPSList, int nIndex) {
        //get times from both strings
//		NodeName=dell1 Process=procserver PID=3310 CPUTime=0:00:03.375 CPUElapsedTime=4:12:14.860 
        String strTimeOne = strPSListOrg.substring(
                strPSListOrg.indexOf("CPUTime=") + 8, strPSListOrg.indexOf("CPUElapsedTime"));
        String strTimeTwo = strNewPSList[nIndex].substring(
                strNewPSList[nIndex].indexOf("CPUTime=") + 8, strNewPSList[nIndex].indexOf("CPUElapsedTime"));

        String strElapsedTimeOne = strPSListOrg.substring(
                strPSListOrg.indexOf("CPUElapsedTime=") + 15, strPSListOrg.indexOf("endMark"));
        String strElapsedTimeTwo = strNewPSList[nIndex].substring(
                strNewPSList[nIndex].indexOf("CPUElapsedTime=") + 15, strNewPSList[nIndex].indexOf("endMark"));

        //used TimeCollection to add them
        String strNewTime = TimeCollection.addTime(strTimeOne, strTimeTwo);
        String strElapsedNewTime = TimeCollection.addTime(strElapsedTimeOne, strElapsedTimeTwo);

        //put new value back in new list
        strNewPSList[nIndex] = strNewPSList[nIndex].replaceFirst(strTimeTwo, strNewTime + " ");
        strNewPSList[nIndex] = strNewPSList[nIndex].replaceFirst(strElapsedTimeTwo, strElapsedNewTime + " ");
        //Return the modified new list
        return strNewPSList;
    }

    private static int isProcessAlreadyInList(String[] strNewPSList, String strOrgLst, int nNewListIndex) {
//		NodeName=dell1 Process=procserver PID=3310 CPUTime=0:00:03.375 CPUElapsedTime=4:12:14.860 
        int nIndex = -1;
        String strProcToFind = strOrgLst.substring(strOrgLst.indexOf("Process="), strOrgLst.indexOf("PID="));
        for (int i = 0; i < nNewListIndex; i++) {//
            if (strNewPSList[i].indexOf(strProcToFind) > -1) {
                nIndex = i;
                return nIndex;
            }
        }

        return nIndex;
    }
}
