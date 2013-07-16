package com.ironmountain.pageobject.pageobjectrunner.connected.database.registry;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.connected.database.DataBase;

public class RegistyDatabase extends DataBase{
	
	private static Logger  logger      = Logger.getLogger("com.imd.connected.database.registry.RegistyDatabase");
	private static final String NAME = "Registry";
	
	public RegistyDatabase() {
		setDatabaseName(NAME);
		logger.debug("Database Name is: " + DATABASE_NAME);
	}
	
	
	
}
