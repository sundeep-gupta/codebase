package com.bubble.examples.utils;
import java.util.Calendar;
public class DateEx {
    public static boolean addDate(int iDate) { 
        Calendar cal = Calendar.getInstance(); 
        cal.set(2009,01,01); 
        cal.add(Calendar.DATE, iDate); // Add days in Dates in Calendar 
        System.out.println("Date :"+cal.get(Calendar.DATE)); 
        System.out.println("Month :"+cal.get(Calendar.MONTH)); 
        System.out.println("Year :"+cal.get(Calendar.YEAR)); 
        return true; 
    } 
    public static void main(String[] args) {
        addDate(30); 
    }
}
