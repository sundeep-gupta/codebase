import java.net.*;

class gettingIP{
	public static void main(String[] args) throws Exception{
		InetAddress ipAddr = InetAddress.getByName("pvijay");
		System.out.println("IP Address : " + ipAddr);
	}
}