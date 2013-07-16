/*
 * Created on May 19, 2005
 * @author Chance Williams
 */
package com.keylabs.monitoring;

import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.TimeZone;


public final class TimeCollection {

//	NodeName=dell1 Process=procserver CPUTime=0:00:03.500 CPUElapsedTime=4:12:14.860 
//	NodeName=dell1 Process=procserver CPUTime=0:00:03.671 CPUElapsedTime=4:12:14.860 

    public static String addTime(String strTimeOne, String strTimeTwo) {
        String strTimeTotal;
        float fSecondsOne = breakTimeToSeconds(strTimeOne);
        float fSecondsTwo = breakTimeToSeconds(strTimeTwo);
        float fSecondsTotal = fSecondsOne + fSecondsTwo;
        strTimeTotal = convertSecondsToTimeStampFormat(fSecondsTotal);
        return strTimeTotal;
    }

    public static float breakTimeToSeconds(String strTimeOne) {
//		NodeName=dell1 Process=procserver CPUTime=0:00:03.671 CPUElapsedTime=4:12:14.860 
        String timeOne[] = strTimeOne.split(":");
        float fTime = 0;
        fTime += Float.parseFloat(timeOne[0]) * 3600;
        fTime += Float.parseFloat(timeOne[1]) * 60;
        fTime += Float.parseFloat(timeOne[2]);
        return fTime;
    }


    private static String convertSecondsToTimeStampFormat(float fGivenTime) {
//		NodeName=dell1 Process=procserver CPUTime=0:00:03.671 CPUElapsedTime=4:12:14.860
        float fSeconds = fGivenTime % 60;
        fGivenTime = fGivenTime - fSeconds;
        int nMinutes = (int) (fGivenTime % 3600) / 60;
        fGivenTime = fGivenTime - (nMinutes * 60);
        int nHours = (int) fGivenTime / 3600;
        String strHours = String.valueOf(nHours);
        String strMinutes = String.valueOf(nMinutes);
        strMinutes = addZeros(strMinutes);
        String strSeconds = String.valueOf(fSeconds);
        strSeconds = addZeros(strSeconds);
        String strTime;
        strTime = strHours + ":" + strMinutes + ":" + strSeconds;
        return strTime;
    }

    private static String addZeros(String strTmp) { //3 0 12
        if (strTmp.compareTo("0") == 0) {
            return "00";
        }
        if (Float.parseFloat(strTmp) < 10) {
            strTmp = "0" + strTmp;
            return strTmp;
        }
        return strTmp;
    }

    /*public static String getDateTimeStamp() {
        String strDateTime;
        Date date = new Date();
        Format formatter;

        formatter = new SimpleDateFormat("HH:mm:ss ");
        strDateTime = formatter.format(date);
        // 01:12:53 AM
        formatter = new SimpleDateFormat("dd/MM/yy");
        strDateTime += formatter.format(date);
        return strDateTime;
    }*/

    public static String getDateTimeStamp() {
        String strDateTime;
        String hr;
        String mn;
        String sc;
        String dy;
        String mo;

        Calendar cal = new GregorianCalendar(TimeZone.getTimeZone("GMT-7"));

        // Get the components of the time
 
        int hour24 = cal.get(Calendar.HOUR_OF_DAY);     // 0..23
        int min = cal.get(Calendar.MINUTE);             // 0..59
        int sec = cal.get(Calendar.SECOND);             // 0..59

        int month = cal.get(Calendar.MONTH);
        int year = cal.get(Calendar.YEAR);
        int day = cal.get(Calendar.DAY_OF_MONTH);

        if (hour24 < 10) {
            hr = "0" + hour24;
        } else {
            hr = String.valueOf(hour24);
        }

        if (min < 10) {
            mn = "0" + min;
        } else {
            mn = String.valueOf(min);
        }

        if (sec < 10) {
            sc = "0" + sec;
        } else {
            sc = String.valueOf(sec);
        }

        if (month < 10) {
            mo = "0" + (month + 1);
        } else {
            mo = String.valueOf(month + 1);
        }

        if (day < 10) {
            dy = "0" + day;
        } else {
            dy = String.valueOf(day);
        }


        strDateTime = hr + ":" + mn + ":" + sc + " " + dy + "/" + mo + "/" + year;

        return strDateTime;
    }

    public static String getTimeStamp() {
        String strDateTime;
        String hr;
        String mn;
        String sc;
        String dy;
        String mo;

        Calendar cal = new GregorianCalendar(TimeZone.getTimeZone("GMT-7"));

        // Get the components of the time

        int hour24 = cal.get(Calendar.HOUR_OF_DAY);     // 0..23
        int min = cal.get(Calendar.MINUTE);             // 0..59
        int sec = cal.get(Calendar.SECOND);             // 0..59

        int month = cal.get(Calendar.MONTH);
        int year = cal.get(Calendar.YEAR);
        int day = cal.get(Calendar.DAY_OF_MONTH);

        if (hour24 < 10) {
            hr = "0" + hour24;
        } else {
            hr = String.valueOf(hour24);
        }

        if (min < 10) {
            mn = "0" + min;
        } else {
            mn = String.valueOf(min);
        }

        if (sec < 10) {
            sc = "0" + sec;
        } else {
            sc = String.valueOf(sec);
        }

        if (month < 10) {
            mo = "0" + (month + 1);
        } else {
            mo = String.valueOf(month + 1);
        }

        if (day < 10) {
            dy = "0" + day;
        } else {
            dy = String.valueOf(day);
        }

        // strDateTime = hr + ":" + mn + ":" + sc + " " + dy + "/" + mo + "/" + year;
        strDateTime = dy + mo + year + "_" + hr + mn + sc;

        return strDateTime;
    }

    public static int getSeconds() {
        int sec;
        Calendar cal = new GregorianCalendar(TimeZone.getTimeZone("GMT-7"));
        // 0..59
        sec = cal.get(Calendar.SECOND);
        return sec;
    }

   public static int getMinutes() {
        int min;
        Calendar cal = new GregorianCalendar(TimeZone.getTimeZone("GMT-7"));
        // 0..59
        min = cal.get(Calendar.MINUTE);
        return min;
    }              /**/



}//END OF CLASS
