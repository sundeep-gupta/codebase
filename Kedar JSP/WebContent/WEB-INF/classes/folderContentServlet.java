import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class folderContentServlet extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException{

		String folderName = req.getParameter("file");

		File folder = new File("../webapps/kndn/WEB-INF/Data/" + folderName);
		String contents[] = folder.list();
		byte[] buff = new byte[1024];
		int charsRead=-1;
		ServletOutputStream stream = res.getOutputStream();
//		PrintWriter out = res.getWriter();
		
		res.setContentType("text/html");
//		stream.write(contents.length);
//		out.print(contents.length);


	
		for(int loopCount = 0; loopCount < contents.length; loopCount++){

			DataInputStream dis = new DataInputStream(new FileInputStream(folder.getAbsolutePath() + "/" + contents[loopCount]));
stream.print("<a href=\"/kndn/folders.jsp\"> kedarnath </a>");
			res.setContentType("image/jpeg");
			res.addHeader("Content-Disposition","filename=getimage.jpeg");
			while((charsRead = dis.read(buff, 0, 1024)) != -1){
				stream.write(buff);
		
			}
			res.flushBuffer();
			dis.close();
			res.setContentType("text/html");
			stream.print("<br />");
			
		}	
		stream.close();
//		out.close();
			
		}
}