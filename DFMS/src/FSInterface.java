import java.rmi.Remote;
import java.rmi.RemoteException;

public interface FSInterface extends Remote 
{
    /**
     *  Returns the file separator character for the file
     *  server's platform.
     */
    public String getFileSeparator(FSTicket t)
	throws BadTicketException, RemoteException;

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
     *  a WrongResourceType exception is thrown.  If
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
	       WrongResourceTypeException, RemoteException;

    /**
     *  Given a user's ticket, this method returns the
     *  full pathname of a directory which would be an
     *  appropriate default working directory for users
     *  of the file server.
     */
    public String initialWD (FSTicket t)
	throws BadTicketException, RemoteException;

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
	throws ResourceNotFoundException, BadTicketException, RemoteException;

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
	       BadTicketException, RemoteException;

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
	       BadTicketException, RemoteException;
    
    /**
     *  The "recursive delete" command.  If the user has
     *  permission to modify both directories and files,
     *  and if the given directory "target" exists in the
     *  given directory "currentDirectory", then this
     *  removes the target directory and any files it
     *  might have contained.  If any of those conditions
     *  are not met, an appropriate exception is thrown.
     */
    public void deltree (FSTicket t, String currentDirectory, String target)
	throws ResourceNotFoundException, WrongResourceTypeException,
	       BadTicketException, RemoteException;
    
    /**
     *  The "rename" command.  If the user has permission
     *  to modify it, then this command renames the given
     *  file or directory "target" to the new name "newName".
     *  If the given file or directory does not exist, if
     *  the user does not have permission, or if a file or
     *  directory by that name already exists, then an
     *  exception is thrown.
     */
    public void ren (FSTicket t, String currentDirectory, String target, String newName)
	throws ResourceNotFoundException, NameConflictException,
	       BadTicketException, RemoteException;
    
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
    public void copy (FSTicket t, String currentDirectory, String target, String newName)
	throws ResourceNotFoundException, NameConflictException,
	       BadTicketException, RemoteException;
    
    /**
     *  The "create file" command.  If the current directory
     *  exists and the user has permission to modify files,
     *  then this will create an empty file with the given
     *  name "target".  If a file by that name already
     *  exists, or if the user does not have permission to
     *  modify files, or if the current directory does not
     *  exist, then this will throw an appropriate exception.
     */
    public void create (FSTicket t, String currentDirectory, String target)
	throws ResourceNotFoundException, NameConflictException,
	       BadTicketException, RemoteException;

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
	       WrongResourceTypeException, RemoteException;
    
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
    public String display (FSTicket t, String currentDirectory, String target)
	throws ResourceNotFoundException, BadTicketException,
	       RemoteException;
}
