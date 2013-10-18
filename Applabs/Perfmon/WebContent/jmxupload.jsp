<!--User Interface page for Uploading the File(Monitoringspecifications) -->
<%@ include file="escapechars.jsp" %>
<%@ include file="connection.jsp" %>
<link href="css/CFP_per.css" rel="stylesheet" type="text/css">
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<HTML>
	<HEAD>
		<TITLE>Add User</TITLE>
<script language="javascript">
function checkOnSubmit(form)
{
	var Space=/[^" "]/;
	var urlRegxp = /^(http:\/\/www.|https:\/\/www.|ftp:\/\/www.|www.){1}([\w]+)(.[\w]+){1,2}$/;


	if(form.txtCustID.selectedIndex==0)
    {
    alert("Select Customer Name"); 
	form.txtCustID.focus();
	return false;
	}
	if(form.txtSDescription.value=="" || form.txtSDescription.value.length==0 || Space.test(form.txtSDescription.value)==false)
		{
		alert("Description Should not be NULL or Empty"); 
		form.txtSDescription.focus();
		return false;
		}
	if(urlRegxp.test(form.txtSitename.value)==false || Space.test(form.txtSitename.value)==false)
		{
			alert("Enter a Valid URL for SiteName"); 
			form.txtSitename.focus();
			return false;
		}
	if(form.txtLDescription.value=="" || form.txtLDescription.value.length==0 || Space.test(form.txtLDescription.value)==false)
		{
		alert("Details Feild Should not be NULL"); 
		form.txtLDescription.focus();
		return false;
		}
	if (form.txtFrequency.value=="" || Space.test(form.txtFrequency.value)==false)
	{	
		alert("Frequency Should not be NULL or Empty"); 
		form.txtFrequency.focus();
		return false;
	}
	
	if (IsNumeric(form.txtFrequency.value)==0)
	{
		alert("Frequency Should be Numeric");
		form.txtFrequency.focus();
		return false;
	}

	if (form.uploadfile.value=="" || Space.test(form.uploadfile.value)==false)
	{	
		alert("Enter the File name to Uploaded"); 
		form.uploadfile.focus();
		return false;
	}
	if((form.uploadfile.value).search(".jmx")==-1)
	{
		alert("Invalid File Uploaded"); 
		form.uploadfile.focus();
		return false;

	}
	return true;
}

function IsNumeric(sText)
{
   var ValidChars = "0123456789.";
   var IsNumber=1;
   var Char;

 
   for (i = 0; i < sText.length && IsNumber ==1; i++) 
      { 
      Char = sText.charAt(i); 
      if (ValidChars.indexOf(Char) == -1) 
         {
         IsNumber = 0;
		 
         }
      }
   return IsNumber;
 }
</script>

 </HEAD>
<link href="birt.css" rel="stylesheet" type="text/css">
	<BODY>
		<CENTER>
		  <form name=addUserForm onSubmit="return checkOnSubmit(addUserForm);init(addUserForm);" action="jmxUploadFile.jsp" method=post ENCTYPE="multipart/form-data">
		 <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
			<tr>
			<td bgcolor="#EFF4F9" align="center">
          <table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		  <tr><td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;SERVICE SPECIFICATION</td></tr>
		<tr> 
          <td align="center" valign="middle"> 
            <table width="600" border="0" cellspacing="0" cellpadding="1" height="90">
              <tr> 
                <td width="47%"  align="right" class="fieldnames"><b>Customer Name :</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" align=left><font face="verdana" size="1"> 
                  <SELECT name="txtCustID" class="select">
				  <option value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Select Customer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
<%
    try {
        Connection C = getConnection();
        Statement stmt = C.createStatement();

        String SQL = "select * from customers order by custname";
        ResultSet rs=stmt.executeQuery(SQL);

        while(rs.next()) {
            out.println("<option value="+rs.getString(1)+">"+rs.getString(4)+"</option>");
	}
    } catch (Exception E) {
	out.println("SQLException: " + E.getMessage());
    }
%>
		</select>
			</td>
            </tr>
			 <tr> 
                <td width="47%"  align="right" class="fieldnames"><b>Service Description :</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" align=left><font face="verdana" size="1"> 
                  <input name="txtSDescription" type="text" class="textfield">
                  </font></td>
              </tr>
			  <tr> 
                <td width="47%"  align="right" class="fieldnames"><b>Site Name :</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" align=left><font face="verdana" size="1"> 
                  <input name="txtSitename" type="text" class="textfield">
                  </font></td>
              </tr>
			 <tr> 
                <td align="right" class="fieldnames" valign=top><b>Details :</b></td>
                <td width="2%">&nbsp;</td>
                <td align=left>
                <textarea cols="40" rows="5" name="txtLDescription" class="textarea"></textarea>
				</td>
              </tr>
			  <tr> 
                <td align="right" class="fieldnames"><b>Frequency : </b></td>
                <td>&nbsp;</td>
                <td align=left><font face="verdana" size="1"> 
                  <input name="txtFrequency" type="text" class="textfield">
                  </font></td>
              </tr>
			 <tr> 
                <td width="47%"  align="right" class="fieldnames"><b>JMX File :</b></td>
                <td width="2%">&nbsp;</td>
                <td width="51%" align=left><font face="verdana" size="1"> 
                  <input type=file name="uploadfile" class="textfield" >
                  </font></td>
              </tr>
			    <tr> 
                <td colspan="3" height="30" align="center"><font face="verdana" size="1"> 
                  <input type="Submit" class="Button" value="&nbsp;Submit&nbsp;">
                  </font></td>
              </tr>
		</table>
		</TD>
		</tr>
	</table>
		 </form>	
		</CENTER>
	</BODY>
</HTML>
