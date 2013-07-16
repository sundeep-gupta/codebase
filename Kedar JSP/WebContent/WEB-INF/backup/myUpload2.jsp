<%
	ServletInputStream sis = request.getInputStream();
	String str=null;
	byte[] b = new byte[1024];
	int i=0, j=0;
	System.out.println(request.getContentType());
	while((j = sis.readLine(b, 0, 1024)) > -1){
		str = new String(b, 0, j);
		out.print(str);
	}
%>