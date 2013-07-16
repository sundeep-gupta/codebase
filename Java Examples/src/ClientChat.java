import java.io.*;
import java.net.*;

class ClientChat 
{
	Socket clientSkt = null;
	BufferedReader clientRead = null, inputRead = null;
	PrintWriter clientWrite = null;
	String readStr, writeStr;

	ClientChat(){
	try{
		clientSkt = new Socket(InetAddress.getByName("kedarnath"),4444);

		clientWrite = new PrintWriter(clientSkt.getOutputStream(),true);
		clientRead = new BufferedReader(new InputStreamReader(clientSkt.getInputStream()));

		inputRead = new BufferedReader(new InputStreamReader(System.in));

		while(true){
			writeStr = inputRead.readLine();
			clientWrite.println(writeStr);
			readStr = clientRead.readLine();
			if(readStr == null)
				continue;
			System.out.println("\nKedar : " + readStr);
		}
	}catch(IOException ioe){
		System.out.println(ioe);
	}catch(Exception e){
		System.out.println(e);
	}

	}

	public static void main(String[] args){
		new ClientChat();
	}
}
