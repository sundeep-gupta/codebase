<%
if(((String)session.getAttribute("user")).equals("admin")){
 
    response.setContentType("text/html");
    response.setHeader("Cache-control","no-cache");
 
    String err = "";
    String lastFileName = "";
 
    String contentType = request.getContentType();
    String boundary = "";
	String folderName = "";
	int folderNameStart=-1, folderNameEnd = -1;
	boolean myFlag = false;

    final int BOUNDARY_WORD_SIZE = "boundary=".length();

    if(contentType == null || !contentType.startsWith("multipart/form-data")) {
      err = "Ilegal ENCTYPE : must be multipart/form-data\n";
      err += "ENCTYPE set = " + contentType;
    }
	else{

      boundary = contentType.substring(contentType.indexOf("boundary=") + BOUNDARY_WORD_SIZE);
      boundary = "--" + boundary;


		try {
        
		javax.servlet.ServletInputStream sis = request.getInputStream();
        byte[] b = new byte[1024*10];
        int x=0;
        int state=0, prevState = -1;
        String fileName=null,contentType2=null;
        java.io.FileOutputStream buffer = null;

        while((x=sis.readLine(b,0,1024*10))>-1) {
			String s = new String(b,0,x);

			if(s.startsWith(boundary)) {
				prevState = state;
				state = 0;
//out.println(prevState + " " + state + "Boundary : " + s  + "$$$$<br />");
//				name = null;
//				contentType2 = null;
				fileName = null;
			}else if(s.startsWith("Content-Disposition") && state==0) {
				prevState=state;
		        state = 1;
//out.println(prevState + " "  + state + "ContentDisp : " + s + "$$$$<br />");
				if(s.indexOf("filename=") != -1){
//					name = s.substring(s.indexOf("name=") + "name=".length(),s.lastIndexOf(";"));
					fileName = s.substring(s.indexOf("filename=") + "filename=".length(),s.length()-2);
					if(fileName.equals("\"\"")) {
						fileName = null;
					}else {
						String userAgent = request.getHeader("User-Agent");
						String userSeparator="/";  // default
						if (userAgent.indexOf("Windows")!=-1)
							userSeparator="\\";
						if (userAgent.indexOf("Linux")!=-1)
							userSeparator="/";
						fileName = fileName.substring(fileName.lastIndexOf(userSeparator)+1,fileName.length()-1);
						if(fileName.startsWith( "\""))
							fileName = fileName.substring( 1);
					}
				}
//				name = name.substring(1,name.length()-1);
//            if (name.equals("file")) 
//				{
				if (buffer!=null)
					buffer.close();
				lastFileName = fileName;

				if(fileName != null && !(folderName.equals(""))){
					(new java.io.File("../webapps/kndn/WEB-INF/Data/" + folderName.substring(0, folderName.length()-1))).mkdir();
					buffer = new java.io.FileOutputStream("../webapps/kndn/WEB-INF/Data/" + folderName + fileName);
				}
			}else if(s.startsWith("Content-Type") && state==1) {
prevState = state;
				state = 2;
//out.println(prevState + " " + state + "ContentType : " + s+ "$$$$<br />");
//				contentType2 = s.substring(s.indexOf(":")+2,s.length()-2);
			}else if(s.equals("\r\n") && state != 3) {
prevState=state;
				state = 3;
//out.println(prevState + " " + state + "NewLine : " + s+ "$$$$<br />");
			}else {
//            if (name.equals("file"))
//out.println(prevState + " " + state + "Writing : " + s+ "$$$$<br />");
				if(prevState == 2){
					buffer.write(b,0,x);
				}else{
					folderName += s.trim() + "/";
				}
			}
		}
		sis.close();
		buffer.close();
		
		}catch(java.io.IOException e) {
			err = e.toString();
		}

	}
	
	boolean ok = err.equals("");
	if(ok){
System.out.println(folderName);
int x = folderName.indexOf("/")+1;
String paramToBeSent = null;
if(folderName.indexOf("/", x) != -1){
	paramToBeSent = folderName.substring(0, folderName.indexOf("/", x));
}
System.out.println(folderName.substring(0, folderName.indexOf("/", x)));
%>

		<jsp:forward page="folderContent.jsp">
			<jsp:param name="file" value="<%= paramToBeSent %>" />
		</jsp:forward>
<%
	}else{
		System.out.println(err);
%>
<%
	}
}
%>