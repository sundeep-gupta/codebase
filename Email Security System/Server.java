import server.*;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class Server{
	JButton startButton,stopButton;
	JPanel panel = new JPanel(new FlowLayout());
	MailServer ms = null;
	public static void main(String[] arg){
		new Server();
		
	}
	public Server(){
		JFrame serverWindow = new JFrame("Email Server");
		serverWindow.setContentPane(panel);
		
		startButton = new JButton("Start");
		startButton.addActionListener(new ActionListener(){
							public void actionPerformed(ActionEvent ae){
								if(((JButton)ae.getSource()).getText().equals("Start")){
									ms = new MailServer();
									startButton.setText("Stop");
								}else{
									ms.stop();
									ms = null;
									startButton.setText("Start");
								}
		
							}
							});

		panel.add(startButton);
		serverWindow.addWindowListener(new WindowAdapter(){
							public void windowClosing(WindowEvent we){
								System.exit(0);
							}
							});
		serverWindow.pack();
		serverWindow.setVisible(true);
	}
}