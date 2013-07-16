package ui;
import javax.swing.*;
import java.beans.Beans;
import java.awt.Dimension;
import java.awt.event.ActionListener;
import java.awt.event.FocusAdapter;
import java.awt.event.FocusEvent;
import java.awt.event.ActionEvent;
import java.awt.Frame;
import java.io.ObjectOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.StringTokenizer;
import ui.ServerBean;
public class OptionDialog extends JDialog{
	private JLabel titleLabel,portLabel,addressLabel;
	private JTextField addressText,portText;
	private JButton okButton,cancelButton;
	private JPanel titlePanel,addressPanel,portPanel,buttonPanel,dialogPanel;

	private ServerBean serverBean;
	private byte[] address;
	private int port;
	
	public OptionDialog(Frame owner)throws IOException,ClassNotFoundException,UnknownHostException{
		super(owner,"Options...",true);

		/* Instantiate the bean */
		try{
			serverBean = (ServerBean)Beans.instantiate(null,"serverAddress");
		}catch(Exception e){
			serverBean = (ServerBean)Beans.instantiate(null,"ui.ServerBean");
			byte[] address = {127,0,0,1};
			serverBean.setServerAddress(InetAddress.getByAddress(address));
		}

		address = serverBean.getServerAddress().getAddress();
		port = serverBean.getPort();
		
		/* title of the dialog*/
		titleLabel = new JLabel("Set the address of the server");
		
		/* address of server */
		addressLabel = new JLabel("Server Address :");
		addressText = new JTextField( ((int)address[0]& 0xff) + "." 
						    + ((int)address[1]& 0xff) + "."
						    + ((int)address[2]& 0xff) + "."
						    + ((int)address[3]& 0xff),15);
		addressText.addFocusListener(new FocusAdapter(){
						public void focusLost(FocusEvent fe){
							/* check if the address is valid */
							StringTokenizer st = new StringTokenizer(addressText.getText(),".");
							try{
								address = new byte[4];
								int val,i=0;
								while(st.hasMoreTokens() && i < 4){
									val = Integer.parseInt(st.nextToken());
									if( val > 255 || val < 0 )
										throw new NumberFormatException();
									address[i] = (byte)val;
									i++;
								}
								if(i<4 || st.hasMoreTokens())
									throw new NumberFormatException();
							}catch(NumberFormatException nfe){
								JOptionPane.showMessageDialog(null,"Invalid Address.\n Please Enter a valid Address","Error",JOptionPane.ERROR_MESSAGE);
								addressText.requestFocus();
							}
						}
					});
		
		/* port number */
		portLabel = new JLabel("Port :");
		portText = new JTextField(new Integer(port).toString(),6);
		portText.addFocusListener(new FocusAdapter(){
						public void focusLost(FocusEvent fe){
							try{
								port = Integer.parseInt(portText.getText());
								if(port < 0 || port > 65537)
									throw new NumberFormatException();
							}catch(NumberFormatException nfe){
								JOptionPane.showMessageDialog(null,"Invalid Port Number.\nPlease Enter a valid Port number (0-65537)","Error",JOptionPane.ERROR_MESSAGE);
								portText.requestFocus();
							}
						}
					});
		portText.setSize(50,portText.getWidth());

		/* instantiate the button */
		okButton = new JButton("OK");
		okButton.addActionListener( new ActionListener(){
						public void actionPerformed(ActionEvent ae){
							try{
								/* set the address of the serverBean */
								serverBean.setServerAddress(InetAddress.getByAddress(address));
							}catch(UnknownHostException uhe){
								JOptionPane.showMessageDialog(null,"No host with this address is found","Error",JOptionPane.ERROR_MESSAGE);
							}

							/* set the port number */
							serverBean.setPort(port);
							try{
								/* Store the address and host */
								FileOutputStream fos = new FileOutputStream("serverAddress.ser");
								ObjectOutputStream oos = new ObjectOutputStream(fos);
								oos.writeObject(serverBean);
								oos.flush();
								oos.close();
							}catch(IOException ioe){
								JOptionPane.showMessageDialog(null,"Input Output Exception occured during saving of address","Error",JOptionPane.ERROR_MESSAGE);
							}
							/* remove the window */
							dispose();
						}
					});

		/* cancel button */
		cancelButton = new JButton("Cancel");
		cancelButton.addActionListener(new ActionListener(){
						public void actionPerformed(ActionEvent ae){
							/* remove the dialog */
							dispose();
						}
					});
		
		/* panels for display */
		
		addressPanel = new JPanel();
		addressPanel.setLayout(new BoxLayout(addressPanel,BoxLayout.X_AXIS));
		addressPanel.add(Box.createRigidArea(new Dimension(10,0)));
		addressPanel.add(addressLabel);
		addressPanel.add(Box.createRigidArea(new Dimension(10,0)));
		addressPanel.add(addressText);
		addressPanel.add(Box.createGlue());

		portPanel = new JPanel();
		portPanel.setLayout(new BoxLayout(portPanel,BoxLayout.X_AXIS));
		portPanel.add(Box.createRigidArea(new Dimension(75,0)));
		portPanel.add(portLabel);
		portPanel.add(Box.createRigidArea(new Dimension(10,0)));
		portPanel.add(portText);
		portPanel.add(Box.createGlue());
	
		buttonPanel = new JPanel();
		buttonPanel.setLayout(new BoxLayout(buttonPanel,BoxLayout.X_AXIS));
		buttonPanel.add(Box.createGlue());
		buttonPanel.add(okButton);
		buttonPanel.add(Box.createRigidArea(new Dimension(20,0)));
		buttonPanel.add(cancelButton);
		buttonPanel.add(Box.createRigidArea(new Dimension(20,0)));
		
		dialogPanel = new JPanel();
		dialogPanel.setLayout(new BoxLayout(dialogPanel,BoxLayout.Y_AXIS));
		
		dialogPanel.add(Box.createRigidArea(new Dimension(0,10)));
		dialogPanel.add(titleLabel);
		dialogPanel.add(Box.createRigidArea(new Dimension(0,10)));
		dialogPanel.add(addressPanel);
		dialogPanel.add(Box.createRigidArea(new Dimension(0,10)));
		dialogPanel.add(portPanel);
		dialogPanel.add(Box.createRigidArea(new Dimension(0,10)));
		dialogPanel.add(buttonPanel);
		dialogPanel.add(Box.createRigidArea(new Dimension(0,10)));
		
		this.setContentPane(dialogPanel);
		
		setSize(300,150);
		
	}
	public byte[] getAddress(){
		return address;
	}
	public int getPort(){
		return port;
	}
	public static void main(String[] arg)throws Exception{
		JFrame frame = new JFrame("Sandeep Test");
		frame.setSize(200,200);
		frame.addWindowListener(new java.awt.event.WindowAdapter(){
						public void windowClosing(java.awt.event.WindowEvent we){
							System.exit(0);
						}
					});
		OptionDialog od = new OptionDialog(frame);
		frame.setVisible(true);
		od.setVisible(true);
	}
}