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
<%@ page import="org.eclipse.birt.report.viewer.aggregation.Fragment" %>

<%-----------------------------------------------------------------------------
	Expected java beans
-----------------------------------------------------------------------------%>
<jsp:useBean id="fragment" type="org.eclipse.birt.report.viewer.aggregation.Fragment" scope="request" />
 
<%-----------------------------------------------------------------------------
	Report content fragment
-----------------------------------------------------------------------------%>
<TR VALIGN='top'>
	<TD>
		<%
			if ( fragment != null )
			{
				fragment.callBack( request, response );
			}
		%>
		<DIV ID="Document" CLASS="birtviewer_document_fragment">
		</DIV>
	</TD>
</TR>