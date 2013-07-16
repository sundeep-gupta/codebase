<html>

<%@ page import="java.util.*" %>

<head> <title> Add Customer Contact </title> 


<script language="javascript">
            <!--
	function cl(){
		document.addcg.reset();

	}

	function save(){
	
		if(document.addcg.firstname.value==""){
			alert("Please enter first name");
			document.addcg.firstname.focus();
			return;
		}
		if(document.addcg.lastname.value==""){
			alert("Please enter last name");
			document.addcg.lastname.focus();
			return;
		}
		
		if(document.addcg.title.value==""){
			alert("Please enter title");
			document.addcg.title.focus();
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

<b> Add Customer Contact </b>
<br> <br>
<table border="2">
<form name="addcg" action="/kndn/jsp15" method="post">
<tr>
<td>
<table border="0" >
<tr>
	<td>
		<table width="750" border="0">
		<tr>
			<td align="center"> <b> Contact details for <%= (String)session.getAttribute("cstmr") %> </b> </td>
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
			<td width="180"> First Name &nbsp; &nbsp; </td>
			<td width="180"> <input type="text" name="firstname"> </td>
			<td width="180"> Middle Name  </td>
			<td width="180"> <input type="text" name="middlename"> </td>
		</tr>

		<tr>
			<td> Last Name </td>
			<td> <input type="text" name="lastname"> </td>
			<td> Title </td>
			<td> <input typ="text" name="title"> </td>
		</tr>
		<tr>
		
			<td> Gender </td>
			<td> <select name="gender">
				<option value="m"> Male </option>
				<option value="f"> Female </option>
			     </select>	
			</td>
			<td> Type </td>
			<td> <select name="type">
				<option> SHIP_TO </option>
				<option> BILL_TO </option>
			</td>
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
			<td align="left"> Phone1 &nbsp; &nbsp; &nbsp;  </td>
			<td align="left"> <input type="text" name="phone1"> </td>
			<td align="left"> Extn1 &nbsp; &nbsp;  </td>
			<td align="left"> <input type="text" name="extn1"> </td>
		</tr>
		<tr>
			<td> <sup> (xxx) xxx-xxxx </sup> </td>
			<td> &nbsp; </td>
			<td> &nbsp; </td>
		</tr>

		<tr>
			<td align="left"> Phone2 &nbsp; &nbsp; &nbsp;  </td>
			<td align="left"> <input type="text" name="phone2"> </td>
			<td align="left"> Extn2 &nbsp; &nbsp;  </td>
			<td align="left"> <input type="text" name="extn2"> </td>
		</tr>
		<tr>
			<td> <sup> (xxx) xxx-xxxx </sup> </td>
			<td> &nbsp; </td>
			<td> &nbsp; </td>
		</tr>
		
		<tr>
			<td> Toll Free Number </td>
			<td> <input type="text" name="tollfreenumber">	</td>
			<td> Mobile </td>
			<td> <input type="text" name="mobile">	</td>
		</tr>
		<tr>
			<td> <sup> (x-xxx-xxx-xxxx) </sup> </td>
			<td> &nbsp; </td>
			<td> <sup> (xxx) xxx-xxxx </sup>  </td>
		</tr>
		<tr>
			<td> Fax1 </td>
			<td> <input type="text" name="fax1">	</td>
			<td> Fax2 </td>
			<td> <input type="text" name="fax2">	</td>
		</tr>
		<tr>
			<td> <sup> (xxx) xxx-xxxx </sup> </td>
			<td> &nbsp; </td>
			<td> <sup> (xxx) xxx-xxxx </sup>  </td>
		</tr>
		<tr>
			<td> Email </td>
			<td> <input type="text" name="email">	</td>
			<td> WebSite </td>
			<td> <input type="text" name="website">	</td>
		</tr>
		<tr>
		
			<td> Mode of Contact </td>
			<td> <select name="modeofcontact">
				<option> Phone </option>
				<option> Email </option>
			     </select>	
			</td>
			<td> Do not Solicit </td>
			<td> <select name="donotsolicit">
				<option value="1"> Yes </option>
				<option value="0"> No </option>
			</td>
		</tr>




		<tr>
			<td> Comments </td>
			<td> <textarea name="comments" rows="3" cols="20"> </textarea> </td>
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
			<a href="javascript:save()"> Add </a>
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