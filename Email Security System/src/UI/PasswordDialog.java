package ui;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
public class PasswordDialog extends JDialog{
	String keyId;
	boolean cancelled = true;
	JLabel keyIdLabel,keyID,passLabel,confirmLabel,msgLabel;
	JPasswordField pass,confirm;
	JButton ok,cancel;
	JPanel dialogPanel,panel1,panel2,panel3,labelPanel1,labelPanel2;
	public PasswordDialog(Frame owner,String keyId){
		super(owner,"Select Key",true);
		this.keyId = keyId;
		//setLocation(owner.getWidth()/2,owner.getHeight()/2);
		init();
	}
	public void init(){

		panel1 = new JPanel();
		panel1.setLayout(new BoxLayout(panel1,BoxLayout.X_AXIS));
		passLabel =    new JLabel("Password :",JLabel.RIGHT);
		pass = new JPasswordField(10);
		pass.setSize(50,getHeight());
		panel1.add(Box.createRigidArea(new Dimension(10,0)));
		panel1.add(passLabel);
		panel1.add(Box.createRigidArea(new Dimension(10,0)));
		panel1.add(pass);
		panel1.add(Box.createRigidArea(new Dimension(10,0)));
	
		panel2 = new JPanel();
		panel2.setLayout(new BoxLayout(panel2,BoxLayout.X_AXIS));
		confirmLabel = new JLabel("Confirm :",JLabel.RIGHT);
		confirm = new JPasswordField(10);
		panel2.add(Box.createRigidArea(new Dimension(25,0)));
		panel2.add(confirmLabel);
		panel2.add(Box.createRigidArea(new Dimension(10,0)));
		panel2.add(confirm);
		panel2.add(Box.createRigidArea(new Dimension(10,0)));

		panel3 = new JPanel();
		panel3.setLayout(new BoxLayout(panel3,BoxLayout.X_AXIS));
		ok = new JButton("OK");
		ok.setMnemonic(KeyEvent.VK_O);
		cancel = new JButton("Cancel");
		cancel.setMnemonic(KeyEvent.VK_C);

		panel3.add(Box.createGlue());
		panel3.add(ok);
		panel3.add(Box.createRigidArea(new Dimension(10,0)));
		panel3.add(cancel);			
		panel3.add(Box.createRigidArea(new Dimension(10,0)));

		labelPanel1 = new JPanel();
		labelPanel1.setLayout(new BoxLayout(labelPanel1,BoxLayout.X_AXIS));
		keyIdLabel = new JLabel("KeyId of key used: ");
		keyID = new JLabel(keyId);
		keyID.setForeground(Color.BLUE);
		labelPanel1.add(Box.createRigidArea(new Dimension(10,0)));
		labelPanel1.add(keyIdLabel);
		labelPanel1.add(Box.createRigidArea(new Dimension(10,0)));	
		labelPanel1.add(keyID);
		labelPanel1.add(Box.createRigidArea(new Dimension(10,0)));	
		
		labelPanel2 = new JPanel();
		labelPanel2.setLayout(new BoxLayout(labelPanel2,BoxLayout.X_AXIS));
		msgLabel= new JLabel("Enter the password for corresponding key");
		labelPanel2.add(Box.createRigidArea(new Dimension(10,0)));
		labelPanel2.add(msgLabel);
		labelPanel2.add(Box.createRigidArea(new Dimension(10,0)));		

		dialogPanel = new JPanel();
		dialogPanel.setLayout(new BoxLayout(dialogPanel,BoxLayout.Y_AXIS));
		dialogPanel.add(Box.createRigidArea(new Dimension(0,10)));
		dialogPanel.add(labelPanel1);
		dialogPanel.add(Box.createRigidArea(new Dimension(0,5)));
		dialogPanel.add(labelPanel2);
		dialogPanel.add(Box.createRigidArea(new Dimension(0,10)));
		dialogPanel.add(panel1);
		dialogPanel.add(Box.createRigidArea(new Dimension(0,10)));
		dialogPanel.add(panel2);
		dialogPanel.add(Box.createRigidArea(new Dimension(0,10)));
		dialogPanel.add(panel3);		
		dialogPanel.add(Box.createRigidArea(new Dimension(0,10)));
		setContentPane(dialogPanel);
		pack();
		
		ok.setEnabled(false);
		pass.addKeyListener(new KeyAdapter(){
					public void keyPressed(KeyEvent ke){
						if(new String(pass.getPassword()).equals("")){
							ok.setEnabled(false);							
						}else
							ok.setEnabled(true);
					}
				});
		
		ok.addActionListener(new ActionListener(){
					public void actionPerformed(ActionEvent ae){
						if(!(new String(pass.getPassword()).equals(new String(confirm.getPassword()))))
							JOptionPane.showMessageDialog(PasswordDialog.this,"Please retype the password correctly.","Error",JOptionPane.ERROR_MESSAGE);
						else{
							cancelled = false;
							dispose();
						}
					}
				});
		cancel.addActionListener(new ActionListener(){
					public void actionPerformed(ActionEvent ae){
						cancelled = true;
						dispose();
					}
				});


	}
	public String getPassword(){
		return new String(pass.getPassword());
	}
	public boolean isCancelled(){
		return cancelled;
	}
	public static void main(String arg[]){
		JFrame frame = new JFrame("MyFrame");
		frame.setSize(200,200);
		frame.setVisible(true);
		PasswordDialog pd = new PasswordDialog(frame,"MyKeyId");
		pd.addWindowListener(new WindowAdapter(){
					public void windowClosing(WindowEvent we){
						System.exit(0);
					}
				});
		pd.show();

	}
}