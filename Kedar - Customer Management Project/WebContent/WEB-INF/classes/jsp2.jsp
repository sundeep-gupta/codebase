<%@ page import="javax.servlet.*,javax.servlet.http.*,java.io.*"  session="true" %>



<jsp:useBean  id="obj" class="k.Prj1" scope="session" />
<jsp:setProperty 	name="obj" property="user" param="loginID"/>
<jsp:setProperty 	name="obj" property="pass" param="password"/>



<%		if(obj.verify(session)){	%>	

	<head>
    <title> PCC Inventry	</title>
    <script language="JavaScript" src="scripts/customer.js"></script>
	</head>

	<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">
    <div align="left">
    <table width="785" cellpadding="0" cellspacing="0" border="0" align="center">
    <tr>
	    <td align="left" colspan="2"><img src="images/gui_2.jpg" border="0" width="100%"><td>
    </tr>
    <tr>
	    <td width="15%" valign="top" align="left">
	        <table width="100%" border="0" background="images/side_custom-mgmt.gif">
            <tr>
		        <td>&nbsp;</td>
		    </tr>
            <tr>
			    <td>&nbsp;</td>
            </tr>
            <tr>

		<td> &nbsp; </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
				<td>&nbsp;</td>
            </tr>
            <tr>
			    <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                 <td>&nbsp;</td>
            </tr>
            <tr>
                 <td>&nbsp;</td>
            </tr>
            </table>
		</td>
        <td valign="top" align="left">
				<!-- Menu Part-Begining-->
	        <table cellspacing="0" cellpadding="0" border="0" align="right" >
          <tr align="center" background="images/bottomstrip.gif">
		<td nowrap="nowrap" onmouseover="chgBg('tlm0',3);expandMenu('mn1','tlm0',event)" onmouseout="chgBg('tlm0',0);collapseMenu('mn1')" id='tlm0' class="mit"><a id="tlm0a" class="CL0" href="javascript:void(0)" onMouseOver="expandMenuNS('mn1',event)" onmouseout="collapseMenuNS('mn1')" ><div id='mn1top' class='topFold'><img src="images/customergroup.gif" border="0"></div></a></font></td>
                <td nowrap="nowrap" onmouseover="chgBg('tlm1',3);expandMenu('mn2','tlm1',event)" onmouseout="chgBg('tlm1',0);collapseMenu('mn2')" id='tlm1' class="mit"><a id="tlm1a" class="CL0" href="javascript:void(0);" onMouseOver="expandMenuNS('mn2',event)" onmouseout="collapseMenuNS('mn2')" ><div id='mn2top' class='topFold'><img src="images/customer.gif" border="0"></div></a></font></td>
                <td nowrap="nowrap" onmouseover="chgBg('tlm2',3);expandMenu('mn3','tlm2',event)" onmouseout="chgBg('tlm2',0);collapseMenu('mn3')" id='tlm2' class="mit"><a id="tlm2a" class="CL0" href="javascript:void(0);" onMouseOver="expandMenuNS('mn3',event)" onmouseout="collapseMenuNS('mn3')" ><div id='mn3top' class='topFold'><img src="images/customeraccount.gif" border="0"></div></a></font></td>
                <td nowrap="nowrap" onmouseover="chgBg('tlm3',3);expandMenu('mn4','tlm3',event)" onmouseout="chgBg('tlm3',0);collapseMenu('mn4')" id='tlm3' class="mit"><a id="tlm3a" class="CL0" href="javascript:void(0);" onMouseOver="expandMenuNS('mn4',event)" onmouseout="collapseMenuNS('mn4')" ><div id='mn4top' class='topFold'><img src="images/quirk.gif" border="0"></div></a></font></td>
			</tr>
            </table>

				        <!-- Menu Part-End-->

             <br>
             <table border="0" cellpadding="0" cellspacing="0" width="620">
             <tr>
				<td width="20">&nbsp</td>
				<td>
					<table>
				    <tr>
						<td colspan="2" width="600">
                        <table border="0" cellspacing="0" cellpadding="0" valign="center">
                        <tr valign="center">
							<td height="27"></td>
                        </tr>
                        </table>
                        </td>
					</tr>
	                </table>

                    <table border="1" cellpadding="0" cellspacing="0" width="100%" bordercolorlight="black" bordercolordark="white">
                    <tr>
						<td width="600">
                        <div align="center">
                        <form>
                        <table border="0" width="98%" align="center">
                        <tr>
	                        <td colspan="4" align="center" valign="top">
                                            <b><font class="tdstyle"><u>Customer Group Details</u></font></b>
                            </td>
                        </tr>
                        </table>
                        </form>
				        </div>
						</td>
					</tr>
						
				    </table>
				</td>
			</tr>
						<tr>
						<td  </td>
						</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	</table>
	</div>
	</body>


<jsp:useBean id="cusD" class="k.CusDetails" scope="request" />
<%
	cusD.setUserid(((Integer)session.getAttribute("userid")).intValue());
	cusD.setFirstname((String)session.getAttribute("firstname"));
	cusD.setMiddlename((String)session.getAttribute("middlename"));
	cusD.setLastname((String)session.getAttribute("lastname"));
	cusD.setContactid(((Integer)session.getAttribute("contactid")).intValue());
	cusD.setDivisionid(((Integer)session.getAttribute("divisionid")).intValue());
	cusD.setDivisionname((String)session.getAttribute("divisionname"));
	cusD.setPlantid(((Integer)session.getAttribute("plantid")).intValue());
	cusD.setPlantname((String)session.getAttribute("plantname"));
	cusD.setUsername((String)session.getAttribute("username"));

%>



<%		
		}else{	%>
			who r u
<%		}	%>