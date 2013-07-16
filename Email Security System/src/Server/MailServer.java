package server;
import java.net.*;
import java.io.*;
public class MailServer implements Runnable{
	ServerSocket serverSocket = null;
	Thread myThread;
	int i = 0;
	public void run(){
		Thread currentThread = Thread.currentThread();
		while(currentThread == myThread){
			try{
				new MailSession("Client"+i,serverSocket.accept()).start();
				i++;
			}catch(IOException e){
			
			}
		}
	}
	public void stop(){
		try{
		serverSocket.close();

		}catch(IOException e){}
		serverSocket = null;
		myThread = null;
System.out.println("Closing");
	}
	public MailServer(){
		try{
			serverSocket = new ServerSocket(125);
System.out.println("Listening...");
		}catch(IOException e){
			System.out.println("Could not listen to port 25");
			System.exit(0);
		}
		myThread = new Thread(this,"Server");
		myThread.start();
	}
	public static void main(String[] arg)throws IOException{
		MailServer server = new MailServer();
	}
	
}