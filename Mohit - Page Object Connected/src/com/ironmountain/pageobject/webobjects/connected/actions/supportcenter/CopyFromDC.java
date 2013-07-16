package com.ironmountain.pageobject.webobjects.connected.actions.supportcenter;

import java.io.File;

import javax.net.ssl.HostnameVerifier;
import java.net.InetAddress;

import org.apache.log4j.Logger;

import com.ibm.staf.STAFException;
import com.ibm.staf.STAFHandle;
import com.ibm.staf.STAFResult;
import com.ironmountain.digital.qa.automation.connected.qaStaf.qaSTAFFileService;
import com.ironmountain.digital.qa.automation.connected.qaStaf.qaSTAFPing;
import com.ironmountain.digital.qa.automation.connected.qaStaf.qaSTAFEnv;
import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;

public class CopyFromDC {
  
	final private static Logger logger = Logger.getLogger(CopyFromDC.class.getName());
	static String srcfolder = null;
	String destfolder = "C:\\DCBrandingFiles";
	private static String Brandspath = "C:\\DataCenter\\Configuration$\\Brands";
	private static STAFResult res;
	private static String DC_MACHINE = PropertyPool.getProperty("PrimaryDataCenterRegistryMachineName");
	private static String COMP_NAME = null;
	
	public static STAFResult copyBrandingDirectoryFromDC(){
		try{
			logger.info("Using STAF to copy files from DC");
			final qaSTAFPing qaSTAFPingService = new qaSTAFPing();
			final boolean isServerPingable = qaSTAFPingService.ping(DC_MACHINE);
			logger.info("Server Pingable =" + isServerPingable);
			if (!(isServerPingable)) {
				final String uniqueMessage = "FAIL: copy()- Server is not pingable.Please verify if the machine:  "+"2003-server-dc1.englab.qa"+ ": is running and STAF is running :";
				logger.info(uniqueMessage);
				System.exit(1);
			}
			qaSTAFFileService srv = new qaSTAFFileService("FS");
			srcfolder = new File(Brandspath).getAbsolutePath();
			COMP_NAME = InetAddress.getLocalHost().getCanonicalHostName();
		    res = srv.copyFolder(DC_MACHINE, "C:\\DataCenter\\Configuration$\\Brands", COMP_NAME, "C:\\DCBrandingFiles");
			}catch (final Exception e) {		
				logger.info(e.getMessage());
			}
			return res;
		
	}

}
