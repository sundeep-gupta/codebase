/*
 * DatabaseBean.java
 *
 * Created on May 28, 2006, 4:23 PM
 */

package com.bookstore.beans;

import java.beans.*;
import java.io.Serializable;
import java.sql.*;

/**
 * @author Sundeep Gupta
 */
public class DatabaseBean extends Object implements Serializable {
    
    
     /* Database Driver class*/
    private String dbDriver  ="sun.jdbc.odbc.JdbcOdbcDriver";

     /*URI of Database */
    private String sUrl = "jdbc:odbc:bookstore";

  /*User name and password */
  private String userName="";
  private String password="";
  
    public static final String PROP_SAMPLE_PROPERTY = "sampleProperty";
    
    private Connection connection = null;
   
    /* TODO: Remove Exception with all appropriate exception */
    public DatabaseBean() throws Exception{
        Class.forName(dbDriver).newInstance();
        connection = DriverManager.getConnection(sUrl , userName, password);
    }
    
    public Connection getConnection() {
        return connection;
    }
    
    public ResultSet execute(String sql) throws Exception {
        return connection.createStatement().executeQuery(sql);
    }
    
    String[] getFieldNames ( java.sql.ResultSet rs ) throws java.sql.SQLException {
	  /* Get the information about the ResultSet */
    java.sql.ResultSetMetaData metaData = rs.getMetaData();
    String[] aFields = new String[metaData.getColumnCount()];
    for(int j = 0; j < aFields.length; j++) {
      aFields[j] = metaData.getColumnLabel(j+1);
    }
    return aFields;
  }
    
    
}
