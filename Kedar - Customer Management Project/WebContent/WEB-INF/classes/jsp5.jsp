<html>
<head> 
<script language="javascript">
	function chk(){
		if(document.srchcg.groupname.value=="" && document.srchcg.shortname.value==""){
			alert("Enter atleast one of the search criterion");
			document.srchcg.groupname.focus();
			return;
		}
		document.srchcg.submit();
	}
</script>

</head>

<body>

<b> Search Customer Group  </b>
<br>
<br>
<table border="2" width="750">
<tr> <td>
<center>
<form name="srchcg" action="/kndn/jsp6" method="post">
<input type="hidden" name="back" value="edit">
<table border="0" >

<tr>
<td> &nbsp; </td>
</tr>
<tr>
	<td>
		<center> <b> Search Customer Group </b> </center>
	</td>
</tr>
<tr>
<td> &nbsp; </td>
</tr>

<tr>
	<td> 
	<center>
		<table>
			<tr>
				<td> Customer Group Name &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
			
				<td> <input type="text" name="groupname"> </td>
			</tr>
			<tr>
				<td> Short Name </td>
			
				<td> <input type="text" name="shortname"> </td>
			</tr>
			<tr>
				<td> Company Name </td>
			
				<td> <input type="text" name="companyname"> </td>
			</tr>
			<tr>
				<td> Account Number </td>
			
				<td> <input type="text" name="accnumber"> </td>
			</tr>
			

		</table>
	</center>
	</td>
</tr>
<tr>
<td> &nbsp; </td>
</tr>

<tr>
	<td> <center> <a href="javascript:chk()"> Search </a> </center> </td>
</tr>
<tr>
<td> &nbsp; </td>
</tr>

</table>
</form>
</center>
</td> </tr>

</table>


</body>
</html>