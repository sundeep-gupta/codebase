package ui;
import javax.swing.*;
import javax.swing.event.*;
import java.awt.*;
import java.awt.event.*;

public class JKeyDialog extends JDialog implements ActionListener{
	//private String keyIDName = null;
	//private String passphrase = null;
	private JLabel keyIDLabel,passphraseLabel,confirmLabel;
	private JTextField keyID;
	private JPasswordField passphrase,confirmPassphrase;
	private JButton generate,cancel;
	private boolean cancelled = false;
public JKeyDialog(Frame owner,String title, boolean modal){
	super(owner,title,modal);
	keyIDLabel = new JLabel("KeyID :");
	passphraseLabel = new JLabel("Passphrase :");
	confirmLabel = new JLabel("Confirm :");
	keyID = new JTextField(20);
	keyID.addKeyListener( new KeyAdapter(){
				    public void keyReleased(KeyEvent ke){
						if(keyID.getText().equals("")){
							passphraseLabel.setEnabled(false);
							passphrase.setEnabled(false);
							confirmLabel.setEnabled(false);
							confirmPassphrase.setEnabled(false);
							generate.setEnabled(false);
						}else{		
							passphraseLabel.setEnabled(true);
							passphrase.setEnabled(true);
							confirmLabel.setEnabled(true);
							confirmPassphrase.setEnabled(true);
							generate.setEnabled(true);
						}
				    }
				}); /* end of the abstract class for Key Listener */
		
		passphrase = new JPasswordField(20);
		confirmPassphrase = new JPasswordField(20);
		
		/* ok button creating */
		generate = new JButton("Generate");
		generate.setMnemonic(KeyEvent.VK_G);
		generate.addActionListener(this);
		generate.setEnabled(false);
		
		/* cancel button creation */
		cancel = new JButton("Cancel");
		cancel.setMnemonic(KeyEvent.VK_C);
		cancel.addActionListener(this);
		
		GridBagLayout layout = new GridBagLayout();
		GridBagConstraints con = new GridBagConstraints();
		JPanel dialogPanel = new JPanel(layout);

		con.insets = new Insets(5,5,5,5);
		con.fill = GridBagConstraints.BOTH;
		con.weightx = 1.0;
		layout.setConstraints(keyIDLabel,con);
		dialogPanel.add(keyIDLabel);
		
		con.gridwidth = GridBagConstraints.REMAINDER;
		layout.setConstraints(keyID,con);
		dialogPanel.add(keyID);

		con.gridwidth = 1;
		layout.setConstraints(passphraseLabel,con);
		dialogPanel.add(passphraseLabel);
	
		con.gridwidth = GridBagConstraints.REMAINDER;
		layout.setConstraints(passphrase,con);
		dialogPanel.add(passphrase);

		con.gridwidth = 1;
		layout.setConstraints(confirmLabel,con);
		dialogPanel.add(confirmLabel);
	
		con.gridwidth = GridBagConstraints.REMAINDER;
		layout.setConstraints(confirmPassphrase,con);
		dialogPanel.add(confirmPassphrase);
		
		JPanel mainPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT,30,4));
		mainPanel.add(dialogPanel);
		mainPanel.add(generate);
		mainPanel.add(cancel);
		setContentPane(mainPanel);

		setSize(350,150);
		setResizable(false);
	}
	public String getKeyID(){
		return keyID.getText();
	}
	public String getPassphrase(){
		return new String(passphrase.getPassword());
	}
	public void actionPerformed(ActionEvent ae){
		if(ae.getSource().equals(generate)){
			if(passphrase.getPassword().length < 6){
				JOptionPane.showConfirmDialog(JKeyDialog.this,"Please enter passphrase of atleast 6 characters",
									"Error",JOptionPane.OK_CANCEL_OPTION,JOptionPane.ERROR_MESSAGE);
			}else
			if(!new String(passphrase.getPassword()).equals(new String(confirmPassphrase.getPassword()))){
				JOptionPane.showConfirmDialog(JKeyDialog.this,"Retype the correct passphrase in the confirm field",
									"Error",JOptionPane.OK_CANCEL_OPTION,JOptionPane.ERROR_MESSAGE);
			}else{
				this.dispose();	
			}
		}else
		if(ae.getSource().equals(cancel)){
			keyID.setText("");
			passphrase.setText("");
			confirmPassphrase.setText("");
			cancelled = true;
			hide();
		}
	}
	public boolean isCancelled(){
		return cancelled;
	}
}
