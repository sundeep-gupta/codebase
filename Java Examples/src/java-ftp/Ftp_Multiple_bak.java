import java.net.*;
import java.io.*;
import java.util.*;
import java.lang.*;
import java.text.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Ftp_Multiple extends HttpServlet {

	static long restartpoint = 0L;

	static final int PRELIM = 1; 

	static final int COMPLETE = 2; 
 
	static final int CONTINUE = 3; 

	static final int TRANSIENT = 4; 
 
	static final int ERROR = 5; 


    public Socket echoSocket= null;
    public PrintStream os = null;
    public DataInputStream is = null;
    public DataInputStream stdIn = null;

	public Ftp_Multiple()
	{
		stdIn = new DataInputStream(System.in); 
	
		try 
		{
			echoSocket = new Socket("ftp5.pershing.com", 21); 

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
        ServletOutputStream out = response.getOutputStream();
		String result = "";
		int r=0;
		String userInput1 = request.getParameter("UNAME");
		String userInput2 = request.getParameter("PASSWORD");
		String bid_fname[] = request.getParameterValues("chk_file");
		
		if (userInput1 != null && userInput2 != null)
		{
    		reFtp_Multiple();
			r = user_pass(userInput1,userInput2);
						
			if (r == 230)
			{
				 header(out);
				 result = list(out);
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
				getfiles_download(bid_fname,userInput1,out,response);
		}
    }

	public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException
    {
		
		 doGet(request,response);
	}

public void reFtp_Multiple()
	{
		stdIn = new DataInputStream(System.in); 
	
		try 
		{
			echoSocket = new Socket("ftp5.pershing.com", 21); 

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


	public void header(ServletOutputStream out) throws IOException
	{
		out.println("<html>");
		out.println("<head>");
   		out.println("<title> Web Ftp Server</title>");
		out.println("</head>");
		out.println("<body bgcolor=\"white\">");
		out.println("<h2><center> Ftp Server </center></h2>");
		out.println("<Form Method=\"POST\" Action=\"/examples/servlet/Ftp_Multiple\">");
		out.println("<CENTER><TABLE BORDER=1><TR><TH>Flags</TH><TH>Format</TH><TH>Mailbox</TH><TH>Batch# </TH><TH>Size(in Bytes)</TH><TH> Creation Month</TH><TH>Creation date</TH><TH>Creation time</TH><TH>Description (Batch ID)</TH><TH></TH></TR>");
	}

public void footer(ServletOutputStream out) throws IOException
	{
		out.println("</Form>");
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


public void display(String result,ServletOutputStream out,String userInput1) throws IOException
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
					out.println("<TD><CENTER>"+str[i][j]+"</CENTER></TD>");
					j++;				
			}
					out.println("<TD><input type=\"checkbox\" name=\"chk_file\" value=\""+str1[i]+"_"+str2[i]+"\"></TD>");
					i++;
					k++;
					out.println("</TR>");
					j = 1;
		 }
		 out.println("</TABLE></CENTER>");
		 out.print("<CENTER>"+res+"</CENTER>");
		 out.print("<input type=\"hidden\" value=\""+userInput1+"\" name=\"UNAME\">");
		 out.print("<BR><CENTER><input type=\"submit\" value=\"Download\" name=\"download\">");
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

public static String doDataPort(String command, boolean saveToFile, DataInputStream incontrolport, PrintStream outcontrolport,ServletOutputStream out)
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
	port(serverSocket, incontrolport, outcontrolport,out); 
	
	outcontrolport.println(command); 
	System.out.println(command); 
	int ret = getreply(incontrolport); 

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

			int amount; 
		
			while((amount = is.read(b)) != -1) 
			{
				f.write(b,0,amount);
				str= f.toString()+"\n";
			}
			System.out.print(str);
			

			getreply(incontrolport); 
			is.close(); 

			clientSocket.close(); 
		} 
		catch (IOException e) 
		{ 
			System.out.println(e);
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
} 

public static boolean port(ServerSocket serverSocket, DataInputStream incontrolport, PrintStream outcontrolport,ServletOutputStream out) 
{ 
	int result = 0;
	try
	{

	int localport = serverSocket.getLocalPort(); 
	System.out.println("Will listen on port, " + localport); 

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

	byte[] addrbytes = localip.getAddress(); 

	short addrshorts[] = new short[4]; 

	for(int i = 0; i <= 3; i++)
	{ 
		addrshorts[i] = addrbytes[i]; 
		if(addrshorts[i] < 0) addrshorts[i] += 256; 
	} 
	outcontrolport.println("port " + addrshorts[0] + "," + addrshorts[1] + "," + addrshorts[2] + "," + addrshorts[3] + "," + ((localport & 0xff00) >> 8) + "," + (localport & 0x00ff)); 

	System.out.println("port " + addrshorts[0] + "," + addrshorts[1] + "," + addrshorts[2] + "," + addrshorts[3] + "," + ((localport & 0xff00) >> 8) + "," + (localport & 0x00ff)); 
	result = getreply(incontrolport);

	System.out.println(result);

	if( result == 421 )
	{
			out.println("<html>");
		    out.println("<head>");
		    out.println("<title> Web Ftp Server</title>");
		    out.println("</head>");
		    out.println("<body bgcolor=\"white\">");
		    out.println("<h1> Login the session again. </h1>");
			out.println("</body>");
			out.println("</html>");
	}
	
	}

	catch (Exception e)
	{
		System.out.println(e);
	}
	return(result == COMPLETE); 
}


public String list(ServletOutputStream out)
{
	String replylist="";
	replylist = doDataPort("list", false, is, os,out);
	return replylist;
}

public void getfiles_download(String[] bid_fname,String userInput1,ServletOutputStream out,HttpServletResponse response)
{
		int i=0;
		String[] bid = new String[50];
		String[] fname = new String[50];
		System.out.println(bid_fname[i]);

			try
			{
				do
				{
					StringTokenizer st1 = new StringTokenizer(bid_fname[i],"_");
					while (st1.hasMoreTokens()) 
					{
						bid[i] = st1.nextToken();
						fname[i] = st1.nextToken();
						i++;
					}
				}while( bid_fname[i] != null);
			}
		
		catch (Exception e)
		{
			System.out.println(e);
		}

		download(bid,userInput1,out,fname,response,i);		
}

public void download(String[] bid,String userInput1,ServletOutputStream out,String[] fname,HttpServletResponse response,int j)
{
	for (int k=0 ; k<j ; k++)
	{
		doDataPort_download("retr $$ id="+userInput1+" bid=#"+bid[k]+"", true, is, os,out,fname[k],response);
	}
	
}

public void doDataPort_download(String command, boolean saveToFile, DataInputStream incontrolport, PrintStream outcontrolport,ServletOutputStream out,String fname,HttpServletResponse response)
{ 
	ServerSocket serverSocket = null; 
	try 
	{ 
		serverSocket = new ServerSocket(0); 
	} 
	catch (IOException e) 
	{ 
		System.out.println("Could not get port for listening: " + serverSocket.getLocalPort() + ", " + e);
		return ; 
	} 
	port(serverSocket, incontrolport, outcontrolport,out); 
	

	if(saveToFile)
	{ 	
		outcontrolport.println("type a"); 	
		System.out.println("type a"); 
		getreply(incontrolport); 
	}
 	
	
	if(restartpoint != 0)
	{ 
 
		outcontrolport.println("rest " + restartpoint); 
		System.out.println("rest " + restartpoint); 
		getreply(incontrolport);
	} 

	outcontrolport.println(command); 
	System.out.println(command); 
	int result = getreply(incontrolport); 


	if(true)
	{ 

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


			filedownload(is,out,fname,response);
			
			is.close(); 
			getreply(incontrolport); 	

			clientSocket.close(); 
			
		} 
		catch (IOException e) 
		{ 
			System.out.println(e);
		}		
	} 
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
} 

public void filedownload(InputStream ip,ServletOutputStream out,String fname,HttpServletResponse response) throws IOException
{
	try
	{
		response.setContentType("application/download");
		response.setHeader ("Content-Disposition", "attachment; ");
		byte[] buf = new byte[4 * 1024]; 
	    int bytesRead;
	    while ((bytesRead = ip.read(buf)) != -1) out.write(buf, 0, bytesRead);		
	}
	catch(Exception e)
	{
		System.out.println(e);
	}
}
}