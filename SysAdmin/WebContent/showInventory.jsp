<html>
<head>
<%@ page import="javax.servlet.*, javax.servlet.http.*, java.sql.*" %>
<%@ include file="includes.jsp" %>

<script language="javascript">
function submitForm(){
	if(document.forms('addNewInventory').elements('newInventory').value == ""){
		alert('Enter the name of the inventory')
		document.forms('addNewInventory').elements('newInventory').focus()
		return
	}
	document.forms('addNewInventory').submit()
}
</script>

<script type="text/javascript" language="JavaScript1.2" src="_pgtres/stm31.js"></script>


</head>

<%!
	Connection con = null;
	Statement stmt = null;
	ResultSet rs = null;
	String queryStr = null;
%>

<body align="center" background="images/dgrey027.gif" topmargin="0">
<div align="center">
<table border="0" width="710" id="table1" cellspacing="0" cellpadding="0" background="images/marmor.jpg">
	<tr>
		<td colspan="3">
		<img border="0" src="images/ict.jpg" width="700" height="47"></td>
	</tr>
	<tr>
		<td width="110"><img border="0" src="3.jpg" width="113" height="76"></td>
		<td width="420" rowspan="38">
		
		<table border="0" width="300">
<%
	String id = request.getParameter("id");
	if(id != null){
		id = id.trim();
		queryStr = "select * from sysadmin." + id + " order by 2";
%>
		<tr>
		<th align="left"> <%= id.toUpperCase() %> </th>
		</tr>
<%
		con = getConnection();
		stmt = con.createStatement();

		rs = stmt.executeQuery(queryStr);

		while(rs.next()){
%>
			<tr>
				<td width="85%"> <%= rs.getString(2) %> </td>
				<td> <a href="deleteInv.jsp?type=<%=id%>&id=<%=rs.getInt(1)%>"> [ Delete ] </a> </td>
			</tr>
<%
		}

	}
%>
</table>

		

		
		<table border="0">
<tr>
<td width="200" valign="top">
<!--<table border="0" width="100%">
<form name="addNewInventory" action="addNewInv.jsp" method="post">
<tr>
	<th colspan="2" align="left"> Add New </th>
</tr>
<tr>
	<td width="10%">  </td>
	<td>
		<input type="text" name="newInventory" size="20" /> <br />
		<input type="radio" name="inventoryType" value="applications" checked> Application </input> <br />
		<input type="radio" name="inventoryType" value="operatingsystems"> Operating System </input> <br />
		<input type="radio" name="inventoryType" value="databases"> Database </input> <br />
		<input type="radio" name="inventoryType" value="hardware"> Hardware </input> <br />

	</td>
</tr>
<tr>
	<td colspan="2" align="left"> <input type="button" value="Add" onClick="javascript:submitForm()" /> </td>
</tr>
</form>
</table> -->
</td>
<td>
</td>
</tr>
</table>

		
		
		</td>
		<td width="141" rowspan="47">
		
		<table border="0" width="100%">
<form name="addNewInventory" action="addNewInv.jsp" method="post">
<tr>
	<th colspan="2" align="left"> 
	<a href="logout.jsp"> 
	<img border="0" src="/images/logout2.jsp" width="128" height="70" align="right"></a></th>
</tr>
<tr>
	<th colspan="2" align="left" height="37"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Add New </th>
</tr>
<tr>
	<td width="10%">  </td>
	<td>
		<input type="text" name="newInventory" size="20" /> <br />
		<input type="radio" name="inventoryType" value="applications" checked> Application </input> <br />
		<input type="radio" name="inventoryType" value="operatingsystems"> Operating System </input> <br />
		<input type="radio" name="inventoryType" value="databases"> Database </input> <br />
		<input type="radio" name="inventoryType" value="hardware"> Hardware </input> <br />

	</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="button" value="Add" onClick="javascript:submitForm()" /> </td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
	<td colspan="2" align="left"> &nbsp;</td>
</tr>
</form>
</table>
		
		
		</td>
	</tr>
	<tr>
		<td width="110">
		
				<script id="Sothink Widgets:_pgtres\38838.9155787037_PageletServer.DynamicMenu.pgt" type="text/javascript" language="JavaScript1.2">
<!--
stm_bm(["menu7743",430,"","_pgtres/blank.gif",0,"","",0,0,250,0,1000,1,0,0,"","",0],this);
stm_bp("p0",[1,4,0,0,1,3,5,7,100,"",-2,"",-2,40,2,3,"#F6E0B7","#F6E0B7","",0,0,0,"#F6E0B7"]);
stm_ai("p0i0",[0,"Home","","",-1,-1,0,"#","_self","","","","",5,0,0,"","",0,0,0,0,0,"#F6E0B7",0,"#996600",0,"","",3,3,1,1,"#996600","#996600","#996600","#FFFFFF","8pt Verdana","8pt Verdana",0,0]);
stm_aix("p0i1","p0i0",[0,"ICT Inventory","","",-1,-1,0,"#","_self","","","","",0,0,0,"_pgtres/arrow_r.gif","_pgtres/arrow_rb.gif",7,7,0,0,2]);
stm_bpx("p1","p0",[1,2,0,-1,1,3,5,0,100,"progid:DXImageTransform.Microsoft.Wipe(GradientSize=1.0,wipeStyle=2,motion=reverse,enabled=0,Duration=0.61)",-2,"progid:DXImageTransform.Microsoft.Wipe(GradientSize=1.0,wipeStyle=2,motion=reverse,enabled=0,Duration=0.61)",-2,40,2,3,"#999999","#000000","",3]);
stm_aix("p1i0","p0i0",[0,"Applications","","",-1,-1,0,"showInventory.jsp?id=applications","_self","","","","",5,0,0,"","",0,0,0,0,0,"#F6E0B7"]);
stm_aix("p1i1","p1i0",[0,"Operating Systems","","",-1,-1,0,"showInventory.jsp?id=operatingsystems","_self","","","","",0]);
stm_aix("p1i2","p1i1",[1,"Database", "","",-1,-1,0,"showInventory.jsp?id=databases","_self","","","","",0]);
stm_aix("p1i3","p0i0",[0,"Hardware","","",-1,-1,0,"showInventory.jsp?id=hardware","_self","","","","",0,0,0,"","",0,0,0,0,0,"#F6E0B7",0,"#000000",0,"","",3,0]);
stm_aix("p1i4","p1i3",[0,"Server Machines","","",-1,-1,0,"#","_self","","","","",0,0,0,"","",0,0,0,0,0,"#F6E0B7",0,"#000000",0,"","",0]);
stm_ep();

stm_aix("p0i1","p0i0",[0,"Projects","","",-1,-1,0,"#","_self","","","","",0,0,0,"_pgtres/arrow_r.gif","_pgtres/arrow_rb.gif",7,7,0,0,2]);
stm_bpx("p1","p0",[1,2,0,-1,1,3,5,0,100,"progid:DXImageTransform.Microsoft.Wipe(GradientSize=1.0,wipeStyle=2,motion=reverse,enabled=0,Duration=0.61)",-2,"progid:DXImageTransform.Microsoft.Wipe(GradientSize=1.0,wipeStyle=2,motion=reverse,enabled=0,Duration=0.61)",-2,40,2,3,"#999999","#000000","",3]);
stm_aix("p1i0","p0i0",[0,"Project List","","",-1,-1,0,"showProjects.jsp","_self","","","","",5,0,0,"","",0,0,0,0,0,"#F6E0B7"]);
stm_aix("p1i1","p1i0",[0,"Add Project","","",-1,-1,0,"newProjectForm.jsp","_self","","","","",0]);
stm_ep();

stm_aix("p0i2","p0i1",[0,"Credits","","",-1,-1,0,"#","_self","","","","",0,0,0,"","",0,0]);

stm_em(); 
//-->
</script>
		
		</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">

		
		
		</td>
		<td width="420" rowspan="14">
		
		
		
		</td>
	</tr>
	<tr>
		<td width="110" height="14">
		
		

		
		
		
		
		</td>
	</tr>
	<tr>
		<td width="110" height="9">
		
		
		
		
		
		</td>
	</tr>
	<tr>
		<td width="110" height="4">
		
		
		
		
		
		</td>
	</tr>
	<tr>
		<td width="110" height="1">
		
		
		
		
		
		</td>
	</tr>
	<tr>
		<td width="110" height="1">
		
		
		
		
		
		</td>
	</tr>
	<tr>
		<td width="110" height="1">
		
		
		
		
		
		</td>
	</tr>
	<tr>
		<td width="110" height="1">
		
		
		
		
		
		</td>
	</tr>
	<tr>
		<td width="110" height="1">
		
		
		
		
		
		</td>
	</tr>
	<tr>
		<td width="110" height="9">
		
		
		
		
		
		</td>
		<td width="141" height="29" rowspan="3">&nbsp;</td>
	</tr>
	<tr>
		<td width="110" height="9">
		
		
		
		
		
		</td>
	</tr>
	<tr>
		<td width="110" height="9">
		
		
		
		
		
		</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
		<td width="141">
		
		

		
		
		</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
		<td width="141">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
		<td width="420">
		
		
		
		
		</td>
		<td width="141">&nbsp;</td>
	</tr>
	<tr>
		<td width="110">&nbsp;</td>
		<td width="420">&nbsp;</td>
		<td width="141">&nbsp;</td>
	</tr>
</table>
</div>
<!--<%@ include file="mainMenu.html" %>-->
<p>&nbsp;</p>
<p>
<br />

</p>


</body>
</html>