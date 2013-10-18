<!-- To insert the values into the table Monitoring Specifications -->
<%@ include file="escapechars.jsp" %>
<%@ include file="connection.jsp" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%!
    String replace(String s, String one, String another) {
// In a string replace one substring with another
        if (s.equals("")) return "";
        String res = "";
        int i = s.indexOf(one,0);
        int lastpos = 0;
        while (i != -1) {
            res += s.substring(lastpos,i) + another;
            lastpos = i + one.length();
            i = s.indexOf(one,lastpos);
        }
        res += s.substring(lastpos);  // the rest
        return res;  
    }
%>
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
<tr>
<td bgcolor="#EFF4F9" align="center">
<table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		<tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;SERVICE SPECIFICATION</td></tr>
		<tr> 
        <td align="center" valign="middle"> 
        <table width="350" border="0" cellspacing="0" cellpadding="1" height="90">
		<TR>
		<td class="fieldnames" ALIGN="CENTER">
<%
		//Getting the http content 
    String contentType = request.getContentType();
    if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
        DataInputStream in = new DataInputStream(request.getInputStream());
        int formDataLength = request.getContentLength();
        byte dataBytes[] = new byte[formDataLength];
        int byteRead = 0;
        int totalBytesRead = 0;
        while (totalBytesRead < formDataLength) {
            byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
            totalBytesRead += byteRead;
        }
        String file = new String(dataBytes);
        String saveFile = file.substring(file.indexOf("filename=\"") + 10);
        saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
        saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1,saveFile.indexOf("\""));
        int lastIndex = contentType.lastIndexOf("=");
        String boundary = contentType.substring(lastIndex + 1,contentType.length());
        int pos;
        pos = file.indexOf("filename=\"");
        pos = file.indexOf("\n", pos) + 1;
        pos = file.indexOf("\n", pos) + 1;
        pos = file.indexOf("\n", pos) + 1;
        int boundaryLocation = file.indexOf(boundary, pos) - 4;
        int startPos         = ((file.substring(0, pos)).getBytes()).length;
        int endPos           = ((file.substring(0, boundaryLocation)).getBytes()).length;
        String path = "C:\\Program Files\\Apache Group\\Tomcat 4.1\\webapps\\Perfmon\\Files\\"+saveFile;
		
		/*out.println(startPos+"  "+lastIndex+" "+file.lastIndexOf('-'));
        out.println(file.substring(startPos,file.length()-46)); */
        int custidpos       = file.indexOf("txtCustID\"");
        int custidlastpos   = file.indexOf("-",custidpos);
        int sitepos         = file.indexOf("txtSitename\"");
        int sitelastpos     = file.indexOf("-",sitepos);
        int frqpos          = file.indexOf("txtFrequency\"");
        int frqlastpos      = file.indexOf("-",frqpos);
        int sdespos         = file.indexOf("txtSDescription\"");
        int sdeslaspos      = file.indexOf("-",sdespos);
        int ldespos         = file.indexOf("txtLDescription\"");
        int ldeslaspos      = file.indexOf("-",ldespos);
        String cid          = file.substring(custidpos+14,custidlastpos-2);
        String sitename     = file.substring(sitepos+14,sitelastpos-2);
        //rtrim(cid);
        int custid = Integer.parseInt(cid);
        //out.println(custid);
        String frq = file.substring(frqpos+17,frqlastpos-2);
        int ifrq=Integer.parseInt(frq);
        //out.println(frq);
        /* After identifying the contents of the Uploaded file write into the folder in the application */
        String sdescription =file.substring(sdespos+20,sdeslaspos-2);
        sdescription=sdescription.trim();
        Connection C1 = getConnection();
        //DriverManager.getConnection("jdbc:mysql://localhost:3306/birtdb","root","password");
        Statement stmt1 = C1.createStatement();
        String SqlCheck="select count(*) as rowcount from monitoringspecifications where sdescription='"+sdescription+"'";
        ResultSet rs1=stmt1.executeQuery(SqlCheck);
        rs1.next();
        int ResultCount = rs1.getInt("rowCount") ;
        if(ResultCount>=1) {
            C1.close();
%>
				<b>Service Description already exists in the Data Base</b><br>
				<a href="javascript:history.back()"><u> Back to Service Specification</a>
<%
        } else {
            C1.close();
            String ldescription =file.substring(ldespos+20,ldeslaspos-2);
            //ldescription=replace(ldescription,"\n","<br>");
            ldescription=ldescription.trim();
            file = file.substring(startPos,file.length()-48);
            byte dataBytes1[] = file.getBytes();
            FileOutputStream fileOut = new FileOutputStream(path);
            fileOut.write(dataBytes1);
            fileOut.flush();
            fileOut.close();
            FileInputStream fis = new FileInputStream(path); 
            BufferedInputStream bis = new BufferedInputStream(fis); 
            DataInputStream dis = new DataInputStream(bis);
            String record="";
            String str = "";
            while((record=dis.readLine()) != null) {
					//out.println(record);
		str+= record;
            }
            str = single(file);
            str=str.trim();
	//Inseting the values from the form into database
            try {
                //Class.forName("com.mysql.jdbc.Driver").newInstance();
                Connection C = getConnection();
                //DriverManager.getConnection("jdbc:mysql://localhost:3306/birtdb","root","password");
                Statement stmt = C.createStatement();
                String SQL = "insert into monitoringspecifications(CUSTID,FREQUENCY,SDESCRIPTION,LDESCRIPTION,SCRIPT,SITENAME) values("+custid+","+ifrq+",'"+sdescription+"','"+ldescription+"','"+str+"','"+sitename.trim()+"')";
                //out.println(SQL);
                int i=stmt.executeUpdate(SQL); 
                if(i>0) {
%>
								<b>File Uploaded Successfully</b><br><b><br>				
								 <table>
								 <tr><td class="fieldnames" align=right> Frequency   : </td><td class="fieldnames" ><%=ifrq%></td></tr>
								 <tr><td class="fieldnames" align=right> Description : </td><td class="fieldnames"><%=sdescription%></td></tr>
								<tr><td class="fieldnames" align=right> Site Name : </td><td class="fieldnames"><%=sitename%></td></tr>
								 <tr><td class="fieldnames" align=right valign="top"> Details : </td><td class="fieldnames"><%=ldescription%></td></tr>
								 </table>
								 <br><br><a href="jmxupload.jsp">Back to Service Specification</a> 
<%
                }
            } catch (Exception E) {
		E.printStackTrace();
            }
	}
    }
%>