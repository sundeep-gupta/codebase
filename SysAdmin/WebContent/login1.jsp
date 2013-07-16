<html>

<head>
<title>	</title>


</head>

<body>
<center>

<div align="center">
	<table border="0" width="700" id="table1" cellspacing="0" cellpadding="0" background="images/marmor.jpg">
		<tr>
			<td colspan="3">
			<img border="0" src="images/ict.jpg" width="700" height="47"></td>
		</tr>
		<tr>
			<td width="113" bgcolor="#F6E0B7" background="images/marmor.jpg"><img border="0" src="3.jpg" width="113" height="76"></td>
			<td width="459">&nbsp;</td>
			<td width="120" bgcolor="#F6E0B7"><a href="logout.jsp">
			<img border="0" src="logout2.jpg" width="128" height="70"></a></td>
		</tr>
		<tr>
			<td width="100" rowspan="5" bgcolor="#F6E0B7" background="file:///C:/Inetpub/wwwroot/images/marmor.jpg">
			
			<script id="Sothink Widgets:_pgtres\38838.9155787037_PageletServer.DynamicMenu.pgt" type="text/javascript" language="JavaScript1.2">
<!--
stm_bm(["menu7743",430,"","_pgtres/blank.gif",0,"","",0,0,250,0,1000,1,0,0,"","",0],this);
stm_bp("p0",[1,4,0,0,1,3,5,7,100,"",-2,"",-2,40,2,3,"#F6E0B7","#F6E0B7","",0,0,0,"#F6E0B7"]);
stm_ai("p0i0",[0,"Home","","",-1,-1,0,"#","_self","","","","",5,0,0,"","",0,0,0,0,0,"#F6E0B7",0,"#996600",0,"","",3,3,1,1,"#996600","#996600","#996600","#FFFFFF","8pt Verdana","8pt Verdana",0,0]);
stm_aix("p0i1","p0i0",[0,"ICT Inventory","","",-1,-1,0,"#","_self","","","","",0,0,0,"_pgtres/arrow_r.gif","_pgtres/arrow_rb.gif",7,7,0,0,2]);
stm_bpx("p1","p0",[1,2,0,-1,1,3,5,0,100,"progid:DXImageTransform.Microsoft.Iris(irisStyle=star,motion=in,enabled=0,Duration=0.70)",-2,"progid:DXImageTransform.Microsoft.Iris(irisStyle=star,motion=in,enabled=0,Duration=0.70)",-2,40,2,3,"#999999","#000000","",3]);
stm_aix("p1i0","p0i0",[0,"Applications","","",-1,-1,0,"showInventory.jsp?id=applications","_self","","","","",5,0,0,"","",0,0,0,0,0,"#F6E0B7"]);
stm_aix("p1i1","p1i0",[0,"Operating Systems","","",-1,-1,0,"showInventory.jsp?id=operatingsystems","_self","","","","",0]);
stm_aix("p1i2","p1i1",[1,"Database", "","",-1,-1,0,"showInventory.jsp?id=databases","_self","","","","",0]);
stm_aix("p1i3","p0i0",[0,"Hardware","","",-1,-1,0,"showInventory.jsp?id=hardware","_self","","","","",0,0,0,"","",0,0,0,0,0,"#F6E0B7",0,"#000000",0,"","",3,0]);
stm_aix("p1i4","p1i3",[0,"Server Machines","","",-1,-1,0,"#","_self","","","","",0,0,0,"","",0,0,0,0,0,"#F6E0B7",0,"#000000",0,"","",0]);
stm_ep();

stm_aix("p0i1","p0i0",[0,"Projects","","",-1,-1,0,"#","_self","","","","",0,0,0,"_pgtres/arrow_r.gif","_pgtres/arrow_rb.gif",7,7,0,0,2]);
stm_bpx("p1","p0",[1,2,0,-1,1,3,5,0,100,"progid:DXImageTransform.Microsoft.Iris(irisStyle=star,motion=in,enabled=0,Duration=0.70)",-2,"progid:DXImageTransform.Microsoft.Iris(irisStyle=star,motion=in,enabled=0,Duration=0.70)",-2,40,2,3,"#999999","#000000","",3]);
stm_aix("p1i0","p0i0",[0,"Project List","","",-1,-1,0,"showProjects.jsp","_self","","","","",5,0,0,"","",0,0,0,0,0,"#F6E0B7"]);
stm_aix("p1i1","p1i0",[0,"Add Project","","",-1,-1,0,"newProjectForm.jsp","_self","","","","",0]);
stm_ep();

stm_aix("p0i2","p0i1",[0,"Credits","","",-1,-1,0,"#","_self","","","","",0,0,0,"","",0,0]);

stm_em(); 
//-->
</script>


			
			
			
			</td>
			<td width="459">&nbsp;</td>
			<td width="120" bgcolor="#996600">&nbsp;</td>
		</tr>
		<tr>
			<td width="459">&nbsp;</td>
			<td width="120">&nbsp;</td>
		</tr>
		<tr>
			<td width="459">&nbsp;</td>
			<td width="120">&nbsp;</td>
		</tr>
		<tr>
			<td width="459">&nbsp;</td>
			<td width="120">&nbsp;</td>
		</tr>
		<tr>
			<td width="459">&nbsp;</td>
			<td width="120">&nbsp;</td>
		</tr>
		<tr>
			<td width="113" bgcolor="#F6E0B7" background="file:///C:/Inetpub/wwwroot/images/marmor.jpg">&nbsp;</td>
			<td width="459">&nbsp;</td>
			<td width="120">&nbsp;</td>
		</tr>
		<tr>
			<td width="113" bgcolor="#F6E0B7" background="file:///C:/Inetpub/wwwroot/images/marmor.jpg">&nbsp;</td>
			<td width="459">&nbsp;</td>
			<td width="120">&nbsp;</td>
		</tr>
	</table>
</div>

<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<table border="0" width="850">
<tr height="250" valign="bottom">
	<td>
		<table align="center" border="0">
		<%
			if(request.getParameter("message") != null){
		%>
			<tr>
				<td colspan="2">
					<font size="5" color="f22f0e"> <%= request.getParameter("message") %>	</font>
				</td>
			</tr>
			<tr height="15">
				<td>
				</td>
			</tr>
		<%
			}
		%>
		<form name="adminLogin" method="post" action="SysAdmin.jsp" />

		<tr>
			<td align="right">
				User : 
			</td>
			<td>
				<input type="text" name="user" size="12" />
			</td>
		</tr>

		<tr>
			<td align="right">
				Password : 
			</td>
			<td>
				<input type="password" name="passwd" size="12" />
			</td>
		</tr>

		<tr height="20">
			<td>
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2">
				<input type="submit" value="    Go   "/>
		</td>
		</tr>

		</form>
		</table>
		</td>
	</tr>
</table>
</center>
</body>


</html>