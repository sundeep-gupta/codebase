<%@ include file="connection.jsp" %>


<% 
	Connection con = null;
	Statement stmt = null;
	String queryStr = null, toBeRedirectedTo = null;
	ResultSet rs = null;
	int idOrder = 0;

	con = getConnection("services");
	stmt = con.createStatement();

	queryStr = "select idCategory from categories_products where idProduct=" + request.getParameter("pid");

	rs = stmt.executeQuery(queryStr);
	
	try{
	if(rs.next()){
		switch(Integer.parseInt(rs.getString("idCategory"))){
			case 52 :	toBeRedirectedTo = "PTServiceSpecView.jsp";
						break;
			case 53 :	toBeRedirectedTo = "PMServiceSpecView.jsp";
						break;
		}
%>
		<jsp:forward page="<%= toBeRedirectedTo %>" >
			<jsp:param name="crow" value="<%= request.getParameter("crow") %>" />
		</jsp:forward>
<%
	}
	}catch(NumberFormatException ne){
	}
%>

