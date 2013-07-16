<HTML>
	<HEAD>
		<TITLE>Add Agents</TITLE>
<script>
<%function checkOnSubmit(form)
{

if(isNaN(form.txtAgentID.value) || form.txtAgentID.value=="")
    {
    alert("Enter Valid AgentID"); 
	form.txtAgentID.focus();
	return false;
	}

if(!validateIP(form.txtIp.value)) 
    {
    alert("Enter Valid IP Address"); 
	form.txtIp.focus();
	return false;
	}

	return true;
}

function validateIP(what) {
    if (what.search(/^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/) != -1) {
        var myArray = what.split(/\./);
        if (myArray[0] > 255 || myArray[1] > 255 || myArray[2] > 255 || myArray[3] > 255)
            return false;
        if (myArray[0] == 0 && myArray[1] == 0 && myArray[2] == 0 && myArray[3] == 0)
            return false;

		if (myArray[0] == 255 && myArray[1] == 255 && myArray[2] == 255 && myArray[3] == 255)
            return false;

		return true;
    }
    else
        return false;
}
%>
</script>
 </HEAD>
<link href="birt.css" rel="stylesheet" type="text/css">
	<BODY>
		
		<CENTER>
		  <form name=addAgentsForm onSubmit="return checkOnSubmit(addAgentsForm);" method=post action="addAgents.jsp">
          <table>
		  <tr>
		  <td colspan=2 align=center height=100><FONT FACE="verdana" SIZE=3 COLOR="red"><B> ADD AGENT </B></FONT><td></tr>
		  
		  <tr><td align=right height=30 class=text>HostName :</td>
			  <td class=text><INPUT TYPE="Text" name="txtHostName" class=text></td>
		  </tr>

		  
		  <tr><td align=right height=30 class=text>IP Address :
			  <td class=text><INPUT TYPE="text" Size=20 name="txtIp" class=text></td>
		  </tr>

		  <tr><td align=right height=30 class=text>CityID :</td>
			  <td class=text><select name=selectCityId class=text>
			   <option value="">City ID</option>

<%

try
	{
		Class.forName("com.mysql.jdbc.Driver").newInstance();
	}
	catch (Exception E)
	{
		E.printStackTrace();
	}
	try
	{
		Connection C = DriverManager.getConnection("jdbc:mysql://localhost:3306/newbirtdb","root","password");

		Statement stmt = C.createStatement();



		String SQL = "select Cityid from cities";

		ResultSet rs=stmt.executeQuery(SQL);

		while(rs.next())
		{
			out.println("<option value='"+rs.getString(1)+"'>"+rs.getString(1)+"</option>");

		}
    } 
	
    catch (Exception E)
	{
		out.println("SQLException: " + E.getMessage());
    }
			   %>


			   </select>
		  </td>
		  </tr>


		  
		  <tr><td colspan=2 align=center class=text>
		       <INPUT Type="Submit" Value="ADD AGENT" class=text></td>
		  </tr>
		</table>
		</form>	
		</CENTER>
	</BODY>
</HTML>