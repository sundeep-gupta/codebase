<%-----------------------------------------------------------------------------
	Copyright (c) 2004 Actuate Corporation and others.
	All rights reserved. This program and the accompanying materials 
	are made available under the terms of the Eclipse Public License v1.0
	which accompanies this distribution, and is available at
	http://www.eclipse.org/legal/epl-v10.html
	
	Contributors:
		Actuate Corporation - Initial implementation.
-----------------------------------------------------------------------------%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page session="false" buffer="none" %>
<%@ page import="org.eclipse.birt.report.viewer.aggregation.Fragment,
				 org.eclipse.birt.report.viewer.bean.ViewerAttributeBean,
				 org.eclipse.birt.report.viewer.resource.Resources" %>

<%-----------------------------------------------------------------------------
	Expected java beans
-----------------------------------------------------------------------------%>
<jsp:useBean id="fragment" type="org.eclipse.birt.report.viewer.aggregation.Fragment" scope="request" />
<jsp:useBean id="attributeBean" type="org.eclipse.birt.report.viewer.bean.ViewerAttributeBean" scope="request" />

<%-----------------------------------------------------------------------------
	Navigation bar fragment
-----------------------------------------------------------------------------%>
<TR HEIGHT="25px">
	<TD>
		<DIV id="navigationBar">
			<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%" HEIGHT="25px" CLASS="birtviewer_navbar">
				<TR><TD></TD></TR>
				<TR>
					<TD WIDTH="6px"/>
					<TD>
						<B>
						<%
							if ( attributeBean.getBookmark( ) != null )
							{
						%>
							<%= Resources.getString( "birt.viewer.navbar.prompt.one" )%>&nbsp;
							<SPAN ID='pageNumber'></SPAN>&nbsp;
							<%= Resources.getString( "birt.viewer.navbar.prompt.two" )%>&nbsp;
							<SPAN ID='totalPage'>1</SPAN>
						<%
							}
							else
							{
						%>
							<%= Resources.getString( "birt.viewer.navbar.prompt.one" )%>&nbsp;
							<SPAN ID='pageNumber'><%= attributeBean.getReportPage( ) %></SPAN>&nbsp;
							<%= Resources.getString( "birt.viewer.navbar.prompt.two" )%>&nbsp;
							<SPAN ID='totalPage'>1</SPAN>
						<%
							}
						%>
						</B>
					</TD>
					
					<TD WIDTH="15px">
						<IMG SRC="images/iv/FirstPage_disabled.gif" NAME='first'
							TITLE="<%= Resources.getString( "birt.viewer.navbar.first" )%>" CLASS="birtviewer_clickable">
					</TD>
					<TD WIDTH="2px"/>
					<TD WIDTH="15px">
						<IMG SRC="images/iv/PreviousPage_disabled.gif" NAME='previous'
							TITLE="<%= Resources.getString( "birt.viewer.navbar.previous" )%>" CLASS="birtviewer_clickable">
					</TD>
					<TD WIDTH="2px"/>
					<TD WIDTH="15px">
						<IMG SRC="images/iv/NextPage_disabled.gif" NAME='next'
							TITLE="<%= Resources.getString( "birt.viewer.navbar.next" )%>" CLASS="birtviewer_clickable">
					</TD>
					<TD WIDTH="2px"/>
					<TD WIDTH="15px">
						<IMG SRC="images/iv/LastPage_disabled.gif" NAME='last'
							TITLE="<%= Resources.getString( "birt.viewer.navbar.last" )%>" CLASS="birtviewer_clickable">
					</TD>
					
					<TD WIDTH="8px"/>
					
					<TD ALIGN="right" WIDTH="80px"><b><%= Resources.getString( "birt.viewer.navbar.lable.goto" )%></b></TD>
					<TD WIDTH="2px"/>
					<TD ALIGN="right" WIDTH="50px">
						<INPUT ID='gotoPage' TYPE='text' VALUE='' MAXLENGTH="8" SIZE='5' CLASS="birtviewer_navbar_input">
					</TD>
					<TD WIDTH="4px"/>
					<TD ALIGN="right" WIDTH="10px">
						<IMG SRC="images/iv/Go.gif" NAME='goto'
							TITLE="<%= Resources.getString( "birt.viewer.navbar.goto" )%>" CLASS="birtviewer_clickable">
					</TD>
					<TD WIDTH="6px"/>
				</TR>
			</TABLE>
		</DIV>
	</TD>
</TR>