import java.io.*;
import java.net.*;
import javax.swing.*;

class ServerChat 
{
	ServerSocket srvrSkt = null;
	Socket clientSkt = null;

	BufferedReader srvrRead = null, inputRead = null;
	PrintWriter srvrWrite = null;

	String readStr, writeStr, sysName;

	JFrame chatWndK = null;
	JButton send = null;

	ServerChat(){
	try{
		
		sysName
		srvrSkt = new ServerSocket(4444);
		openChatWnd();
		System.out.println("Waiting for the client...");
		clientSkt = srvrSkt.accept();

		srvrRead = new BufferedReader(new InputStreamReader(clientSkt.getInputStream()));
		srvrWrite = new PrintWriter(clientSkt.getOutputStream(),true);

		inputRead = new BufferedReader(new InputStreamReader(System.in));

		while(true){
			readStr = srvrRead.readLine();
			if(readStr!=null)
				System.out.println("\nOuter : " + readStr);
			writeStr = inputRead.readLine();
			srvrWrite.println(writeStr);
		}
	}catch(IOException ioe){
		System.out.println(ioe);
	}catch(Exception e){
		System.out.println(e);
	}
	}

	protected void getSysName(){
		sysName = InetAddress.getHostName();
	}

	protected void openChatWnd(){
		chatWndK = new JFrame("");
	}

	public static void main(String[] args){
		new ServerChat();
	}
}
