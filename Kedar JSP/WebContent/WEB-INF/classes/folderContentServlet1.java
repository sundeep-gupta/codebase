import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class folderContentServlet1 extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException{

		String fileName = req.getParameter("file");

		File file = new File("../webapps/kndn/WEB-INF/Data/" + fileName);
		byte[] buff = new byte[1024];
		int charsRead=-1;
		ServletOutputStream stream = res.getOutputStream();
//		PrintWriter stream = res.getWriter();
		
//		stream.write(contents.length);
//		out.print(contents.length);


		res.setContentType("image/jpeg");
		
/*			String fileType = contents[loopCount].substring(contents[loopCount].lastIndexOf("."), contents[loopCount].length());
			System.out.println(fileType);
			if(fileType.equals(".jpeg") || fileType.equals(".jpg") || fileType.equals(".gif") || fileType.equals(".bmp")){
				res.setContentType("image/jpeg");
				stream.write("<img src=" + folder.getAbsolutePath() + "\\" + contents[loopCount] + ">");
			}
			stream.close();

*/

			DataInputStream dis = new DataInputStream(new FileInputStream(file.getAbsolutePath()));
			System.out.println("Data input stream constructed for " + file.getAbsolutePath());
//stream.print("<a href=\"/kndn/folders.jsp\"> kedarnath </a>");
			
//			res.reset();
//			res.addHeader("Content-Disposition","filename=getimage.jpeg");
			System.out.println("Reading started");
			while((charsRead = dis.read(buff, 0, 1024)) != -1){
				stream.write(buff, 0, charsRead);
		
			}
			System.out.println("Reading ended");
//			res.flushBuffer();
			dis.close();
			dis = null;
//			res.setContentType("text/html");
//			stream.print("<br />kedar");
			
		res.flushBuffer();
		stream.close();
//		out.close();
			
		}
}