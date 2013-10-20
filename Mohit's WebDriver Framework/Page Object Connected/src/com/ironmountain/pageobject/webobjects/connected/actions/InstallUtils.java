package com.ironmountain.pageobject.webobjects.connected.actions;



import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;

import org.apache.axis.AxisFault;
import org.apache.log4j.Logger;



import SSWSAPIService_pkg.SSWSAPIServiceLocator;
import SSWSAPIService_pkg.SSWSAPIServiceSoapStub;
import SSWSAPIService_pkg.SSWSTicket;


import com.connected.www.AdminAPI.v7_5.AdminAPIServiceLocator;
import com.connected.www.AdminAPI.v7_5.AdminAPIServiceSoapStub;




import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.utils.Executor;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;

import com.ironmountain.pageobject.webobjects.connected.pages.amws.AccountManagementHomePage;
import com.ironmountain.pageobject.webobjects.connected.tests.AccountManagementTest;
import com.ironmountain.pageobject.webobjects.connected.actions.amws.AccountManagementLogin;



/** This Class executes the executables to install Application Software
 *  @author pjames
 *  @author rramanand
 *
 */
public class InstallUtils {
	
	private static Logger  logger      = Logger.getLogger(InstallUtils.class.getName());
	
	public static String Browser = PropertyPool.getProperty("browser");
	public static String DownloadLocation = null;
	public static String OS = PropertyPool.getProperty("OS");
	public static String DownloadOpt = PropertyPool.getProperty("DownloadOpt");
	public static String ExeName;
	public static String[] dialog;
	public static Executor exec;
	public static String ExeLoc;
	public static String DefaultInstallLocation = "C:\\Program Files\\Iron Mountain\\Connected BackupPC";
	public static String DefaultInstallLocation64Bit = "C:\\Program Files (x86)\\Iron Mountain\\Connected BackupPC";
	public static String uninstallermsi = null;
	public static String uninstallermsiloc = null;
	public static AdminAPIServiceSoapStub	adminService = null;
	private static int iCommunityID = -1;
	private static SSWSAPIServiceSoapStub sswsService = null;
	static SSWSTicket ticket = null;
	
	
	
	/**This method would invoke the msi and install the agent on the Client box where the script is run.
	 * @throws Exception
	 
	public static void installAgent(String FileName) throws Exception {
		DownloadLocation = FileUtils.setDownloadLocationwithFileName(FileName);
		if(OS.contains("win")){
			ExeName = "Install_Agent.exe";
			ExeLoc = FileUtils.getExeCannonicalPath(ExeName);
			dialog =  new String[]{ ExeLoc, DownloadLocation };
			Executor.executeProcess(dialog, 600);
			}
	}
	public static void main(String[]args){
		try {
			installAgent("AgentSetupFile", "reinstallagentuser@abc.com", "1connected");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}*/

	/**This method would run the msi silently and install the agent on the Client box where the script is run.
	 * @throws Exception
	 **/
	public static void installAgent(String FileName, String Email, String Password) throws Exception {
		try {
			System.out.println("inside installAgent");
			DownloadLocation = FileUtils.setDownloadLocationwithFileName(FileName);
			logger.info(DownloadLocation);
			uninstallermsiloc = FileUtils.getBaseDirectory() +  File.separator + PropertyPool.getProperty("downloadsdir") + File.separator + "UninstallerLocDir";
			uninstallermsi = uninstallermsiloc + File.separator + "AgentSetup.msi";	
			String[] dialog;
			File file=new File(DefaultInstallLocation);
			File file1=new File(DefaultInstallLocation64Bit);
			//boolean exists = file.exists();
			if (file.exists()) {
				logger.info("Agent is already Installed");
				System.out.println(uninstallermsi);
				dialog = new String[] {"msiexec", "/qn", "/x", uninstallermsi};
				Executor.executeProcess(dialog, 600);
				logger.info("Completed uninstalling the Agent");
			} else {
				if (file1.exists()) {
					logger.info("Agent is already Installed");
					System.out.println(uninstallermsi);
					dialog = new String[] {"msiexec", "/qn", "/x", uninstallermsi};
					Executor.executeProcess(dialog, 600);
					logger.info("Completed uninstalling the Agent");
				}
			}
			dialog = new String[] {"msiexec", "/qn", "/i", DownloadLocation, "EMAILADDRESS="+Email, "PASSWORD="+Password};
			Executor.executeProcess(dialog, 6000);
			logger.info("Completed installing the Agent");
			AccountManagementHomePage accMgmtHomePage = AccountManagementLogin.login(Email, Password);
			String accountNumber = accMgmtHomePage.getAccountNumber();
			if (file.exists()){
			String ExeLoc = DefaultInstallLocation + File.separator + "Activate.exe";
			logger.info("Activating the Agent");
			dialog = new String[] {ExeLoc , "-account", accountNumber , "-password", "1connected", "-techid", "admin"}; 
			Executor.executeProcess(dialog, 180);
			logger.info("Completed the Agent Activation");
			} else {if (file1.exists()){
				String ExeLoc = DefaultInstallLocation64Bit + File.separator + "Activate.exe";
				logger.info("Activating the Agent");
				dialog = new String[] {ExeLoc , "-account", accountNumber , "-password", "1connected", "-techid", "admin"}; 
				Executor.executeProcess(dialog, 180);
				logger.info("Completed the Agent Activation");
			}
			}
			dialog = new String[]{"cmd","/c","mkdir",uninstallermsiloc};
			Executor.executeProcess(dialog, 180);			
			dialog = new String[]{"cmd","/c","copy" ,DownloadLocation, uninstallermsiloc};
			Executor.executeProcess(dialog, 180);
			logger.info("Completed Copying the uninstaller msi");
			dialog = new String[]{"cmd","/c","del","/f",DownloadLocation};
			Executor.executeProcess(dialog, 180);			
			}
		
			catch (Exception e){
				System.out.println(e);
			}
	}
	
	/**This method would run the msi silently and cleanup the agent on the Client box where the script is run.
	 * @throws Exception
	 **/
	public static void cleanupAgent(String FileName) throws Exception {
		try {
			DownloadLocation = FileUtils.setDownloadLocationwithFileName(FileName);
			uninstallermsiloc = FileUtils.getBaseDirectory() +  File.separator + PropertyPool.getProperty("downloadsdir") + File.separator + "UninstallerLocDir";
			uninstallermsi = uninstallermsiloc + File.separator + "AgentSetup.msi";	
			String[] dialog;
			File file=new File(DefaultInstallLocation);
			File file1=new File(DefaultInstallLocation64Bit);
			//boolean exists = file.exists();
			if (file.exists()) {
				logger.info("Agent is already Installed");
				System.out.println(uninstallermsi);
				dialog = new String[] {"msiexec", "/qn", "/x", uninstallermsi};
				Executor.executeProcess(dialog, 600);
				logger.info("Completed uninstalling the Agent");
			} else {
				if (file1.exists()) {
					logger.info("Agent is already Installed");
					System.out.println(uninstallermsi);
					dialog = new String[] {"msiexec", "/qn", "/x", uninstallermsi};
					Executor.executeProcess(dialog, 600);
					logger.info("Completed uninstalling the Agent");
				}
			}
			}
			catch (Exception e){
				System.out.println(e);
			}
		}
	
	/**
	 * Downloads the Agent MSI using Admin api
	 * @param comId					Community ID
	 * @param configId				Configuration ID
	 * @param installationPath		Path where the MSI has to be downloaded
	 * @param installPlatform		Platform is Win or MAC
	 * @throws Exception
	 */
	public static void downloadAgentMSI_AdminAPI(String strTechName,String strTechPassword, String serverName, int comId, int configId, String installationPath) throws Exception
	{
		    
			URL urlAdminAPI = new URL("http://"+serverName+"/AdminAPI/AdminAPI.dll?Handler=Default");
			AdminAPIServiceLocator ServiceLocator = new AdminAPIServiceLocator();
			ServiceLocator.setMaintainSession(true);
			ServiceLocator.getEngine().setOption("sendMultiRefs", Boolean.FALSE);
			adminService = new AdminAPIServiceSoapStub(urlAdminAPI, ServiceLocator);	
			logger.debug("Value of the AdminService::: "+adminService);
			
		
			iCommunityID = adminService.sessionLoginTechnician(strTechName, strTechPassword);
		logger.debug("****In downloadAgentMSI****");
		
		boolean done = false;
		int bytesDownloaded = 0;
		final File outputFile = new File(installationPath);
		BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(outputFile));
        
		while (!done) {
            final byte[] installationMsi = adminService.communityGetInstall2(comId, configId, bytesDownloaded, 1024 * 1024);
            if (installationMsi == null || installationMsi.length == 0) {
                done = true;
            } else {
                stream.write(installationMsi);
                bytesDownloaded += installationMsi.length;
            }
		}
		stream.flush();
        stream.close();
		logger.debug("Download complete!!");
		
	}
	/**
     * This method gets the SSWSTicket which is required by all the
     * authenticated methods
     * 
     * @param iCommunityId
     * @param StrAccountNumber
     * @param StrPassword
     * @return ticket
     */

    public static SSWSTicket lgetTicket(int iCommunityId, String StrAccountNumber,
            String StrPassword) {
    try {
        logger.debug("Getting a SSWSTicket...");
        ticket = new SSWSTicket(0, iCommunityId, StrAccountNumber, "",
                StrPassword, 0, 0);
        int iAccountNumber = ticket.getICommunityID();
        logger.debug("The community id  in the ticket is :" + iAccountNumber);
    } catch (Exception e) {
			e.printStackTrace();

		}
    return ticket;
    }
	
	/**
     * This method downloads an agent setup using ssws api
     * 
     * @param iCommunityId
     * @param StrAccountNumber
     * @param StrPassword
     */
    public static void lgenerateAgentSetup_SSWSAPI(int iCommunityId, String StrAccountNumber,String StrPassword,String StrSCServerName) {
    try {
    	 try {
    	logger.debug(".... Connecting to the SSWS server ...");
    	final URL urlSSWSAPI = new URL("http://"+StrSCServerName+"/SSWSAPI/SSWSAPI.dll?Handler=Default");
    	logger.info(urlSSWSAPI);
        SSWSAPIServiceLocator serviceLocator = new SSWSAPIServiceLocator();
        serviceLocator.setMaintainSession(true);
        serviceLocator.getEngine().setOption("sendMultiRefs",Boolean.FALSE);
        sswsService = new SSWSAPIServiceSoapStub(urlSSWSAPI, serviceLocator);
    	 }catch(MalformedURLException e){
				e.printStackTrace();
			}
        long iretrivesize;
        ticket = lgetTicket(iCommunityId, StrAccountNumber, StrPassword);
        logger.info("The ticket information is " + ticket);
        SSWSAPIService_pkg.AgentDownloadInfo agentInfo = sswsService.generateAgentSetup(ticket, false);
        iretrivesize = agentInfo.getSize().longValue();
        logger.info("*******The size of this iretrieve is : " + iretrivesize);
        //String StrRetrievePath = fhelper.convertPath(StrRestoreDir);
        String FileName = "AgentSetupFile";
        DownloadLocation = FileUtils.setDownloadLocationwithFileName(FileName);
        logger.info("The installation MSI will be downloaded to : "+ DownloadLocation);
        // Chunking code to download the MSI
        final File outputfile = new File(DownloadLocation);
        BufferedOutputStream stream = new BufferedOutputStream(
                new FileOutputStream(outputfile));
        if (!outputfile.exists()) {
            outputfile.createNewFile();
        }
        boolean done = false;
        int bytesDownloaded = 0;
        while (!done) {
            if (bytesDownloaded == iretrivesize) {
                break;
            } else {
                final byte[] installationMsi = sswsService.fetchAgentSetupBytes(ticket, agentInfo,bytesDownloaded, 1344665);
                try {
					Thread.sleep(2000);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
                if (installationMsi == null || installationMsi.length == 0) {
                	logger.info("installationMsi was null or 0");
                    done = true;
                } else {
                    stream.write(installationMsi);
                    bytesDownloaded += installationMsi.length;
                    logger.debug("The number of bytes downloaded so far are ......."+ bytesDownloaded);
                   /* try {
						Thread.sleep(10);
					} catch (InterruptedException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}*/
                    
                }
            }
            
        }
        
        stream.flush();
        stream.close();
        logger.info("Installation donwloaded," + bytesDownloaded+ " bytes, written to " + outputfile);

    } catch (FileNotFoundException e1) {
    	e1.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
    }
	
}
