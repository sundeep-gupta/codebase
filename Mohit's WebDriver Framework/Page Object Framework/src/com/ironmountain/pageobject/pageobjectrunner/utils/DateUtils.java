package com.ironmountain.pageobject.pageobjectrunner.utils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

/**
 * @author Jinesh Devasia
 *
 */
public class DateUtils {

	public static long getCurrentTimeInMillis()
	{
		return System.currentTimeMillis();		
	}
	public static String getCurrentTimeAsString()
	{
		return Long.toString(System.currentTimeMillis());
	}
	
	public static int getCurrentTimeInHMMMSSFormat()
	{
		DateFormat dateFormat = new SimpleDateFormat("HH:MM:SS");
		java.util.Date date = new java.util.Date();
		String time = dateFormat.format(date);	
		time = time.replaceAll(":", "");
		int newTime = Integer.parseInt(time);
		return newTime;
	}
	
	public static int getCurrentHour()
	{
		int time = getCurrentTimeInHMMMSSFormat();
		String hour = Integer.toString(time).substring(0, 2);
		return Integer.parseInt(hour);		
	}
	public static int getCurrentMinute()
	{
		int time = getCurrentTimeInHMMMSSFormat();
		String minute = Integer.toString(time).substring(2, 4);
		return Integer.parseInt(minute);		
	}
	
	public static String getBackupDateFormat(){
		DateFormat dateFormat = new SimpleDateFormat("EEE, M/dd/yy, K:mm aa");
		java.util.Date date = new java.util.Date();
		return dateFormat.format(date);	
	}
	public static String getaccountManagementBackupDateFormat(String date){
		Date newDate = null;
		//Correcting the UI Date time format to 12 HR.
		DateFormat uiDateFormat = new SimpleDateFormat("EEE, M/d/yy, h:mm aa");
		//DateFormat uiDateFormat = new SimpleDateFormat("EEE, M/d/yy, k:mm aa");
		DateFormat dbDateFormat = new SimpleDateFormat("yyyy-MM-dd k:mm:s");
		try {
			newDate = dbDateFormat.parse(date) ;
			System.out.println("Parsed Date: " + newDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return  uiDateFormat.format(newDate);
	}
	
	public static String getKanawhaWebappBackupDateFormat(String date){
		Date newDate = null;
		DateFormat uiDateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		DateFormat dbDateFormat = new SimpleDateFormat("yyyy-MM-dd k:mm:s");
		try {
			newDate = dbDateFormat.parse(date) ;
			System.out.println("Parsed Date: " + newDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return  uiDateFormat.format(newDate);
	}
	
	public static String getUTCDateFromTDateStringInGMT( String TDate )
	{
		/*DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
		dateFormat.setTimeZone(TimeZone.getTimeZone("GMT"));*/
		long dateTime = Long.parseLong(TDate)*1000;
		String dat = getUTCDateFromTDateLongInGMT(dateTime);
		return dat;
	}
	
	public static String getUTCDateFromTDateLongInGMT( long TDate )
	{
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
		dateFormat.setTimeZone(TimeZone.getTimeZone("GMT"));
		return dateFormat.format(TDate);
	}
	
	public static long getTdateFromUTCDate( String UTCDate )
	{
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setTimeZone(TimeZone.getTimeZone("GMT"));
		Date date = null;
		try {
			date = dateFormat.parse(UTCDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return date.getTime();
	}
	
}
