package ui;
import javax.swing.*;
import javax.swing.event.InternalFrameAdapter;
import javax.swing.event.InternalFrameEvent; 
import java.beans.PropertyVetoException;
import java.security.NoSuchAlgorithmException;
import java.util.zip.DataFormatException;
import java.awt.event.*;
import java.awt.*;
import java.io.*;
import java.util.*;
import java.net.UnknownHostException;
import java.net.InetAddress;
import java.beans.Beans;
import mail.*;
import interfaces.*;

public class ESS extends JFrame /*implements WindowListener*/{
	final static int NO_ATTACHMENT = 0;	
	private byte[] address;
	private int port;

	boolean loginSuccess;
	private Login login; 		/* variable storing the loginid and pasword of logged in user */

	MailClient client=null;		/* the mail client through which the interface interacts */
	
	private ESS self = null;	/* a self referencing address */
	private JPanel completeArea;	/* panel representing the center portion  of window */
	private JMenuBar menuBar;	/* menubar object */
	private JToolBar toolbar;	/* object for toolbar */
	JDesktopPane desktop;
	NewMessageFrame sendWindow;	/* object for window displaying the composer*/
	JInboxFrame inboxWindow;	/* object for window displaying the inbox */
	private JMenu mail,doMenu;		/*object for menu */
	private JMenuItem miSignIn;
	private JButton bSignIn;
	private AbstractAction compose;	/* send button for opening the composer*/
	private AbstractAction openInbox;	/* button used to open inbox*/
	private AbstractAction newLogin;	/* button used for new login */
	private AbstractAction signIn; 	/* button used for display login dialog */
	private AbstractAction sendMail;
	private AbstractAction saveMail;
	private AbstractAction readMail;
	private AbstractAction deleteMail;
	private AbstractAction newKey;
	private AbstractAction option;

	private JButton exit;			/* button used for exitting */

	
	private String[] messageHeaders;

/**
 * Gets the reference to the panel used for center part of window
 */
public JDesktopPane getContentArea(){
	return desktop;
}	

/** 
 * Creates the window and 
 * renders it on the screen using JLF
 */
public ESS()throws UnknownHostException,IOException,ClassNotFoundException{
	super("Email Security System");			/* Title of the Window */
	loadAddress();
	self = this;
	completeArea = new JPanel(new BorderLayout());
	setContentPane(completeArea);
	setSize(600,500);						/* set size of window */
	createMenubarAndToolbar();				/* Add Menu Bar and ToolBar*/
	setJMenuBar(menuBar);
	getContentPane().add(toolbar,BorderLayout.NORTH);
		
	loginSuccess = false;					/* mark as not logged */
	
	desktop = new JDesktopPane();	/* Set the desktop pane */
	completeArea.add(desktop,BorderLayout.CENTER);	
	desktop.setVisible(true);				
	show();							/*Display the window */				
}	
protected void loadAddress()throws UnknownHostException,IOException,ClassNotFoundException{
	ServerBean serverBean;
	try{
		serverBean = (ServerBean)Beans.instantiate(null,"serverAddress");
	}catch(Exception e){
		serverBean = (ServerBean)Beans.instantiate(null,"ui.ServerBean");
		byte[] address = {127,0,0,1};
		serverBean.setServerAddress(InetAddress.getByAddress(address));
	}
	address = serverBean.getServerAddress().getAddress();
	port = serverBean.getPort();
}
/**
 * creates the MenuBar and ToolBar for the 
 * application and stores them
 */
protected void createMenubarAndToolbar(){
	menuBar = new JMenuBar();					/* create a menu bar */
	toolbar = new JToolBar();					/* create a tool bar */

	/*Create "Mail" Menu */
	mail = new JMenu("Mail");
	mail.setMnemonic(KeyEvent.VK_M);

	doMenu = new JMenu("Action");
	doMenu.setMnemonic(KeyEvent.VK_A);

	/* create the newLogin button used by both menubar and toolbar */
	newLogin = new AbstractAction("New Login",new ImageIcon("images/new.gif")){
				/** actionPerformed event handler for the newLogin button */
				public void actionPerformed(ActionEvent e){
					getNewLogin();
					if(loginSuccess){
						option.setEnabled(false);
					}		
				}
				}; /* end of the abstract class */

		/* adding button to toolbar and menubar */
		newLogin.setEnabled(true);
		JMenuItem miNewLogin = mail.add(newLogin);
		miNewLogin.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_L,InputEvent.CTRL_MASK));

		JButton bNewLogin = toolbar.add(newLogin);
		bNewLogin.setToolTipText("Creates new login");

		/*
		 * abstract class for button used for signing.
		 */
		signIn = new AbstractAction("Sign In",new ImageIcon("images/login.gif")){
				public void actionPerformed(ActionEvent e){
					if(miSignIn.getText().equals("Sign In")){
						doSignIn();
						if(loginSuccess){
							miSignIn.setText("Sign Out");
							bSignIn.setToolTipText("Sign Out");
							compose.setEnabled(true);
							openInbox.setEnabled(true);
							newKey.setEnabled(true);
							newLogin.setEnabled(false);
							option.setEnabled(false);
						}
					}else{
						int response = JOptionPane.showConfirmDialog(self,"Do you really want to log out?",
													"Log out",JOptionPane.YES_NO_CANCEL_OPTION,JOptionPane.INFORMATION_MESSAGE);
						if(response == JOptionPane.YES_OPTION){
							logout();
						}
					}
				}
			   };
		miSignIn = mail.add(signIn);
		miSignIn.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_G,InputEvent.CTRL_MASK));
		bSignIn = toolbar.add(signIn);
		bSignIn.setToolTipText("Sign in");

		JSeparator sep1 = new JSeparator();
		mail.add(sep1);
		
		toolbar.addSeparator();

		/*
		 * Create the Menu Items in the First Menu
		 */
		compose = new AbstractAction("Compose",new ImageIcon("Images/compose.gif")){
				public void actionPerformed(ActionEvent e){
				/* do the process to send the mail */
					if(!(sendWindow instanceof NewMessageFrame)){					
						sendWindow = new NewMessageFrame("New Message");

						saveMail.setEnabled(true);
						sendMail.setEnabled(true);

						sendWindow.setIconifiable(true);
						sendWindow.setClosable(true);
						sendWindow.setMaximizable(false);
						sendWindow.setSize(540,480);
						sendWindow.addInternalFrameListener(new InternalFrameAdapter(){
												public void internalFrameClosing(InternalFrameEvent ife){
													sendMail.setEnabled(false);	
													saveMail.setEnabled(false);
													sendWindow = null;
												}
										});
						getContentArea().add(sendWindow,new Integer(2));
						sendWindow.show();
					}
					sendWindow.show();
					desktop.setSelectedFrame(sendWindow);
				}
			};
		JMenuItem miCompose = doMenu.add(compose);
		miCompose.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_C,InputEvent.CTRL_MASK));
		JButton cButton = toolbar.add(compose);
		cButton.setToolTipText("Compose new mail");
		compose.setEnabled(false);

		openInbox = new AbstractAction("Open Inbox",new ImageIcon("images/Open.gif")){
					public void actionPerformed(ActionEvent e){
						doOpenInbox();
						if(messageHeaders.length!=0){
							deleteMail.setEnabled(true);	
							readMail.setEnabled(true);
						}
					}
				};
		JMenuItem miOpenInbox = doMenu.add(openInbox);		
		miOpenInbox.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_O,InputEvent.CTRL_MASK));
		JButton bOpenInbox = toolbar.add(openInbox);
		bOpenInbox.setToolTipText("Open inbox");
		openInbox.setEnabled(false);

		JSeparator sep3= new JSeparator();
		doMenu.add(sep3);
		
		toolbar.addSeparator();
		sendMail = new AbstractAction("Send mail",new ImageIcon("images/sendMail.gif")){
				public void actionPerformed(ActionEvent ae){
					doSendMail();
				}
			};
		JMenuItem miSendMail = doMenu.add(sendMail);
		miSendMail.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_M,InputEvent.CTRL_MASK));
		JButton bSendMail = toolbar.add(sendMail);
		bSendMail.setToolTipText("Send mail");
		sendMail.setEnabled(false);

		saveMail = new AbstractAction("Save mail",new ImageIcon("images/save.gif")){
				public void actionPerformed(ActionEvent ae){
					doSaveMail();
				}
			};
		JMenuItem miSaveMail = doMenu.add(saveMail);
		miSaveMail.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_S,InputEvent.CTRL_MASK));
		JButton bSaveMail = toolbar.add(saveMail);
		bSaveMail.setToolTipText("Save  mail");
		saveMail.setEnabled(false);

		deleteMail = new AbstractAction("Delete mail",new ImageIcon("images/delete.gif")){
					public void actionPerformed(ActionEvent ae){
						doDeleteMail();
					}
				};
		JMenuItem miDeleteMail = doMenu.add(deleteMail);
		miDeleteMail.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_D,InputEvent.CTRL_MASK));
		JButton bDeleteMail = toolbar.add(deleteMail);
		bDeleteMail.setToolTipText("Delete selected mail");
		deleteMail.setEnabled(false);		

		readMail = new AbstractAction("Read mail",new ImageIcon("images/readMail.gif")){
					public void actionPerformed(ActionEvent ae){
						doReadMail();
					}
				};
		JMenuItem miReadMail = doMenu.add(readMail);
		miReadMail.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_R,InputEvent.CTRL_MASK));
		JButton bReadMail = toolbar.add(readMail);
		bReadMail.setToolTipText("Read selected message");
		readMail.setEnabled(false);
		
		JSeparator sep4 = new JSeparator();
		doMenu.add(sep4);
		
		newKey = new AbstractAction("Generate Key",new ImageIcon("images/key.gif")){
					public void actionPerformed(ActionEvent ae){
						generateNewKey();
					}
				};
		JMenuItem miNewKey = doMenu.add(newKey);
		miNewKey.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_K,InputEvent.CTRL_MASK));
		JButton bNewKey = toolbar.add(newKey);
		bNewKey.setToolTipText("Generate new Key");
		newKey.setEnabled(false);

		JSeparator sep5 = new JSeparator();
		doMenu.add(sep5);

		option = new AbstractAction("Options...",new ImageIcon("images/options.gif")){
					public void actionPerformed(ActionEvent ae){
						handleOptions();
					}
				};
		JMenuItem miOption = doMenu.add(option);
		miOption.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_P,InputEvent.CTRL_MASK));
		option.setEnabled(true);

		JMenuItem exit =  new JMenuItem("Exit",KeyEvent.VK_X);
		exit.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_F4,InputEvent.ALT_MASK));
		exit.addActionListener( new ActionListener(){
						public void actionPerformed(ActionEvent ae){
							/*close current Window */
							closeAll();
						}});
		
	

		mail.add(exit);
		menuBar.add(mail);	
		menuBar.add(doMenu);
}

protected void handleOptions(){
		
	OptionDialog od;
	try{
		od = new OptionDialog(this);
		od.setVisible(true);
		address = od.getAddress();
		port = od.getPort();
	}catch(IOException ioe){
		JOptionPane.showMessageDialog(this,"An input output error occured while reading options","Error",JOptionPane.ERROR_MESSAGE);
	}catch(ClassNotFoundException cnfe){
		JOptionPane.showMessageDialog(this,"An error occured while loading options","Error",JOptionPane.ERROR_MESSAGE);
	}
}

protected void generateNewKey(){
	JKeyDialog kd = new JKeyDialog(self,"New key",true);
GETKEY:
	while(true){
		kd.show();
		if(! kd.isCancelled()){
			try{
				if(! client.keyIDExists(kd.getKeyID())){
					client.generateKey(kd.getKeyID(),kd.getPassphrase());
				}else{
					JOptionPane.showMessageDialog(self,"Please Select a different key","Key exists",
										JOptionPane.ERROR_MESSAGE);
					continue GETKEY;
				}
			}catch(IOException ioe){
				JOptionPane.showMessageDialog(self,"I/O Error occured during generating keys","Error",
									JOptionPane.ERROR_MESSAGE);
			}catch(LoginNotFoundException lnfe){
				JOptionPane.showMessageDialog(self,"Login Not Found Error occured during generating keys","Error",
									JOptionPane.ERROR_MESSAGE);
			}catch(NoSuchAlgorithmException nsae){
				JOptionPane.showMessageDialog(self,"Error occured during generating keys","Error",
									JOptionPane.ERROR_MESSAGE);
			}
		
		}
		break GETKEY;
	} /* end of while*/
}

protected void doOpenInbox(){
/*
 * Get the list of mail's from the server
 */
	try{
		messageHeaders = client.getMessageHeaders();
		if(messageHeaders.length != 0){
			if(! (inboxWindow instanceof JInboxFrame)){
				inboxWindow = new JInboxFrame("Inbox",messageHeaders);
				inboxWindow.setClosable(true);
				inboxWindow.setIconifiable(true);
				inboxWindow.setMaximizable(true);
				inboxWindow.setSize(480,360);
				inboxWindow.addInternalFrameListener(new InternalFrameAdapter(){	
										public void internalFrameClosing(InternalFrameEvent ife){
											readMail.setEnabled(false);
											deleteMail.setEnabled(false);
											inboxWindow = null;
										}
									});
				getContentArea().add(inboxWindow,new Integer(2));
			}
			inboxWindow.show();
		}else{
		/* No messages for you */
			if(inboxWindow instanceof JInboxFrame){
//				try{
//					inboxWindow.setClosed(true);
					inboxWindow.dispose();
					inboxWindow = null;
//				}catch(PropertyVetoException pve){
//				}
			}
			JOptionPane.showMessageDialog(self,"You have no messages","No Messages",JOptionPane.INFORMATION_MESSAGE);
			readMail.setEnabled(false);
			deleteMail.setEnabled(false);
		}
	}catch(IOException ioe){
		JOptionPane.showMessageDialog(self,"IOException recieving messageHeaders","Error",JOptionPane.ERROR_MESSAGE);
	}
}

protected void getNewLogin(){
	JLoginDialog loginDialog;
	do{
		loginDialog = new JLoginDialog(self,"Create New Account",true);
		loginDialog.show();
		
		if(! loginDialog.isCancelled()){
			/* Create a Login Object */
			login = new Login(loginDialog.getLoginName(),loginDialog.getPassword());
		
			/*connect to the server and send the login information */
			try{
				client = new MailClient(InetAddress.getByAddress(address),port);
				client.newLogin(login);
				/* if login Succeded then show the dialog box */
				loginSuccess = true;
				JOptionPane.showMessageDialog(self,"Login Created Successfully",
									"New Login",JOptionPane.INFORMATION_MESSAGE);
				setTitle(login.getID()+" - Email Security System");
				compose.setEnabled(true);
				openInbox.setEnabled(true);
				newKey.setEnabled(true);	
				newLogin.setEnabled(false);
				option.setEnabled(false);
					
			}catch(IOException ioe){
				JOptionPane.showMessageDialog(null,"I/O error","Error",JOptionPane.ERROR_MESSAGE);
			}catch(ServerException se){
				JOptionPane.showMessageDialog(null,se.toString(),"Error",JOptionPane.ERROR_MESSAGE);
			}
		}else
			break;
	}while(!loginSuccess);
}

protected void doSignIn(){
	JLoginDialog loginDialog;
	do{
		loginDialog = new JLoginDialog(self,"Sign In",true);
		loginDialog.show();
		
		if(!loginDialog.isCancelled()){	
			/* Create a Login Object */
			login = new Login(loginDialog.getLoginName(),loginDialog.getPassword());
		
			/*connect to the server and send the login information */
			try{
				client = new MailClient(InetAddress.getByAddress(address),port);	
				client.signAs(login);
				loginSuccess = true;
				JOptionPane.showMessageDialog(self,"Welcome "+login.getID(),"Welcome",JOptionPane.INFORMATION_MESSAGE);
				setTitle(login.getID()+" - Email Security System");
				
			}catch(IOException ioe){
				JOptionPane.showMessageDialog(self,ioe.toString(),"Error",JOptionPane.ERROR_MESSAGE);
			}catch(ServerException se){
				JOptionPane.showMessageDialog(self,se.toString(),"Error",JOptionPane.ERROR_MESSAGE);
			}
		}else
			break;
	}while(!loginSuccess);			

}

protected void doSendMail(){

	byte[] recPubKey ,senPriKey;
	/* check if reciever specified or not */
	if(sendWindow.getTo().equals("")){
		JOptionPane.showMessageDialog(self,"Please enter to whom the mail to be sent","Incomplete information",
				JOptionPane.INFORMATION_MESSAGE);
		return;
	}
	/*
	 * store the message into byte array
	 */
	String to = sendWindow.getTo();
	String subject = sendWindow.getSubject();
	boolean encrypted = sendWindow.isEncrypted();
	File attachFile = sendWindow.getAttachments();
	byte[] messageText = sendWindow.getMessage().getBytes(); 									
	byte[] fileContents = null;
	if(attachFile instanceof File && attachFile.exists()){
		try{
			FileInputStream fis = new FileInputStream(attachFile);
			fileContents = new byte[fis.available()];
			fis.read(fileContents);
		}catch(IOException ioe){
			JOptionPane.showMessageDialog(null,"Error Reading file contents :\n"+ioe.toString(),"Error",JOptionPane.ERROR_MESSAGE);
		}
	}	
	/*
	 * check whether encryption is to be done
	 * if yes then do the encryption 
	 */
	if(encrypted){
		/*
		 * Get the IDs of all public keys of reciever
		 * Get the IDs of all private keys of sender
		 * get the password from user and ask to select the keys to be used
		 */
		try{
			/* get the list of available key's for public and private */
			String[] pubKeyIDs,priKeyIDs;
			String pubKeyID="",priKeyID="",passphrase;
			pubKeyIDs = client.getPublicKeyIDList(sendWindow.getTo());
			priKeyIDs = client.getPrivateKeyIDList();
			
			/* display the PassphraseDialog to select the keys */
			PassphraseDialog ppd = new PassphraseDialog(self,priKeyIDs,pubKeyIDs);
GETID:
			while(true){
				ppd.show();
				if(!ppd.isCancelled()){
					/* get the "public and private keyID" of the recieverr */
					pubKeyID = ppd.getPublicKeyID();
					priKeyID = ppd.getPrivateKeyID();
					passphrase = ppd.getPassphrase();
		
					if(! client.isValidPassphrase(passphrase,priKeyID)){
						JOptionPane.showMessageDialog(self,"Incorrect Password. \n Try Again","Error",JOptionPane.ERROR_MESSAGE);
						continue GETID;
					}
				} /* if */
				break GETID;
			} /* end of while */

			if(! ppd.isCancelled()){
				try{
System.out.println("Encrypting message");
					messageText = client.encrypt(messageText,pubKeyID,priKeyID,sendWindow.getTo());
System.out.println("Encryption complete");
					if(attachFile instanceof File)
						fileContents = client.encrypt(fileContents,pubKeyID,priKeyID,sendWindow.getTo());
				}catch(NoSuchAlgorithmException nsae){}
				 catch(DataFormatException dfe){}
				 catch(VeryBigMessageException vbme){}
			}/* end of if*/
			else{
			JOptionPane.showMessageDialog(self,"Sending message without encryption.","Information",JOptionPane.INFORMATION_MESSAGE);
				encrypted = false;
			}
		}catch(LoginNotFoundException lnfe){
			JOptionPane.showMessageDialog(self,"Error in key retrieval process","Error",JOptionPane.ERROR_MESSAGE);
			return;
		}catch(IOException ioe){
			JOptionPane.showMessageDialog(self,"i/o Error in key retrieval process"+ioe.toString(),"Error",JOptionPane.ERROR_MESSAGE);
			ioe.printStackTrace();
			return;
		}catch(ServerException se){
			JOptionPane.showMessageDialog(self,"Error in establishing connection with serever","Error",JOptionPane.ERROR_MESSAGE);
			return;
		}	
						
	}
	/*
	 * send mail
	 */
	try{
		if(attachFile instanceof File && attachFile.exists()){
			client.sendMessage(to,subject,encrypted,1,messageText,attachFile.getName(),fileContents);
		}else{
			client.sendMessage(to,subject,encrypted,NO_ATTACHMENT,messageText);
		}
		JOptionPane.showMessageDialog(self,"Message Sent Successfully","Message sent",JOptionPane.INFORMATION_MESSAGE);
	}catch(LoginNotFoundException lnfe){
		JOptionPane.showMessageDialog(self,"LoginNotFound Error occured during transmission",
							"I/O Error",JOptionPane.ERROR_MESSAGE);
	}catch(IOException ioe){
		JOptionPane.showMessageDialog(self,"I/O Error occured during transmission",
							"I/O Error",JOptionPane.ERROR_MESSAGE);
	}catch(ServerException se){
		JOptionPane.showMessageDialog(self,se.toString(),
							"Server Failure",JOptionPane.ERROR_MESSAGE);
	}
}
protected void doSaveMail(){
	JFileChooser fc = new JFileChooser();
	int retval = fc.showSaveDialog(ESS.this);
	if(retval == JFileChooser.APPROVE_OPTION){
		File file = fc.getSelectedFile();
		int res = JOptionPane.YES_OPTION;
		if(file.exists()){
			res = JOptionPane.showConfirmDialog(ESS.this,"File with this name already exists.\n Do you want to replace it.","Save",
										JOptionPane.YES_NO_CANCEL_OPTION,
										JOptionPane.WARNING_MESSAGE);
		}
		if(res == JOptionPane.YES_OPTION){
			try{
			FileOutputStream fos = new FileOutputStream(file);
			PrintWriter pwSave = new PrintWriter(fos,true);
			pwSave.println(sendWindow.getMessage());
			
			pwSave.close();
			fos.close();						
			}catch(FileNotFoundException fnfe){
				JOptionPane.showMessageDialog(ESS.this,"Cannot save this message !\n File not found exception occured",
									"Save",JOptionPane.INFORMATION_MESSAGE);
			}catch(IOException ioe){
				JOptionPane.showMessageDialog(ESS.this,"Cannot save this message !\n An Input output exception occured",
									"Save",JOptionPane.INFORMATION_MESSAGE);
			}
		}

	}
}

protected void doDeleteMail(){
	int index = inboxWindow.getSelectedMessage();
	if(index != -1){
		int res = JOptionPane.showConfirmDialog(self,"Are you sure you want to delete this message?","Delete",
								JOptionPane.YES_NO_OPTION,JOptionPane.QUESTION_MESSAGE);
		if(res == JOptionPane.YES_OPTION){
			try{
				StringTokenizer st = new StringTokenizer(messageHeaders[messageHeaders.length-index-1],":");
				String temp = st.nextToken();
				st.nextToken(); /* leave subject */
				st.nextToken(); /* leave encrypted */
				st.nextToken(); /*leave attachments */
				String msgID = st.nextToken(); 
				client.deleteMessage(msgID);
				inboxWindow.hide();
				inboxWindow = null;
				doOpenInbox();
			}catch(Exception e){
				JOptionPane.showMessageDialog(self,e.toString(),"Error",JOptionPane.ERROR_MESSAGE);
			}
		}
	}
		
	
}
protected void doReadMail(){
	int index = inboxWindow.getSelectedMessage();
	if(index != -1){
		String header = messageHeaders[messageHeaders.length-index-1];

		StringTokenizer st = new StringTokenizer(header,":");

		String from = st.nextToken();
		String subject = st.nextToken();
		String encrypted = st.nextToken();
		int attCount = Integer.parseInt(st.nextToken());
System.out.println("Attachments found :" +attCount);
		String time = st.nextToken();
		String message = "";
		try{
			message = client.getMessage(from,time);
		}catch(ServerException se){
			JOptionPane.showMessageDialog(this,se.toString());
			return;
		}catch(ServerIOException sioe){
			JOptionPane.showMessageDialog(this,sioe.toString());
			return;
		}catch(IOException ioe){
			JOptionPane.showMessageDialog(this,ioe.toString());
			return;
		}
		String attachments = null;
		if(attCount > 0){
System.out.println("Loading attachments");
			attachments = client.getAttachments(); 
		}
		try{
			String passphrase = "";
			if(new Boolean(encrypted).booleanValue()){
				/* get the id of the public key used by the sender to encrypt */
				String keyID = client.getKeyIDFromMessage(message);
				boolean ppCorrect = false;
GETPASS:
				while(true){
					PasswordDialog pd = new PasswordDialog(this,keyID);
					pd.show();
					if(pd.isCancelled()){
						int res = JOptionPane.showConfirmDialog(null,"Do you want to diaplay the message in encrypted form","Error",JOptionPane.YES_NO_OPTION,JOptionPane.ERROR_MESSAGE);
						if(res == JOptionPane.YES_OPTION){
							ppCorrect = false;
							break GETPASS;
						}else
							continue GETPASS;
					}else{
						passphrase = pd.getPassword();
						if(client.isValidPassphrase(passphrase,keyID)){
							ppCorrect = true;
							break GETPASS;
						}
						int response = JOptionPane.showConfirmDialog(null,"Invalid password. \n Do you want to try again",
											"Error",JOptionPane.YES_NO_CANCEL_OPTION,JOptionPane.ERROR_MESSAGE);
						if(!(response == JOptionPane.YES_OPTION))
							break GETPASS;
					}
				}
				if(ppCorrect){		
					byte[] messageBytes = client.decrypt(message.getBytes(),from); 
					message = new String(messageBytes);
				}
			}
		}catch(LoginNotFoundException lnfe){
		}catch(Exception e){
			JOptionPane.showConfirmDialog(null,e.toString());
		}
		try{
			ReadMessageWindow openMessageWindow = new ReadMessageWindow(from,subject,attachments,new Boolean(encrypted).booleanValue(),message,client);
			openMessageWindow.setClosable(true);
			openMessageWindow.setIconifiable(true);
			openMessageWindow.setMaximizable(true);
			openMessageWindow.setVisible(true);
			openMessageWindow.setSize(480,320);
			openMessageWindow.setVisible(true);
			getContentArea().add(openMessageWindow,new Integer(2));
		}catch(Exception e){
			JOptionPane.showMessageDialog(self,"Server Exception occured while reading message"+e.toString(),"Error",JOptionPane.ERROR_MESSAGE);
		}
	}else{
		JOptionPane.showMessageDialog(self,"Please select a mail and then press me","Error",JOptionPane.INFORMATION_MESSAGE);
	}
}
protected void logout(){
	try{
		if(client instanceof MailClient)
			client.close();
	}catch(IOException ioe){
	}
	JInternalFrame[] frame = desktop.getAllFrames();
	for(int i = 0;i<frame.length;i++)
		frame[i].dispose();
	
	client = null;
	inboxWindow = null;
	sendWindow = null;

	miSignIn.setText("Sign In");
	bSignIn.setToolTipText("Sign In");
	
	compose.setEnabled(false);
	openInbox.setEnabled(false);
	newKey.setEnabled(false);
	saveMail.setEnabled(false);
	sendMail.setEnabled(false);
	deleteMail.setEnabled(false);
	readMail.setEnabled(false);
	option.setEnabled(true);
	
	newLogin.setEnabled(true);
}
protected void closeAll(){
	logout();
	System.exit(0);
}
}
