import java.util.*;

public class AccessRegulator 
{
    // The list that holds the list of files that are locked
    private LinkedList fileList;

	/**
     *  AccessRegulator constructor.  Creates a new empty fileList
     */
    public AccessRegulator () 
	{
		fileList = new LinkedList();
    } // end constructor


    /**
     *  Unlock() method - Removes the given file from the fileList.
     *  If the given file is not in the file list, throws a 
     *  ResourceNotFound exception.
     */
    public void unlock(String filename)
	throws ResourceNotFoundException 
	{

		System.err.println("unlock(" + filename +
			   ") called with this list:\n" + toString());
		boolean found = false;
		synchronized (fileList) 
		{
			found = fileList.remove(filename);
		} // end synchronized
		if (!found) 
			throw new ResourceNotFoundException("Attempted to unlock file \""
						+ filename +	"\", which was not locked");
	} // end unlock()

    /**
     *  The following method unlocks every file whose path
     *  starts with the given string.
     */
    public void unlockAll (String path) 
	{
		System.err.println("unlockAll(" + path +
				   ") called with this list:\n" + toString());
		Vector toRemove = new Vector(10,10);
		synchronized (fileList) 
		{
			int i;
		    for (i = 0; i < fileList.size(); i++) 
			{
				if (((String)fileList.get(i)).startsWith(path))
				toRemove.add(fileList.get(i));
		    } // end find files to remove
		    for (i = 0; i < toRemove.size(); i++) 
			{
				fileList.remove(toRemove.get(i));
			} // end remove files
		} // end synchronized
    } // end unlockAll()

    /**
     *  Lock() method - Checks the fileList to see if the given
     *  file is already listed.  If it's listed, then this 
     *  method loops until it finds that the given file is not
     *  listed.  At that point, it adds the given file to the
     *  list and exits.
     */
    public void lock(String filename) 
	{
		System.err.println("lock(" + filename + ") called with this list:\n"  + toString());
		boolean found = false;
		do 
		{
			synchronized (fileList) 
			{
				found = fileList.contains(filename);
				if (!found)	 fileList.add(filename);
		    } // end synchronized
		    if (found) Thread.currentThread().yield();
		} while (found);
    } // end lock()

    /**
     * Method for printing out the contents of the AccessRegulator
     */
    public String toString() 
	{
		String result = new String("");
		synchronized (fileList) 
		{
		    if (fileList.size() > 0)
				result = new String(fileList.get(0).toString());
		    for (int i = 1; i < fileList.size(); i++)
			result = new String(result + "\n" + fileList.get(i).toString());
		} // end sync
		return result;
    } // end toString()

} // end class AccessRegulator
