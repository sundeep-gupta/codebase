package com.ironmountain.pageobject.pageobjectrunner.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FilenameFilter;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.Vector;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;

/**
 * @author Jinesh Devasia
 *
 */
public class FileUtils {
	
	private static Logger logger = Logger.getLogger("com.imd.connected.webuitest.utils.FileUtils");
	static String DownloadLocation = null;
	static String ExeLoc = null;

	public static String getBaseDirectory()
	{
		return System.getProperty("user.dir");
	}
	public static String getSourceDirectory()
	{
		String baseDir = getBaseDirectory();
		return baseDir + File.separator +"src";
	}
	public static String getTestBaseDirectory()
	{
		 String sourceDir = getSourceDirectory();
		return sourceDir +  File.separator +"ironmountain"+ File.separator+"pageobject"+ File.separator+"webobjects";
	}
	public static String getConfigDirectory()
	{
		String baseDir = getBaseDirectory();
		return baseDir +  File.separator +"config";		
	}
	public static String getPageBaseDirectory()
	{
        String sourceDir = getSourceDirectory();
        String locatorBaseDir = PropertyPool.getProperty("locatorbasedir");
        locatorBaseDir = locatorBaseDir.replace("\\",File.separator);
		return sourceDir +  File.separator + locatorBaseDir;		
	}
	
	/**
	 * Method which lists all files from a directory and its sub-directories.
	 * this method is make use of the List<File> getAllFilesFromDirectory(File directory, List<File> filesList) method,
	 * Since the method itself recursive we need to pass the fileList with the method.
	 * 
	 * @param directory
	 * @param filesList
	 * @return filesList
	 */
	public static List<File> getAllFilesFromDirectory(File directory)
	{		
		FileUtils fUtil = new FileUtils();
		ArrayList<File> filesList = new ArrayList<File>();
		return fUtil.getAllFilesFromDirectory(directory, filesList);		
	}
	/**
	 * This method is to do the recursive file search
	 * 
	 * @param directory
	 * @param filesList
	 * @return
	 */
	public List<File> getAllFilesFromDirectory(File directory, List<File> filesList)
	{		
		if(directory.isDirectory()){
			 File[] listOfFiles = directory.listFiles();			    
			 for (int i = 0; i < listOfFiles.length; i++) {
			     if (listOfFiles[i].isFile()) {
			    	  filesList.add(listOfFiles[i].getAbsoluteFile());
			     }
			     else if(listOfFiles[i].isDirectory()){
			    	 getAllFilesFromDirectory(listOfFiles[i], filesList);
			     }
			 }	   
		}	 
		if(directory.isFile()){
			filesList.add(directory.getAbsoluteFile());
		}
		return filesList;
	}
	/**
	 * Get files filtered by filename filter
	 * 
	 * @param directory
	 * @param filter
	 * @return
	 */
	public static List<File> getAllFilesFromDirectory(File directory,  FilenameFilter filter)
	{		
		FileUtils fUtil = new FileUtils();
		ArrayList<File> filesList = new ArrayList<File>();
		return fUtil.getAllFilesFromDirectory(directory, filter, filesList);		
	}
	/**
	 * Get the files filtered by the filename filter
	 * 
	 * @param directory
	 * @param filter
	 * @param filesList
	 * @return
	 */
	public List<File> getAllFilesFromDirectory(File directory, FilenameFilter filter, List<File> filesList)
	{		
		if(directory.isDirectory()){
			 File[] listOfFiles = directory.listFiles();			    
			 for (int i = 0; i < listOfFiles.length; i++) {
			     if (listOfFiles[i].isFile()&& filter.accept(listOfFiles[i], listOfFiles[i].getName())) {
			    	  filesList.add(listOfFiles[i].getAbsoluteFile());
			     }
			     else if(listOfFiles[i].isDirectory()){
			    	 getAllFilesFromDirectory(listOfFiles[i], filesList);
			     }
			 }	   
		}	 
		if(directory.isFile()&& filter.accept(directory, directory.getName())){
			filesList.add(directory.getAbsoluteFile());
		}
		return filesList;
	}
	
	/** From the file Collection received from the listFiles the File Array is returned.
	 * @param directory
	 * @param filter
	 * @param recurse
	 * @return File Arrray
	 */
	public static File[] listFilesAsArray(File directory,FilenameFilter filter,boolean recurse)
	{
		Collection<File> files = listFiles(directory,filter, recurse);
		File[] arr = new File[files.size()];
		for(int i=0; arr.length<=0; i++){
			System.out.println(arr[i]);
		}
		return files.toArray(arr);
	}

	/**Searches for a file in the directory recursively and returns a File Collection
	 * @param directory
	 * @param filter
	 * @param recurse
	 * @return
	 */
	public static Collection<File> listFiles(File directory,FilenameFilter filter,boolean recurse)
	{
		Vector<File> files = new Vector<File>();
		File[] entries = directory.listFiles();
		for (File entry : entries)
		{
			// If there is no filter or the filter accepts the 
			// file / directory, add it to the list
			if (filter == null || filter.accept(directory, entry.getName()))
			{
				files.add(entry);
			}
			// If the file is a directory and the recurse flag
			// is set, recurse into the directory
			if (recurse && entry.isDirectory())
			{
				files.addAll(listFiles(entry, filter, recurse));
			}
		}
		
		// Return collection of files
		return files;		
	}
	
	/** Searches for files with exe extn and returns the actual path of the Exe along with the exename.
	 * @param ExeName
	 * @return
	 * @throws Exception
	 */
	public static String getExeCannonicalPath(String ExeName)throws Exception{
		File directory = new File(".");
		FilenameFilter filter = new FilenameFilter() { 
	           public boolean accept(File dir, String name) { 
	                return name.endsWith(".exe"); 
	            } 
		}; 
	    File[] allMatchingFiles = FileUtils.listFilesAsArray(directory, filter, true);
	    for (File f : allMatchingFiles) {
	    	if (f.getName().equalsIgnoreCase(ExeName)){
	    		ExeLoc = f.getCanonicalPath();
	    	}
	         
	      }
		return ExeLoc;
	}
	
	public static String setDownloadLocationwithFileName(String FileName){
		FileName = PropertyPool.getProperty(FileName);
		return DownloadLocation = (getBaseDirectory() + File.separator + PropertyPool.getProperty("downloadsdir") + File.separator + FileName);
	}
	
	public static boolean compareFiles(String filePath1, String filePath2){
		final int BUFFSIZE = 1024;
		byte buff1[] = new byte[BUFFSIZE];
		byte buff2[] = new byte[BUFFSIZE];
		File file1 = new File(filePath1);
		File file2 = new File(filePath2);		
		InputStream is1 = null;
		InputStream is2 = null;
		if(file1.length() != file2.length()) return false;
		try {
			is1 = new FileInputStream(file1);
			is2 = new FileInputStream(file2);
			if(is1 == null && is2 == null) {
				throw new Exception("Files are null");
			}
			if(is1 == null || is2 == null) {
				throw new Exception("Files are null");
			}			
			if(is1 == is2) return true;
			try {
				int read1 = -1;
				int read2 = -1;

				do {
					int offset1 = 0;
					while (offset1 < BUFFSIZE
	               				&& (read1 = is1.read(buff1, offset1, BUFFSIZE-offset1)) >= 0) {
	            				offset1 += read1;
	        			}

					int offset2 = 0;
					while (offset2 < BUFFSIZE
	               				&& (read2 = is2.read(buff2, offset2, BUFFSIZE-offset2)) >= 0) {
	            				offset2 += read2;
	        			}
					if(offset1 != offset2) return false;
					if(offset1 != BUFFSIZE) {
						Arrays.fill(buff1, offset1, BUFFSIZE, (byte)0);
						Arrays.fill(buff2, offset2, BUFFSIZE, (byte)0);
					}
					if(!Arrays.equals(buff1, buff2)) return false;
				} while(read1 >= 0 && read2 >= 0);
				if(read1 < 0 && read2 < 0) return true;	// both at EOF
				return false;

			} catch (Exception ei) {
				return false;
			}
		}
		catch (Exception e) {
			return false;
		}
		finally {
				try {
					if(is1 != null) is1.close();
					if(is2 != null) is2.close();
				} catch (Exception ei2) {}
			}

		}

	public static void createDirectory(String path) {
		File dir = new File(path);
		if(! dir.exists()){
			dir.mkdir();
			logger.debug("Directory created: " + dir.getAbsolutePath());
		}		
	}
	public static boolean deleteDir(String path) {
		File dir = new File(path);
	    if (dir.isDirectory()) {
	        String[] children = dir.list();
	        for (int i=0; i<children.length; i++) {
	            boolean success = deleteDir(new File(dir, children[i]).getAbsolutePath());
	            if (!success) {
	                return false;
	            }
	        }
	    }
	    return dir.delete();
	}
	
	public static List<String> getSubDirectories(String baseDirectory){
		ArrayList<String> dirList = new ArrayList<String>();
		File dir = new File(baseDirectory);
		File[] subFiles = dir.listFiles();
		for (int i=0; i<subFiles.length; i++) {     
       	 if(subFiles[i].isDirectory()){
           	dirList.add(subFiles[i].getName());
           }
	    }
        return dirList;        
	}
	public static List<String> getSubDirectories(String baseDirectory, List<String> dirList){
		File dir = new File(baseDirectory);
		File[] subFiles = dir.listFiles();
		for (int i=0; i<subFiles.length; i++) {     
        	 if(subFiles[i].isDirectory()){
            	dirList.add(subFiles[i].getName());
            }
	    }
        return dirList;        
	}
	public static List<String> getAllSubDirectories(String baseDirectory){
		ArrayList<String> dirList = new ArrayList<String>();
		File dir = new File(baseDirectory);
		File[] subFiles = dir.listFiles();
        for (int i=0; i<subFiles.length; i++) { 
            if(subFiles[i].isDirectory()){
            	dirList.add(subFiles[i].getName());
            	dirList = (ArrayList<String>) getAllSubDirectories(subFiles[i].getAbsolutePath(), dirList);
            }
	    }
        return dirList;        
	}
	public static List<String> getAllSubDirectories(String baseDirectory, List<String> dirList){
		File dir = new File(baseDirectory);
		File[] subFiles = dir.listFiles();
        for (int i=0; i<subFiles.length; i++) {  
            if(subFiles[i].isDirectory()){
            	dirList.add(subFiles[i].getName());
            	dirList = (ArrayList<String>) getAllSubDirectories(subFiles[i].getAbsolutePath(), dirList);
            }
	    }
        return dirList;        
	}

}
