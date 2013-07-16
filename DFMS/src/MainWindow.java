import javax.swing.*;
import javax.swing.text.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.filechooser.*;
import java.io.File;
import java.util.*;

public class MainWindow extends JFrame implements ActionListener
{
	JScrollPane mainScrollPane = new JScrollPane();
	ShellTextArea mainTextArea;
	JMenuBar _theMenuBar = new JMenuBar();
	JMenu _optionMenu = new JMenu();
	JMenuItem _loginMenuItem = new JMenuItem();
	JMenuItem _logoutMenuItem = new JMenuItem();
	JMenuItem _saveMenuItem = new JMenuItem();
	JMenuItem _exitMenuItem = new JMenuItem();
	JMenuItem _clearMenuItem = new JMenuItem();

	public static final String LOGIN_ACTION_COMMAND  = "Login";
	public static final String LOGOUT_ACTION_COMMAND = "Logout";
	public static final String SAVE_ACTION_COMMAND   = "Save";
	public static final String EXIT_ACTION_COMMAND   = "Exit";
	public static final String CLEAR_ACTION_COMMAND   = "Clear";

	private void jbInit() throws Exception 
	{
		mainTextArea.setMinimumSize(new Dimension(550, 850));
		mainTextArea.setToolTipText("");
		_optionMenu.setMnemonic('O');
		_optionMenu.setText("Options");
		_loginMenuItem.setMnemonic('I');
		_loginMenuItem.setText("Login");
		_logoutMenuItem.setMnemonic('U');
		_logoutMenuItem.setText("Logout");

		_clearMenuItem.setMnemonic('C');
		_clearMenuItem.setText("Clear");


		_saveMenuItem.setMnemonic('S');
		_saveMenuItem.setText("Save session");
		_exitMenuItem.setMnemonic('X');
		_exitMenuItem.setText("Exit");

		_saveMenuItem.setActionCommand(SAVE_ACTION_COMMAND);
		_loginMenuItem.setActionCommand(LOGIN_ACTION_COMMAND);
		_logoutMenuItem.setActionCommand(LOGOUT_ACTION_COMMAND);
		_exitMenuItem.setActionCommand(EXIT_ACTION_COMMAND);
		_clearMenuItem.setActionCommand(CLEAR_ACTION_COMMAND);

		this.setJMenuBar(_theMenuBar);
		mainScrollPane.setMinimumSize(new Dimension(400, 400));
		mainScrollPane.setPreferredSize(new Dimension(400, 400));
		this.getContentPane().add(mainScrollPane, BorderLayout.CENTER);
		mainScrollPane.getViewport().add(mainTextArea, null);
		_theMenuBar.add(_optionMenu);
		_optionMenu.add(_loginMenuItem);
		_optionMenu.add(_logoutMenuItem);
		_optionMenu.addSeparator();
		_optionMenu.add(_saveMenuItem);
		_optionMenu.add(_clearMenuItem);
		_optionMenu.addSeparator();
		_optionMenu.add(_exitMenuItem);

		_logoutMenuItem.addActionListener(this);
		_saveMenuItem.addActionListener(this);
		_exitMenuItem.addActionListener(this);
		_clearMenuItem.addActionListener(this);

		addWindowListener(new WindowAdapter() 
		{
			public void windowClosing(WindowEvent e) 
			{
				// loggedOut();
				System.exit(1);
			}
		});
	}

	public MainWindow(String initialPrompt, WorkStation _workstation) 
	{
		mainTextArea = new ShellTextArea(initialPrompt, this, _workstation);
		try 
		{
			jbInit();
			loggedOut();
			pack();
			_loginMenuItem.addActionListener(_workstation);
			_logoutMenuItem.addActionListener(_workstation);
			_saveMenuItem.addActionListener(_workstation);//for synchronizations reasons
		}
		catch(Exception e) 
		{
			e.printStackTrace();
		}
	}

	public void setPrompt(String pwd)
	{
		mainTextArea.setPrompt(pwd);
	}

	public void passReply(String s)
	{
		mainTextArea.write(s);
	}

//	private void DisplayPrompt(){
//		mainTextArea.append("\n");
//	}
	public void DisplayErrorDialog(String title, String msg) 
	{
		JOptionPane.showMessageDialog(	this, msg,	title,	JOptionPane.OK_OPTION );
	}

	public void actionPerformed(ActionEvent event)
	{
//		if(event.getActionCommand().equals(MainWindow.SAVE_ACTION_COMMAND)){
//			String fileName = saveFileName();
//			if(fileName != null)
//				mainTextArea.saveLater(fileName);
//			return;
//		}
		if(event.getActionCommand().equals(MainWindow.CLEAR_ACTION_COMMAND))
		{
			mainTextArea.clearLater();
			return;
		}
		if(event.getActionCommand().equals(MainWindow.EXIT_ACTION_COMMAND))
		{
//			loggedOut();
			System.exit(1);
		}
	}

	/**
	 * this is called from the action_performed (in the workstation), thus,
	 * are called by the swing thread => don;t have to call it later.
	 */
	public void loggedIn()
	{
		mainTextArea.setEnabledLater(true);
		_loginMenuItem.setEnabled(false);
		_logoutMenuItem.setEnabled(true);
		_saveMenuItem.setEnabled(true);
		_clearMenuItem.setEnabled(true);
	}

	/**
	 * this is called from the action_performed (in the workstation), thus,
	 * are called by the swing thread => don;t have to call it later.
	 */
	public void loggedOut()
	{
		mainTextArea.logoutLater();
		_loginMenuItem.setEnabled(true);
		_logoutMenuItem.setEnabled(false);
		_saveMenuItem.setEnabled(false);
		_clearMenuItem.setEnabled(false);
	}

	public void save(String fName)
	{
		mainTextArea.saveLater(fName);
	}

	public String getSaveFileName()
	{
		JFileChooser chooser=new JFileChooser();
		chooser.setFileSelectionMode(JFileChooser.FILES_ONLY);
		chooser.setDialogType(JFileChooser.SAVE_DIALOG);
		TXTFileFilter filter = new TXTFileFilter();
		chooser.addChoosableFileFilter(filter);
		chooser.setFileFilter(filter);
//		java.io.File.listRoots()
		chooser.setCurrentDirectory(new java.io.File("."));
		int retval = chooser.showDialog(this, null);
		if(retval==JFileChooser.APPROVE_OPTION)
		{
			java.io.File theFile = chooser.getSelectedFile();
			if(theFile != null)
				return chooser.getSelectedFile().getAbsolutePath();
			else	return null;
		}
		else	return null;
	}

	class TXTFileFilter extends FileFilter
	{
		public String getExtension(File f) 
		{
			if(f != null) 
			{
				String filename = f.getName();
				int i = filename.lastIndexOf('.');
				if(i>0 && i<filename.length()-1) 
				{
					return filename.substring(i+1).toLowerCase();
				}
			}
			return null;
		}

		public boolean accept(File f) 
		{
			if(f != null) 
			{
				if(f.isDirectory())	return true;
				String extension = getExtension(f);
				if(extension != null && extension.equalsIgnoreCase("txt"))		return true;
			}
			return false;
		}
		public String getDescription()
		{
			return "text files";
		}
	}
}
