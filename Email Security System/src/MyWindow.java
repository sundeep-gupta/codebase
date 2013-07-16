import mail.*;
import ui.*;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.IOException;
import java.net.UnknownHostException;
public class MyWindow {
public static void main(String[] arg){
	try{
		ESS ess = new ESS();
		ess.addWindowListener(new WindowAdapter(){
				public void windowClosing(WindowEvent we){
					System.exit(0);
				}
				});
	}catch(UnknownHostException uhe){
		System.out.println(uhe);
	}catch(IOException ioe){
		System.out.println(ioe);
	}catch(ClassNotFoundException cnfe){
		System.out.println(cnfe);
	}
}
}