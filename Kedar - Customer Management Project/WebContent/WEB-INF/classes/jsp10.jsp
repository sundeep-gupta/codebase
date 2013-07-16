<html>

<head> <title> View Customer Group </title> 
<%@ page import="java.sql.*,java.util.Calendar" %>

<script language="javascript">
<!--
	function cl(){
		history.back();
	}

	function save(){


		if(document.addcg.groupname.value==""){
			alert("Please enter group name");
			document.addcg.groupname.focus();
			return;
		}
		
		if(document.addcg.address1.value==""){
			alert("Please enter address1");
			document.addcg.address1.focus();
			return;
		}

		if(document.addcg.city.value==""){
			alert("Please enter city");
			document.addcg.city.focus();
			return;
		}

		if(document.addcg.zip.value==""){
			alert("Please enter zip");
			document.addcg.zip.focus();
			return;
		}

		
		document.addcg.submit();
	}
//-->
</script>
</head>

<jsp:useBean id="obj" class="k.Prj2" scope="request" />
<jsp:setProperty name="obj" property="esrch5" param="use" />

<% 	
	obj.srchcg1();
%>

<body>

<b> View Customer Group </b>
<br> <br>

<table border="2">
<form name="addcg" action="/kndn/jsp8">
<input type="hidden" name="use" value="<%= request.getParameter("use") %>">
<tr>
<td>
<table border="0" >
<tr>
	<td>
		<table width="750" border="0">
		<tr>
			<td align="center"> <b> Customer Group Details </b> </td>
		</tr>
		<tr>
			<td> &nbsp; </td>
		</tr>
		</table>
	</td>
</tr>

<tr>
	<td>
		<table width="750" border="0" cellspacing="5" cellpadding="0">
		<tr>	
			<td width="180"> Group Name &nbsp; &nbsp; </td>
			<td width="180"> <%= obj.getGroupname() %> &nbsp; </td>
			<td width="180"> Short Name  </td>
			<td width="180" align="left"> <%= obj.getShortname() %> </td>
		</tr>

		<tr>
			<td> Creation Date </td>
			<td> <%= obj.getD1() %> </td>
		</tr>
			
		</table>

	</td>
</tr>

<tr>
	<td> <hr> </td>
</tr>

<tr>
	<td> &nbsp; </td>
</tr>			

<tr>
	<td> <b> Address Details </b> </td>
</tr>
	
<tr>
	<td> &nbsp; </td>
</tr>

<tr>
	<td>
		<table width="750" border="0" cellspacing="5" cellpadding="5">

		<tr>	
			<td align="left" width="180"> Address  &nbsp; &nbsp; &nbsp;  </td>
			<td align="left" colspan="3"> <%= obj.getAddress1() %>  ,	<%= obj.getCity() %>
				<br>	<%= obj.getCounty() %>	,	<%= obj.getState() %>   &nbsp; 	<%= obj.getZip() %>
				<br>	<%= obj.getCountry() %> 
			</td>
			
		</tr>
		
				
		<tr>
			<td align="left"> Phone &nbsp; &nbsp; &nbsp;  </td>
			<td align="left" width="180"> <%= obj.getPhone() %> </td>
			<td align="left" width="180"> Toll Free Number </td>
			<td align="left"> <%= obj.getTollfreenumber() %> </td>
		</tr>

		<tr>
			<td align="left"> Fax &nbsp; &nbsp; &nbsp;  </td>
			<td align="left"> <%= obj.getFax() %> </td>
			<td align="left"> Web-site &nbsp; &nbsp;  </td>
			<td align="left"> <%= obj.getWebsite() %> </td>
		</tr>

		<tr>
			<td> Description </td>
			<td colspan="3"> <%= obj.getDescription() %>  </td>
		</tr>

		

		</table>

	</td>
</tr>

<tr>
	<td> &nbsp; </td>
</tr>
<tr>
	<td>
		<center>
			<a href="javascript:cl()"> Back </a> 
		</center>
	</td>
</tr>
</table>	
</td>
</tr>
</form>
</table>

</body>

</html>