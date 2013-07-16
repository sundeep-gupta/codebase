import java.rmi.Naming;
import java.rmi.RemoteException;
import java.rmi.RMISecurityManager;
import java.rmi.server.UnicastRemoteObject;
import java.rmi.registry.LocateRegistry;
import java.io.*;

public class FSImplementation extends UnicastRemoteObject
    implements FSInterface 
{
    /**
     *  If homeDirectories is false, then the initial
     *  working directory for each user is baseDirectory.
     *  If homedirectories is true, then the initial
     *  working directory for each user is
     *  "baseDirectory/username".
     */
    private String  _baseDirectory;
    private boolean _homeDirectories;
    
    // Useful for debugging
    private boolean _debugging;

    // Used for file access synchronization
    private AccessRegulator regulator;
    
    /**
     *  FSImplementation constructor.  Throws an exception if
     *  no directory by the name "baseDirectory" exists.
     */
    private FSImplementation(String baseDirectory,
			     boolean homeDirectories, boolean debugging)
	throws ResourceNotFoundException, RemoteException 
	{
		super();
		File testDirectory = new File(baseDirectory);
		try 
		{
			if (!testDirectory.exists())
				throw new ResourceNotFoundException("No such file or directory");
			if (!testDirectory.isDirectory())
				throw new ResourceNotFoundException("Is not a directory");
		}
		catch (SecurityException se) 
		{
			throw new ResourceNotFoundException("Permission denied by the local filesystem");
		} // end try-catch
		try
		{
			_baseDirectory = testDirectory.getCanonicalPath();
		}
		catch (IOException ioe0) 
		{
			ioe0.printStackTrace();
		    System.exit(1);
		}

		_homeDirectories = homeDirectories;
		_debugging = debugging;
		regulator = new AccessRegulator();
    } // end FSImplementation constructor
    
    /**
     *  Returns the file separator character for the file
     *  server's platform.
     */
    public String getFileSeparator(FSTicket t)
	throws BadTicketException, RemoteException 
	{
		if (t == null)
				throw new BadTicketException("No ticket");
		if (_debugging)
		    System.err.println("FS.getFileSeparator called with this ticket:\n" + t.toString());
		if (t.hasExpired())
		    throw new BadTicketException("Expired ticket");
		return File.separator;
    } // end getFileSeparator()


    /**
     *  Command used by the workstation for changing the
     *  current directory.  The current directory for each
     *  workstation is stored at the workstation, but this
     *  method is used to control where the user can change
     *  to and to make sure that the user does not change
     *  into a directory that does not exist.
     *
     *  This method works as follows:
     *  The ticket must be valid (i.e. non-expired), but
     *  no special permissions are required.  If the
     *  ticket is expired, a BadTicketException is thrown.
     *  If "currentDirectory" does not exist or is not a
     *  directory, then a ResourceNotFoundException or
     *  a WrongResourceType exception is thrown. If
     *  "target" is the string "..", then the parent
     *  directory of "currentDirectory" is identified.
     *  If that parent directory is above the user's
     *  initial working directory, then a
     *  ResourceNotFoundException is thrown.  Otherwise, if
     *  "target" is not "..", then "target" is appended to
     *  "currentDirectory" and the result is tested to see
     *  if is is a directory which exists.  If not, then
     *  either a ResourceNotFoundException or a
     *  WrongResourceTypeException is thrown, as appropriate.
     *  In any case, if no exceptions are thrown, then the
     *  resulting directory pathname is returned as a string.
     */
    public String cd(FSTicket t, String currentDirectory, String target)
	throws BadTicketException, ResourceNotFoundException,
	       WrongResourceTypeException, RemoteException 
	{
		if (t == null)
			throw new BadTicketException("No ticket");
		if (currentDirectory == null)
		    throw new ResourceNotFoundException("No current directory was given");
		if (target == null)
		    throw new ResourceNotFoundException("No target directory was given");
		if (_debugging)
		    System.err.println("FS.cd called with this ticket:\n"+ t.toString() +
			       "currentDirectory = \"" + currentDirectory + "\"\ntarget = \"" + target + "\"\n");
		if (t.hasExpired())
		    throw new BadTicketException("Expired ticket");
		File td = new File(_baseDirectory);
		String base = new String(_baseDirectory);
		File cd = new File(currentDirectory);
		try{regulator.lock(cd.getCanonicalPath());}
		catch (IOException ioe0) 
		{
			ioe0.printStackTrace();
		    System.exit(1);
		}
		try 
		{
			if (!cd.exists())
				throw new ResourceNotFoundException("No such file or directory");
		    if (!cd.isDirectory())
				throw new WrongResourceTypeException("Is not a directory");
		    if (target.equals("..")) 
			{
				String parentName = cd.getParent();
				if (parentName == null)
				    throw new ResourceNotFoundException("Cannot go past your directory root");
				td = new File(parentName);
				try{regulator.lock(td.getCanonicalPath());}
				catch (IOException ioe1) 
				{
				    ioe1.printStackTrace();
				    System.exit(1);
				}
				base = new String(_baseDirectory);
				try
				{
				    if (!td.getCanonicalPath().startsWith(base))
						throw new ResourceNotFoundException("Cannot go past your directory root");
				} 
				catch (IOException ioe2) 
				{
				    ioe2.printStackTrace();
				    System.exit(1);
				}
		    } // end if-changing-to-parent
		    else 
			{
				try 
				{
					td = new File(cd.getCanonicalPath() + File.separator + target);
				    regulator.lock(td.getCanonicalPath());
				}
				catch (IOException ioe3) 
				{
				    ioe3.printStackTrace();
					System.exit(1);
				}
				if (!td.exists())
				    throw new ResourceNotFoundException("No such file or directory");
				if (!td.isDirectory()) 
				    throw new WrongResourceTypeException("Is not a directory");
				try 
				{
					if (!td.getCanonicalPath().startsWith(base))
						throw new ResourceNotFoundException("Cannot go past your directory root");
				}
				catch (IOException ioe4) 
				{
				    ioe4.printStackTrace();
				    System.exit(1);
				}	
		    } // end else
		}
		catch (ResourceNotFoundException ex)
		{
		    throw ex;
		}
		catch (SecurityException se) 
		{
			throw new ResourceNotFoundException("Permission denied by local filesystem");
		} 
		catch (Exception ex)
		{
		    ex.printStackTrace();
			throw new RemoteException ("CD fault: "+ex.getMessage());
		}
		finally 
		{
		    try{regulator.unlock(cd.getCanonicalPath());}
			catch (IOException ioe5) 
			{
				ioe5.printStackTrace();
				System.exit(1);
		    }
		    // Since we may not have locked a target directory, we
			// unlock it conditionally here:
		    try {regulator.unlock(td.getCanonicalPath());}
		    catch (ResourceNotFoundException rnfe) {;}
			catch (IOException ioe6) 
			{
				ioe6.printStackTrace();
				System.exit(1);
		    }
		} // end try-catch-finally

		try {return td.getCanonicalPath();}
		catch (IOException ioe0) 
		{
		    ioe0.printStackTrace();
			System.exit(1);
		}
		System.err.println("Programmer error 0 in cd()");
		return new String("ERROR - Programmer error 0 in cd()");
	} // end cd()

    /**
     *  Given a user's ticket, this method returns the
     *  full pathname of a directory which would be an
     *  appropriate default working directory for users
     *  of the file server.
     */
    public String initialWD (FSTicket t)
	throws BadTicketException, RemoteException 
	{
		if (t == null)
		    throw new BadTicketException("No ticket");
		if (_debugging)
		    System.err.println("FS.initialWD called with this ticket:\n" + t.toString());
		if (t.hasExpired())
		    throw new BadTicketException("Expired ticket");
		if (_homeDirectories)
		    return new String(_baseDirectory + File.separator);// +  t.getUserName());
		return (_baseDirectory);
    } // end initialWD()

    /**
     *  The "list directory" command.  Returns a newline-
     *  separated list of files and directories in the
     *  current directory, or throws an exception if the
     *  current directory does not exist.  Note that this
     *  function takes a ticket, but it does not require
     *  any permissions to execute - It only throws a
     *  BadTicketException if the ticket has expired.
     */
    public String dir (FSTicket t, String currentDirectory)
	throws ResourceNotFoundException, BadTicketException, RemoteException 
	{
		if (t == null)
		    throw new BadTicketException("No ticket");
		if (currentDirectory == null)
		    throw new ResourceNotFoundException("No current directory was given");
		if (_debugging)
		    System.err.println("FS.dir called with this ticket:\n" + t.toString() +
			       "currentDirectory = \"" + currentDirectory + "\"\n");
		if (t.hasExpired())
		    throw new BadTicketException("Expired ticket");
		File cd = new File(currentDirectory);
		try{regulator.lock(cd.getCanonicalPath());}
		catch (IOException ioe1) 
		{
				ioe1.printStackTrace();
			    System.exit(1);
		}
		String result = new String("");
		try 
		{
			if (!cd.exists())
				throw new ResourceNotFoundException("No such file or directory");
			if (!cd.isDirectory())
				throw new ResourceNotFoundException("Is not a directory");
			String[] fileList = cd.list();
		    // The first file in the result is not preceeded by a newline
		    if (fileList.length > 0) 
			{
				File firstFile = new File(cd, fileList[0]);
				String firstDetails = "\t"+(firstFile.isFile()? "file" :"dir ")+
						    "   "+(firstFile.isHidden()? "hidden":"shown ")+
						    "   "+firstFile.lastModified()+ "   "+firstFile.length();
				result = new String(fileList[0]+firstDetails);
			}
		    // If there are multiple files, separate them with newlines
		    for (int i = 1; i < fileList.length; i++)
		 	{
				File son = new File(cd, fileList[i]);
				String details =  "\t"+(son.isFile()? "file" :"dir ")+
					    "   "+(son.isHidden()? "hidden":"shown ")+
						"   "+son.lastModified()+ "   "+son.length();
				result = new String(result + "\n" + fileList[i]+details);
		    }
		}
		catch (SecurityException se) 
		{
			throw new ResourceNotFoundException("Permission denied by local filesystem");
		} 
		finally 
		{
			try{regulator.unlock(cd.getCanonicalPath());}
		    catch (IOException ioe0) 
			{
				ioe0.printStackTrace();
				System.exit(1);
		    }
		} // try-catch-finally
		return result;
	} // end dir()


    /**
     *  The "make directory" command.  If the user has
     *  permission to modify directories, then the file
     *  server will create a new directory with the given
     *  name in the current directory.  This throws a
     *  ResourceNotFoundException if "currentDirectory"
     *  doesn't exist and a NameConflictException if
     *  there is already a directory by the name of
     *  "newName" in "currentDirectory".
     */
    public void mkdir (FSTicket t, String currentDirectory, String newName)
	throws ResourceNotFoundException, NameConflictException,
	       BadTicketException, RemoteException
	{
		if (t == null)
		    throw new BadTicketException("No ticket");
		if (currentDirectory == null)
		    throw new ResourceNotFoundException("No current directory was given");
		if (newName == null)
		    throw new ResourceNotFoundException("No target directory was given");
		if (_debugging)
		    System.err.println("FS.mkdir called with this ticket:\n"
			       + t.toString() +"currentDirectory = \"" +
			       currentDirectory + "\"\nnewName = \"" + newName + "\"\n");
		if (t.hasExpired())
			throw new BadTicketException("Expired ticket");
		if (!t.getDirectoryAccess())
		    throw new BadTicketException("User is not authorized to modify directories");

		File cd = new File(currentDirectory);
		File newDirectory = new File(currentDirectory + File.separator + newName);
		try
		{ 
			regulator.lock(cd.getCanonicalPath());
		    regulator.lock(newDirectory.getCanonicalPath());
		}
		catch (IOException ioe1) 
		{
		    ioe1.printStackTrace();
		    System.exit(1);
		}
	
		try 
		{
		    if (!cd.exists())
				throw new ResourceNotFoundException("No such file or directory");
		    if (!cd.isDirectory())
				throw new ResourceNotFoundException("Is not a directory");
		    if (!newDirectory.mkdir())
				throw new NameConflictException("File or directory named " +
						newName + " already exists");
		}
		catch (SecurityException se) 
		{
		    throw new ResourceNotFoundException("Permission denied by local filesystem");
		}
		finally 
		{
		    try 
			{
				regulator.unlock(cd.getCanonicalPath());
				regulator.unlock(newDirectory.getCanonicalPath());
		    } 
			catch (IOException ioe0) 
			{
				ioe0.printStackTrace();
				System.exit(1);
		    }
		} // end try-catch
    } // end mkdir()

    /**
     *  The "delete directory" command.  If the user has
     *  permission to modify directories, and if the given
     *  directory "target" exists in the given directory
     *  "currentDirectory", and if the directory "target"
     *  is empty, this removes the target directory.
     *  If any of those conditions are not met, this will
     *  throw an appropriate exception with an appropriate
     *  message.  Note that "WrongResourceTypeException"
     *  is used for both when the user tries to remove a
     *  file with this command and when the user tries to
     *  remove a non-empty directory with this command.
     */
    public void deldir (FSTicket t, String currentDirectory, String target)
	throws ResourceNotFoundException, WrongResourceTypeException,
	       BadTicketException, RemoteException 
	{
		if (t == null)
			throw new BadTicketException("No ticket");
		if (currentDirectory == null)
		    throw new ResourceNotFoundException("No current directory was given");
		if (target == null)
		    throw new ResourceNotFoundException("No target directory was given");
		if (_debugging)
		    System.err.println("FS.deldir called with this ticket:\n"
			       + t.toString() + "currentDirectory = \"" +
			       currentDirectory + "\"\ntarget = \"" + target + "\"\n");

		if (t.hasExpired())
		    throw new BadTicketException("Expired ticket");
		if (!t.getDirectoryAccess())
		    throw new BadTicketException("User is not authorized to modify directories");
		File targetDir = new File(currentDirectory +
				  File.separator + target);
		try{regulator.lock(targetDir.getCanonicalPath());}
		catch (IOException ioe1) 
		{
			ioe1.printStackTrace();
		    System.exit(1);
		}
		try 
		{
			if (!targetDir.exists())
				throw new ResourceNotFoundException("No such file or directory");
			if (!targetDir.isDirectory())
				throw new WrongResourceTypeException("Is not a directory");
		    if (!targetDir.delete())
				throw new WrongResourceTypeException("Directory is not empty");
		} 
		catch (SecurityException se) 
		{
		    throw new ResourceNotFoundException("Permission denied by local filesystem");
		}
		finally 
		{
		    try{regulator.unlock(targetDir.getCanonicalPath());}
		    catch (IOException ioe0) 
			{
				ioe0.printStackTrace();
				System.exit(1);
			}
		} // end try-catch
    } // end deldir()

    /**
     *  The "recursive delete" command.  If the user has
     *  permission to modify both directories and files,
     *  and if the given directory "target" exists in the
     *  given directory "currentDirectory", then this
     *  removes the target directory and any files it
     *  might have contained.  If any of those conditions
     *  are not met, an appropriate exception is thrown.
     */
    public void deltree (FSTicket t, String currentDirectory,
			 String target)
	throws ResourceNotFoundException, WrongResourceTypeException,
	       BadTicketException, RemoteException 
	{
	if (t == null)
	    throw new BadTicketException("No ticket");
	if (currentDirectory == null)
	    throw new ResourceNotFoundException("No current directory was given");
	if (target == null)
	    throw new ResourceNotFoundException("No target was given");
	if (_debugging)
	    System.err.println("FS.deltree called with this ticket:\n"
			       + t.toString() +
			       "currentDirectory = \"" +
			       currentDirectory +
			       "\"\ntarget = \"" + target + "\"\n");
	
	if (t.hasExpired())
	    throw new BadTicketException("Expired ticket");
	if (!t.getDirectoryAccess())
	    throw new BadTicketException("User is not authorized to modify directories");
	if (!t.getFileAccess())
	    throw new BadTicketException("User is not authorized to modify files");
	File targetDir = new File(currentDirectory +  File.separator + target);
	try{regulator.lock(targetDir.getCanonicalPath());}
	catch (IOException ioe1) 
	{
	    ioe1.printStackTrace();
	    System.exit(1);
	}

	try 
	{
	    if (!targetDir.exists())
		throw new ResourceNotFoundException("No such file or directory");
	    if (!targetDir.isDirectory())
		throw new WrongResourceTypeException("Is not a directory");
	    
	    File[] fileList = targetDir.listFiles();
	    for (int i = 0; i < fileList.length; i++) 
		{
		if (fileList[i].isDirectory())
		    deltree(t, targetDir.toString(),
			    fileList[i].getName());
		else
		    if (!fileList[i].delete())
			System.err.println("Programmer error 1 in deltree()");
	    } // end for-each-file-in-directory
	    if (!targetDir.delete())
		System.err.println("Programmer error 2 in deltree()");
	} 
	catch (SecurityException se) 
	{
	    throw new ResourceNotFoundException("Permission denied by local filesystem");
	}
	finally 
	{
	    try{regulator.unlock(targetDir.getCanonicalPath());}
	    catch (IOException ioe0) 
		{
		ioe0.printStackTrace();
		System.exit(1);
	    }
	} // end try-catch

    } // end deltree()


    /**
     *  The "rename" command.  If the user has permission
     *  to modify it, then this command renames the given
     *  file or directory "target" to the new name "newName".
     *  If the given file or directory does not exist, if
     *  the user does not have permission, or if a file or
     *  directory by that name already exists, then an
     *  exception is thrown.
     */
    public void ren (FSTicket t, String currentDirectory,
		     String target, String newName)
	throws ResourceNotFoundException, NameConflictException,
	       BadTicketException, RemoteException 
	{

	if (t == null)
	    throw new BadTicketException("No ticket");
	if (currentDirectory == null)
	    throw new ResourceNotFoundException("No current directory was given");
	if (target == null)
	    throw new ResourceNotFoundException("No target filename was given");
	if (newName == null)
	    throw new ResourceNotFoundException("No new filename was given");
	if (_debugging)
	    System.err.println("FS.ren called with this ticket:\n"
			       + t.toString() +
			       "currentDirectory = \"" +
			       currentDirectory +
			       "\"\ntarget = \"" + target +
			       "\"\nnewName = \"" + newName +
			       "\"\n");
	
	if (t.hasExpired())
	    throw new BadTicketException("Expired ticket");
	if (target.equals(newName))
	    throw new NameConflictException("\"" + target + "\" and \""
					    + newName + "\" are the same name");
	File targetFile = new File(currentDirectory +
				   File.separator +
				   target);
	try{regulator.lock(targetFile.getCanonicalPath());}
	catch (IOException ioe2) 
	{
	    ioe2.printStackTrace();
	    System.exit(1);
	}
	
	try 
	{
	    if (!targetFile.exists())
		throw new ResourceNotFoundException("No such file or directory");
	    if (targetFile.isDirectory() && (!t.getDirectoryAccess()))
		throw new BadTicketException("User is not authorized to modify directories");
	    else if (!t.getFileAccess())
		throw new BadTicketException("User is not authorized to modify files");
	    
	    try 
		{
		File newFile = new File(currentDirectory +
					File.separator +
					newName);
		regulator.lock(newFile.getCanonicalPath());
		
		if (!targetFile.renameTo(newFile)) 
		{
		    regulator.unlock(newFile.getCanonicalPath());
		throw new NameConflictException("File or directory named \"" +
						newName + "\" already exists");
		} // end if-rename-failed
	    regulator.unlock(newFile.getCanonicalPath());
	    }
		catch (IOException ioe1) 
		{
		ioe1.printStackTrace();
		System.exit(1);
	    }
		} 
		catch (SecurityException se) 
		{
	    throw new ResourceNotFoundException("Permission denied by local filesystem");
		}
		finally 
		{
	    try{regulator.unlock(targetFile.getCanonicalPath());}
	    catch (IOException ioe0) 
		{
		ioe0.printStackTrace();
		System.exit(1);
	    }
		}
	
    } // end ren()
    
    
    /**
     *  The "copy" command.  If no file or directory named
     *  "target" exists in the directory "currentDirectory",
     *  then a ResourceNotFoundException is thrown.  Else,
     *  if the "target" exists and is a regular file, then
     *  a copy of the file will be created with the name
     *  given as "newName".  Else, if the "target" exists
     *  and is a directory, then the target directory is
     *  copied recursively to a new directory named "newName".
     *  The user needs file permission to copy files and
     *  both file and directory permission to copy directories.
     *  If "newName" is the name of an existing file in the
     *  "currentDirectory", then a NameConflictException is thrown.
     */
    public void copy (FSTicket t, String currentDirectory,
		      String target, String newName)
	throws ResourceNotFoundException, NameConflictException,
	BadTicketException, RemoteException 
	{
	
	if (t == null)
	    throw new BadTicketException("No ticket");
	if (currentDirectory == null)
	    throw new ResourceNotFoundException("No current directory was given");
	if (target == null)
	    throw new ResourceNotFoundException("No target filename was given");
	if (newName == null)
	    throw new ResourceNotFoundException("No new filename was given");
	if (_debugging)
	    System.err.println("FS.copy called with this ticket:\n"
			       + t.toString() +
			       "currentDirectory = \"" +
			       currentDirectory +
			       "\"\ntarget = \"" + target +
			       "\"\nnewName = \"" + newName +
			       "\"\n");
	
	if (t.hasExpired())
	    throw new BadTicketException("Expired ticket");
	if (target.equals(newName))
	    throw new NameConflictException("\"" + target + "\" and \""
					    + newName + "\" are the same name");
	File oldFile = new File(currentDirectory +
				File.separator +
				target);
	try{regulator.lock(oldFile.getCanonicalPath());}
	catch (IOException ioe2) 
	{
	    ioe2.printStackTrace();
	    System.exit(1);
	}
	File newFile = new File(currentDirectory +
				File.separator +
				newName);
	try{regulator.lock(newFile.getCanonicalPath());}
	catch (IOException ioe1) 
	{
	    ioe1.printStackTrace();
	    System.exit(1);
	}
	try 
	{
	    if (!oldFile.exists())
		throw new ResourceNotFoundException("No such file or directory");
	    if (newFile.exists())
		throw new NameConflictException("File or directory named \"" +
						newName + "\" already exists");
	    if (oldFile.isDirectory() && (!t.getDirectoryAccess()))
		throw new BadTicketException("User is not authorized to modify directories");
	    if (!t.getFileAccess())
		throw new BadTicketException("User is not authorized to modify files");
	    rCopy(oldFile, newFile);
	} 
	catch (SecurityException se) 
	{
	    throw new ResourceNotFoundException("Permission denied by local filesystem");
	}
	finally 
	{
	    // Do our best to clean up and unlock the files we locked
	    try 
		{
		regulator.unlockAll(oldFile.getCanonicalPath());
		regulator.unlockAll(newFile.getCanonicalPath());
	    }
		catch (IOException ioe0) 
		{
		ioe0.printStackTrace();
		System.exit(1);
	    }
	} // end try-catch-finally
	
    } // end copy()
    
    
    /**
     *  A recursive copy method, which actually carries out the
     *  copying required by the public copy() method.
     */
    private void rCopy (File source, File dest)
	throws SecurityException, NameConflictException,
	ResourceNotFoundException 
	{

	// for debugging
	try 
	{
	
	if (source == null)
	    throw new ResourceNotFoundException("No source file given to rCopy() method");
	if (dest == null)
	    throw new ResourceNotFoundException("No destination file given to rCopy() method");
	if (_debugging)
	    System.err.println("FS.rCopy called with\nsource = \"" +
			       source.toString() + "\"\ndest = \"" +
			       dest.toString() + "\"\n");
	
	if (source.isDirectory()) 
	{
	    if (!dest.mkdir()) 
		throw new NameConflictException("File or directory named \""
						+ dest.getName() +
						"\" already exists");
	    File[] fileList = source.listFiles();
	    for (int i = 0; i < fileList.length; i++) 
		{
		try 
			{
		    regulator.lock(fileList[i].getCanonicalPath());
		    File newDest = new File(dest.getCanonicalPath() + File.separator
					    + fileList[i].getName());
		    regulator.lock(newDest.getCanonicalPath());
		    rCopy(fileList[i], newDest);
			} 
			catch (IOException ioe0) 
			{
		    ioe0.printStackTrace();
		    System.exit(1);
		}
    } // end for-each-file
	} // end if-is-directory
	else {
	    
	    try {
		FileInputStream inStream = new FileInputStream(source);
		FileOutputStream outStream = new FileOutputStream(dest);
		byte[] buffer = new byte[512];
		int increment = -1;
		do {
		    increment = inStream.read(buffer, 0,
					      buffer.length);
		    if (increment != -1) {
			outStream.write(buffer, 0, increment);
		    } // end if-not-end-of-file
		} while (increment != -1);
		inStream.close();
		outStream.close();
	    } catch (IOException ie) {
		throw new ResourceNotFoundException("I/O Error: " +
						    ie.getMessage());
	    } // end try-catch
	    
	} // end else-is-normal-file

	// for debugging
	} 
	catch (Exception ex) 
	{
	    ex.printStackTrace();
	    System.exit(1);
	}
	
    } // end rCopy()


    /**
     *  The "create file" command.  If the current directory
     *  exists and the user has permission to modify files,
     *  then this will create an empty file with the given
     *  name "target".  If a file by that name already
     *  exists, or if the user does not have permission to
     *  modify files, or if the current directory does not
     *  exist, then this will throw an appropriate exception.
     */
    public void create (FSTicket t, String currentDirectory, 	String target)
	throws ResourceNotFoundException, NameConflictException,
	       BadTicketException, RemoteException 
	{
	
	if (t == null)
	    throw new BadTicketException("No ticket");
	if (currentDirectory == null)
	    throw new ResourceNotFoundException("No current directory was given");
	if (target == null)
	    throw new ResourceNotFoundException("No target was given");
	if (_debugging)
	    System.err.println("FS.create called with this ticket:\n"
			       + t.toString() + "currentDirectory = \"" +
			       currentDirectory + "\"\ntarget = \"" + target + "\"\n");
	
	if (t.hasExpired())
	    throw new BadTicketException("Expired ticket");
	if (!t.getFileAccess())
	    throw new BadTicketException("User is not authorized to modify files");
	File cd = new File(currentDirectory);
	try {regulator.lock(cd.getCanonicalPath());}
	catch (IOException ioe2) 
	{
	    ioe2.printStackTrace();
	    System.exit(1);
	}
	File newFile = new File(currentDirectory + File.separator +	target);
	try
	{
		regulator.lock(newFile.getCanonicalPath());
	}
	catch (IOException ioe1) 
	{
	    ioe1.printStackTrace();
	    System.exit(1);
	}
	try 
	{
	    if (!cd.exists())
		throw new ResourceNotFoundException("No such file or directory");
			if (!cd.isDirectory())
			    throw new ResourceNotFoundException("Is not a directory");
			if (!newFile.createNewFile())
			    throw new NameConflictException("File or directory named \"" +
							    target + "\" already exists");
	}
	catch (SecurityException se) 
	{
	    throw new ResourceNotFoundException("Permission denied by local filesystem");
	}
	catch (IOException ie) 
	{
	    throw new ResourceNotFoundException("I/O Error: " +	ie.getMessage());
	} 
	finally 
	{
	    try{regulator.unlock(newFile.getCanonicalPath());}
	    catch (IOException ioe0) 
		{
			ioe0.printStackTrace();
			System.exit(1);
	    }
	}
    } // end create()

    
    /**
     *  The "delete file" command.  If the current directory
     *  exists and the user has permision to modify files,
     *  then this will delete the file with the given name
     *  "target".  If no file by that name exists, or if the
     *  user does not have permission to modify files, then
     *  this will throw an appropriate exception.
     */
    public void delete (FSTicket t, String currentDirectory,	String target)
	throws ResourceNotFoundException, BadTicketException,
	       WrongResourceTypeException, RemoteException 
	{
	
	if (t == null)
	    throw new BadTicketException("No ticket");
	if (currentDirectory == null)
	    throw new ResourceNotFoundException("No current directory was given");
	if (target == null)
	    throw new ResourceNotFoundException("No target was given");
	if (_debugging)
	    System.err.println("FS.delete called with this ticket:\n"
			       + t.toString() +
			       "currentDirectory = \"" +
			       currentDirectory +
			       "\"\ntarget = \"" + target + "\"\n");
	
	if (t.hasExpired())
	    throw new BadTicketException("Expired ticket");
	if (!t.getFileAccess())
	    throw new BadTicketException("User is not authorized to modify files");
	File targetFile = new File(currentDirectory +
					 File.separator +
					 target);
	try{regulator.lock(targetFile.getCanonicalPath());}
	catch (IOException ioe1) 
	{
	    ioe1.printStackTrace();
	    System.exit(1);
	}


	try
	{
	    if (!targetFile.exists())
		throw new ResourceNotFoundException("No such file or directory");
	    if (targetFile.isDirectory())
		throw new WrongResourceTypeException("Is not a regular file");
	    if (!targetFile.delete())
		throw new ResourceNotFoundException("Programming error 1 in delete()");
	}
	catch (SecurityException se) 
	{
	    throw new ResourceNotFoundException("Permission denied by local filesystem");
	} 
	finally 
	{
	    try{regulator.unlock(targetFile.getCanonicalPath());}
	    catch (IOException ioe0) 
		{
		ioe0.printStackTrace();
		System.exit(1);
	    }
	} // end try-catch

    } // end delete()
    
    
    /**
     *  The "display file" command.  If the user has the
     *  correct permissions, then this command returns the
     *  contents of the given file as a single String
     *  object.  In turn, the workstation can either print
     *  the file to the screen or pass the file along to
     *  the print server.  As always, if anything is not
     *  right, this method will throw the relevant
     *  exception.
     */
    public String display (FSTicket t, String currentDirectory,
			   String target)
	throws ResourceNotFoundException, BadTicketException,
	       RemoteException 
	{
	
	if (t == null)
	    throw new BadTicketException("No ticket");
	if (currentDirectory == null)
	    throw new ResourceNotFoundException("No current directory was given");
	if (target == null)
	    throw new ResourceNotFoundException("No target was given");
	if (_debugging)
	    System.err.println("FS.display called with this ticket:\n"
			       + t.toString() +
			       "currentDirectory = \"" +
			       currentDirectory +
			       "\"\ntarget = \"" + target + "\"\n");
	
	if (t.hasExpired())
	    throw new BadTicketException("Expired ticket");
	if (!t.getFileAccess())
	    throw new BadTicketException("User is not authorized to modify files");
	String result = new String("");
	File targetFile = new File(currentDirectory +
				   File.separator +
				   target);
	try{regulator.lock(targetFile.getCanonicalPath());}
	catch (IOException ioe1) 
	{
	    ioe1.printStackTrace();
	    System.exit(1);
	}

	try 
	{
	    if (!targetFile.exists())
		throw new ResourceNotFoundException("No such file or directory");
	    if (!targetFile.isFile())
		throw new ResourceNotFoundException("Is not a regular file");
	    
	    BufferedReader inReader = new BufferedReader(new FileReader(targetFile));
	    String newLine;
	    while ((newLine = inReader.readLine()) != null) 
		{
		result = new String(result + newLine + "\n");
		} // end while-more-input
	}
	catch (SecurityException se) 
	{
	    throw new ResourceNotFoundException("Permission denied by local filesystem");
	}
	catch (IOException ie) 
	{
	    throw new ResourceNotFoundException("I/O Error: " +	ie.getMessage());
	} 
	finally 
	{
	    try{regulator.unlock(targetFile.getCanonicalPath());}
	    catch (IOException ioe0) 
		{
		ioe0.printStackTrace();
		System.exit(1);
	    }
	} // end try-catch
	
	return result;

    } // end display()


    /**
     *  Main program.  Creates a security manager and
     *  registers an instance of itself with the RMI
     *  nameserver.  The name of the directory to use as the
     *  intial working directory for clients is given as the
     *  first command-line argument.  The name of the host to
     *  register with is given as the second command-line
     *  argument, and the server is always known as FileServer.
     *  If no argument is given, the RMI server defaults to
     *  "127.0.0.1".
     */
    public static void main (String args[]) 
	{
	
	String hostname = "127.0.0.1";
	
	if (args.length == 2) 
	{
	    hostname = args[1];
	}
	else if (!(args.length == 1) ||
		   ((args.length == 1) &&
		    args[0].equals("-h") ||
		    args[0].equals("--help"))) {
	    System.err.println("Usage:  java FSImplementation <base_dir> <rmi_hostname>");
	    System.exit(1);
	}
	
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
	    FSImplementation server = new FSImplementation(new String(args[0]), true, true);
	    Naming.bind("//" + hostname + ":1099/FileServer", server);
	    System.out.println("FileServer good to go");
	}
	catch (Exception e) 
	{
	    e.printStackTrace();
	    System.exit(1);
	} // end try-catch
	
    } // end main()
    
} // end class FSImplementation

