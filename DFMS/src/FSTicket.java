import java.util.*;

public class FSTicket extends ServiceTicket 
{
    private boolean _directoryAccess;
    private boolean _fileAccess;

    /**
     *  File server ticket constructor.  Sets the values of
     *  the two permission flags and invokes the parent
     *  constructor to handle the rest of the initialization.
     */
    public FSTicket(String userid, boolean directoryAccess, boolean fileAccess)
	{
		super(userid);
		_directoryAccess = directoryAccess;
		_fileAccess = fileAccess;
    } // end FSTicket constructor


    // Data access methods
    public boolean getDirectoryAccess() 
	{
		return _directoryAccess;
    }
    public boolean getFileAccess() 
	{
		return _fileAccess;
    }

    public String toString() 
	{
		String myString = new String("*** FILE SERVER TICKET ***     "
				     + super.toString() + "Permission is given to ");
		if (_directoryAccess && _fileAccess) 
		{
			myString = new String(myString +"work with files and directories.\n");
		} 
		else if (_directoryAccess) 
		{
			myString = new String(myString + "work only with directories.\n");
		} 
		else if (_fileAccess) 
		{
			myString = new String(myString +	  "work only with files.\n");
		} 
		else 
		{
			myString = new String(myString + "do NOTHING AT ALL.\n");
		}
		return myString;
    } // end toString()

}
