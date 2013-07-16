package com.ironmountain.pageobject.pageobjectrunner.utils;

import java.util.List;

/**
 * @author Jinesh Devasia
 *
 */
public class ListUtils {

    /**
     * Convert a String List to a String Array
     * 
     * @param stringList
     * @return
     */
    public static String[] getStringListAsArray(List<String> stringList){
		
		int size = stringList.size();
		String[] array = new String[size];
		for (int i = 0; i < array.length; i++) {
			array[i] = stringList.get(i);
		}		
		return array;	
	}
		
	/**
	 * Convert a String List to an int array
	 * 
	 * @param stringList
	 * @return
	 */
	public static int[] getStringListAsIntArray(List<String> stringList){
		
		int size = stringList.size();
		int[] array = new int[size];
		for (int i = 0; i < array.length; i++) {
			array[i] = Integer.parseInt(stringList.get(i));
		}		
		return array;	
	}
	
	
	
}
