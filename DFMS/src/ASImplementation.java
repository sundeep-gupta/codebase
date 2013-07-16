import java.rmi.Naming;
import java.rmi.RemoteException;
import java.rmi.RMISecurityManager;
import java.rmi.server.UnicastRemoteObject;
import java.io.FileNotFoundException;
import java.rmi.registry.LocateRegistry;

public class ASImplementation extends UnicastRemoteObject
		implements ASInterface 
{
    // This object stores the data contained in a given
    // password file.
    PasswordFile pf;
    // Used for debugging
    private boolean _debugging;
    
    /**
     *  ASInteface constructor.  Uses the given password
     *  file to fill in its PasswordFile object.
     */
    private ASImplementation (String filename, boolean debugging)
	throws FileNotFoundException, RemoteException 
	{
		super();
		pf = new PasswordFile(filename);
		_debugging = debugging;
    } // end ASInterface constructor
    
    /**
     *  The workstation invokes this method, providing the
     *  username and password.  If the username and password
     *  match the password file, then the correct ticket is
     *  constructed and returned to the workstation.
     *  Otherwise, an exception is thrown.
     */
    public LoginTicket login(SerializablePasswordAuthentication loginInfo)
	throws InvalidNameOrPasswordException, RemoteException 
	{
		if (loginInfo == null)
		    throw new InvalidNameOrPasswordException("No login info given");
		if (_debugging)
		    System.err.println("AS.login called with this password info:\n"
			       + loginInfo.toString());
		return pf.getLoginTicket(loginInfo);
	} // end login()
    
    /**
     *  The workstation can invoke this method anytime
     *  before the login ticket has expired, as long as the
     *  user is still logged in.  This method returns a new
     *  ticket that will not expire as soon as the current
     *  one.
     */
    public LoginTicket renewLogin(LoginTicket lt)
	throws BadTicketException, RemoteException 
	{
		if (lt == null)
		    throw new BadTicketException("No ticket");
		if (_debugging)
		    System.err.println("AS.renewLogin called with this ticket:\n" + lt.toString());
		return pf.renewLoginTicket(lt);
    } // end renewLogin()
    
    /**
     *  The workstation can invoke this method at any
     *  time to get a ticket for use at the file server,
     *  assuming that it has a valid login ticket to
     *  provide to the authentication server.
     */
    public FSTicket getFSTicket(LoginTicket lt)
	throws BadTicketException, RemoteException 
	{
	
		if (lt == null)
			throw new BadTicketException("No ticket");
		if (_debugging)
		    System.err.println("AS.getFSTicket called with this ticket:\n" + lt.toString());
		return pf.getFSTicket(lt);
	} // end getFSTicket()
    
    /**
     *  The workstation can invoke this method at any
     *  time to get a ticket for use at the print server,
     *  assuming that it has a valid login ticket to
     *  provide to the authentication server.
     */
    public PSTicket getPSTicket(LoginTicket lt)
	throws BadTicketException, RemoteException 
	{
		if (lt == null)
		    throw new BadTicketException("No ticket");
		if (_debugging)
		    System.err.println("AS.getPSTicket called with this ticket:\n" + lt.toString());
		return pf.getPSTicket(lt);
	} // end getPSTicket()
        
    /**
     *  Main program.  Creates a security manager and
     *  registers an instance of itself with the RMI
     *  nameserver.  The name of the host to register with
     *  is given as the first command-line argument,
     *  and the server is always known as AuthenticationServer.
     *  If no argument is given, the RMI server defaults to
     *  "127.0.0.1".
     */
    public static void main(String args[]) 
	{
		String hostname = "127.0.0.1";
		if (args.length == 0) 
		{
		    // Do nothing, default is already used;
		}
		else if (args.length == 1) 
		{
		    if ((!args[0].equals("--help")) &&	(!args[0].equals("-h"))) 
			{
				hostname = args[0];
			} 
			else 
			{
				System.err.println("Usage: java ASImplementation [hostname]");
				System.exit(0);
		    } // end if-one-argument
		}
		else 
		{
			System.err.println("Usage: java ASImplementation [hostname]");
		    System.exit(1);
		} // end parsing command line arguments
		// Create and install a security manager
		if (System.getSecurityManager() == null) 
		{
		    System.setSecurityManager(new RMISecurityManager());
		} // end if-no-security-manager
		// Register the service with the RMI nameserver
		try 
		{
			//Find the registry (get a stub and force it to connect by calling list)
		    LocateRegistry.getRegistry().list();
		    ASImplementation server = new ASImplementation("password.txt", true);
		    Naming.bind("//" + hostname + ":1099/AuthenticationServer", server);
		    System.out.println("AuthenticationServer good to go");
		}
		catch (Exception e) 
		{
			System.err.println("Caught an exception as we tried to start the server:");
		    e.printStackTrace();
		    System.exit(1);
		} // end try-catch
	} // end main()
} // end class ASImpl
