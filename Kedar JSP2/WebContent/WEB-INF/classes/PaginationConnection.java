/*
 * @(#)Pagination.java 1.0 06/02/26
 *
 * You can modify the template of this file in the
 * directory ..\JCreator\Templates\Template_1\Project_Name.java
 *
 * You can also create your own project template by making a new
 * folder in the directory ..\JCreator\Template\. Use the other
 * templates as examples.
 *
 */


package myprojects.pagination;

import java.sql.*;
import javax.sql.*;
import java.io.*;
import java.util.*;


public class PaginationConnection 
{

	
		Connection con=null;
		PreparedStatement prst=null;
		ResultSet rs=null; 
		String dbURL="jdbc:mysql://localhost:3306/kapil";
		String query="select * from reportingdata";

		AppMeterBean appBean=null;
			public ArrayList getData(int counter)
			{
				ArrayList list = new ArrayList();
				try
				{
					con=getConnection();
					prst=con.prepareStatement(query,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
					rs=prst.executeQuery();
					counter = counter-1;
					int localcounter=0;
					appBean=new AppMeterBean();
					if(counter != 0)
						rs.absolute(counter*10); 
						
					else
					{
						appBean=new AppMeterBean();
						rs.absolute(1); 
						localcounter++;
						appBean.setServiceId(rs.getInt(1));
						appBean.setReportingId(rs.getInt(2));

						list.add(appBean);
					
					}
					while(rs.next())
					{
							
						appBean=new AppMeterBean();	
						localcounter++;
						appBean.setServiceId(rs.getInt(1));
						appBean.setReportingId(rs.getInt(2));
						list.add(appBean);
							
							if(localcounter==10)
							break;
						
					}
						
					rs.close();
					prst.close();
					con.close();
						
					
				}
				catch(Exception e)
				{
						System.out.println(e);
	
				}
							
				finally
				{
					
					rs=null;
					prst=null;
					con=null;
						
				}
      	
      		return list;
      	}
      	
      	public int getCount()
		{
				
				int count=0;
				try
				{
					con=getConnection();
					prst=con.prepareStatement("select count(*) from reportingdata");
					rs=prst.executeQuery();
					
					while(rs.next())
					{
							
					 count = rs.getInt(1);			
						
					}
					rs.close();
					prst.close();
					con.close();
						
					
				}
				catch(Exception e)
				{
						System.out.println(e);
	
				}
							
				finally
				{
					
					rs=null;
					prst=null;
					con=null;
						
				}
      	
      		return count;
      	}
public Connection getConnection()
{
	try
	{				
		Class.forName("com.mysql.jdbc.Driver");
		con=DriverManager.getConnection(dbURL,"root","admin");

	}
	catch(Exception e)
	{
		
		System.out.println(e);	
	}	
		return con;
}


}



