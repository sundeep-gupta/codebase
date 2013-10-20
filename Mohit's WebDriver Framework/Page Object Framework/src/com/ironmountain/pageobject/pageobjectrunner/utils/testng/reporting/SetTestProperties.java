package com.ironmountain.pageobject.pageobjectrunner.utils.testng.reporting;

import java.util.*;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import org.apache.commons.logging.impl.Log4JLogger;

/**
 * @author pjames - Class taken from Legacy Automation
 * This object is the 'test' section of the common IMD Test Results File format.
 * 
 */
public class SetTestProperties {
	
	private String			testpath		= "";
	private String			testset			= "";
	private String			testname		= "";	
	private String			runname			= "";
	private String			status			= "";
	
	private String			starttime		= "";
	private String			stoptime		= "";
	
	private String			resultdetail	= "";
	private String			host			= "";
	private String			platform		= System.getProperty("os.name");;
	private String			osversion		= System.getProperty("os.version");
	//private String 			nameOS = 
	

/**
	 * This object is the 'test' section of the common IMD Test Results File format.
	 * 
	 * Example:
	 * 			      <test>
	 *		            <testpath></testpath>
	 *		            <testset></testset>
	 *		            <testname></testname>
	 *		            <runname></runname>
	 *		            <status></status>
	 *		            
	 *		            <starttime></starttime>
	 *		            <stoptime></stoptime>
	 *							            
	 *					<resultdetail></resultdetail>
	 *		            <customfield name="" type=""></customfield>
	 *					<attachedfile location=””>filename</attachedfile>
	 *					<host></host>
	 *					<platform></platform>
	 *					<osversion></osversion>
	 *		      </test>
	 *
	 */
	public SetTestProperties() {

	}

	/**
	 * @param aDate
	 * @return a string containing the date in the format required for the standard test results fle
	 */
	public String formatDate(Date aDate) {
		DateFormat dfm = new SimpleDateFormat("yyyy-MM-dd:HH:mm:ss.000");
		return dfm.format(aDate);
	}

	public void setTestPath(String testpath) {
		this.testpath = testpath;
	}

	public String getTestPath() {
		return testpath;
	}

	public void setTestSet(String testset) {
		this.testset = testset;
	}

	public String getTestSet() {
		return testset;
	}

	public void setRunName(String runname) {
		this.runname = runname;
		System.out.println(runname);
		runname = formatRunName(runname);
		this.runname = runname;
	}

	public String getRunName() {
		return runname;
	}

	public void setStatus(String status) {
		this.status = status.toUpperCase();
	}

	public String getStatus() {
		return status;
	}

	
	public void setStartTime(Date starttime) {
		this.starttime = formatDate(starttime);
	}

	public void setStartTime(String starttime) {
		this.starttime = starttime;
	}

	public void setStartTime(long starttime) {

		// Create a calendar object that will convert the date and time value
		// in milliseconds to date. We use the setTimeInMillis() method of the
		// Calendar object.
		//
		Calendar calendar = Calendar.getInstance();
		calendar.setTimeInMillis(starttime);

		this.setStartTime(calendar.getTime());
	}

	public String getStartTime() {
		return this.starttime;
	}

	public void setStopTime(String stoptime) {
		this.stoptime = stoptime;
	}

	public void setStopTime(Date stoptime) {
		this.stoptime = formatDate(stoptime);
	}
	public void setStopTime(long stoptime) {

		// Create a calendar object that will convert the date and time value
		// in milliseconds to date. We use the setTimeInMillis() method of the
		// Calendar object.
		//
		Calendar calendar = Calendar.getInstance();
		calendar.setTimeInMillis(stoptime);

		this.setStopTime(calendar.getTime());
	}

	public String getStopTime() {
		return stoptime;
	}

	public void setResultDetail(String resultdetail) {
		this.resultdetail = resultdetail;
	}

	public String getResultDetail() {
		return resultdetail;
	}

	/*public void setCustomField(String name, String type) {
		this.customfield = new CustomField(name, type);
	}

	public CustomField getCustomField() {
		return customfield;
	}

	public void setAttachedfile(String name, String location) {
		this.attachedfile = new AttachedFile(name, location);
	}

	public AttachedFile getAttachedfile() {
		return attachedfile;
	}*/

	public void setTestName(String testname) {
		this.testname = testname;
	}

	public String getTestName() {
		return testname;
	}
public void setHost(String host) {
		
		this.host =this.getHost();
	}

	public String getHost() {
		
			InetAddress addr;
			try {
				addr = InetAddress.getLocalHost();
				host = addr.getHostName();
				return host;
			} catch (UnknownHostException e) {
				System.out.println("Error Occured : "+e.getMessage());
			}
		
		return host;
	}

	public String getOSname(){
		
		return platform ;
		
	}
	public String getOSversion(){
		
		return osversion ;
		
	}
	
	public String formatRunName(String runname){
		runname = runname.replace("/", "_");
		runname = runname.replace(" ", "_");
		return runname;
	}
}
