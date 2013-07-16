package com.ironmountain.pageobject.pageobjectrunner.utils;

import org.apache.log4j.Logger;

/**
 * @author jdevasia
 * 
 * This is time keeper thread. Just like a Timer Thread
 * The TimeKeeper will keep the time specified by the owner 
 * 
 */
public class TimeKeeper extends Thread{

	private static final Logger logger = Logger.getLogger("com.ironmountain.pageobject.pageobjectrunner.utils.TimeKeeper");
	
	private long myTime = 0;
	private boolean timeKept = false;
	private boolean stopKeeping = false;
	
	public TimeKeeper(){
		myTime = 1000;
	}
	public TimeKeeper(int seconds){
		myTime = seconds * 1000;
	}	
	
	public void setMyTime(int seconds){
		myTime = seconds * 1000;
	}
	
	/**
	 * Keep the default time, The time should be specified while constructing the TimeKeeper else
	 * TimeKeeper will keep time only for a second.
	 */
	public void keepTime(){		
		logger.debug("TimeKeeper will keep time for '"+ myTime + "' milli seconds");
		this.start();
	}
	/**
	 * TimeKeeper keeps the time specified. This is useful when you have a TimeKeeper already and you want to keep
	 * different timings in different occasions.
	 * 
	 * @param seconds
	 */
	public void keepTime(int seconds){		
		this.setMyTime(seconds);
		logger.debug("TimeKeeper will keep time for '"+ myTime + "' milli seconds");
		this.start();
	}
	/**
	 * Non-Threaded call to the TimeKeeper, its just a wait for some seconds without sleeping
	 */
	public void keepTimeAndWait(){		
		logger.debug("TimeKeeper will keep time for '"+ myTime + "' milli seconds");
		this.run();
	}
	/**
	 * Non-Threaded call to the TimeKeeper, its just a wait for some seconds without sleeping
	 * 
	 * @param seconds
	 */
	public void keepTimeAndWait(int seconds){		
		this.setMyTime(seconds);
		logger.debug("TimeKeeper will keep time for '"+ myTime + "' milli seconds");
		this.run();
	}
	
	/**
	 * Instruct the TimeKeeper to stop keeping time.
	 */
	public void stopKeeping(){
		logger.debug("Instructing TimeKeeper to stop keeping..");
		this.stopKeeping = true;
	}

	/**
	 * TimeKeeper will return the status of TimeKeeping completed or not-completed
	 * 
	 * @return
	 */
	public boolean isTimeKept(){
		return timeKept;
	}
	
	
	@Override
	public void run() {
		logger.debug("TimeKeeper started keeping Time..");
		long startTime = DateUtils.getCurrentTimeInMillis();

		while(true)
		{
			if((DateUtils.getCurrentTimeInMillis() - startTime) >= myTime || stopKeeping) {
				if(stopKeeping){
					logger.debug("TimeKeeper stopping before the time keep session..");
				}
				else{
					logger.debug("TimeKeeper kept the time for '" + myTime + "' milli seconds");
				}
				logger.debug("Time has come, I can't keep the time anymore..");
				timeKept = true;
				break;
			}
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}	
	}
	
	
	
	
	
}
