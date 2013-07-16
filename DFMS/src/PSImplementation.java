import java.rmi.RMISecurityManager;
import java.rmi.RemoteException;
import java.rmi.Naming;
import java.rmi.server.UnicastRemoteObject;
import java.rmi.registry.LocateRegistry;
import java.util.*;

public class PSImplementation extends UnicastRemoteObject
    implements PSInterface, Runnable 
{
	// Queues for holding the print jobs:
    static private LinkedList nameQueue = new LinkedList();
    static private LinkedList fileQueue = new LinkedList();
    // Thread for doing the printing
    private Thread printThread;

    // Used for debugging
    private boolean _debugging;
    
    /**
     *  PSImplementation constructor.  Starts the thread which
     *  will actually print the jobs in the print queue.
     */
    private PSImplementation (boolean debugging) throws RemoteException 
	{
		super();
		printThread = new Thread(this);
		printThread.start();
		_debugging = debugging;
    } // end constructor
   
    /**
     *  The "print file" command.  Note that the workstation
     *  has already fetched the contents of the file with a
     *  "display file" command, and so one of the parameters
     *  to this function is the contents of the file itself.
     *  The only way this function can fail is if the user
     *  does not have permission to print jobs, in which
     *  case a BadTicketException is thrown.  If this function
     *  succeeds, then the job is thrown into the print queue
     *  and eventually displayed to the screen.
     */
    public void print (PSTicket t, String filename, String fileContents)
		throws BadTicketException, RemoteException 
	{
		if (t == null)
		{
			System.err.println("No ticket ERROR");
		    throw new BadTicketException("No ticket");
		}
		if (filename == null) 
		{
			System.err.println("No filename ERROR");
			return;
		}
		if (fileContents == null) 
		{
			System.err.println("No fileContents ERROR");
		    return;
		}
		if (_debugging)
		    System.err.println("PS.print called with this ticket:\n"
			       + t.toString() + "filename = \"" + filename + "\"\n");
		if (t.hasExpired())
		{
			System.err.println("Expired ticke ERROR");
			    throw new BadTicketException("Expired ticket");
		}
		if (!t.getPrintAccess())
		{
			System.err.println("User is not authorized to print ERROR");
			    throw new BadTicketException("User is not authorized to print");
		}
		synchronized (this) 
		{
			nameQueue.addLast(filename);
		    fileQueue.addLast(fileContents);
		} // end synchronized
    } // end print()
    
    /**
     *  The "show print queue" command.  Requires permission
     *  for the user to be able to manipulate the print
     *  queue.  Returns the list of files being printed
     *  as a newline-separated string.
     */
    public String prg (PSTicket t) throws BadTicketException, RemoteException 
	{
		if (t == null)
		    throw new BadTicketException("No ticket");
		if (_debugging)
		    System.err.println("PS.prg called with this ticket:\n" + t.toString());
		if (t.hasExpired())
		    throw new BadTicketException("Expired ticket");
		if (!t.getPrintQueueAccess())
		    throw new BadTicketException("User is not authorized to access the print queue");
		String myString = "";
		synchronized (this) 
		{
			for (int i = 0; i < nameQueue.size(); i++) 
			{
				myString = new String(myString + "\n" + (String)nameQueue.get(i));
		    } // end for-each-filename
		} // end synchronized
		return myString;
    } // end prg()
    
    /**
     *  The "cancel print job" command.  Given the name of
     *  a file in the print queue, removes the first instance
     *  of that file from the print queue.  If the file being
     *  sought does not exist, then a ResourceNotFoundException
     *  is thrown.
     */
    public void prcancel (PSTicket t, String filename)
	throws ResourceNotFoundException, BadTicketException, RemoteException 
	{
		//java.io.File f = new java.io.File(filename);
		//filename = f.getAbsolutePath();
		//System.out.println(filename);
		if (t == null)
			throw new BadTicketException("No ticket");
		if (filename == null) 
		{
		    System.err.println("No filename ERROR");
			return;
		}
		if (_debugging)
			System.err.println("PS.prcancel called with this ticket:\n"
				       + t.toString() + "filename = \"" + filename + "\"\n");
		if (t.hasExpired())
		    throw new BadTicketException("Expired ticket");
		if (!t.getPrintQueueAccess())
			throw new BadTicketException("User is not authorized to access the print queue");
		boolean found = true;
		synchronized (this) 
		{
			int i = nameQueue.indexOf(filename);
		    if (i == -1)	found = false;
		    else 
			{
				nameQueue.remove(i);
				fileQueue.remove(i);
			}
		} // end synchronized
		if (!found)
			throw new ResourceNotFoundException("No file named " +
						filename + " in the queue");
    } // end prcancel()
    
    /**
     *  This method contains the thread code that will actually
     *  do the work of removing jobs from the queue and displaying
     *  them to the screen.  Specifically, the thread removes
     *  one "page" worth of lines, displays them, and then sleeps for
     *  5 seconds.
     */
    public void run() 
	{
		boolean printing = false;
		boolean finished = false;
		String target, substring;
		int line, start, end;
		while (true)
		{
		    // Sleep for 5 seconds
		    try 
			{
				Thread.currentThread().sleep(5000);
			} 
			catch (InterruptedException e) {}
		    // Check the queue for jobs.  If there's a job, print it.
		    synchronized(this) 
			{
				if (nameQueue.size() != 0) 
				{
		    		// If this is a new job, print a header for it
					if (!printing) 
					{
						printing = true;
						finished = false;
						System.out.println("\nPrinting file \"" +
							   (String)nameQueue.getFirst() + "\":\n");
					} // end if-not-printing
				    target = (String)fileQueue.getFirst();
				    line = 0;
				    start = 0;
				    while ((line < 10) && (!finished)) 
					{
						line++;
						end = target.indexOf("\n", start);
						if (end == -1) 
						{
						    finished = true;
						    substring = target.substring(start);
						} // end if-last-line
						else 
						{
							end++;
							substring = target.substring(start, end);
						} // end else
						System.out.print(substring);
						start = end + 1;
				    } // end while-printing
		
				    // If the job finished (i.e. the last line of the
				    // first job was printed), then remove the first
					// job and set the variable "printing" to false.
				    // Otherwise, replace the file data in the queue
					// with the portion of the data that has not been
				    // printed yet.
					if (finished) 
					{
						nameQueue.removeFirst();
						fileQueue.removeFirst();
						printing = false;
				    } // end if-finished
					else 
					{
						fileQueue.set(0, new String(target.substring(start)));
					} // end else-shorten-file
				} // end if-queue-not-empty
			} // end synchronized
		} // end while-forever
    } // end run()
    
    /**
     *  Main program.  Creates a security manager and
     *  registers an instance of itself with the RMI
     *  nameserver.  The name of the host to register with
     *  is given as the first command-line argument,
     *  and the server is always known as PrintServer.
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
			if ((!args[0].equals("--help")) &&
					(!args[0].equals("-h"))) 
			{
				hostname = args[0];
			} 
			else 
			{
				System.err.println("Usage: java PSImplementation [hostname]");
				System.exit(0);
			} // end if-one-argument
		} 
		else 
		{
			System.err.println("Usage: java PSImplementation [hostname]");
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
		    //LocateRegistry.getRegistry().list();
		    PSImplementation server = new PSImplementation(true);
			Naming.bind("//" + hostname + ":1099/PrintServer", server);
		    System.out.println("PrintServer good to go");
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		    System.exit(1);
		} // end try-catch
    } // end main()
} // end class PSImplementation
