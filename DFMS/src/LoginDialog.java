import java.awt.*;
import java.awt.event.*;
import java.util.*;
import javax.swing.*;

/*
 * LoginDialog.java
 */
public class LoginDialog extends JDialog
{	
/*	public static void main(String s[])
	{
		JFrame p = new JFrame();
		LoginDialog l = new LoginDialog(p);
		l.show();
	}*/
	JPanel _mainPanel = new JPanel();
	JLabel _userIdLabel = new JLabel();
	JTextField _useridTextField = new JTextField();
	JLabel _passwordLabel = new JLabel();
	JPasswordField _passwordField = new JPasswordField();
	JPanel _buttonsPanel = new JPanel();
	JButton _loginButton = new JButton();
	JButton _cancelButton = new JButton();
	boolean validData;
	public LoginDialog(JFrame parent) 
	{
		super(parent, true);
		//it gets true if you press Login, it remains false if you press cancel
		validData = false;
		try 
		{
				jbInit();
        }
		catch(Exception e) 
		{
			e.printStackTrace();
		}
		pack();
		center(parent);
	}
	public SerializablePasswordAuthentication getPasswordAuthentication()
	{
		this.setVisible(true);
		if (validData)
			return new SerializablePasswordAuthentication(_useridTextField.getText(), _passwordField.getPassword());
		else
		return null;
	}

	private void jbInit() throws Exception 
	{
		_mainPanel.setLayout(new GridBagLayout());
		_userIdLabel.setDisplayedMnemonic('U');
		_userIdLabel.setText("User Name:");
		_userIdLabel.setLabelFor(_useridTextField);
		_passwordLabel.setDisplayedMnemonic('P');
		_passwordLabel.setText("Password:");
		_passwordLabel.setLabelFor(_passwordField);
		_loginButton.setMnemonic('L'); 
		_loginButton.setText("Login");
		_cancelButton.setMnemonic('C');
		_cancelButton.setText("Cancel");
		this.setModal(true);
		this.setResizable(false);
		this.setTitle("Distributed File Maintenance System");
		this.getContentPane().add(_mainPanel, BorderLayout.CENTER);
		_mainPanel.add(_userIdLabel,  new GridBagConstraints(0, 0, 1, 1, 0.0, 0.0
						,GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(0, 0, 0, 0), 0, 0));
		_mainPanel.add(_useridTextField,  new GridBagConstraints(1, 0, 1, 1, 0.0, 0.0
						,GridBagConstraints.CENTER, GridBagConstraints.HORIZONTAL, new Insets(0, 0, 0, 0), 0, 0));
		_mainPanel.add(_passwordLabel,  new GridBagConstraints(0, 1, 1, 1, 0.0, 0.0
						,GridBagConstraints.CENTER, GridBagConstraints.NONE, new Insets(0, 0, 0, 0), 0, 0));
		_mainPanel.add(_passwordField,  new GridBagConstraints(1, 1, 1, 1, 0.0, 0.0
						,GridBagConstraints.CENTER, GridBagConstraints.HORIZONTAL, new Insets(0, 0, 0, 0), 0, 0));
		_mainPanel.add(_buttonsPanel,    new GridBagConstraints(0, 2, 2, 1, 0.0, 0.0
						,GridBagConstraints.CENTER, GridBagConstraints.BOTH, new Insets(0, 0, 0, 0), 0, 0));
		_loginButton.addActionListener(new ActionListener()
		{
			public void actionPerformed(ActionEvent event) 
			{
					LogIn();
			}
		});
		_cancelButton.addActionListener(new ActionListener()
		{
			public void actionPerformed(ActionEvent event) 
			{
				Cancel();
			}
		});
		addWindowListener(new WindowAdapter () 
		{
			public void windowClosing(WindowEvent event) 
			{
				// user hit window manager close button
				Cancel();
			}
		});
		_buttonsPanel.add(_loginButton, null);
		_buttonsPanel.add(_cancelButton, null);
		_mainPanel.getRootPane().setDefaultButton(_loginButton);
/*_cancelButton.addFocusListener(new FocusListener()
		{
			void focusGained(FocusEvent event) 
			{
				
			}
		});*/

}
		/** Center the window */
	public void center(JFrame parent)
	{
		 Dimension parentSize = parent.getSize();
		 Dimension dialogSize = getSize();
		 Point parentLocation =	 parent.getLocation();
		 if (dialogSize.height > parentSize.height)
		 dialogSize.height = parentSize.height;
		 if (dialogSize.width > parentSize.width)
		 dialogSize.width = parentSize.width;
		 setLocation((int) parentLocation.getX() + (parentSize.width - dialogSize.width) / 2,(int) parentLocation.getY() + (parentSize.height - dialogSize.height) / 2);
	}
	public void LogIn()
	{
		validData=true;
		setVisible(false);
	}
	public void Cancel()
	{
		validData=false; 
		setVisible(false);
	}
} // class LoginDialog
