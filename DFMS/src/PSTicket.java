import java.util.*;

public class PSTicket extends ServiceTicket 
{
    private boolean _printQueueAccess;
    private boolean _printAccess;

    /**
     *  Print server ticket constructor.  Sets the values of
     *  the two permission flags and invokes the parent
     *  constructor to handle the rest of the initialization.
     */
    public PSTicket(String userid, boolean printQueueAccess, boolean printAccess) 
	{
		super(userid);
		_printQueueAccess = printQueueAccess;
		_printAccess = printAccess;
    } // end PSTicket constructor


    // Data access methods
    public boolean getPrintQueueAccess() 
	{
		return _printQueueAccess;
    }

    public boolean getPrintAccess() 
	{
		return _printAccess;
    }

    public String toString() 
	{
		String myString = new String("*** PRINT SERVER TICKET ***     "
				     + super.toString() + "Permission is given to ");
		if (_printQueueAccess && _printAccess) 
		{
			myString = new String(myString + "print files and modify the queue.\n");
		} 
		else if (_printQueueAccess) 
		{
		    myString = new String(myString + "modify the print queue.\n");
		} 
		else if (_printAccess) 
		{
			myString = new String(myString + "print files.\n");
		}
		else 
		{
			myString = new String(myString + "do NOTHING AT ALL.\n");
		}
		return myString;
    } // end toString()

}
