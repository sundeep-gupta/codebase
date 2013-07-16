package k;


import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.Calendar;

public class Prj2 implements java.io.Serializable{

	String groupname,shortname,address1,address2,address3,city,county,state,zip,country,phone,tollfreenumber,fax,website,description,d1;
	String group,name,createdby,creditlimit,collectiontype,latelimit,creditstatus,terms,creditstatusdetail;
	String cstmr,firstname,middlename,lastname,title,type,phone1,phone2,extn1,extn2,fax1,fax2,email,modeofcontact,comments,mobile;
	int donotsolicit;
	char gender;
	double climit;
	int llimit,ctype,gid;
	char cstatus;
	java.sql.Date date1;
	String esrch1,esrch2,esrch3,esrch4,esrch5;
	String back;
	Connection con=null;


	public void setGroupname(String s){
		groupname=s.trim();
	}


	public void setShortname(String s){
		shortname=s.trim();
	}

	public void setAddress1(String s){
		address1=s.trim();
	}

	public void setAddress2(String s){
		address2=s.trim();
	}

	public void setAddress3(String s){
		address3=s.trim();
	}

	public void setCity(String s){
		city=s.trim();
	}


	public void setCounty(String s){
		county=s.trim();
	}

	public void setState(String s){
		state=s.trim();
	}

	public void setZip(String s){
		zip=s.trim();
	}

	public void setCountry(String s){
		country=s.trim();
	}

	public void setPhone(String s){
		phone=s.trim();
	}

	public void setTollfreenumber(String s){
		tollfreenumber=s.trim();
	}

	public void setFax(String s){
		fax=s.trim();
	}


	public void setWebsite(String s){
		website=s.trim();
	}

	public void setDescription(String s){
		description=s.trim();
	}

	public void setEsrch1(String s){
		esrch1=s.trim();
	}

	public void setEsrch2(String s){
		esrch2=s.trim();
	}

	public void setEsrch3(String s){
		esrch3=s.trim();
	}

	public void setEsrch4(String s){
		esrch4=s.trim();
	}

	public void setEsrch5(String s){
		esrch5=s.trim();
	}

	public void setBack(String s){
		back=s.trim();
	}

	public void setDate1(java.sql.Date s){
		date1=s;
	}

	public void setGroup(String s){
		group=s.trim();
	}

	public void setName(String s){
		name=s.trim();
	}

	public void setCreatedby(String s){
		createdby=s.trim();
	}

	public void setCreditlimit(String s){
		creditlimit=s.trim();
	}

	public void setCollectiontype(String s){
		collectiontype=s.trim();
		collectiontype=collectiontype.toLowerCase();
	}

	public void setLatelimit(String s){
		latelimit=s.trim();
	}

	public void setCreditstatus(String s){
		creditstatus=s.trim();
	}

	public void setTerms(String s){
		terms=s.trim();
	}
	
	public void setCreditstatusdetail(String s){
		creditstatusdetail=s.trim();
	}

	public void setFirstname(String s){
		firstname=s.trim();
	}

	public void setMiddlename(String s){
		middlename=s.trim();
	}
	public void setLastname(String s){
		lastname=s.trim();
	}
	public void setTitle(String s){
		title=s.trim();
	}
	public void setGender(String s){
		gender=s.charAt(0);
	}
	public void setPhone1(String s){
		phone1=s.trim();
	}
	public void setPhone2(String s){
		phone2=s.trim();
	}
	public void setExtn1(String s){
		extn1=s.trim();
	}
	public void setExtn2(String s){
		extn2=s.trim();
	}
	public void setMobile(String s){
		mobile=s.trim();
	}
	public void setFax1(String s){
		fax1=s.trim();
	}
	public void setFax2(String s){
		fax2=s.trim();
	}
	public void setEmail(String s){
		email=s.trim();
	}
	public void setModeofcontact(String s){
		modeofcontact=s.trim();
	}
	public void setDonotsolicit(String s){
	try{
		donotsolicit=Integer.parseInt(s);
	}catch(Exception e){	
	}
	}
	public void setComments(String s){
		comments=s.trim();
	}
	public void setCstmr(String s){
		cstmr=s.trim();
	}
	public void setType(String s){
		type=s.trim();
	}



	



	public String getGroupname(){
		return groupname;
	}

	public String getShortname(){
		return shortname;
	}

	public String getAddress1(){
		return address1;
	}

	public String getAddress2(){
		return address2;
	}

	public String getAddress3(){
		return address3;
	}
	public String getCity(){
		return city;
	}

	public String getCounty(){
		return county;
	}

	public String getState(){
		return state;
	}

	public String getZip(){
		return zip;
	}

	public String getCountry(){
		return country;
	}

	public String getPhone(){
		return phone;
	}

	public String getTollfreenumber(){
		return tollfreenumber;
	}

	public String getFax(){
		return fax;
	}

	public String getWebsite(){
		return website;
	}

	public String getDescription(){
		return description;
	}

	public String getEsrch1(){
		return esrch1;
	}

	public String getEsrch2(){
		return esrch2;
	}

	public String getEsrch3(){
		return esrch3;
	}

	public String getEsrch4(){
		return esrch4;
	}

	public String getEsrch5(){
		return esrch5;
	}

	public String getBack(){
		return back;
	}

	public java.sql.Date getDate1(){
		return date1;
	}
	
	public String getD1(){
		return d1;
	}

	public String getGroup(){
		return group;
	}
	public String getName(){
		return name;
	}
	public String getCreatedby(){
		return createdby;
	}
	public String getCollectiontype(){
		return collectiontype;
	}
	public String getCreditstatusdetail(){
		return creditstatusdetail;
	}
	public String getTerms(){
		return terms;
	}


	


	public boolean addcg(){

		Statement st; 
		ResultSet rs;
		int temp=-1,res[];
		
	try{
		con=connect();
		st = con.createStatement();

		temp = st.executeUpdate("insert into customergroup(groupname,shortname,description,creationdate) values('"+groupname+"','"+shortname+"','"+description+"',sysdate)");	
		if(temp==1){

			rs = st.executeQuery("select max(customergroupid) from customergroup");
			rs.next();
			temp = rs.getInt(1);
			temp = st.executeUpdate("insert into contact(contactofid,contactcategory,address1,address2,address3,city,county,state,zip,country,phone1,tollfreenumber,fax1,website,entrydate) values("+temp+",'CUST_GROUP','"+address1+"','"+address2+"','"+address3+"','"+city+"','"+county+"','"+state+"','"+zip+"','"+country+"','"+phone+"','"+tollfreenumber+"','"+fax+"','"+website+"',sysdate)");
		}

		st.close();
		disconnect();
		if(temp==1)
			return true;
		else 
			return false;


	}catch(Exception e){
		e.printStackTrace();
		return false;
	}
	}



	public boolean addcg1(){
		Statement st=null;
		ResultSet rs=null;
		int temp=-100;
		

	try{
		try{

		llimit=Integer.parseInt(latelimit);
		}catch(Exception e){
			System.out.print("integer");
			e.printStackTrace();
		}

		try{
		climit=Double.parseDouble(creditlimit);

		}catch(Exception e){
			System.out.print("double");
			e.printStackTrace();
		}

		con = connect();
		st = con.createStatement();
		
		try{
		rs=st.executeQuery("select collectiontypeid from customercollectiontype where collectiontypename='"+collectiontype+"'");
		rs.next();
		ctype=rs.getInt(1);
		}catch(Exception e){
			System.out.println("first select");
			e.printStackTrace();
		}

		if(creditstatus.equalsIgnoreCase("positive"))
			cstatus='0';
		else
			cstatus='1';
		try{
		rs=st.executeQuery("select customergroupid from customergroup where groupname='"+group+"'");
		rs.next();
		gid=rs.getInt(1);
		}catch(Exception e){
			System.out.println("second select");
			e.printStackTrace();
		}



		temp = st.executeUpdate("insert into customer(customername,terms,collectiontypeid,creditstatus,creditstatusdetail,creditlimit,latelimit,customergroupid,description,createdby,creationdate) values('"+name+"','"+terms+"',"+ctype+",'"+cstatus+"','"+creditstatusdetail+"',"+climit+","+llimit+","+gid+",'"+description+"',1,sysdate)");	

		st.close();
		disconnect();
	
		if(temp==1)	
			return true;
		else 
			return false;

	}catch(Exception e){
		e.printStackTrace();
	}
		return false;
	}



	public void srchcg(JspWriter out){
	
	Statement st;
	String qry=null,x=null,y=null,op1=null,op2=null,op3=null;
	ResultSet rs=null;
	int count=1;

	try{
	
		con = connect();
		st = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);

		if((this.esrch2!=null) && !(this.esrch2.equals("")))	
			qry="select cg.customergroupid,cg.groupname,cg.shortname,c.phone1 from customergroup cg,contact c where cg.shortname like '%"+esrch2+"%' and cg.customergroupid=c.contactofid and c.contactcategory='CUST_GROUP'";
		if((this.esrch1!=null) && !(this.esrch1.equals("")))
			qry="select cg.customergroupid,cg.groupname,cg.shortname,c.phone1 from customergroup cg,contact c where cg.groupname like '%"+esrch1+"%' and cg.customergroupid=c.contactofid and c.contactcategory='CUST_GROUP'";

		rs = st.executeQuery(qry);

		if(!rs.next()){
			out.println("</table><br><br><table><center>Sorry no customer group matches with the info provided </center>");
		}else{

			if(back.equals("edit")){
				op1 = "<td align=\"center\"> <a name=\"";
				op2 = "\" onclick=\"javascript:go1(name)\"> <img src=\"images/edit-16x16.gif\"> ";
				op3 = "</a> </td> ";	  
			}
			if(back.equals("srch")){
				op1 = "<td align=\"center\" name=\"";
				op2 = "\" onclick=\"javascript:go1(name)\"> ";
				op3 = "</td> ";
				
			}
			rs.beforeFirst();
			
			while(rs.next()){
	
				out.print("<tr>" + 
					  "<td align=\"center\">" + count + "</td>"+
					  op1 + rs.getInt(1) + op2 + rs.getInt(1)  + op3 + 
					  "<td>" + rs.getString(2) + "</td>"+
					  "<td>" + rs.getString(3) + "</td>"+
					  "<td align=\"center\">" + rs.getString(4) + "</td>"+
					  "</tr>");

				count++;
			}
		}
		disconnect();

	}catch(Exception e){
		e.printStackTrace();
	}
	}

	public void srchcg1(){

		ResultSet rs=null;
		Statement st=null;
		int use=-1000;
		String temp=null;
	try{
		use=change();
		
		con = connect();
		st = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);

		rs = st.executeQuery("select cg.groupname,cg.shortname,cg.description,c.address1,c.address2,c.address3,c.city,c.county,c.state,c.zip,c.country,c.phone1,c.tollfreenumber,c.fax1,c.website,cg.creationdate from customergroup cg,contact c where cg.customergroupid="+use+" and cg.customergroupid=c.contactofid and c.contactcategory='CUST_GROUP'");
		rs.next();

		this.groupname=rs.getString(1);
		this.shortname=rs.getString(2);
		this.description=rs.getString(3);
		this.address1=rs.getString(4);
		this.address2=rs.getString(5);
		this.address3=rs.getString(6);
		this.city=rs.getString(7);
		this.county=rs.getString(8);
		this.state=rs.getString(9);
		this.zip=rs.getString(10);
		this.country=rs.getString(11);
		this.phone=rs.getString(12);
		this.tollfreenumber=rs.getString(13);
		this.fax=rs.getString(14);
		this.website=rs.getString(15);
		this.date1=rs.getDate(16);

		temp = date1.toString();
		d1 = temp.substring(5,7);
		d1 += "/";
		d1 += temp.substring(8);
		d1 += "/";
		d1 += temp.substring(0,4);
		
/*		if(shortname.equals("null"))		this.shortname=" ";
		if(description.equals("null"))		this.description=" ";
		if(address2.equals("null"))		this.address2=" ";
		if(address3.equals("null"))		this.address3=" ";
		if(county.equals("null"))		this.county=" ";
		if(phone.equals("null"))		this.phone=" ";
		if(tollfreenumber.equals("null"))	this.tollfreenumber=" ";
		if(fax.equals("null"))			this.fax=" ";
		if(website.equals("null"))		this.website=" ";		
*/



		disconnect();

	}catch(Exception e){
		e.printStackTrace();
	}

	}

	
	public void srchcg2(){

		ResultSet rs1=null,rs2=null;
		Statement st1=null,st2=null;
		int use=-1000;
		Calendar c=Calendar.getInstance();

	try{


		use=change();
		
		con = connect();
		st1 = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		st2 = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);


		rs1 = st1.executeQuery("select cg.groupname,cg.shortname,cg.description,cg.creationdate from customergroup cg where cg.customergroupid="+use+"");
		rs2 = st2.executeQuery("select c.address1,c.address2,c.address3,c.city,c.county,c.state,c.zip,c.country,c.phone1,c.tollfreenumber,c.fax1,c.website,c.entrydate from contact c where c.contactofid="+use+" and c.contactcategory='CUST_GROUP'");

		rs1.next();
		rs2.next();

		rs1.updateString(1,groupname);
		rs1.updateString(2,shortname);
		rs1.updateString(3,description);
		rs1.updateDate(4,new java.sql.Date(c.get(Calendar.YEAR),c.get(Calendar.MONTH)+1,c.get(Calendar.DATE)));
		rs2.updateString(1,address1);
		rs2.updateString(2,address2);
		rs2.updateString(3,address3);
		rs2.updateString(4,city);
		rs2.updateString(5,county);
		rs2.updateString(6,state);
		rs2.updateString(7,zip);
		rs2.updateString(8,country);
		rs2.updateString(9,phone);
		rs2.updateString(10,tollfreenumber);
		rs2.updateString(11,fax);
		rs2.updateString(12,website);
		rs2.updateDate(13,new java.sql.Date(c.get(Calendar.YEAR),c.get(Calendar.MONTH)+1,c.get(Calendar.DATE)));
		rs1.updateRow();
		rs2.updateRow();
		

		st1.close();
		st2.close();

		disconnect();

	}catch(Exception e){
		e.printStackTrace();
	}
	}

	int change(){
		int k=-1000;
	try{
		k = Integer.parseInt(esrch5);
	}catch(Exception e){
		e.printStackTrace();
	}
		return k;
	}

	public void grpsrch(JspWriter out){

		Statement st=null;
		ResultSet rs=null;

	
	try{
		con = connect();
		st = con.createStatement();
		rs = st.executeQuery("select groupname,shortname from customergroup");

		while(rs.next()){
			out.print("<tr><td> <input type=\"radio\" name=\"grp\" value=\"" + rs.getString(1) + "\"> </td> <td>" + rs.getString(1) + "</td> <td>" + rs.getString(2) + "</td> </tr>");
		}

	}catch(Exception e){
		e.printStackTrace();
	}
	}


	public boolean addcstmr1(){
		ResultSet rs=null;
		Statement st=null;
		int temp1,temp;
		
	try{
		
		con = connect();
		st = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		rs = st.executeQuery("select customerid from customer where customername='"+cstmr+"'");
		rs.next();
		temp=rs.getInt(1);
		rs.beforeFirst();
		while(rs.next()){
			if(rs.getInt(1)>temp)
				temp=rs.getInt(1);
		}



		temp1=st.executeUpdate("insert into contact values("+temp+","+temp+",'"+type+"','CUSTOMER','"+title+"','"+gender+"',sysdate,'"+firstname+"','"+middlename+"','"+lastname+"','"+address1+"','"+address2+"','"+address3+"','"+city+"','"+county+"','"+state+"','"+zip+"','"+country+"','"+phone1+"','"+extn1+"','"+phone2+"','"+extn2+"','"+mobile+"','"+fax1+"','"+fax2+"','"+email+"','"+website+"','"+modeofcontact+"','"+comments+"','"+tollfreenumber+"',"+donotsolicit+",sysdate)");
		disconnect();	

		if(temp1==1)
			return true;
		else 
			return false;
	
	
	}catch(Exception e){
		e.printStackTrace();
	}
		return false;
	}

	


	public Connection connect(){
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:kndn","scott","tiger");
	}catch(Exception e){
		e.printStackTrace();
	}
		return con;
	}

	public void disconnect(){
	try{
		con.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	}



}