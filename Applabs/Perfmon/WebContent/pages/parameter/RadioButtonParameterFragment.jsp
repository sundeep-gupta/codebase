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
<%@ page import="org.eclipse.birt.report.viewer.bean.ScalarParameterBean,
				 org.eclipse.birt.report.viewer.bean.ViewerAttributeBean,
				 org.eclipse.birt.report.viewer.utilities.ParameterAccessor" %>

<%-----------------------------------------------------------------------------
	Expected java beans
-----------------------------------------------------------------------------%>
<jsp:useBean id="attributeBean" type="org.eclipse.birt.report.viewer.bean.ViewerAttributeBean" scope="request" />

<%-----------------------------------------------------------------------------
	Radio button parameter control
-----------------------------------------------------------------------------%>
<%
	ScalarParameterBean parameterBean = ( ScalarParameterBean ) attributeBean.getParameterBean( );
%>
<TR>
	<TD NOWRAP>
		<IMG SRC="images/iv/parameter.gif" ALT="<%= parameterBean.getDisplayName( ) %>" TITLE="<%= parameterBean.getToolTip( ) %>"/>
	</TD>
	<TD NOWRAP>
		<FONT TITLE="<%= parameterBean.getToolTip( ) %>"><%= parameterBean.getDisplayName( ) %>:</FONT>
		<%-- is required --%>
		<%
		if ( parameterBean.isRequired( ) )
		{
		%>
			<FONT COLOR="red">*</FONT>
		<%
		}
		%>
	</TD>
</TR>
<TR>
	<TD NOWRAP></TD>
	<%-- Parameter Name--%>

	<TD NOWRAP WIDTH="100%">
	<%-- Parameter control --%>
<%
	if (parameterBean.getSelectionList( ) != null)
	{
%>
	<INPUT TYPE="HIDDEN"
		ID="<%= parameterBean.getName( ) + "_hidden" %>"
		NAME="<%= ParameterAccessor.PARAM_ISNULL %>"
		VALUE="<%= (parameterBean.getValue( ) == null)? parameterBean.getName( ) : "" %>">
<%
		for ( int i = 0; i < parameterBean.getSelectionList( ).size( ); i++ )
		{
			String label = ( String ) parameterBean.getSelectionList( ).get( i );
			String value = ( String ) parameterBean.getSelectionTable( ).get( label );
%>
	<INPUT TYPE="RADIO"
		NAME="<%= parameterBean.getName( ) %>"
		VALUE="<%= ParameterAccessor.htmlEncode( value ) %>"
		<%= (parameterBean.getValue( ) != null && parameterBean.getValue( ).equalsIgnoreCase( value ) )? "CHECKED" : "" %>>
		<%= label %>
	</INPUT>
	<BR>
<%
		}
		if ( parameterBean.allowNull( ) )
		{
%>
	<INPUT TYPE="RADIO"
		NAME="<%= parameterBean.getName( ) %>"
		VALUE=""
		<%= ( parameterBean.getValue( ) == null )? "CHECKED" : "" %>>
		Null Value
	</INPUT>
	<BR>
<%
		}
	}
%>
	</TD>
</TR>