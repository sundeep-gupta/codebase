package ui;
import java.util.zip.DataFormatException;
import java.security.*;
import java.security.interfaces.*;
import javax.swing.*;
import java.awt.event.*;
import java.awt.*;
import java.io.*;
import java.util.*;
import javax.swing.event.InternalFrameAdapter;
import javax.swing.event.InternalFrameEvent; 

/* 
 * Class is the subclass of JInternalFrame 
 * Used for the creation of the NewMessage window 
 * This window is used in the Parent window and is used
 * to allow the user to type the message and other mail 
 * details required for the sending of the mail.
 * To:
 * Subject:
 * Message:
 * Attachments: 
 */
public class NewMessageFrame extends JInternalFrame{
 
	/* 
	 * private variables to store toaddress, 
	 * fromAddress and the message
	 */
	private String toAddress;
	private String fromAddress;
	private String[] attachList = new String[0];
	private byte[] messageText;
	
	/* 
	 * variables used to display the Window and it's components
	 * To, From, Subject, Encrypt option, Area to write Message
	 */
	private JLabel toLabel,ccLabel,subjectLabel,attachLabel;
	private JTextField to,cc,subject;
	private JTextArea messageArea;
	private JCheckBox encryptCheckBox;
	private JButton attachButton,removeButton;		
	JScrollPane messageScrollPane;

	File attachFile = null;
	/*
	 * Panels used 
       */
	private JPanel fieldPanel,framePanel,instancePanel,attachPanel,optionPanel,subjectPanel,toPanel;
	
	/*
	 * Variable containing the list of all unsent destination addresses
	 */
	TreeSet list;
	
	/* 
	 * Constructor to creat a "New Message Frame"
	 * argument : title to diplay in titlebar
	 */
			
	public NewMessageFrame(String title){
		/* create a JInternalFrame object with the specified title */
		super(title);
		/* initialize */
		init();
	}
	public void init(){

	/* create image icons */
		toLabel = new JLabel("To :",new ImageIcon("images/BArrow.gif"),SwingConstants.LEFT);
		to = new JTextField(30);
	
	/* create checkbox to encrypt/not */
	  	encryptCheckBox = new JCheckBox("Send Encrypted Message");
	      encryptCheckBox.setMnemonic(KeyEvent.VK_E); 
	      encryptCheckBox.setSelected(false);

	/*create fields */	
		subjectLabel = new JLabel("Subject :");
		subject = new JTextField(30);
	/* attach button */
		attachButton = new JButton("Attach");
		attachButton.addActionListener( new ActionListener(){
						public void actionPerformed(ActionEvent ae){
							JFileChooser openDialog = new JFileChooser();
							int retVal = openDialog.showOpenDialog(NewMessageFrame.this);
							if(retVal == JFileChooser.APPROVE_OPTION){
								attachFile = openDialog.getSelectedFile();
								if(attachFile.exists()){
									attachButton.setEnabled(false);
									attachLabel = new JLabel(attachFile.getName());
									removeButton = new JButton("Remove");
									attachPanel = new JPanel();
									attachPanel.setLayout(new BoxLayout(attachPanel,BoxLayout.X_AXIS));	
									attachPanel.add(Box.createRigidArea(new Dimension(15,0)));
									attachPanel.add(attachLabel);
									attachPanel.add(Box.createRigidArea(new Dimension(15,0)));
									attachPanel.add(removeButton);
									attachPanel.add(Box.createGlue());
									fieldPanel.add(attachPanel);
									NewMessageFrame.this.pack();
									removeButton.addActionListener( new ActionListener(){
													public void actionPerformed(ActionEvent ae){
														fieldPanel.remove(attachPanel);
														attachPanel.remove(removeButton);
														attachPanel.remove(attachLabel);
														attachPanel = null;
														
														attachButton.setEnabled(true);
													}
													});
								}
							}

						}
					});
	/* create message area */
		messageArea = new JTextArea(15,60);
		messageArea.setBorder(BorderFactory.createEtchedBorder());
		messageArea.setLineWrap(true);
		messageArea.setWrapStyleWord(true);
		
		messageScrollPane = new JScrollPane(messageArea);

	/* put components in layout */
		toPanel = new JPanel();
		toPanel.setLayout(new BoxLayout(toPanel,BoxLayout.X_AXIS));
		toPanel.add(Box.createRigidArea(new Dimension(15,0)));
		toPanel.add(toLabel);
		toPanel.add(Box.createRigidArea(new Dimension(15,0)));
		toPanel.add(to);
		toPanel.add(Box.createRigidArea(new Dimension(15,0)));
		
		subjectPanel = new JPanel();
		subjectPanel.setLayout(new BoxLayout(subjectPanel,BoxLayout.X_AXIS));
		subjectPanel.add(Box.createRigidArea(new Dimension(15,0)));
		subjectPanel.add(subjectLabel);
		subjectPanel.add(Box.createRigidArea(new Dimension(15,0)));
		subjectPanel.add(subject);
		subjectPanel.add(Box.createRigidArea(new Dimension(15,0)));
		
		optionPanel = new JPanel();
		optionPanel.setLayout(new BoxLayout(optionPanel,BoxLayout.X_AXIS));
		optionPanel.add(Box.createRigidArea(new Dimension(15,0)));
		optionPanel.add(encryptCheckBox);
		optionPanel.add(Box.createRigidArea(new Dimension(15,0)));
		optionPanel.add(attachButton);
		optionPanel.add(Box.createGlue());

		/* to add the attachments to the screen == no code written still to be written*/
		
		fieldPanel = new JPanel();
		fieldPanel.setLayout(new BoxLayout(fieldPanel,BoxLayout.Y_AXIS));
		
		fieldPanel.add(toPanel);
		fieldPanel.add(Box.createRigidArea(new Dimension(15,15)));
		fieldPanel.add(subjectPanel);
		fieldPanel.add(Box.createRigidArea(new Dimension(15,15)));
		fieldPanel.add(optionPanel);
		fieldPanel.add(Box.createRigidArea(new Dimension(15,15)));
		framePanel = new JPanel(new BorderLayout(10,15)){
					public Insets getInsets(){
						return new Insets(5,10,5,10);
					}
					};
		framePanel.add(fieldPanel,BorderLayout.NORTH);
		framePanel.add(messageScrollPane,BorderLayout.CENTER);

		instancePanel = new JPanel(new BorderLayout());
		instancePanel.add(framePanel,BorderLayout.CENTER);
		setContentPane(instancePanel);
		pack();
		setVisible(true);
	}
	public String getToAddress(){
		return toAddress;
	}
	public String getMessage(){
		return messageArea.getText();
	}
	public boolean isEncrypted(){
		return encryptCheckBox.isSelected();
	}
	public String getTo(){
		return to.getText();
	}
	public String getSubject(){
		return subject.getText();
	}
	public File getAttachments(){
		return attachFile;
	}
	public static void main(String[] str){
		JFrame frame = new JFrame("main Frame");
	
		JDesktopPane desktop = new JDesktopPane();	/* Set the desktop pane */
		
		frame.getContentPane().add(desktop,BorderLayout.CENTER);	
		desktop.setVisible(true);				
		frame.pack();
		frame.show();
		frame.addWindowListener(new WindowAdapter(){
					public void windowClosing(WindowEvent we){
						System.exit(0);
				}});
		NewMessageFrame sendWindow = new NewMessageFrame("test frame");
		sendWindow.setIconifiable(true);
		sendWindow.setClosable(true);
		sendWindow.setSize(540,480);
		sendWindow.addInternalFrameListener(new InternalFrameAdapter(){
						public void internalFrameClosing(InternalFrameEvent ife){
							((NewMessageFrame)ife.getInternalFrame()).dispose();
						}
					});
		desktop.add(sendWindow,new Integer(1));
		sendWindow.show();
		
	}
}
class EncryptAction extends AbstractAction{
		private boolean encrypt = false;
		public EncryptAction(String title,ImageIcon icon){
			super(title,icon);
			encrypt = false;
		}
		public void actionPerformed(ActionEvent ae){
			/* mark or unmark that the message is to be encrypted when sent*/
			if(encrypt)
				((AbstractButton)ae.getSource()).setIcon(new ImageIcon("images/Encrypt.gif"));
			else
				((AbstractButton)ae.getSource()).setIcon(new ImageIcon("images/Decrypt.gif"));
			encrypt=!encrypt;
			JOptionPane.showConfirmDialog(null,"Decryptd","Decrypt",JOptionPane.OK_CANCEL_OPTION,JOptionPane.INFORMATION_MESSAGE);
		}
}