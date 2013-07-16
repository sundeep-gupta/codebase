package com.ironmountain.pageobject.pageobjectrunner.utils;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import org.apache.log4j.Logger;

public class ZipUtils {

	private static Logger logger = Logger
			.getLogger("com.ironmountain.pageobject.pageobjectrunner.utils.ZipUtils.class");
	
	private static ArrayList<String> fileContentList = new ArrayList<String>();

	@SuppressWarnings("unchecked")
	public static void unzipFile(String unzipLocation, String zipFileName)
	{
		FileUtils.deleteDir(unzipLocation);
		FileUtils.createDirectory(unzipLocation);
		Enumeration entries;
		ZipFile zipFile;
		try {
			zipFile = new ZipFile(zipFileName);
			entries = zipFile.entries();
			while (entries.hasMoreElements()) {
				ZipEntry entry = (ZipEntry) entries.nextElement();
				if (entry.isDirectory()) {
					System.out.println("Directory is: " + entry.getName());
					logger.debug("Extracting directory: " + entry.getName());
					FileUtils.createDirectory(unzipLocation + entry.getName());
					continue;
				}
				fileContentList.add(entry.getName());
				System.out.println("Extracting file: " + entry.getName());
				logger.debug("Extracting file: " + entry.getName());
				copyInputStream(zipFile.getInputStream(entry),
						new BufferedOutputStream(new FileOutputStream(
								unzipLocation + entry.getName())));
			}
			zipFile.close();
		} catch (IOException ioe) {
			logger.debug("Exception: " + ioe.getMessage());
			ioe.printStackTrace();
			return;
		}
	}
	
	@SuppressWarnings("unchecked")
	public static void unzipRetrivedFile(String unzipLocation, String zipFileName){	
		FileUtils.createDirectory(unzipLocation);		
		Enumeration entries;
		ZipFile zipFile;
		try {
			zipFile = new ZipFile(zipFileName);
			entries = zipFile.entries();
			while (entries.hasMoreElements()) {
				ZipEntry entry = (ZipEntry) entries.nextElement();
				
				if (entry.isDirectory()) {
					System.out.println("Directory is: " + entry.getName());
					logger.debug("Extracting directory: " + entry.getName());
					FileUtils.createDirectory(unzipLocation + entry.getName());
					continue;
				}
				fileContentList.add(entry.getName());
				createBackupPathDirectory(unzipLocation, entry);
				System.out.println("Extracting file: " + entry.getName());
				logger.debug("Extracting file: " + entry.getName());
				copyInputStream(zipFile.getInputStream(entry),
						new BufferedOutputStream(new FileOutputStream(
								unzipLocation + entry.getName())));
			}
			zipFile.close();
		} catch (IOException ioe) {
			logger.debug("Exception: " + ioe.getMessage());
			ioe.printStackTrace();
			return;
		}
	}

	public static void copyInputStream(InputStream in, OutputStream out)
			throws IOException {
		byte[] buffer = new byte[1024];
		int len;
		while ((len = in.read(buffer)) >= 0)
			out.write(buffer, 0, len);
		in.close();
		out.close();
	}

	public static void createBackupPathDirectory(String unzipLocation, ZipEntry entry){
		String path = "";
		if (entry.getName().contains("/")) {
			String[] s = entry.getName().split("/");
			for (int i = 0; i < (s.length - 1); i++) {
				path = path + "\\" + s[i];
			}
		}
		File dir = new File(unzipLocation + path);
		if(! dir.exists()){
			dir.mkdirs();
			logger.debug("Directory created: " + dir.getAbsolutePath());
		}			
	}



}
