package ui;
import java.io.Serializable;
import java.net.InetAddress;
import java.net.UnknownHostException;
public class ServerBean implements Serializable{
	private InetAddress serverAddress = InetAddress.getByName("localhost");
	private int port = 1111;
	public ServerBean()throws UnknownHostException{
	}
	public synchronized void setServerAddress(InetAddress serverAddress){
		this.serverAddress = serverAddress;
	}
	public synchronized InetAddress getServerAddress(){
		return serverAddress;
	}
	public synchronized void setPort(int port){
		this.port = port;
	}
	public synchronized int getPort(){
		return port;
	}
}