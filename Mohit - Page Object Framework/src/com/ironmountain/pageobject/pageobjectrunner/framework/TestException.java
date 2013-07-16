package com.ironmountain.pageobject.pageobjectrunner.framework;


/**
 * @author Jinesh Devasia
 *
 */
public class TestException extends RuntimeException{

	
	private static final long serialVersionUID = 1L;
	
	
	public TestException(String message)
	{
		super(message);
	}
	public TestException(String message, Exception e) {
	     super(message, e);
	     e.printStackTrace();
	}
	public TestException(Exception e) {
		 final String message = e.getMessage();
		    if(message.contains("Got a null result"))
		       new TestException("Selenium session is set to null, since the execution time exceeded the maximum execution time limit!!"+
		    		   "\n or the test will be waiting for a response which is timed out..");
	}
	

}
