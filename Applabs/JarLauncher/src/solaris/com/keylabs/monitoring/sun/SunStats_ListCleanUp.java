// Decompiled by DJ v3.8.8.85 Copyright 2005 Atanas Neshkov  Date: 1/23/2006 4:52:43 PM
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   SunStats_ListCleanUp.java

package com.keylabs.monitoring.sun;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Iterator;

import com.keylabs.monitoring.TimeCollection;
// Referenced classes of package com.keylabs:
//            TimeCollection

final class SunStats_ListCleanUp  //This function checks for the redundancy of the processes and then if they exist it adds up the values of the two instances and then eliminates the duplicates
{

    public SunStats_ListCleanUp()
    {
    }

    public final String[] listCleanUp(ArrayList arIncomingList)
    {
        ArrayList arCompleteList = new ArrayList(storeNewValues_ReturnCompleteList(arIncomingList));
        String strOriginalList[] = (String[])arCompleteList.toArray(new String[0]);
        int nNewListIndex = 0;
        int nIndexOfDuplicate = -1;
        String strNewList[] = new String[strOriginalList.length];
        for (String aStrOriginalList : strOriginalList) {
            if (strNewList[0] != null)
                nIndexOfDuplicate = isThisProcessAlreadyInThere(strNewList, aStrOriginalList, nNewListIndex);
            if (nIndexOfDuplicate > -1)
                strNewList = combineProcessValues(aStrOriginalList, strNewList, nIndexOfDuplicate);
            else
                strNewList[nNewListIndex++] = aStrOriginalList;
        }

        return strNewList;
    }

    private ArrayList storeNewValues_ReturnCompleteList(ArrayList alNewIncomingPSList)
    {
        ArrayList alNewList = new ArrayList();
        String strValue;
        String strKey;
        for(Iterator it = alNewIncomingPSList.iterator(); it.hasNext(); mProcessList.put(strKey, strValue))
        {
            strValue = it.next().toString().trim();
            strKey = createKey(strValue);
            if(mProcessList.containsKey(strKey))
                mProcessList.remove(strKey);
        }

        for(Iterator it = mProcessList.values().iterator(); it.hasNext(); alNewList.add(it.next().toString().trim()));
        return alNewList;
    }

    private static String createKey(String strValues)
    {
        String strProcess = strValues.substring(strValues.indexOf("Process=") + 8, strValues.indexOf("PID=")).trim();
        String strPID = strValues.substring(strValues.indexOf("PID=") + 4, strValues.indexOf("CPUTime=")).trim();
        return strProcess + strPID;
    }

    private static String[] combineProcessValues(String strOriginalList, String strNewList[], int nIndex)
    {
        String strFirstValue = strOriginalList.substring(strOriginalList.indexOf("CPUTime=") + 8, strOriginalList.indexOf("VirtMem")).trim();
        String strSecondValue = strNewList[nIndex].substring(strNewList[nIndex].indexOf("CPUTime=") + 8, strNewList[nIndex].indexOf("VirtMem")).trim();
        String strNewValue = TimeCollection.addTime(strFirstValue, strSecondValue);
        strNewList[nIndex] = strNewList[nIndex].replaceFirst("CPUTime=" + strSecondValue, "CPUTime=" + strNewValue);
        strFirstValue = strOriginalList.substring(strOriginalList.indexOf("VirtMem=") + 8, strOriginalList.indexOf("WorkingSet")).trim();
        strSecondValue = strNewList[nIndex].substring(strNewList[nIndex].indexOf("VirtMem=") + 8, strNewList[nIndex].indexOf("WorkingSet")).trim();
        strNewValue = String.valueOf(Long.parseLong(strFirstValue) + Long.parseLong(strSecondValue)).trim();
        strNewList[nIndex] = strNewList[nIndex].replaceFirst("VirtMem=" + strSecondValue, "VirtMem=" + strNewValue);
        strFirstValue = strOriginalList.substring(strOriginalList.indexOf("WorkingSet=") + 11, strOriginalList.indexOf("endMark")).trim();
        strSecondValue = strNewList[nIndex].substring(strNewList[nIndex].indexOf("WorkingSet=") + 11, strNewList[nIndex].indexOf("endMark")).trim();
        strNewValue = String.valueOf(Long.parseLong(strFirstValue) + Long.parseLong(strSecondValue)).trim();
        strNewList[nIndex] = strNewList[nIndex].replaceFirst("WorkingSet=" + strSecondValue, "WorkingSet=" + strNewValue);
        return strNewList;
    }

    private static int isThisProcessAlreadyInThere(String strNewPSList[], String strOrgLst, int nNewListIndex)
    {
        int nIndex = -1;
        String strProcToFind = strOrgLst.substring(strOrgLst.indexOf("Process="), strOrgLst.indexOf("PID="));
        for(int i = 0; i < nNewListIndex; i++)
            if(strNewPSList[i].indexOf(strProcToFind) > -1)
            {
                nIndex = i;
                return nIndex;
            }

        return nIndex;
    }

    private static final Map mProcessList = new HashMap();

}