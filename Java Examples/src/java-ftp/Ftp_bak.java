import java.net.*;
import java.io.*;
import java.util.*;
import java.lang.*;
import java.text.*;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 * The simplest possible servlet.
 *
 * @author James Duncan Davidson
 */

public class Ftp extends HttpServlet {
	// at what offset to resume a file transfer 
	static long restartpoint = 0L;
    // ftpd result code prefixes 
	static final int PRELIM = 1; 
   // positive preliminary 
	static final int COMPLETE = 2; 
   // positive completion 
	static final int CONTINUE = 3; 
   // positive intermediate 
	static final int TRANSIENT = 4; 
  // transient negative completion 
	static final int ERROR = 5; 
 // permanent negative completion

	public Socket echoSocket= null;
    public PrintStream os = null;
    public DataInputStream is = null;
    public DataInputStream stdIn = null;

	public Ftp()
	{
		stdIn = new DataInputStream(System.in); 
	
		try 
		{
			echoSocket = new Socket("ftp5.pershing.com", 21); 
			// ftp port 
			os = new PrintStream(echoSocket.getOutputStream());
			is = new DataInputStream(echoSocket.getInputStream()); 
			System.out.println("POST");
		} 
		catch (UnknownHostException e) 
		{ 
			System.out.println(e); 
		} 
		catch (IOException e) 
		{ 
			System.out.println(e); 
		}
	}


    public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException
    {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
		String result = "";
		int r=0;
		String userInput1 = request.getParameter("UNAME");
		String userInput2 = request.getParameter("PASSWORD");
		String bid = request.getParameter("bid");
		String fname = request.getParameter("fname");

		if (userInput1 != null && userInput2 != null)
		{
			r = user_pass(userInput1,userInput2);
						
			if (r == 230)
			{
				 header(out);
				 result = list();
				 display(result,out,userInput1);
				 footer(out);
		    }
			else
			{
					out.println("<html>");
			        out.println("<head>");
			   	    out.println("<title> Web Ftp Server</title>");
			        out.println("</head>");
			        out.println("<body bgcolor=\"white\">");
					out.println("<h1> Invalid ID or Password </h1>");
					out.println("</body>");
					out.println("</html>");
			}
		}
		else
		{
			if (bid !=null && fname != null )
			{
				response.setContentType("application/download");
				response.setHeader ("Content-Disposition", "attachment; filename=\"" + fname + "\"");
				download(bid,userInput1);

			}
			else
			{
					out.println("<html>");
			        out.println("<head>");
			   	    out.println("<title> Web Ftp Server</title>");
			        out.println("</head>");
			        out.println("<body bgcolor=\"white\">");
					out.println("<h1> No File to Download </h1>");
					out.println("</body>");
					out.println("</html>");
			}
		}
    }

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException
    {
		 doGet(request,response);
	}

	public void header(PrintWriter out)
	{
		out.println("<html>");
        out.println("<head>");
   	    out.println("<title> Web Ftp Server</title>");
        out.println("</head>");
        out.println("<body bgcolor=\"white\">");
		out.println("<h2><center> Ftp Server </center></h2>");
		out.println("<CENTER><TABLE BORDER=1><TR><TH>Flags</TH><TH>Format</TH><TH>Mailbox</TH><TH>Batch# </TH><TH>Size(in Bytes)</TH><TH> Creation Month</TH><TH>Creation date</TH><TH>Creation time</TH><TH>Description (Batch ID)</TH></TR>");
	}

public void footer(PrintWriter out)
	{
		out.println("</body>");
		out.println("</html>");
	}

public int user_pass(String username,String password)
{
	String user_mod;
	String pass_mod;
	System.out.println(username);
	System.out.println(password);
	user_mod = "user "+username;   
	pass_mod = "pass "+password;
	int replycode = getreply(is);	
	os.println(user_mod);
	replycode = getreply(is);
    if (replycode==331)
		os.println(pass_mod);
	replycode=getreply(is);
							
		return(replycode);
}

public static int getreply(DataInputStream is)
{ 
	String sockoutput;
	// get reply (intro) 
	try 	
	{ 
		do 
		{ 
			sockoutput = is.readLine(); 
			System.out.println(sockoutput);
		} 
		while(!(Character.isDigit(sockoutput.charAt(0)) && Character.isDigit(sockoutput.charAt(1)) && Character.isDigit(sockoutput.charAt(2)) && sockoutput.charAt(3) == ' ')); 
	} 
	catch (IOException e) 
	{ 
		System.out.println("Error getting reply from controlport"); 
		return(0); 
	}
	return(Integer.parseInt(sockoutput.substring(0, 3)));
}
// end getreply 

public void display(String result,PrintWriter out,String userInput1)
{
	String[][] str = new String[100][100];
	String res = "";
	String[] str1 = new String[50];
	String[] str2 = new String[50];
	
	str1 = getbid(result);
	str2 = getfname(result);
	int i = 1;
	int j = 1;
	int k = 1;				
	StringTokenizer st1 = new StringTokenizer(result,"\n");
	while (st1.hasMoreTokens()) 
		{
			out.println("<TR>");
			res = st1.nextToken();
			if(res.startsWith("Total"))
				break;
				
			StringTokenizer st  = new StringTokenizer(res," ");
			while(st.hasMoreTokens())
			{
				str[i][j] = st.nextToken();
				if (j==9)
				{
					out.println("<TD><A HREF=\"/examples/servlet/Ftp?bid="+str1[i]+"&UNAME="+userInput1+"&fname="+str2[i]+"\"><CENTER>"+str[i][j]+"</CENTER></A></TD>");
					j++;
				}
				else
				{
					out.println("<TD><CENTER>"+str[i][j]+"</CENTER></TD>");
					j++;
				}
			}
					i++;
					k++;
					out.println("</TR>");
					j = 1;
		 }
		 out.println("</TABLE></CENTER>");
		 out.print("<CENTER>"+res+"</CENTER>");
}



public String[] getbid(String result)
{
	int i = 1;
	int j = 1;
	int k = 1;
	int n = 1;
	String[][] str = new String[100][100];
	String res = "";
	String[] str1 = new String[50];
	StringTokenizer st1 = new StringTokenizer(result,"\n");
			while (st1.hasMoreTokens()) 
				{
					res = st1.nextToken();
					if(res.startsWith("Total"))
						break;
					StringTokenizer st  = new StringTokenizer(res," ");
					while(st.hasMoreTokens())
					{
							str[i][j] = st.nextToken();
							if ( j == 4 )
							{
								str1[k] = str[i][j];
								k++;
							}
							j++;
					}
							i++;
							j = 1;
				 }
	return(str1);
}

public String[] getfname(String result)
{
	int i = 1;
	int j = 1;
	int k = 1;
	String[][] str = new String[100][100];
	String res = "";
	String[] str1 = new String[50];
	StringTokenizer st1 = new StringTokenizer(result,"\n");
			while (st1.hasMoreTokens()) 
				{
					res = st1.nextToken();
					if(res.startsWith("Total"))
						break;
					StringTokenizer st  = new StringTokenizer(res," ");
					while(st.hasMoreTokens())
					{
							str[i][j] = st.nextToken();
							if ( j == 9 )
							{
								str1[k] = str[i][j];
								k++;
							}
							j++;
					}
							i++;
							j = 1;
				 }
	return(str1);
}

public static String doDataPort(String command, boolean saveToFile, DataInputStream incontrolport, PrintStream outcontrolport)
{ 
	String str = "";
	ServerSocket serverSocket = null; 
	try 
	{ 
		serverSocket = new ServerSocket(0); 
	} 
	catch (IOException e) 
	{ 
		System.out.println("Could not get port for listening: " + serverSocket.getLocalPort() + ", " + e);
		return ""; 
	} 
	port(serverSocket, incontrolport, outcontrolport); 
	
	outcontrolport.println(command); 
	System.out.println(command); 
	int ret = getreply(incontrolport); 

	// guess this should be an exception if false 
     
		// connect to data port 
		Socket  clientSocket = null; 
		try 
		{ 	
			clientSocket = serverSocket.accept();
		} 
		catch (IOException e) 
		{ 
			System.out.println("Accept failed: " + serverSocket.getLocalPort() + ", " + e);
		} 
		try 
		{ 
			InputStream is = clientSocket.getInputStream();	
			ByteArrayOutputStream f = new ByteArrayOutputStream();
			byte b[] = new byte[1024]; 
			// 1K blocks I guess 
			int amount; 
		
			while((amount = is.read(b)) != -1) 
			{
				f.write(b,0,amount);
				str= f.toString()+"\n";
			}
			System.out.print(str);
			
			// write to screen 
			getreply(incontrolport); 
			is.close(); 
			// clean up when done 
			clientSocket.close(); 
		} 
		catch (IOException e) 
		{ 
			e.printStackTrace(); 
		} 

		try 
		{ 
			serverSocket.close(); 
		} 
		catch (IOException e) 
		{ 
			System.out.println("Error closing server socket."); 
		} 
		return str;
} // end list 

public static boolean port(ServerSocket serverSocket, DataInputStream incontrolport, PrintStream outcontrolport) 
{ 
	int localport = serverSocket.getLocalPort(); 
	System.out.println("Will listen on port, " + localport); 
	// get local ip address 
	InetAddress inetaddress = serverSocket.getInetAddress(); 
	InetAddress localip; 
	try 
	{ 
		localip = inetaddress.getLocalHost(); 
	} 
	catch(UnknownHostException e) 
	{ 
		System.out.println("can't get local host"); 
		return(false); 
	} 	
	// get ip address in high byte order 
	byte[] addrbytes = localip.getAddress(); 
	// tell server what port we are listening on 
	short addrshorts[] = new short[4]; 
	// problem: bytes greater than 127 are printed as negative numbers 
	for(int i = 0; i <= 3; i++)
	{ 
		addrshorts[i] = addrbytes[i]; 
		if(addrshorts[i] < 0) addrshorts[i] += 256; 
	} 
	outcontrolport.println("port " + addrshorts[0] + "," + addrshorts[1] + "," + addrshorts[2] + "," + addrshorts[3] + "," + ((localport & 0xff00) >> 8) + "," + (localport & 0x00ff)); 
	// echo for myself 
	System.out.println("port " + addrshorts[0] + "," + addrshorts[1] + "," + addrshorts[2] + "," + addrshorts[3] + "," + ((localport & 0xff00) >> 8) + "," + (localport & 0x00ff)); 
	int result = getreply(incontrolport); 
	return(result == COMPLETE); 
}// end port


public String list()
{
	String replylist="";
	replylist = doDataPort("list", false, is, os);
	return replylist;
}

public void download(String bid,String userInput1)
{
	doDataPort_download("retr $$ id="+userInput1+" bid=#"+bid+"", true, is, os);

}

public static void doDataPort_download(String command, boolean saveToFile, DataInputStream incontrolport, PrintStream outcontrolport)
{ 
	ServerSocket serverSocket = null; 
	try 
	{ 
		serverSocket = new ServerSocket(0); 
	} 
	catch (IOException e) 
	{ 
		System.out.println("Could not get port for listening: " + serverSocket.getLocalPort() + ", " + e);
		return; 
	} 
	port(serverSocket, incontrolport, outcontrolport); 
	
	// set binary type transfer 
	if(saveToFile)
	{ 	
		outcontrolport.println("type i"); 	
		System.out.println("type i"); 
		getreply(incontrolport); 
	}
 	
	// ok, send command 	
	if(restartpoint != 0)
	{ 
		// have to do right before retr 
		outcontrolport.println("rest " + restartpoint); 
		System.out.println("rest " + restartpoint); 
		getreply(incontrolport);
	} 

	outcontrolport.println(command); 
	System.out.println(command); 
	int result = getreply(incontrolport); 

	// guess this should be an exception if false 
	if(true)
	{ 
		// connect to data port 
		Socket  clientSocket = null; 
		try 
		{ 	
			clientSocket = serverSocket.accept();
		} 
		catch (IOException e) 
		{ 
			System.out.println("Accept failed: " + serverSocket.getLocalPort() + ", " + e);
		} 
		try 
		{ 
			InputStream is = clientSocket.getInputStream();	
			byte b[] = new byte[1024]; 
			// 1K blocks I guess 
			int amount; 
			if(saveToFile)
			{ 
				// get filename argument 
				StringTokenizer stringtokens = new StringTokenizer(command); 
				stringtokens.nextToken(); 
				String filename = stringtokens.nextToken(); 
				// open file 
				RandomAccessFile outfile = new RandomAccessFile(filename, "rw"); 
				// do restart if desired 
				if(restartpoint != 0)
				{ 
					System.out.println("seeking to " + restartpoint); 
					outfile.seek(restartpoint); 
					restartpoint = 0; 
				} 
				while((amount = is.read(b)) != -1)
				{ 
					outfile.write(b, 0, amount); 
					System.out.print("#"); 
				} 
				System.out.print("\n"); 
				outfile.close(); 
			} 
			// end if savetofile else 
			getreply(incontrolport); 
			is.close(); 
			// clean up when done 
			clientSocket.close(); 
		} 
		catch (IOException e) 
		{ 
			e.printStackTrace(); 
		} 
	} 
	// end if PRELIM 
	else
	{ 
		System.out.println("Error calling for download"); 
		try 
		{ 
			serverSocket.close(); 
		} 
		catch (IOException e) 
		{ 
			System.out.println("Error closing server socket."); 
		} 
	} 
} // end download() 

}