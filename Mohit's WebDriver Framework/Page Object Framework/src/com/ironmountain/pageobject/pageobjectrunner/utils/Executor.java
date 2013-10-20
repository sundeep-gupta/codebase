package com.ironmountain.pageobject.pageobjectrunner.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.framework.TestException;

/**
 * @author pjames
 *
 */
public class Executor {

	private static Logger  logger      = Logger.getLogger("com.ironmountain.pageobject.pageobjectrunner.utils.Executor");
	
	
	/** This method creates a runtime process builder instance and executes the command. 
	 * @param dialog
	 * This method can further be updated.
	 */
//	public static void executeProcess(String[] dialog){
//		try{		
//			ProcessBuilder proc = new ProcessBuilder(dialog);
//			Process p = proc.start();
//			
//			BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));           
//			BufferedReader stdError = new BufferedReader(new InputStreamReader(p.getErrorStream()));           
//			// read the output from the command           
//			String s = null;          
//			//System.out.println("Here is the standard output of the command:\n");          
//			while ((s = stdInput.readLine()) != null) {              
//				//System.out.println(s);          
//			}           
//			// read any errors from the attempted command           
//			//System.out.println("Here is the standard error of the command (if any):\n");          
//			while ((s = stdError.readLine()) != null) 
//			{              
//				//System.out.println(s);         
//				}		
//				//System.out.println("I am In try");	  
//			}  	
//				catch(Exception e){ 
//					e.printStackTrace();
//					//System.out.println("I am In catch");			
//				}
//			}
	
//	public static void executeProcess(String[] command){
//		Executor exe = new Executor();
//		exe.execute(command, 300);
//	}
	
	/**
	 * This function should be called to execute a command and get a exit status
	 * or terminate the process within a given time
	 * 
	 *  @param command
	 *  @param maxExecutionTime
	 */
	public static void executeProcess(String[] command, int maxExecutionTime){
		Executor exe = new Executor();
		exe.execute(command, maxExecutionTime);
	}
	
	/** 
	 * This function should be called for just starting a process
	 * 
	 * @param command
	 */
	public static void startProcess(String[] command )
	{
		Executor exe = new Executor();
		exe.startProc( command );
	}
	
	public static void executeProcessAndWait(String[] command){
		Executor exe = new Executor();
		exe.executeAndWait(command);
	}
	
	/**
	 * This Function just starts the given process and does not wait for the exit status
	 * Not to be called directly. startProcess to be called instead
	 * 
	 * @param command
	 */
	private void startProc( String [] command )
	{
		logger.debug("Process Starting with command: " + command[0]);
		Process process = null;
		
		//Creating TimeKeeper just for Creating ProcessController; will not be used to keep time.
		//This will leave the timeKept status of the TimeKeeper as false and thus not terminate the created process
		TimeKeeper keeper = new TimeKeeper(10);
		try
		{
			ProcessBuilder processBuilder = new ProcessBuilder(command);
			process = processBuilder.start();
			ProcessController ec = new ProcessController(process, keeper);
			ec.start();
			//Start the process and set a process complete immediately
			//Thus no need to wait for process completion and exit status
			ec.setProcessComplete();
		}
		catch (Exception e)
		{
			e.printStackTrace();
			logger.error("Error occured while executing the command" + e.getMessage());
		} 
	}
	
	/**
	 * Executes the command, this method execute the process with a specified amount of time.
	 * This is very important that when we start an external process the process may wait for the completion.
	 * If the external process encountered a problem and it is not able to return the Executor will wait indefinitely
	 * in such cases the process will be destroyed by the executor after the maxExecutionTime
	 * 
	 * Not to be called directly. executeProcess to be called instead
	 * 
	 * @param command
	 * @param maxExecutionTime (seconds)
	 */
	private void execute(String[] command, int maxExecutionTime){
		logger.debug("Process Executing with command: " + command[0]);
		Process process = null;		
		TimeKeeper keeper = new TimeKeeper(maxExecutionTime);
		keeper.keepTime();
		try {
			ProcessBuilder processBuilder = new ProcessBuilder(command);
			process = processBuilder.start();
			StreamProcesser outputProcesser = new StreamProcesser(process
					.getInputStream(), "OUTPUT");
			StreamProcesser errorProcesser = new StreamProcesser(process
					.getErrorStream(), "ERROR");
			outputProcesser.start();
			errorProcesser.start();
			ProcessController ec = new ProcessController(process, keeper);
			ec.start();
			int exitValue = process.waitFor();
			if(exitValue == 0){				
				ec.setProcessComplete();
			}

		} catch (Exception e) {
			e.printStackTrace();
			logger.error("Error occured while executing the command" + e.getMessage());
		} 
	}
	
	/**
	 * This process will execute a process and wait for it to finish.
	 * This function should not be used unless we are sure the the launched process will end and not freeze
	 * Otherwise execute should be used.
	 * 
	 * Not to be called directly. executeProcessAndWait to be called instead
	 * 
	 * @param command
	 */
	private void executeAndWait(String[] command){
		logger.debug("Process Executing with command: " + command[0]);
		Process process = null;	
		
		//Creating TimeKeeper just for Creating ProcessController; will not be used to keep time.
		//This will leave the timeKept status of the TimeKeeper as false and thus not terminate the created process
		TimeKeeper keeper = new TimeKeeper(10);
		
		try {
			ProcessBuilder processBuilder = new ProcessBuilder(command);
			process = processBuilder.start();
			StreamProcesser outputProcesser = new StreamProcesser(process
					.getInputStream(), "OUTPUT");
			StreamProcesser errorProcesser = new StreamProcesser(process
					.getErrorStream(), "ERROR");
			outputProcesser.start();
			errorProcesser.start();
			ProcessController ec = new ProcessController(process, keeper);
			ec.start();
			int exitValue = process.waitFor();
			if(exitValue == 0){				
				ec.setProcessComplete();
			}

		} catch (Exception e) {
			e.printStackTrace();
			logger.error("Error occured while executing the command" + e.getMessage());
		} 
	}
	
	/**
	 * @author jdevasia
	 *
	 * Thread which handles the input/out put streaming
	 * 
	 */
	static final class StreamProcesser extends Thread
	{
	    InputStream is;
	    String type;
	    
	    StreamProcesser(InputStream is, String type)
	    {
	        this.is = is;
	        this.type = type;
	    }
	    
	    @SuppressWarnings("null")
		public void run()
	    {
			BufferedReader br = null;
			try {
				InputStreamReader isr = new InputStreamReader(is);
				br = new BufferedReader(isr);
				String line = null;
				while ((line = br.readLine()) != null)
					logger.info(type + ": " + line);
			} catch (IOException ioe) {
				ioe.printStackTrace();
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
	    }
	}

	/**
	 * @author jdevasia
	 *
	 *This Thread class will control the process execution. This thread is to handle the execution time of the started process.
	 *
	 */
	public final class ProcessController extends Thread {
		
		Process proc = null;
		TimeKeeper keeper = null;
		boolean pComplete = false;
		
		public ProcessController(Process p, TimeKeeper k){
			proc = p;
			keeper = k;
		}
		 
		public void setProcessComplete(){
			pComplete = true;
		}
		
		public void run(){
			while(! pComplete && ! keeper.isTimeKept()){	
				try {
					Thread.sleep(1000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
			if(keeper.isTimeKept()){
				try {
					proc.destroy();					
					logger.debug("Problem with exit value Process killed by ProcessController" + proc);
				} catch (Exception e) {
					logger.error("Error while killing the process");
					e.printStackTrace();
				}
			}
			else if(pComplete){
				keeper.stopKeeping();
				logger.debug("Process Completed normally");
			}
			else{
				throw new TestException("Unexpected problem occured while handling the process");
			}
		}
	}
	

}
