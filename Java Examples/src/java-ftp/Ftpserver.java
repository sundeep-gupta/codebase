package num;

import java.net.*;
import java.io.*;
import java.util.*;
import java.lang.*;
import javax.servlet.*;
import javax.servlet.http.*;



public class Ftpserver extends HttpServlet { 


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
    public String user_mod;
	public String pass_mod;


	public Socket echoSocket= null;
    public PrintStream os = null;
    public DataInputStream is = null;
    public DataInputStream stdIn = null;

// constructor
public Ftpserver()
{
	stdIn = new DataInputStream(System.in); 
	
	try 
	{
		echoSocket = new Socket("ftp5.pershing.com", 21); 
		// ftp port 
		os = new PrintStream(echoSocket.getOutputStream());
		is = new DataInputStream(echoSocket.getInputStream()); 
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

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    ServletOutputStream out = res.getOutputStream();
    String filename = req.getParameter("fname");
	String userInput1 = req.getParameter("uname");
	String bid = req.getParameter("bid");

	os.println("user "+userInput1);
	getreply(is);
	String userInput2 = req.getParameter("passwd");
	os.println("pass "+userInput2);
	getreply(is);

    // No file, nothing to download
    if (filename == null) {
    
    out.println("No file to download");
    return;
    }
	res.setContentType("application/download");
	res.setHeader ("Content-Disposition", "attachment; filename=\"" + filename + "\"");
	
	//doDataPort("retr $$ id="+userInput1+" bid=#"+bid+"", true, is, os);

    /*String pathName = getServletContext().getRealPath("/ftpserver/" + filename);
     String contentType = getServletContext().getMimeType(pathName);
    // .xls files content type is not known
    if (contentType != null) res.setContentType(contentType);
     else res.setContentType("application/octet-stream");
    res.setHeader ("Content-Disposition", "attachment; filename=\"" + filename + "\"");

// Return the file
    try {
			returnFile(pathName, out);
    }
    catch (FileNotFoundException e) {
    out.println("File not found: " + pathName);
    }
    catch (IOException e) {
    out.println("Problem sending file " + pathName + ": " + e.getMessage());
    }

    }*/


public static void returnFile(String filename, OutputStream out) throws FileNotFoundException, IOException {
    // A FileInputStream is for bytes
    FileInputStream fis = null;
    try {
    fis = new FileInputStream(filename);
     byte[] buf = new byte[4 * 1024]; // 4K buffer
    int bytesRead;
    while ((bytesRead = fis.read(buf)) != -1) out.write(buf, 0, bytesRead);}
    finally {
    if (fis != null) fis.close();
    }
    }


	
public static void rename(String fname)
	{
		File f = new File("C:\\Documents and Settings\\sramalingam\\Start Menu\\Programs\\Apache Tomcat 4.1\\$$");
		File f1 = new File("C:\\Documents and Settings\\sramalingam\\Start Menu\\Programs\\Apache Tomcat 4.1\\"+fname+"");
		System.out.println(fname);
		if(f.renameTo(f1))
		{
			System.out.println("File renamed");
		}		
		
	}	


public static void copyfile(String fname,String result)
{
	/*try
	{      
		System.out.println(fname);
		String dest = "C:\\Data\\Tomcat 4.1\\webapps\\examples\\"+fname+"";
		System.out.println(dest);
		FileOutputStream out;
		PrintStream p; 
		
		out = new FileOutputStream(dest);
		p = new PrintStream( out );
		if(result != null)
		{
				p.println (result);
			
		}
		p.close();
	} 
	catch (Exception e)
	{
		e.printStackTrace();
	}*/

	
	try {
		System.out.println(fname);
		//String nme = "c:\\data\\REO2.REO2";
		String nme = "C:\\Data\\Tomcat 4.1\\webapps\\examples\\ftpserver\\"+fname+"";
		FileWriter fw = new FileWriter(new File(nme));
	    fw.write(result);
		fw.flush();
		fw.close();
	
	} catch (Exception e) {
		e.printStackTrace();
	}


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


public static String getreply_str(DataInputStream is)
{ 
	String sockoutput;
	String temp=""; 
	// get reply (intro) 
	try 	
	{ 
		do 
		{ 
			sockoutput = is.readLine(); 
			System.out.println(sockoutput);
			temp = temp+sockoutput;
		} 
		while(!(Character.isDigit(sockoutput.charAt(0)) && Character.isDigit(sockoutput.charAt(1)) && Character.isDigit(sockoutput.charAt(2)) && sockoutput.charAt(3) == ' ')); 
	} 
	catch (IOException e) 
	{ 
		System.out.println("Error getting reply from controlport"); 
		return("0"); 
	}
	return(temp);
	//return(Integer.parseInt(sockoutput.substring(0, 1)));
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
	return(Integer.parseInt(sockoutput.substring(0, 1)));
}
// end getreply

/** Performs downloading commands that need a data port. Tells server 
which data port it will listen on, then sends command on control port, 
then listens on data port for server response. @param command list, nlist, or 
retr plus arguments @param saveToFile whether to save to file or print to screen from 
data port @param incontrolport input stream on the control port socket 
@param outcontrolport output stream on the control port socket. 
*/
 
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
		return(""); 
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
	if(result == PRELIM)
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
			ByteArrayOutputStream f = new ByteArrayOutputStream();

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
					f.write(b,0,amount);
					str=f.toString();
					System.out.print("#"); 
				} 
				System.out.print("\n"); 
				outfile.close(); 
			} 
			
			
			int i=0;
			// end if savetofile else 
			while((amount = is.read(b)) != -1) 
			{
				f.write(b,0,amount);
				str= f.toString()+"\n";
				
			//	System.out.write(b, 0, amount); 
			}
			System.out.print(str);
			
			// write to screen */
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
return(str);
} // end list() 



/** 
* Set the restart point for the next retr. This way you can 
* resume an interrupted upload or download just like with zmodem. 
* Actually it doesn't send the rest command until right before the 
* retr (it has to be that way), but it will remember to do it. 
* 
* @param command The command line that begins with rest. 
* @param incontrolport For reading from the ftp control port. 
* @param outcontrolport For writing to the ftp control port. 
*/ 

public static void rest(String command, DataInputStream incontrolport, PrintStream outcontrolport)
{ 
	StringTokenizer stringtokens = new StringTokenizer(command); 
	stringtokens.nextToken(); 
	// put second argument here 
	restartpoint = Integer.parseInt(stringtokens.nextToken()); 
	System.out.println("restart noted"); 
} 

/** Upload a file in binary mode using either stor or stou. Looks like restart 
doesn't work with stores, unfortunately. Ftpd at least on my solaris account zeros 
out the old half of the file already transferred.@param command stor or stou plus 
arguments @param incontrolport input stream on the control port socket 
@param outcontrolport output stream on the control port socket. 
*/ 

public static boolean upload(String command, DataInputStream incontrolport, PrintStream outcontrolport)
{ 
	ServerSocket serverSocket = null; 
	try 
	{ 
		serverSocket = new ServerSocket(0); 
	} 
	catch (IOException e) 
	{ 
		System.out.println("Could not get port for listening: " + serverSocket.getLocalPort() + ", " + e);
		return(false); 
	} 
	port(serverSocket, incontrolport, outcontrolport);
	// set binary type transfer 
	outcontrolport.println("type i"); 
	System.out.println("type i"); 
	getreply(incontrolport); 
	// send restart if desired 
	if(restartpoint != 0)
	{ 
		// have to do right before retr? 
		outcontrolport.println("rest " + restartpoint); 
		System.out.println("rest " + restartpoint); 
		getreply(incontrolport); 
	} 
	// ok, send command 	
	outcontrolport.println(command); 
	System.out.println(command); 
	int result = getreply(incontrolport); 
	// guess this should be an exception if false 
	if(result == PRELIM)
	{ 
		// listen on data port
		Socket clientSocket = null; 
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
			OutputStream outdataport = clientSocket.getOutputStream(); 
			byte b[] = new byte[1024]; 
			// 1K blocks I guess 
			// get filename argument 	
			StringTokenizer stringtokens = new StringTokenizer(command); 
			stringtokens.nextToken(); 
			String filename = stringtokens.nextToken(); 
			// open file 
			RandomAccessFile infile = new RandomAccessFile(filename, "r"); 
			// do restart if desired 
			if(restartpoint != 0)
			{ 
				System.out.println("seeking to " + restartpoint); 
				infile.seek(restartpoint); 
				restartpoint = 0; 
			} 
			// do actual upload 
			int amount; 
			//*** read returns 0 at end of file, not -1 as in api 
			// while((amount = infile.read(b)) != -1){ 
			//while((amount = infile.read(b)) != 0){
			while ((amount = infile.read(b)) > 0)
			{ 
				outdataport.write(b, 0, amount); 
				System.out.print("#"); 
			} 
			System.out.print("\n"); 
			infile.close(); 
			outdataport.close(); 
			// clean up when done 
			clientSocket.close();
			serverSocket.close(); 
			result = getreply(incontrolport);
		} 
		catch (IOException e) 
		{ 
			e.printStackTrace(); 
		} 
		return(result == COMPLETE); 
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
		return(false); 
	} 
}// end upload 

/** 
Get ip address and port number from serverSocket and send them via the port 
command to the ftp server, and getting a valid response.@param serverSocket Socket 
to get info from.@return true or false depending on success 
*/ 
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

} // Class Ftp