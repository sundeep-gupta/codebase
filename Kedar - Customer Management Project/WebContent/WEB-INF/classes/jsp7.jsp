<html>

<head> <title> Edit Customer Group </title> 
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
	Calendar c = Calendar.getInstance();
	
%>

<% 	
	obj.srchcg1();
%>

<body>

<b> Edit Customer Group </b>
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
		<table width="750" border="0" cellspacing="0" cellpadding="1">
		<tr>	
			<td> Group Name &nbsp; &nbsp; </td>
			<td> <input type="text" name="groupname" value="<%= obj.getGroupname() %>" > </td>
			<td> Short Name  </td>
			<td align="center"> <input type="text" name="shortname" value="<%= obj.getShortname() %>" > </td>
		</tr>

		<tr>
			<td> Creation Date </td>
			<td> <%= c.get(Calendar.MONTH)+1 + "/" + c.get(Calendar.DATE) + "/" + c.get(Calendar.YEAR) %>	</td>
		</tr>
		<tr>
			<td> (mm/dd/yyyy) </td>
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
		<table width="750" border="0" cellspacing="0" cellpadding="1">
		<tr>	
			<td align="left"> Address1  &nbsp; &nbsp; &nbsp;  </td>
			<td align="left"> <input type="text" name="address1" value="<%= obj.getAddress1() %>" > </td>
			<td align="left"> Address2  &nbsp; &nbsp;  </td>
			<td align="left"> <input type="text" name="address2" value="<%= obj.getAddress2() %>" > </td>
		</tr>
		
		<tr>
			<td align="left"> Address3  &nbsp; &nbsp; &nbsp;  </td>
			<td align="left"> <input type="text" name="address3" value="<%= obj.getAddress3() %>" > </td>
			<td align="left"> City  &nbsp; &nbsp;  </td>
			<td align="left"> <input type="text" name="city" value="<%= obj.getCity() %>" > </td>
		</tr>

		<tr>
			<td align="left"> County  &nbsp; &nbsp; &nbsp;  </td>
			<td align="left"> <input type="text" name="county" value="<% obj.getCounty(); %>" > </td>
			<td align="left"> State &nbsp; &nbsp;  </td>
			<td align="left"> <select name="state" > 
				<%= "<option selected>" + obj.getState() %>
				<option> Alabama
				<option> Alaska
				<option> Arizona
				<option> Arkansas
				<option> California
				<option> Colorado
				<option> Connecticut
				<option> Delaware
				<option> Florida
				<option> Georgia
				<option> Hawaii
				<option> Idaho
				<option> Illinos
				<option> Indiana
				<option> Iowa
				<option> Kansas
				<option> Kentucky
				<option> Louisiana
				<option> Maine
				<option> Maryland
				<option> Massachusetts
				<option> Michigan
				<option> Minnesota
				<option> Mississipi
				<option> Missouri
				<option> Monata
				<option> Nebraska
				<option> Nevada
				<option> New Hampshire
				<option> New Jersey
				<option> New Mexico
				<option> Newyork
				<option> North Carolina
				<option> North Dakota
				<option> Ohio
				<option> Oklahoma
				<option> Oregon
				<option> Pennsylvania
				<option> Rhode Island
				<option> South Carolina
				<option> South Dakota
				<option> Tennessee
				<option> Texas
				<option> Utah
				<option> Vermont
				<option> Virginia
				<option> Washington
				<option> West Virginia
				<option> Wisconsin
				<option> Wyoming
			
					</select>	
			</td>
		</tr>

		<tr>
			<td align="left"> Zip  </td>
			<td align="left"> <input type="text" name="zip" value="<%= obj.getZip() %>" > </td>
			<td align="left"> Country  &nbsp; &nbsp;  </td>
			<td align="left">  <select name="country" >  
					<%= "<option selected>" + obj.getCountry() %>
					<option> USA
					<option> Canada
					<option> China
				
						</select>
			</td>
		</tr>
		<tr>
			<td> <sup> (xxx xxx or xxxxx[-xxxx]) </sup>
			</td>
		</tr>

		<tr>
			<td align="left"> Phone &nbsp; &nbsp; &nbsp;  </td>
			<td align="left"> <input type="text" name="phone" value="<%= obj.getPhone() %>" > </td>
			<td align="left"> Toll Free Number &nbsp; &nbsp;  </td>
			<td align="left"> <input type="text" name="tollfreenumber" value="<%= obj.getTollfreenumber() %>" > </td>
		</tr>
		<tr>
			<td> <sup> (xxx) xxx-xxxx </sup> </td>
			<td> &nbsp; </td>
			<td> <sup> (x-xxx-xxx-xxxx) </sup> </td>
		</tr>

		<tr>
			<td align="left"> Fax &nbsp; &nbsp; &nbsp;  </td>
			<td align="left"> <input type="text" name="fax" value="<%= obj.getFax() %>" > </td>
			<td align="left"> Web-site &nbsp; &nbsp;  </td>
			<td align="left"> <input type="text" name="website" value="<%= obj.getWebsite() %>" > </td>
		</tr>
 		<tr>
			<td> <sup> (xxx) xxx-xxxx </sup> </td>
		</tr>

		<tr>
			<td> Description </td>
			<td> <textarea name="description" rows="3" cols="20" > <% obj.getDescription();   %>  </textarea> </td>
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
			&nbsp;
			<a href="javascript:save()"> Update </a>
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