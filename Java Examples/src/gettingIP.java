import java.net.*;

class gettingIP{
	public static void main(String[] args) throws Exception{
		InetAddress ipAddr = InetAddress.getByName("http://www.yahoo.com");
		System.out.println("IP Address : " + ipAddr);
	}
}