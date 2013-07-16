package ui;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.StringTokenizer;
import java.util.zip.DataFormatException;
import java.security.NoSuchAlgorithmException;
import mail.*;
import interfaces.*;
public class ReadMessageWindow extends JInternalFrame{
	String from,subject,attachments,time;
	boolean encrypted;
	String message;
	JLabel fromLabel,fromVal,subjectLabel,subjectVal,attLabel;
	JButton saveButton;
	JTextArea messageArea;
	JScrollPane messageScrollPane;
	GridBagLayout gbl;
	GridBagConstraints gbc;
	JPanel subjectPanel,fromPanel,attachPanel,windowPanel;

	MailClient client;
	public ReadMessageWindow(String from,String subject,String attachments,boolean encrypted,String message,MailClient client)throws ServerException,
									ServerIOException,
									LoginNotFoundException,
									java.io.IOException,
									java.security.NoSuchAlgorithmException,
									java.util.zip.DataFormatException{
		super();
		this.client = client;

		this.from = from;
		this.subject = subject;
		this.attachments = attachments;
		this.encrypted = encrypted;
		this.message = message;

		setTitle(from);
		
		init();
	}
	public void init(){
		messageArea  = new JTextArea(message,15,40);
		messageArea.setEnabled(true);
		messageArea.setLineWrap(true);
		messageArea.setWrapStyleWord(true);
		messageArea.setEditable(false);
		
		messageScrollPane = new JScrollPane(messageArea);
		
		Font fnt = new Font("Times New Roman",Font.BOLD,14);

		fromLabel = new JLabel("From :");
		fromVal = new JLabel(from);
		fromVal.setFont(fnt);
		
		fromPanel = new JPanel();
		fromPanel.setLayout(new BoxLayout(fromPanel,BoxLayout.X_AXIS));
		fromPanel.add(fromLabel);
		fromPanel.add(Box.createRigidArea(new Dimension(25,0)));
		fromPanel.add(fromVal);
		fromPanel.add(Box.createGlue());
		
		subjectLabel = new JLabel("Subject :");
		subjectVal = new JLabel(subject);
		subjectVal.setFont(fnt);

		subjectPanel = new JPanel();
		subjectPanel.setLayout(new BoxLayout(subjectPanel,BoxLayout.X_AXIS));
		subjectPanel.add(subjectLabel);
		subjectPanel.add(Box.createRigidArea(new Dimension(10,0)));
		subjectPanel.add(subjectVal);
		subjectPanel.add(Box.createGlue());

		windowPanel = new JPanel(); 
		windowPanel.setLayout(new BoxLayout(windowPanel,BoxLayout.Y_AXIS));

		windowPanel.add(Box.createRigidArea(new Dimension(0,5)));
		windowPanel.add(fromPanel);
		windowPanel.add(Box.createRigidArea(new Dimension(0,5)));
		windowPanel.add(subjectPanel);		
		windowPanel.add(Box.createRigidArea(new Dimension(0,5)));

		setContentPane(windowPanel);
		
		if(attachments instanceof String){
			attLabel = new JLabel(attachments);
			saveButton = new JButton("Save");
			
			saveButton.addActionListener(new ActionListener(){
							public void actionPerformed(ActionEvent ae){
								JFileChooser fc = new JFileChooser();
								int retval = fc.showSaveDialog(null);
								if(retval == JFileChooser.APPROVE_OPTION){
									File file = fc.getSelectedFile();
									int res = JOptionPane.YES_OPTION;
									if(file.exists()){
										res = JOptionPane.showConfirmDialog(null,"File with this name already exists.\n Do you want to replace it.","Save",
																		JOptionPane.YES_NO_CANCEL_OPTION,
																		JOptionPane.WARNING_MESSAGE);
									}
									if(res == JOptionPane.YES_OPTION){
										String fileContentsString = "";
										byte fileContents[];
										try{									
											fileContents = client.getAttachment(attachments,encrypted).getBytes();
											if(encrypted){
JOptionPane.showMessageDialog(null,"Decrypting the file"+from);
												fileContents = client.decrypt(fileContents,from);
JOptionPane.showMessageDialog(null,"Decryption completed");
											}
JOptionPane.showMessageDialog(null,"Creating filestream");

											FileOutputStream fos = new FileOutputStream(file);
JOptionPane.showMessageDialog(null,"FileStream created");

											fos.write(fileContents);
JOptionPane.showMessageDialog(null,"Saving the file");
											fos.close();

											

										}catch(ServerException se){
											JOptionPane.showMessageDialog(null,se.toString());
										}catch(DataFormatException dfe){
											JOptionPane.showMessageDialog(null,"Unknow format of message");
										}catch(FileNotFoundException fnfe){
											JOptionPane.showMessageDialog(null,"FileNotFoundException occured during saving process");
										}catch(LoginNotFoundException lnfe){
JOptionPane.showMessageDialog(null,"Login not found exception occured");
										}catch(IOException ioe){
											JOptionPane.showMessageDialog(null,"Input Output Exception occured during saving of attachment");
										}catch(VeryBigMessageException vbme){
JOptionPane.showMessageDialog(null,"Very big message exception");
										}

									}
								}
							}
						});
			attachPanel = new JPanel();
			attachPanel.setLayout(new BoxLayout(attachPanel,BoxLayout.X_AXIS));
			attachPanel.add(attLabel);
			attachPanel.add(saveButton);
			attachPanel.add(Box.createGlue());			

			windowPanel.add(attachPanel);
			windowPanel.add(Box.createRigidArea(new Dimension(0,5)));
		
		}
		windowPanel.add(messageScrollPane);
		windowPanel.add(Box.createRigidArea(new Dimension(0,5)));
		
		pack();
		setVisible(true);
	}
}