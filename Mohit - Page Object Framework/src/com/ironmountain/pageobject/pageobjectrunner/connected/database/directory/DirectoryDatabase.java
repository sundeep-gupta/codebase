package com.ironmountain.pageobject.pageobjectrunner.connected.database.directory;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.connected.database.DataBase;

public class DirectoryDatabase extends DataBase{
	
	private static Logger  logger      = Logger.getLogger("com.imd.connected.database.registry.DirectoryDatabase");
	private static final String NAME = "Directory";
	
	public DirectoryDatabase() {
		setDatabaseName(NAME);
		logger.debug("Database Name is: " + DATABASE_NAME);
	}
	
	
	
}
