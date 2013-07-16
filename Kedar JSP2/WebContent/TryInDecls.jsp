<%!
	public void doSomething(JspWriter out) throws Exception{
		out.println("kedar");
	}
%>

<%
	doSomething(out);
%>