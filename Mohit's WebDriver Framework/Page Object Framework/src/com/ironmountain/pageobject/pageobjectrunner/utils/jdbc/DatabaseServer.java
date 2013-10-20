package com.ironmountain.pageobject.pageobjectrunner.utils.jdbc;

import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;

/**
 * @author Jinesh Devasia
 * 
 * The enum type which refers to the ConnectionServers, DatabaseServer actually refers the database server entity.
 * if you need to connect to different databases then each database must be referred as a DatabaseServer. 
 * (If we need a new Database then create a DatabaseServer here with a new name)
 *
 */
public enum DatabaseServer {


	/*
	 * Connection to a common database, if the framework/tests need to connect only to a single DB then can use this connection type.
	 */
	COMMON_SERVER("Common Database Server"){
		public String getServerType() {
			return PropertyPool.getProperty("DBServerType");
		}
		public String getDbDriver() {
			return PropertyPool.getProperty("DBDriver");
		}
		public String getDbServerUrl() {
			return PropertyPool.getProperty("DBServerUrl");
		}
		public String getPort() {
			return PropertyPool.getProperty("DBPort");
		}
		public String getUserName() {
			return PropertyPool.getProperty("DBUsername");
		}		
		public String getPassword() {
			return PropertyPool.getProperty("DBPassword");
		}
	},	
	/*
	 * Represents a Primary database server
	 * Useful for test cases which need to be tested in a mirrored database setup.
	 */
	PRIMARY_SERVER("Primary Database Server"){
		public String getServerType() {
			return PropertyPool.getProperty("PrimaryServerType");
		}
		public String getDbDriver() {
			return PropertyPool.getProperty("PrimaryServerDBDriver");
		}

		public String getDbServerUrl() {
			return PropertyPool.getProperty("PrimaryServerDBServerUrl");
		}
		public String getPort() {
			return PropertyPool.getProperty("PrimaryServerDBPort");
		}
		public String getUserName() {
			return PropertyPool.getProperty("PrimaryServerDBUsername");
		}
		
		public String getPassword() {
			return PropertyPool.getProperty("PrimaryServerDBPassword");
		}
	},
	/*
	 * Represents a Secondary database server
	 * Useful for test cases which need to be tested in a mirrored database setup.
	 */
	SECONDARY_SERVER("Secondary Database Server"){
		public String getServerType() {
			return PropertyPool.getProperty("SecondaryServerType");
		}
		public String getDbDriver() {
			return PropertyPool.getProperty("SecondaryServerDBDriver");
		}

		public String getDbServerUrl() {
			return PropertyPool.getProperty("SecondaryServerDBServerUrl");
		}
		public String getPort() {
			return PropertyPool.getProperty("SecondaryServerDBPort");
		}
		public String getUserName() {
			return PropertyPool.getProperty("SecondaryServerDBUsername");
		}
		
		public String getPassword() {
			return PropertyPool.getProperty("SecondaryServerDBPassword");
		}
	}, 
	
	
	PRIMARY_REGISTRY_SERVER("Primary Registry Database Server"){
		public String getServerType() {
			return PropertyPool.getProperty("PrimaryRegistryType");
		}
		public String getDbDriver() {
			return PropertyPool.getProperty("PrimaryRegistryDBDriver");
		}

		public String getDbServerUrl() {
			return PropertyPool.getProperty("PrimaryRegistryDBUrl");
		}
		public String getPort() {
			return PropertyPool.getProperty("PrimaryRegistryDBPort");
		}
		public String getUserName() {
			return PropertyPool.getProperty("PrimaryRegistryDBUsername");
		}
		
		public String getPassword() {
			return PropertyPool.getProperty("PrimaryRegistryDBPassword");
		}
	},	
	SECONDARY_REGISTRY_SERVER("Secondary Registry Database Server"){
		public String getServerType() {
			return PropertyPool.getProperty("SecondaryRegistryType");
		}
		public String getDbDriver() {
			return PropertyPool.getProperty("SecondaryRegistryDBDriver");
		}

		public String getDbServerUrl() {
			return PropertyPool.getProperty("SecondaryRegistryDBUrl");
		}
		public String getPort() {
			return PropertyPool.getProperty("SecondaryRegistryDBPort");
		}
		public String getUserName() {
			return PropertyPool.getProperty("SecondaryRegistryDBUsername");
		}
		
		public String getPassword() {
			return PropertyPool.getProperty("SecondaryRegistryDBPassword");
		}
	},
	
	PRIMARY_DIRECTORY_SERVER("Primary Directory Database Server"){
		public String getServerType() {
			return PropertyPool.getProperty("PrimaryDirectoryType");
		}
		public String getDbDriver() {
			return PropertyPool.getProperty("PrimaryDirectoryDBDriver");
		}

		public String getDbServerUrl() {
			return PropertyPool.getProperty("PrimaryDirectoryDBUrl");
		}
		public String getPort() {
			return PropertyPool.getProperty("PrimaryDirectoryDBPort");
		}
		public String getUserName() {
			return PropertyPool.getProperty("PrimaryDirectoryDBUsername");
		}
		
		public String getPassword() {
			return PropertyPool.getProperty("PrimaryDirectoryDBPassword");
		}
	},	
	SECONDARY_DIRECTORY_SERVER("Secondary Directory Database Server"){
		public String getServerType() {
			return PropertyPool.getProperty("SecondaryDirectoryType");
		}
		public String getDbDriver() {
			return PropertyPool.getProperty("SecondaryDirectoryDBDriver");
		}

		public String getDbServerUrl() {
			return PropertyPool.getProperty("SecondaryDirectoryDBUrl");
		}
		public String getPort() {
			return PropertyPool.getProperty("SecondaryDirectoryDBPort");
		}
		public String getUserName() {
			return PropertyPool.getProperty("SecondaryDirectoryDBUsername");
		}
		
		public String getPassword() {
			return PropertyPool.getProperty("SecondaryDirectoryDBPassword");
		}
	},
	/*
	 * Represents a SQLLite Database server.
	 */
	SQLLITE_DB("Sqllite DB"){
		public String getServerType() {
			return PropertyPool.getProperty("ServerName");
		}
		public String getDbDriver() {
			return PropertyPool.getProperty("");
		}

		public String getDbServerUrl() {
			return PropertyPool.getProperty("");
		}
		public String getPort() {
			return PropertyPool.getProperty("DBPort");
		}
		public String getUserName() {
			return PropertyPool.getProperty("");
		}
		
		public String getPassword() {
			return PropertyPool.getProperty("");
		}
	};
	
	private String dbDriver ;
	private String dbServerUrl ;
	private String userName ;
	private String password ;
	private String port;
	/*
	 * This represents the Database Server in use, (MS SQL, Oracle, SQLLite, MySQL, Postgress...)
	 */
	private String connectionServerType ;
	
	
	private DatabaseServer(String dbServerName) {
		setServerType(dbServerName);
	}
	
	private void setServerType(String dbServerName) {
		connectionServerType = dbServerName ;		
	}
	public String getServerType() {
		return connectionServerType;
	}
	
	public String getDbDriver() {
		return dbDriver;
	}

	public String getDbServerUrl() {
		return dbServerUrl;
	}
	public String getPort() {
		return port;
	}

	public String getUserName() {
		return userName;
	}
	
	public String getPassword() {
		return password;
	}

	
}
