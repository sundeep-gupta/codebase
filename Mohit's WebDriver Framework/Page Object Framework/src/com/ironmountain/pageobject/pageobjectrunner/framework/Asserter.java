package com.ironmountain.pageobject.pageobjectrunner.framework;

import org.testng.Assert;

/**
 * @author Jinesh Devasia
 * 
 * A framework level class which maps all the methods of the Assert class.
 * Currently the TestAssert uses TestNG Assert class, user's can change the Assert class to 
 * any common testing frameworks assert.
 *
 */
public class Asserter {


	public static void assertEquals(boolean actual, boolean expected)
	{
		Assert.assertEquals(actual, expected);
	}
	public static void assertEquals(boolean actual, boolean expected, String message)
	{
		Assert.assertEquals(actual, expected, message);
	}
	public static void assertEquals(int actual, int expected)
	{
		Assert.assertEquals(actual, expected);
	}
	public static void assertEquals(int actual, int expected, String message)
	{
		Assert.assertEquals(actual, expected, message);
	}	
	public static void assertEquals(String actual, String expected)
	{
		Assert.assertEquals(actual, expected);
	}
	public static void assertEquals(String actual, String expected, String message)
	{
		Assert.assertEquals(actual, expected, message);
	}
	public static void assertEquals(Object actual, Object expected)
	{
		Assert.assertEquals(actual, expected);
	}
	public static void assertEquals(Object actual, Object expected, String message)
	{
		Assert.assertEquals(actual, expected, message);
	}
	public static void assertFalse(boolean condition) {
		Assert.assertFalse(condition);
		
	}
	public static void assertFalse(boolean condition, String message) {
		Assert.assertFalse(condition, message);
		
	}
	public static void assertTrue(boolean condition)
	{
		Assert.assertTrue(condition);
	}
	public static void assertTrue(boolean condition, String message)
	{
		Assert.assertTrue(condition, message);
	}
	public static void fail()
	{
		Assert.fail();
	}
	public static void fail(String message)
	{
		Assert.fail(message);
	}
	public static void fail(String message, Throwable realCause)
	{
		Assert.fail(message, realCause);
	}
	
	
}
