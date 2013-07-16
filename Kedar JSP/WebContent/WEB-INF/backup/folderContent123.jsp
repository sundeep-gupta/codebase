<html>

<%
	String folderName = request.getParameter("file");
%>

<head>
<%@ page import="java.io.*"	%>
<title>	Contents of folder	<%= "\"" + request.getParameter("file")	+ "\"" %>	</title>
</head>



<body>

<%
	File folder = new File("../webapps/kndn/Data/" + folderName);
	String contents[] = folder.list();
	byte[] buff = new byte[1024];
	int charsRead=-1;
	OutputStream stream = response.getOutputStream();

	for(int loopCount = 0; loopCount < contents.length; loopCount++){
//response.setContentType("text/html");
//stream.write(loopCount);
		DataInputStream dis = new DataInputStream(new FileInputStream(folder.getAbsolutePath() + "/" + contents[loopCount]));
		String type = request.getContentType();
		response.setContentType("image/gif");
		while((charsRead = dis.read(buff, 0, 1024)) != -1){
			stream.write(buff);
	
		}
//		response.setContentType("text/html");
		
	}
	stream.close();

//		out.println("<img src=\"" + new File("../webapps/kndn/WEB-INF/Data/" + folderName).getAbsolutePath() + "/" + contents[loopCount] + "\">");
		
		
%>
	


</body>

</html>