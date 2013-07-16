package k;

import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public class  Prj1 implements java.io.Serializable
{

	String user=null,pass=null;
	Connection con=null;

	public Prj1(){
	}

	public void setUser(String s){
		user=s.trim();
	}


	public void setPass(String s){
		pass=s.trim();
	}


	public String getUser(){
		return user;
	}

	public String getPass(){
		return pass;
	}

	



	public boolean verify(HttpSession sn){

		
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		boolean flag=false;

		try{

		con = connect();		
		pstmt = con.prepareStatement("select username,password from kuser where username=? and password=?");

		pstmt.setString(1,user);
		pstmt.setString(2,pass);
	
		rs = pstmt.executeQuery();
		flag = rs.next();

		}catch(Exception e){

			e.printStackTrace();
		}


		if(flag){
			String query =	"select k.userid," + 
						"c.firstname,c.middlename,c.lastname," + 
						"c.contactid," + 
						"d.divisionid,d.divisionname," + 
						"p.plantid,p.plantname "+ 
						"from kuser k,plant p,division d,contact c " + 
						"where k.divisionid=d.divisionid " + 
						"and k.plantid=p.plantid " + 
						"and k.userid=c.contactofid and " + 
						"k.username=?";
			try{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1,user);
			rs = pstmt.executeQuery();
			rs.next();
			sn.setAttribute("userid",Integer.valueOf(rs.getString(1)));
			sn.setAttribute("firstname",rs.getString(2));
			sn.setAttribute("middlename",rs.getString(3));
			sn.setAttribute("lastname",rs.getString(4));
			sn.setAttribute("contactid",Integer.valueOf(rs.getString(5)));
			sn.setAttribute("divisionid",Integer.valueOf(rs.getString(6)));
			sn.setAttribute("divisionname",rs.getString(7));
			sn.setAttribute("plantid",Integer.valueOf(rs.getString(8)));
			sn.setAttribute("plantname",rs.getString(9));
			sn.setAttribute("username",user);
			disconnect();
			}catch(Exception e){
				e.printStackTrace();
			}
			return true;
		}
		return false;
	}

	Connection connect(){
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:kndn","scott","tiger");
	}catch(Exception e){
		e.printStackTrace();
	}
		return con;
	}

	void disconnect(){
	try{
		con.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	}
}
