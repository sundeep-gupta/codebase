package com.ironmountain.pageobject.pageobjectrunner.connected.database.registry;

import java.sql.ResultSet;
import java.util.Date;

import org.apache.log4j.Logger;

import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.ConnectionManager;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.DatabaseServer;
import com.ironmountain.pageobject.pageobjectrunner.utils.jdbc.QueryExecutor;

public class PushedMessageTable extends RegistyDatabase{
	private static Logger  logger      = Logger.getLogger("com.imd.connected.database.registry.PushedMessageTable");
public static final String TABLE_NAME = "PUSHEDMESSAGE" ;
	
	public PushedMessageTable(DatabaseServer dbServer){
		setDatabaseServer(dbServer);
		queryExecutor = new QueryExecutor(databaseServer, DATABASE_NAME);
	}	
	public PushedMessageTable(ConnectionManager conMgr){
		queryExecutor = new QueryExecutor(conMgr, DATABASE_NAME);
	}
	public void insertExpiredMessage(String Message,String date){
		String query = "Insert into "+TABLE_NAME+" values('"+date+"' ,'admin' , '"+Message+"')";
		logger.info(query);
		queryExecutor.executeUpdate(query);
	}
	public void insertRow(String Technician,String Message,String CreateDate){
		String query = "Insert into "+TABLE_NAME+" values('"+CreateDate+"','"+Technician+"','"+Message+"')";
		//logger.info(query);
		queryExecutor.executeUpdate(query);
	}
	public void insertRowUnicode(String Technician,String Message,String CreateDate){
		String append = " collate SQL_Latin1_General_CP1_CI_AS";
		String query = "Insert into "+TABLE_NAME+" values('"+CreateDate+"','"+Technician+"',N'"+Message+"' "+append+")";
		logger.info(query);
		queryExecutor.executeUpdate(query);
	}

}
