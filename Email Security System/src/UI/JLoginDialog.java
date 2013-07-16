package ui;
import javax.swing.*;
import javax.swing.event.*;
import java.awt.*;
import java.awt.event.*;

public class JLoginDialog extends JDialog implements ActionListener{
	private String loginName = null;
	private String passWord = null;
	private JLabel loginLabel,passwordLabel;
	private JTextField loginID;
	private JPasswordField password;
	private JButton ok,cancel;
	private boolean cancelled = false;
public JLoginDialog(Frame owner,String title, boolean modal){
	super(owner,title,modal);
	loginLabel = new JLabel("Login :");
	passwordLabel = new JLabel("Password :");
	loginID = new JTextField(20);
	loginID.addKeyListener( new KeyAdapter(){
				    public void keyReleased(KeyEvent ke){
						if(loginID.getText().equals("")){
							password.setEnabled(false);
							ok.setEnabled(false);
						}else{		
							password.setEnabled(true);
							ok.setEnabled(true);
						}
				    }
				}); /* end of the abstract class for Key Listener */
		
		password = new JPasswordField(20);
		
		/* ok button creating */
		ok = new JButton("Ok");
		ok.setMnemonic(KeyEvent.VK_O);
		ok.addActionListener(this);
		ok.setEnabled(false);
		
		/* cancel button creation */
		cancel = new JButton("Cancel");
		cancel.setMnemonic(KeyEvent.VK_C);
		cancel.addActionListener(this);
		
		setDefaultCloseOperation(DISPOSE_ON_CLOSE);		
		
		GridBagLayout layout = new GridBagLayout();
		GridBagConstraints con = new GridBagConstraints();
		JPanel dialogPanel = new JPanel(layout);

		con.insets = new Insets(5,5,5,5);
		con.fill = GridBagConstraints.BOTH;
		con.weightx = 1.0;
		layout.setConstraints(loginLabel,con);
		dialogPanel.add(loginLabel);
		
		con.gridwidth = GridBagConstraints.REMAINDER;
		layout.setConstraints(loginID,con);
		dialogPanel.add(loginID);

		con.gridwidth = 1;
		layout.setConstraints(passwordLabel,con);
		dialogPanel.add(passwordLabel);
	
		con.gridwidth = GridBagConstraints.REMAINDER;
		layout.setConstraints(password,con);
		dialogPanel.add(password);
		
		JPanel mainPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT,30,4));
		mainPanel.add(dialogPanel);
		mainPanel.add(ok);
		mainPanel.add(cancel);
		setContentPane(mainPanel);

		setSize(350,150);
		setResizable(false);
	}
	public void setLoginName(String loginName){
		this.loginName = loginName;
	}
	public String getLoginName(){
		return loginName;
	}
	public String getPassword(){
		return passWord;
	}
	public void setPassword(String password){
		this.passWord = password;
	}
	public void actionPerformed(ActionEvent ae){
		if(ae.getSource().equals(ok)){
			setLoginName(loginID.getText());
			setPassword(new String(password.getPassword()));
			/*close the dialog */
			this.dispose();
		}else
		if(ae.getSource().equals(cancel)){
			setLoginName("");
			setPassword("");
			cancelled = true;
			hide();
		}
	}
	public boolean isCancelled(){
		return cancelled;
	}
}
