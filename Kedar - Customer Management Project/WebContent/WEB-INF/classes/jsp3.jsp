<html>

<%@ page import="java.util.*" %>

<head> <title> Add Customer Group </title> 


<script language="javascript">
            <!--
	function cl(){
		document.addcg.reset();

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

		if(document.addcg.state.selectedIndex==0){
			alert("Please enter the State");
			document.addcg.state.focus();
			return;
		}

		if(document.addcg.country.selectedIndex==0){
			alert("Please enter the Country");
			document.addcg.country.focus();
			return;
		}


		
		document.addcg.submit();
	}
//-->
</script>
</head>
<body>
<%
	Calendar c = Calendar.getInstance();
	
%>

<b> Add Customer Group </b>
<br> <br>
<table border="2">
<form name="addcg" action="/kndn/jsp4" method="post">
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
			<td> <input type="text" name="groupname"> </td>
			<td> Short Name  </td>
			<td align="center"> <input type="text" name="shortname"> </td>
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
			<td align="left"> <input type="text" name="address1"> </td>
			<td align="left"> Address2  &nbsp; &nbsp;  </td>
			<td align="left"> <input type="text" name="address2"> </td>
		</tr>
		
		<tr>
			<td align="left"> Address3  &nbsp; &nbsp; &nbsp;  </td>
			<td align="left"> <input type="text" name="address3"> </td>
			<td align="left"> City  &nbsp; &nbsp;  </td>
			<td align="left"> <input type="text" name="city"> </td>
		</tr>

		<tr>
			<td align="left"> County  &nbsp; &nbsp; &nbsp;  </td>
			<td align="left"> <input type="text" name="county"> </td>
			<td align="left"> State &nbsp; &nbsp;  </td>
			<td align="left"> <select name="state"> 
				<option selected>select one
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
			<td align="left"> <input type="text" name="zip"> </td>
			<td align="left"> Country  &nbsp; &nbsp;  </td>
			<td align="left">  <select name="country"> 
					<option selected>select one
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
			<td align="left"> <input type="text" name="phone"> </td>
			<td align="left"> Toll Free Number &nbsp; &nbsp;  </td>
			<td align="left"> <input type="text" name="tollfreenumber"> </td>
		</tr>
		<tr>
			<td> <sup> (xxx) xxx-xxxx </sup> </td>
			<td> &nbsp; </td>
			<td> <sup> (x-xxx-xxx-xxxx) </sup> </td>
		</tr>

		<tr>
			<td align="left"> Fax &nbsp; &nbsp; &nbsp;  </td>
			<td align="left"> <input type="text" name="fax"> </td>
			<td align="left"> Web-site &nbsp; &nbsp;  </td>
			<td align="left"> <input type="text" name="website"> </td>
		</tr>
 		<tr>
			<td> <sup> (xxx) xxx-xxxx </sup> </td>
		</tr>

		<tr>
			<td> Description </td>
			<td> <textarea name="description" rows="3" cols="20"> </textarea> </td>
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
			<a href="javascript:cl()"> Reset </a> 
	

				&nbsp;
			<a href="javascript:save()"> Save </a>
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