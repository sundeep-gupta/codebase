<html>
<head>
<title>	Authenticated Administrator	</title>

<%@ page import="javax.servlet.*, javax.servlet.http.*, java.io.*" %>

</head>

<body>

<form name="uploadFile" method="post" action="http://localhost:8080/kndn/jmxUploadFile.jsp" ENCTYPE="multipart/form-data">
<input type="file" name="fileToBeUploaded" />
<input type="submit" value="Upload" />
</form>

</body>
</html>