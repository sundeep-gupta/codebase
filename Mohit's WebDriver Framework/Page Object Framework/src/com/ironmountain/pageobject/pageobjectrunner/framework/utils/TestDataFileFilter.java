package com.ironmountain.pageobject.pageobjectrunner.framework.utils;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import com.ironmountain.pageobject.pageobjectrunner.utils.FileUtils;

/**
 * @author Jinesh Devasia
 *
 */
public class TestDataFileFilter {

	public static final String TESTDATA_FILENAME_FILTER = "dataprovider.xml";
	
	public static List<String> getAllTestDataFiles(String testDirectory)
	{
		List<String> testDataFilesList = new ArrayList<String>();
		File dir = new File(testDirectory);	
		List<File> listOfFiles = FileUtils.getAllFilesFromDirectory(dir);
		for(File file:listOfFiles){
			if(file.getName().endsWith(TESTDATA_FILENAME_FILTER)){
				testDataFilesList.add(file.getAbsolutePath());
			}				
		}	
		return testDataFilesList;
	}
	public static String getTestDataFile(String testDirectory, String fileName)
	{
		String testDataFile = null;
		File dir = new File(testDirectory);	
		List<File> listOfFiles = FileUtils.getAllFilesFromDirectory(dir);
		for(File file:listOfFiles){
			if(file.getName().equals(fileName)){
				testDataFile = file.getAbsolutePath();
				return testDataFile;
			}				
		}	
		return testDataFile;
	}
	
}
