package com.ironmountain.pageobject.pageobjectrunner.utils;



import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.utils.Executor;
import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;

/** This Class executes the executables to install Application Software
 *  @author pjames
 *
 */
public class InstallUtils {
	
	
	public static String Browser = PropertyPool.getProperty("browser");
	public static String DownloadLocation = null;
	public static String OS = PropertyPool.getProperty("OS");
	public static String DownloadOpt = PropertyPool.getProperty("DownloadOpt");
	public static String ExeName;
	public static String[] dialog;
	public static Executor exec;
	public static String ExeLoc;
	
	
	/**This method would invoke the msi and install the agent on the Client box where the script is run.
	 * @throws Exception
	 */
	public static void installAgent(String FileName) throws Exception {
		DownloadLocation = FileUtils.setDownloadLocationwithFileName(FileName);
		if(OS.contains("win")){
			ExeName = "Install_Agent.exe";
			ExeLoc = FileUtils.getExeCannonicalPath(ExeName);
			dialog =  new String[]{ ExeLoc, DownloadLocation };
			Executor.executeProcess(dialog, 600);
			}
	}

}
