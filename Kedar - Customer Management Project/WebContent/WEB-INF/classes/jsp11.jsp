<html>

<%@ page import="java.util.*" %>

<head> <title> Add Customer </title> 


<script language="javascript">
            <!--
	function cl(){
		document.addcg.reset();

	}

	function save(){

		if(document.addcg.name.value==""){
			alert("Please enter customer name");
			document.addcg.name.focus();
			return;
		}

	

		if(document.addcg.group.value==""){
			alert("Please enter Group name");
			document.addcg.group.focus();
			return;
		}


		if(document.addcg.creditlimit.value==""){
			alert("Please enter credit limit");
			document.addcg.creditlimit.focus();
			return;
		}


		if(document.addcg.latelimit.value==""){
			alert("Please enter latelimit");
			document.addcg.latelimit.focus();
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



<b> Add Customer </b>
<br> <br>
<table border="2">
<form name="addcg" action="/kndn/jsp13" method="post">
<tr>
<td>
<table border="0" >
<tr>
	<td>
		<table width="750" border="0">
		<tr>
			<td align="center"> <b> Customer Details </b> </td>
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
			<td width="180"> Name &nbsp; &nbsp; </td>
			<td width="180"> <input type="text" name="name"> </td>
			<td width="180"> Short Name  </td>
			<td width="180"> <input type="text" name="shortname" disabled> </td>
		</tr>

		<tr>
			<td> Creation Date </td>
			<td> <%= c.get(Calendar.MONTH)+1 + "/" + c.get(Calendar.DATE) + "/" + c.get(Calendar.YEAR) %>	</td>
			<td> Created By </td>
			<td> <input type="text" name="createdby" value="Administrator"> </td>
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
			<td align="left" width="180"> Address1  &nbsp; &nbsp; &nbsp;  </td>
			<td align="left" width="180"> <input type="text" name="address1"> </td>
			<td align="left" width="180"> Address2  &nbsp; &nbsp;  </td>
			<td align="left" width="180"> <input type="text" name="address2"> </td>
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
				<option> Alabama </option>
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
			<td align="left"> <input type="text" name="zip" disabled> </td>
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
			<td align="left"> <input type="text" name="phone" disabled> </td>
			<td align="left"> Toll Free Number &nbsp; &nbsp;  </td>
			<td align="left"> <input type="text" name="tollfreenumber" disabled> </td>
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

		</table>
	</td>
</tr>

<tr>
	<td> &nbsp; </td>
</tr>

<tr>
	<td> <hr> </td>
</tr>
<tr>
<td> &nbsp; </td>
</tr>
<tr>
<td>
	<table width="750" border="0" cellspacing="0" cellpadding="1">
	<tr>
		<td width="180"> Group </td>	
		<td align="left" width="180"> <input type="text" name="group" > <%-- <a href="/kndn/jsp12" target="1"> <img src="images/edit-16x16.gif" border="0"> </a> --%> </td>
		<td width="180"> Ar Rep </td>
		<td width="180"> <input type="text" name="arrep"> </td>
	</tr>
	<tr>
		<td> Credit Limit &nbsp; ($) </td>	
		<td> <input type="text" name="creditlimit"> </td>
		<td> &nbsp; </td>
		<td> &nbsp; </td>
	</tr>
	<tr>
		<td> Collection Type </td>	
		<td> 	<select name="collectiontype"> 
				<option> Normal </option>
				<option> Extended </option>
				<option> Major </option>
				<option> Aggressive </option>
			</select> </td>

		<td> Late Limit </td>
		<td> <input type="text" name="latelimit"> days </td>
	</tr>
	<tr>
		<td> Credit Status </td>	
		<td> 	<select name="creditstatus"> 
				<option> Positive </option>
				<option> Negative </option>
			</select> </td>
		<td> Terms </td>
		<td> <input type="text" name="terms"> </td>
	</tr>
	<tr>
		<td> Description </td>	
		<td> <textarea name="description" rows="3" cols="17"> </textarea> </td>
		<td> Credit Status Detail </td>
		<td> <textarea name="creditstatusdetail" rows="3" cols="17"> </textarea> </td>
	
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