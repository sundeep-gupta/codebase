package com.ironmountain.pageobject.pageobjectrunner.utils;


import java.util.ArrayList;

import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.utils.DateUtils;

/**
 * @author Jinesh Devasia
 *
 */
public class StringUtils {
	
	public static boolean isNull(String string)
	{
		return (string == null);
	}
	public static boolean isEmpty(String string)
	{
		return (string.equalsIgnoreCase(""));
	}
	public static boolean isNullOrEmpty(String string)
	{
		return (isNull(string) || isEmpty(string));
	}	
	
	/**
	 * This method will take a String as parameter which comma separated list of string values
	 * and convert those values in to a list of Strings
	 * 
	 * @param commaSeparatedString
	 * @return
	 */
	public static ArrayList<String> toStringArrayList(String commaSeparatedString)
	{
		commaSeparatedString.trim();
		String[] stringArray = commaSeparatedString.split(",");
		ArrayList<String> list =new ArrayList<String>();
		for (int i = 0; i < stringArray.length; i++) {
			list.add(stringArray[i].trim());
		}
		return list;
	}
	/**
	 * This method will split the string using a custom separator value, this method will be useful if we 
	 * want to use our own separators to split the Strings, where the comma is a normal sub-String
	 * 
	 * @param customSeparatedString
	 * @param separater
	 * @return
	 */
	public static ArrayList<String> toStringArrayList(String customSeparatedString, String separater)
	{
		customSeparatedString.trim();
		String[] stringArray = customSeparatedString.split(separater);
		ArrayList<String> list =new ArrayList<String>();
		for (int i = 0; i < stringArray.length; i++) {
			list.add(stringArray[i].trim());
		}
		return list;
	}
	
	/** Method that creates Name values to be passed as test data
	 * @author pjames
	 * @return
	 */
	public static String createNameVal(){
		int iTime = DateUtils.getCurrentTimeInHMMMSSFormat();
		String currentTime = Integer.toString(iTime);
		//String currentTime = DateUtils.getCurrentTimeAsString();
		String varName = null;
		varName = ("Auto" + currentTime);
		return varName;
	}
	/**
	 * The account number for connected is different in UI and DB, the "-" and the next digit will not be seen in the DB format
	 * This method will convert the UI format Account number to DB format 
	 * 
	 * @param accountNumber
	 * @return
	 */
	public static String getDbFormattedAccountNumber(String accountNumber){
		return accountNumber.replaceAll("-\\d", "");
	}
	public static String getUiFormattedAccountNumber(String accountNumber){
		
		/*
		 * Same algoritham from dev code is used to get the Check Digit
		 */
		int nCheckDigit = 0;
		boolean bEven = false;
		long dwAcctNum = Integer.parseInt(accountNumber);

		while ( dwAcctNum> 0)
		{
			int nDigit = (int) (dwAcctNum %  10);
			dwAcctNum /= 10;
			if (bEven)
				nCheckDigit -= nDigit;
			else
				nCheckDigit += nDigit;

			bEven = !bEven;
		}
		nCheckDigit = (nCheckDigit + 90) % 10;
		
		String accountSub1 = accountNumber.substring(0, 5);
		String accountSub2 = accountNumber.substring(5, 9);
		return accountSub1 + "-" + nCheckDigit + accountSub2 ;		
	}
	
	/** Method to extract all the text after a pattern is matched in the main text. 
	 * @param MainString
	 * @param SubString
	 */
	public static String extractURL(String MainString, String SubString){
		String text = null;
		int mainStringLength = MainString.length();
		System.out.println(mainStringLength);
		int subStringLength = SubString.length();
		System.out.println(subStringLength);
		boolean foundIt = false;
		for (int i = 0; i <= (mainStringLength - subStringLength); i++) {
		   if (MainString.regionMatches(i, SubString, 0, subStringLength)) {
		      foundIt = true;
		      text = MainString.substring(i, mainStringLength);
		      System.out.println(text);
		      break;	
		   }
		}
		if (!foundIt) System.out.println("No match found.");
		return text;
	}
	
	
	/** Method to extract the DC Name from the fully qualified name.
	 * @return returns the DCName
	 */
	public static String extractDCNamefromMachineName(){
		String mn = PropertyPool.getProperty("PrimaryDataCenterRegistryMachineName");
		String[]  DCName = mn.split("\\.");
		return DCName[0];
	}
	
	public static String createStrongPasswordString(){
		int iTime = DateUtils.getCurrentTimeInHMMMSSFormat();
		String currentTime = Integer.toString(iTime);
		String varName = null;
		varName = ("Str0ngP@#9()*^%$!" + currentTime);
		return varName;
	}
	
}
