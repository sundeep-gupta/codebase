import java.io.*;
import java.util.zip.GZIPOutputStream;
import javax.servlet.ServletException;
import javax.servlet.ServletResponse;
import javax.servlet.http.*;

public class GzipServlet extends HttpServlet
{

    public void doGet(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws ServletException, IOException
    {
        doPost(httpservletrequest, httpservletresponse);
    }

    public void doPost(HttpServletRequest httpservletrequest, HttpServletResponse httpservletresponse)
        throws ServletException, IOException
    {
        String s = httpservletrequest.getHeader("Accept-Encoding");
        boolean flag = false;
        if(s != null && s.indexOf("gzip") >= 0)
            flag = true;
        if(flag)
        {
            httpservletresponse.setHeader("Content-Encoding", "gzip");
            javax.servlet.ServletOutputStream servletoutputstream = httpservletresponse.getOutputStream();
            GZIPOutputStream gzipoutputstream = new GZIPOutputStream(servletoutputstream);
            String s1 = "";
            s1 = s1 + "<html>";
            s1 = s1 + "<br>Go ahead and add text and code...it will compress it.";
            s1 = s1 + "<br>_____________________________________________________";
            s1 = s1 + "<br>this was compressed";
            s1 = s1 + "<br>this was compressed";
            gzipoutputstream.write(s1.getBytes());
            gzipoutputstream.close();
            servletoutputstream.close();
            return;
        } else
        {
            PrintWriter printwriter = httpservletresponse.getWriter();
            httpservletresponse.setContentType("text/html");
            printwriter.println("<html>");
            printwriter.println("Your browser does not support GZIP encoding. Please upgrade");
            printwriter.println("</html>");
            printwriter.flush();
            printwriter.close();
            return;
        }
    }

    public GzipServlet()
    {
    }
}

