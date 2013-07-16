import java.awt.event.*;
import javax.swing.*;
import java.util.*;
import java.rmi.*;
import java.rmi.registry.*;
import java.net.*;
public class WorkStation implements ActionListener
{
		/**
		 * If a ticket is expired, the workstation will
		 * renew it. However, if the ticket is valid for
		 * very short time or the machines have a large difference
		 * between clocks, WS will not be able to use it, and will
		 * attempt to renew it, and so on, in an infinite loop.
		 */

		/**
		 * the fraction of the validity interval
		 * the LoginTicketRenewer thread sleeps.
		 * (Eg.sleepRatio = 4/5 and the ticket is valid for 5 minutes
		 * => I sleep 4 minutes before attempting to renew the ticket)
		 */
		private final double sleepRatio = 0.8;
		
		/**
		 * The duration (miliseconds) after the last command when the system logsout by itself.
		 */
		String fName;
		private static final long AUTO_LOGOUT_INTERVAL = 10*60*1000; //10 minutes
		public static final int LOCAL_AUTHENTICATION  = 0;
		public static final int REMOTE_AUTHENTICATION = 1;
		ASInterface _authenticationS = null;
		FSInterface _fileServer = null;
		PSInterface _printServer = null;
		Date _lastCommandDate = null;
		Object auto_logout_lock = new Object();
		String _commandString = null;
		String _pwd ="";
		LoginTicket _loginTicket = null;
		FSTicket _fileTicket = null;
		PSTicket _printTicket = null;
		Object loginLock = new Object();
		LoginTicketRenewer _automaticRenewer = new LoginTicketRenewer();
		String _tmpFileBuffer = null;
		MainWindow _gui = new MainWindow("[]", this);;
		
		/**
		 * Attempts to renew the Logint ticket (if exists)
		 * or get a new one if there is none.
		 *
		 * Returns true if it succeeded and
		 * false if it failed.
		 */
		public boolean getOrRenewLoginTicket() throws RemoteException
		{
			synchronized(loginLock)
			{
				if(_loginTicket != null)
				{
					System.out.println("[getOrRenewLoginTicket] ticket:"+_loginTicket.toString());
					try
					{
						_loginTicket = _authenticationS.renewLogin(_loginTicket);
						if(Thread.currentThread() != _automaticRenewer)
						loginLock.notify();
						return true;
					}
					catch(BadTicketException ex)
					{
						_loginTicket = null;
					}
				}
				//_login == null;
				SerializablePasswordAuthentication  pa = new LoginDialog(_gui).getPasswordAuthentication();
				if (pa==null)		return false;//the user pressed cancel
				try
				{
					_loginTicket = _authenticationS.login(pa);
					if(Thread.currentThread() != _automaticRenewer)
						 loginLock.notify();
					return true;
				}
				catch (InvalidNameOrPasswordException ex)
				{
					_gui.DisplayErrorDialog("Login Error", ex.getMessage());
					return false;
				}
				catch (RemoteException ex)
				{
					_gui.DisplayErrorDialog("Communication Error", ex.getMessage());
					return false;
				}//catch
			}//sync
		}//getLoginTicket

		/**
		 * It renews or gets for the first time a FileServer ticket
		 */
		public boolean getOrRenewFSTicket() throws RemoteException
		{
			if(!Ticket.valid(_loginTicket))
			if(!getOrRenewLoginTicket())
					return false;
			if(!Ticket.valid(_fileTicket))
			try
			{
				_fileTicket = _authenticationS.getFSTicket(_loginTicket);
			}
			catch(BadTicketException ex)
			{
				System.out.println("FS ticket request turned down: "+ex.getMessage());
				return false;
			}
			return true;
		}

		/**
		 * It renews or gets for the first time a PrintServer ticket
		*/
		public boolean getOrRenewPSTicket() throws RemoteException
		{
			if(!Ticket.valid(_loginTicket))
			if(! getOrRenewLoginTicket())
			return false;
			if(!Ticket.valid(_printTicket))
			try
			{
				_printTicket = _authenticationS.getPSTicket(_loginTicket);
			}
			catch(BadTicketException ex)
			{
				System.out.println("PF ticket request turned down: "+ex.getMessage());
				return false;
			}
			return true;
		}

		/**
		 * clears the ticket and then gets a new one.
		 */
		public boolean forceRenewTicket(ServiceTicket ticket) throws RemoteException
		{
			clearTicket(ticket);
			if(ticket instanceof FSTicket)
					return getOrRenewFSTicket();
			if(ticket instanceof PSTicket)
					return getOrRenewPSTicket();
			System.err.println("Invalid ticket type");
			return false;
		}

		public void setLastCommandDate()
		{
			synchronized(auto_logout_lock)
			{
				_lastCommandDate = new Date();
			}
		}

		public boolean isAUTO_LOGOUT_INTERVALExceeded()
		{
			return timeTill_AUTO_LOGOUT_INTERVAL_Exceeded()<0;
		}

		/* in milliseconds */
		public long timeTill_AUTO_LOGOUT_INTERVAL_Exceeded()
		{
			synchronized(auto_logout_lock)
			{
				if(_lastCommandDate == null) //I am between sessions
						return Long.MAX_VALUE;
				else
						return ( _lastCommandDate.getTime() + AUTO_LOGOUT_INTERVAL - new Date().getTime());
			}
		}

		public void actionPerformed(ActionEvent event)
		{
			if(event.getActionCommand().equals(MainWindow.LOGOUT_ACTION_COMMAND))
			{
				logout();
			}
			if(event.getActionCommand().equals(MainWindow.SAVE_ACTION_COMMAND))
			{
				String fileName;
				synchronized(loginLock)
				{
					fileName = _gui.getSaveFileName();
				}
				if(fileName != null)
				_gui.save(fileName);
				return;
			}
			if(event.getActionCommand().equals(MainWindow.LOGIN_ACTION_COMMAND))
			{
				try
				{
					if(!getOrRenewLoginTicket())	return;
					//signal the TicketRenewer that I have a ticket.
					signalAutomaticRenewer();
					getOrRenewFSTicket();
					getOrRenewPSTicket();
					_pwd = _fileServer.initialWD(_fileTicket);
					_gui.setPrompt(_pwd);
				}
				catch(Exception ex)
				{
					_gui.DisplayErrorDialog("Initialization Problem", ex.getMessage());
					return;
				}
				//the login is valid, I will unblock the shell editor
				setLastCommandDate();
				signalAutomaticRenewer();
				_gui.loggedIn();
				return;
			}
		}

		private void logout()
		{
			_pwd = "";
			synchronized(auto_logout_lock)
			{
				_lastCommandDate = null;
			}
			synchronized(loginLock)
			{
				_loginTicket = null;
				_fileTicket = null;
				_printTicket = null;
			}
			SwingUtilities.invokeLater(new Runnable()
			{ 
				public void run()
				{ 
					_gui.loggedOut();
				} 
			});
		}

		private synchronized void clearTicket(Ticket t)
		{
			t = null;
		}
		
		public WorkStation(int authenticationMode, String aservername, String fservername, String pservername) throws MalformedURLException, NotBoundException 
		{
			_automaticRenewer.start();
			_gui.setVisible(true);	
			try
			{
				if(authenticationMode == LOCAL_AUTHENTICATION)
						_authenticationS = new LocalAuthenticationServer();
				else
						_authenticationS = (ASInterface)Naming.lookup("//"+aservername+":1099/AuthenticationServer");
				_fileServer = (FSInterface)Naming.lookup("//"+fservername+":1099/FileServer");
				_printServer = (PSInterface)Naming.lookup("//"+pservername+":1099/PrintServer");
			}
			catch(RemoteException ex)
			{
				_gui.DisplayErrorDialog("Authentication Server Error", ex.getMessage());
				/** @todo EXIT/QUIT/HALT */
				System.exit(-1);
				return;
			}
			catch(Exception ex)
			{
				if (_authenticationS == null )
						System.err.println("Could not find any Authentication Server.");
				if (_fileServer == null )
						System.err.println("Could not find any File Server.");
				if (_printServer == null )
						System.err.println("Could not find any Print Server.");
				/** @todo EXIT/QUIT/HALT */
				System.exit(-1);
				return;
			}
			while(true)
			{
				try
				{
					_gui.passReply(parse(getUserCommand()));
				}
				catch(LogoutWhileParsing ex){}
				//I don't want that the latency of the remote computation to count a the inactivity
				setLastCommandDate();
			}
		}

		/**
		* Used by the Swing/awt thread to pass the command
		* Action is initiated by ENTER keyevent in ShellTextArea
		*
		* This is a producer-consumer with buffer-capacity 1, except the producer
		* (editor) will not be able to produce another command, until the consumer
		* comes up with a reply. (the reply will be transmited using the swing/awt queue)
		*
		* I am using this to decouple the AWT-queue thread, so the menues will
		* still be available while waiting fo the RMI
		*/
		public synchronized void passCommand(String cmd)
		{
			_commandString = cmd;
			notify();
		}

		/**
		 * Used by the workstation (main) thread.
		 */
		private synchronized String getUserCommand()
		{
			String str;
			while(_commandString == null)
			try
			{
				wait();
			}
			catch(InterruptedException ex){}
			str = _commandString;
			_commandString = null;

			return str;
		}

		//I use this exception to get out of 'parse' (when process logout command)
		//so the parse will not return a string that will be sent to ShellTextArea.
		private class LogoutWhileParsing extends Exception
		{
			public LogoutWhileParsing()
			{
				super();
			}
		}

		/**
		 * This parses the commands, calls the appropriate remote functions
		 * and returns their return values or error messages.
		 *
		 * If the user logged out, or the ticket expired, it returns null,
		 * so the ShellTextArea will clear its contens, get disabled
		 * and wait for a special message to get enabled.
		 *
		 * This function is executed by the main thread only !!!
		 */
		 public String parse(String command) throws LogoutWhileParsing
		{
			if(command == null || command.length() ==0)		return "";
			setLastCommandDate();
			StringTokenizer st =new StringTokenizer(command);
			int tokenCount = st.countTokens();
			if(tokenCount<1)  	return "";
			String commandToken = st.nextToken();
			/**
			 * LOGOUT
   			 */
			if(commandToken.equalsIgnoreCase("logout"))
			{
				if(tokenCount != 1)
					return "LOGOUT called with "+ (tokenCount - 1) + " arguments, instead of 0";
				logout();
				throw new LogoutWhileParsing();
			}

			/**
			 * DIR (list content of current directory)
			 */
			if(commandToken.equalsIgnoreCase("dir"))
			{
				if(tokenCount != 1)
					return "DIR called with "+ (tokenCount - 1) + " arguments, instead of 0";
				try
				{
					try
					{
						return _fileServer.dir(_fileTicket, _pwd);
					}
					catch (ResourceNotFoundException ex)
					{
						return ex.getMessage();
					}
					catch (BadTicketException ex)
					{
						return ex.getMessage();
					}
				}
				catch (RemoteException ex)
				{
					return ex.getMessage();
				}
			}

			/**
			 * PATH (equivalent to pwd)
			 */
			if(commandToken.equalsIgnoreCase("path"))
			{
				if(tokenCount != 1)
					return "PATH called with "+ (tokenCount - 1) + " arguments, instead of 0";
				return _pwd;
			}

			/**
			 * CD (Change Directory)
			 */
			if(commandToken.equalsIgnoreCase("cd"))
			{
				if(tokenCount != 2)
					return "CD called with "+ (tokenCount - 1) + " arguments, instead of 1";
				try
				{
					try
					{
						String _destDir = st.nextToken();
						_pwd = _fileServer.cd(_fileTicket, _pwd, _destDir);
						_gui.setPrompt(_pwd);
					}
					catch (WrongResourceTypeException ex)
					{
						return ex.getMessage();
					}
					catch (ResourceNotFoundException ex)
					{
						return ex.getMessage();
					}
					catch (BadTicketException ex){return ex.getMessage();}
				}
				catch (RemoteException ex)
				{
					return ex.getMessage();
				}
				return "";
			}

			/**
			 * MKDIR (makes a new directory in teh current one)
			 */
			if(commandToken.equalsIgnoreCase("mkdir"))
			{
				if(tokenCount != 2)
					return "MKDIR called with "+ (tokenCount - 1) + " arguments, instead of 1";
				try
				{
					try
					{
						String newDir = st.nextToken();
						_fileServer.mkdir(_fileTicket, _pwd, newDir);
						return "";
					}
					catch (NameConflictException ex) 
					{
						return ex.getMessage();
					}
					catch (ResourceNotFoundException ex)
					{
						return ex.getMessage();
					}
					catch (BadTicketException ex)
					{
						return ex.getMessage();
					}
				}
				catch (RemoteException ex)
				{
					return ex.getMessage();
				}
			}

			/**
			 * DELDIR (deletes empty directory)
			 */
			if(commandToken.equalsIgnoreCase("deldir"))
			{
				if(tokenCount != 2)
					return "DELDIR called with "+ (tokenCount - 1) + " arguments, instead of 1";
				try
				{
					try
					{
						String dir = st.nextToken();
						_fileServer.deldir(_fileTicket, _pwd, dir);
						return "";
					}
					catch (WrongResourceTypeException ex){ return ex.getMessage();}
					catch (ResourceNotFoundException ex){return ex.getMessage();}
					catch (BadTicketException ex){return ex.getMessage();}
				}
				catch (RemoteException ex){return ex.getMessage();}
			}

			/**
			 * DELTREE (deletes tree of subdirectories)
			 */
			if(commandToken.equalsIgnoreCase("deltree"))
			{
				if(tokenCount != 2)
					return "DELTREE called with "+ (tokenCount - 1) + " arguments, instead of 1";
				try
				{
					try
					{
						String dir = st.nextToken();
						_fileServer.deltree(_fileTicket, _pwd, dir);
						return "";
					}
					catch (WrongResourceTypeException ex){ return ex.getMessage();}
					catch (ResourceNotFoundException ex){return ex.getMessage();}
					catch (BadTicketException ex)	{return ex.getMessage();}
				}
				catch (RemoteException ex){return ex.getMessage();}
			}

			/**
			 * DELETE (erases a file)
			 */
			if(commandToken.equalsIgnoreCase("delete"))
			{
				if(tokenCount != 2)
				return "DELETE called with "+ (tokenCount - 1) + " arguments, instead of 1";
				try
				{
					try
					{
						String fileName = st.nextToken();
						_fileServer.delete(_fileTicket, _pwd, fileName);
						return "";
					}
					catch (ResourceNotFoundException ex){return ex.getMessage();}
					catch (WrongResourceTypeException ex){return ex.getMessage();}
					catch (BadTicketException ex)	{return ex.getMessage();}
				}
				catch (RemoteException ex){return ex.getMessage();}
			}

			/**
			 * CREATE (creates a file)
			 */
			if(commandToken.equalsIgnoreCase("CREATE"))
			{
				if(tokenCount != 2)
					return "CREATE called with "+ (tokenCount - 1) + " arguments, instead of 1";
				try
				{
					try
					{
						String fileName = st.nextToken();
						_fileServer.create(_fileTicket, _pwd, fileName);
						return "";
					}
					catch (NameConflictException ex){ return ex.getMessage();}
					catch (ResourceNotFoundException ex){return ex.getMessage();}
					catch (BadTicketException ex)	{return ex.getMessage();}
				}
				catch (RemoteException ex){return ex.getMessage();}
			}

			/**
			 * COPY ( creates a copy of a file)
			 */
			if(commandToken.equalsIgnoreCase("copy"))
			{
				if(tokenCount != 3)
					return "COPY called with "+ (tokenCount - 1) + " arguments, instead of 2";
				try
				{
					try
					{
						String oldName = st.nextToken();
						String newName = st.nextToken();
						_fileServer.copy(_fileTicket, _pwd, oldName, newName);
						return "";
					}
					catch (NameConflictException ex){ return ex.getMessage();}
					catch (ResourceNotFoundException ex){return ex.getMessage();}
					catch (BadTicketException ex)	{return ex.getMessage();}
				}
				catch (RemoteException ex){return ex.getMessage();}
			}

			/**
			 * REN ( renames a file)
			 */
			if(commandToken.equalsIgnoreCase("ren"))
			{
				if(tokenCount != 3)
					return "REN called with "+ (tokenCount - 1) + " arguments, instead of 2";
				try
				{
					try
					{
						String oldName = st.nextToken();
						String newName = st.nextToken();
						_fileServer.ren(_fileTicket, _pwd, oldName, newName);
						return "";
					}
					catch (NameConflictException ex){ return ex.getMessage();}
					catch (ResourceNotFoundException ex){return ex.getMessage();}
					catch (BadTicketException ex)	{return ex.getMessage();}
				}
				catch (RemoteException ex){return ex.getMessage();}
			}

			/**
			 * DISPLAY (displays the file on the screen)
			 */
			if(commandToken.equalsIgnoreCase("display"))
			{
				if(tokenCount != 2)
					return "DISPLAY called with "+ (tokenCount - 1) + " arguments, instead of 1";
				try
				{
					try
					{
						String fileName = st.nextToken();
						return _fileServer.display(_fileTicket, _pwd, fileName);
					}
					catch (ResourceNotFoundException ex)	{return ex.getMessage();}
					catch (BadTicketException ex)	{return ex.getMessage();}
				}
				catch (RemoteException ex){return ex.getMessage();}
			}

			/**
			 * PRINT (prints a file)
			 */
			if(commandToken.equalsIgnoreCase("print"))
			{
				if(tokenCount != 2)
					return "PRINT called with "+ (tokenCount - 1) + " arguments, instead of 1";
				try
				{
					try
					{
						String fileName = st.nextToken();
						fName=(String)fileName;
						_tmpFileBuffer = _fileServer.display(_fileTicket, _pwd, fileName);
						//Now I substitute the print command for the print2
						//this way is the printTicket is expired,
						//I don't have bring the file again.
						//
						// It ends in \n so that the user cannot type it.
						//(the shell returns a command without \n, so...)
						commandToken = "print2\n";
						command = "print2\n";
					}
					catch(ResourceNotFoundException ex)
					{
						return ex.getMessage();
					}
					catch (BadTicketException ex)
					{
						System.out.println("PRINT turned down because "+ex.getMessage());
						return ex.getMessage();
					}
					//I use this nested try/catch-es because getOrRenew... from the catch throws RemoteEx.
				}
				catch (RemoteException ex){return ex.getMessage();}
			}
		
			/**
			 * PRINT2 is not an available to the user
			 * (that is why it has an \n in the name)
			 *
			 * It is the second half of the print command
			 * It prints the file bufferred in _tmpFileBuffer
			 *
			 * The reason behind this split is that if PS
			 * refuses to print because of an expired ticket,
			 * afer I renew the printTicket I don't have
			 * to bring the file again from the FS.
			 */
			if(commandToken.equalsIgnoreCase("print2\n"))
			{
				try
				{
					try
					{
						_printServer.print(_printTicket, _pwd+fName, _tmpFileBuffer);
						_tmpFileBuffer = null;
						return "";
					}
					catch (BadTicketException ex)
					{
						System.out.println("PRINT turned down because "+ex.getMessage());
					}
				//I use this nested try/catch-es because getOrRenew... from the catch throws RemoteEx.
				}
				catch (RemoteException ex){return ex.getMessage();}
			}

			/**
			 * RRG (displays the content of the print queue)
			 */
			if(commandToken.equalsIgnoreCase("prg"))
			{
				if(tokenCount != 1)
					return "PRG called with "+ (tokenCount - 1) + " arguments, instead of 0";
				try
				{
					try
					{
						return _printServer.prg(_printTicket);
					}
					catch (BadTicketException ex) {	return ex.getMessage();}
				}
				catch (RemoteException ex){return ex.getMessage();}
			}

			/**
			 * PRCANCEL (displays the content of the print queue)
			 */
			if(commandToken.equalsIgnoreCase("prcancel"))
			{
				if(tokenCount != 2)
					return "PRG called with "+ (tokenCount - 1) + " arguments, instead of 0";
				try
				{
					try
					{
						String fileName = st.nextToken();
						_printServer.prcancel(_printTicket, fileName);
						return fileName+" is deleted from Print queue";
					}
					catch (ResourceNotFoundException ex){return ex.getMessage();}
					catch (BadTicketException ex)	{return ex.getMessage();}
				}
				catch (RemoteException ex){return ex.getMessage();}
			}
			return "Unknown Command";
		}

		public void signalAutomaticRenewer()
		{
			synchronized(loginLock)
			{
				loginLock.notify();
			}
		}

		/**
		 * It is a timer set to renew the Login Ticket.
		 */
		class LoginTicketRenewer extends Thread
		{
			public LoginTicketRenewer()
			{
				super();
			}
			public void run()
			{
			try
			{
				synchronized (loginLock)
				{
						while(true)
						{
							if(_loginTicket == null)
							{
								System.out.println("[Automatic RENEWER] no ticket");
								try
								{
									loginLock.wait();
								}
								catch(InterruptedException ex){}
							}
							else
							{
								long sleepTime = Math.min(timeTill_AUTO_LOGOUT_INTERVAL_Exceeded(),(long) (sleepRatio * _loginTicket.timeTillExpiration()));
								// in milliseconds
								if(sleepTime >0)
								{
									// wait(0) means something else. :)
									System.out.println("[Automatic RENEWER] I have ticket, go to sleep for "+ sleepTime);
									try
									{
										loginLock.wait(sleepTime);
										//System.out.println("[Automatic RENEWER] Woke up by myself");
									}
									catch(InterruptedException ex)
									{
										//System.out.println("[Automatic RENEWER] Interrupted");
									}
								}
								if(isAUTO_LOGOUT_INTERVALExceeded())
								{
									System.out.println("[Automatic RENEWER] Auto_Logout_Interval exceeded, dropping the ticket.");
									_gui.DisplayErrorDialog("Logout", "You have been logged out due to a long period of inactivity.");
									logout();
								}
								else
								{
									System.out.println("[Automatic RENEWER] Now I'll renew the Ticket");
									getOrRenewLoginTicket();
								}//else
							}//else
						}//while(true)
				}//sync
			}
			catch(RemoteException ex)
			{
				System.out.println("Remote Exeception stopped the LoginTicketRenewer thread");
				ex.printStackTrace();
			}
		}//run()
	}//LoginTicketRenewer

	public static void main(String[] args) 
	{
		String authenticationMode;
		String  aservername = "127.0.0.1";
		String  pservername = "127.0.0.1";
		String  fservername = "127.0.0.1";
		if (args.length == 0) 
		{
			
		    // Do nothing, default is already used;
		}
		else if (args.length == 1) 
		{
		    if ((!args[0].equals("--help")) &&	(!args[0].equals("-h"))) 
			{
				aservername = args[0];
				fservername = args[0];
				pservername = args[0];
			} 
			else 
			{
				System.err.println("Usage: java WorkStation [servername]"+"\tOR");
				System.err.println("Usage: java WorkStation [Authentication server name]  [File&Print server name]"+"\tOR");
				System.err.println("Usage: java WorkStation [Authentication server name]  [File server name]  [Print server name]");
				System.exit(0);
		    } // end if-one-argument
		}
		else if (args.length == 3 || args.length == 2) 
		{
		    	aservername = args[0];
				fservername = args[1];
				if(args.length == 2)	pservername = args[1];
				else pservername = args[2];
		}
		else 
		{
			System.err.println("Usage: java WorkStation [servername]"+"\tOR");
			System.err.println("Usage: java WorkStation [Authentication server name]  [File&Print server name]"+"\tOR");
			System.err.println("Usage: java WorkStation [Authentication server name]  [File server name]  [Print server name]");
		    System.exit(1);
		} // end parsing command line arguments

		if(System.getSecurityManager()==null)
				System.setSecurityManager(new RMISecurityManager());
		WorkStation _workStation;
		if (aservername.equals("127.0.0.1") || aservername.equalsIgnoreCase("localhost"))
				authenticationMode = System.getProperty("AuthenticationMode", "local");
		else
				authenticationMode = System.getProperty("AuthenticationMode", "remote");

		try
		{
			if( authenticationMode.equalsIgnoreCase("local"))
						_workStation = new WorkStation(LOCAL_AUTHENTICATION, aservername, fservername, pservername);
			else	if( authenticationMode.equalsIgnoreCase("remote"))
						_workStation =new WorkStation(REMOTE_AUTHENTICATION, aservername, fservername, pservername);
		}
		catch( NotBoundException ex){ ex.printStackTrace(); }
		catch( MalformedURLException ex){ ex.printStackTrace(); }
	}
}
