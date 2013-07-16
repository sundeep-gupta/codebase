
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<HTML>
	<HEAD>
		<TITLE>Add User</TITLE>
<script>
function checkOnSubmit(form)
{

	return true;
}
</script>

 </HEAD>
<link href="birt.css" rel="stylesheet" type="text/css">
	<BODY>
		
		<CENTER>
		  <form name=addUserForm onSubmit="return checkOnSubmit(addUserForm);" action="jmxUploadFile.jsp" method=post ENCTYPE="multipart/form-data">
          <table>
		  <tr>
		  <td colspan=2 align=center height=100><FONT FACE="verdana" SIZE=3 COLOR="red"><B> FILE UPLOAD </B></FONT><td></tr>
 <%
/*			try
			{
				//Class.forName("com.mysql.jdbc.Driver").newInstance();
				Connection C = getConnection();
				//DriverManager.getConnection("jdbc:mysql://localhost:3306/birtdb","root","password");

				Statement stmt = C.createStatement();

				String SQL = "select * from customers ";

				ResultSet rs=stmt.executeQuery(SQL);

				while(rs.next())
				{
					out.println("<option value="+rs.getString(1)+">"+rs.getString(2)+"</option>");

				}
			} 
			
			catch (Exception E)
			{
				out.println("SQLException: " + E.getMessage());
			}
*/
%>

		  <tr><td align=right height=30 class=text>File :</td>
		      <td class=text><input type=file name="uploadfile" class=text></td>
		  </tr>

		  <tr><td align=right height=30 class=text>File :</td>
		      <td class=text><input type=file name="uploadfile2" class=text></td>
		  </tr>
		  <tr><td colspan=2 align=center class=text>
		       <INPUT Type="Submit" vALUE="Upload File" class=text></td>
		  </tr>
		</table>
		</form>	
		</CENTER>
	</BODY>
</HTML>
