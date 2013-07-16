import java.rmi.Remote;
import java.rmi.RemoteException;

public interface PSInterface extends Remote 
{
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
		throws BadTicketException, RemoteException;

    /**
     *  The "show print queue" command.  Requires permission
     *  for the user to be able to manipulate the print
     *  queue.  Returns the list of files being printed
     *  as a newline-separated string.
     */
    public String prg (PSTicket t)	throws BadTicketException, RemoteException;
        
    /**
     *  The "cancel print job" command.  Given the name of
     *  a file in the print queue, removes the first instance
     *  of that file from the print queue.  If the file being
     *  sought does not exist, then a ResourceNotFoundException
     *  is thrown.
     */
    public void prcancel (PSTicket t, String filename)
		throws ResourceNotFoundException, BadTicketException, RemoteException;

}
