<HTML>
	<HEAD>
		<TITLE>Customer Module</TITLE>

<link href="css/CFP_per.css" rel="stylesheet" type="text/css">
 </HEAD>
<BODY>
<CENTER>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#EFF4F9" valign="top">
<tr>
	<td bgcolor="#EFF4F9" align="center">
		<table width="95%" height="95%" border="0" cellpadding="0" cellspacing="0" class="tabinside" bgcolor="#EFF4F9">
		<tr>
			<td height="25" align="left" width="100%" valign="middle" class="tabheading" colspan=2>&nbsp;&nbsp;WELCOME TO PERFORMANCE MONITORING SUITE 
            </td>
		</tr>
		<tr> 
			<td align="center" valign="middle"> 
				<table width="35%" border="0" cellspacing="0" cellpadding="0">
				<tr>
						<td align="left" width="42%" class="fieldnames"> <b> Customer Name </b> </td>
						<td align="left" width="5%" class="fieldnames"> <b> : </b> </td>
						<td align="left" class="fieldnames"> <b> 	<%= session.getAttribute("custname") %> 	</b> </td>
				</tr>
				<tr> 
						<td align="left" class="fieldnames"> <b> User Name </b>	</td>
						<td align="left" class="fieldnames"> <b> : </b> </td>
						<td align="left" class="fieldnames"> <b> <%= session.getAttribute("username") %>	</b> </td>
				</tr>

				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>

</CENTER>
</BODY>
</HTML>