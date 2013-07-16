<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%
		String contentType = request.getContentType();
		System.out.println(contentType);
		if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0))
	    {
		DataInputStream in = new DataInputStream(request.getInputStream());
		int formDataLength = request.getContentLength();
		byte dataBytes[] = new byte[formDataLength];
		int byteRead = 0;
		int totalBytesRead = 0;
		while (totalBytesRead < formDataLength) 
			{
				byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
				totalBytesRead += byteRead;
			}
		String file = new String(dataBytes);
		out.println(file);
		String saveFile = file.substring(file.indexOf("filename=\"") + 10);
		saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
		saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1,saveFile.indexOf("\""));
		int lastIndex = contentType.lastIndexOf("=");
		String boundary = contentType.substring(lastIndex + 1,contentType.length());
		int pos;
		pos = file.indexOf("filename=\"");
		pos = file.indexOf("\n", pos) + 1;
		pos = file.indexOf("\n", pos) + 1;
		pos = file.indexOf("\n", pos) + 1;

		int boundaryLocation = file.indexOf(boundary, pos) - 4;
		int startPos = ((file.substring(0, pos)).getBytes()).length;
		int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;

        String path = "..\\webapps\\kndn\\WEB-INF\\Data\\"+saveFile;

		
		//out.println(startPos+"  "+lastIndex+" "+file.lastIndexOf('-'));

		int praStart = file.indexOf("pra");
		final int praLen = ("pra\" ").length() + 1;
		System.out.println(praLen);
		int praValEnd = file.indexOf("-", praStart);
		String praVal = file.substring(praStart + praLen, praValEnd);

		out.println(praVal);

        
		/* out.println(file.substring(0,file.length()-46)); */
//		int custidpos = file.indexOf("txtCustID\"");
//		int custidlastpos = file.indexOf("-",custidpos);
		
//		int frqpos = file.indexOf("txtFrequency\"");

//		System.out.println(frqpos);

//		int frqlastpos = file.indexOf("-",frqpos);

//		System.out.println(frqlastpos);

//		String cid = file.substring(custidpos+14,custidlastpos-2);
        //rtrim(cid);
		
//		System.out.println(cid);

//		int custid = Integer.parseInt(cid);
		//out.println(custid);
//		String frq = file.substring(frqpos+17,frqlastpos );

		file = file.substring(startPos,file.length()-46);

      
	    byte dataBytes1[] = file.getBytes();

		FileOutputStream fileOut = new FileOutputStream(path);
		//fileOut.write(dataBytes);
		//fileOut.write(dataBytes,startPos,(endPos-startPos));
		fileOut.write(dataBytes1);
		fileOut.flush();
		fileOut.close();

		FileInputStream fis = new FileInputStream(path); 
		BufferedInputStream bis = new BufferedInputStream(fis); 
		DataInputStream dis = new DataInputStream(bis);
		String record="";
		String str = "";

		}

/*		while((record=dis.readLine()) != null)
		{
			//out.println(record);
			str+= record;
		}
		str = single(str);
		
		try
			{
				//Class.forName("com.mysql.jdbc.Driver").newInstance();
			
				Connection C = getConnection();
				//DriverManager.getConnection("jdbc:mysql://localhost:3306/birtdb","root","password");

				Statement stmt = C.createStatement();

				String SQL = "insert into testtable values('"+str+"')";

				//out.println(SQL);

				stmt.executeUpdate(SQL); 
				
				out.println("Uploaded into Database");
			}
			catch (Exception E)
			{
				E.printStackTrace();
			}
		}

*/
%>
