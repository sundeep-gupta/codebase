import java.applet.*;
import java.awt.*;

// <applet code="myApplet" height="200" width="200">	 </applet>

public class myApplet extends Applet{
	
	String[] name = new String[10];
	int i = 0;

	public void init(){
		name[i++] = "Initializing";
	}

	public void start(){
		name[i++] = "Starting";
	}

	public void paint(Graphics g){
		for (int j=0; j < i; j++) 
			g.drawString(name[j], 5, 15*j + 15);
	}

	public void stop(){
		name[i++] = "Stopping";
		repaint();
	}

	public void destroy(){
		name[i++] = "Destroying";
		repaint();
	}

}
