import java.io.*;
import java.util.*;

public class PasswordFile 
{
		/* Internal variables: */
		private Vector _userids;
		private Vector _passwords;
		private Vector _printQueueAccess;
		private Vector _printAccess;
		private Vector _directoryAccess;
		private Vector _fileAccess;

		/**
		 *  PasswordFile constructor.  Given the name of
		 *  a file, opens that file and reads in the
		 *  usernames, passwords, and permission strings
		 *  of the users.  Throws a FileNotFoundException
		 */
		public PasswordFile (String filename)	throws FileNotFoundException 
		{
			BufferedReader input = new BufferedReader(new FileReader(filename));
			boolean done = false;
			String userid, password, permissionString;
			String inputLine = null;
			char[] permissionArray;
			StringTokenizer tokenizer;
	
			_userids = new Vector (10, 10);
			_passwords = new Vector (10, 10);
			_printQueueAccess = new Vector (10, 10);
			_printAccess = new Vector (10, 10);
			_directoryAccess = new Vector (10, 10);
			_fileAccess = new Vector (10, 10);

			while (!done) 
			{
				// Here's how input should be handled:  Lines are read in
				// one at a time.  If no tokens can be found on a line,
				// then that line is ignored.  If exactly 3 tokens can not
				// be found on the line, then the whole configuration file
				// is deemed "bad" and an exception is thrown.  If the
				// permission string is not composed of exactly four
				// characters, all of which are 1's and 0's, then the
				// file is also deemed "bad".

				try 
				{
					inputLine = input.readLine();
				} 
				catch (IOException e) 
				{
					if (e.getMessage() != null) 
					{
						System.err.println(e.getMessage());
					} // end if-message
					e.printStackTrace();
					done = true;
				} // end try-catch

				if (inputLine == null) 	done = true;
				else 
				{
					tokenizer = new StringTokenizer(inputLine, ":", false);
					if (tokenizer.hasMoreTokens()) 
					{
						userid = tokenizer.nextToken();
						try 
						{
							password  = tokenizer.nextToken();
							permissionString = tokenizer.nextToken();
						}
						catch (NoSuchElementException n) 
						{
							throw new FileNotFoundException("Invalid password file format");
						}
						if ((userid == null) ||
							(password == null) ||
							(permissionString == null) ||
							(permissionString.length() != 4) ||
							(tokenizer.hasMoreTokens())) 
						{
							throw new FileNotFoundException("Invalid password file format");
						} // end if-bad-input

					// These first two vectors hold each user's username
					// and password.
					_userids.add(userid);
					_passwords.add(password);
	
					// The other four vectors hold boolean values indicating
					// what rights this user has.
					permissionArray = permissionString.toCharArray();
	
					if (permissionArray[0] == '0') 
					{
						_printQueueAccess.add(new Boolean(false));
					} 
					else if (permissionArray[0] == '1') 
					{
						_printQueueAccess.add(new Boolean(true));
					} 
					else 
					{
						throw new FileNotFoundException("Invalid password file format");
					} // end if-else for printQueueAccess
	
					if (permissionArray[1] == '0') 
					{
						_printAccess.add(new Boolean(false));
					} 
					else if (permissionArray[1] == '1') 
					{
						_printAccess.add(new Boolean(true));
					} 
					else 
					{
						throw new FileNotFoundException("Invalid password file format");
					} // end if-else for printAccess

					if (permissionArray[2] == '0') 
					{
						_directoryAccess.add(new Boolean(false));
					} 
					else if (permissionArray[2] == '1') 
					{
						_directoryAccess.add(new Boolean(true));
					} 
					else 
					{
						throw new FileNotFoundException("Invalid password file format");
					} // end if-else for directoryAccess

					if (permissionArray[3] == '0') 
					{
						_fileAccess.add(new Boolean(false));
					} 
					else if (permissionArray[3] == '1') 
					{
						_fileAccess.add(new Boolean(true));
					} 
					else 
					{
						throw new FileNotFoundException("Invalid password file format");
					} // end if-else for fileAccess

					} // end if-any-tokens-at-all

				} // end else-process-new-line

			} // end while-reading-in-input

			try
			{
				input.close();
			}
			catch (IOException e) 
			{
				if (e.getMessage() != null) 
				{
					System.err.println(e.getMessage());
				} // end if-message
				e.printStackTrace();
				done = true;
			} // end try-catch

		} // end PasswordFile constructor


		/**
		 *  Prints out the current contents of this object
		 *  in the format of a password file.  As always,
		 *  useful for debugging.
		 */
		public String toString() 
		{
			String outputString = "";
			String permissionString;
			int size = _userids.size();

			for (int i = 0; i < size; i++) 
			{
				outputString = new String(outputString + 
						(String)_userids.get(i) + ":" +
							(String)_passwords.get(i)	+ ":");
				if (((Boolean)_printQueueAccess.get(i)).booleanValue())
					outputString = new String(outputString + "1");
				else
					outputString = new String(outputString + "0");
				if (((Boolean)_printAccess.get(i)).booleanValue())
					outputString = new String(outputString + "1");
				else
					outputString = new String(outputString + "0");
				if (((Boolean)_directoryAccess.get(i)).booleanValue())
					outputString = new String(outputString + "1");
				else
					outputString = new String(outputString + "0");
				if (((Boolean)_fileAccess.get(i)).booleanValue())
					outputString = new String(outputString + "1\n");
				else
					outputString = new String(outputString + "0\n");
			} // end for-each-line

			return outputString;
		} // end toString()


		/**
		 *  Returns a LoginTicket for this user if the user is in
		 *  the list and the correct password is given.  Also,
		 *  sets the _loggedIn value for that user to true and
		 *  starts or restarts the thread which ensures that the
		 *  user's login status will be revoked if no login
		 *  requests are issued before the expected lifetime of a
		 *  login ticket.
		 */
		public LoginTicket getLoginTicket (SerializablePasswordAuthentication loginInfo)
			throws InvalidNameOrPasswordException
		{
			String password = new String(loginInfo.getPassword());
			int index = _userids.indexOf(loginInfo.getUserName());
			if (index == -1)
				throw new InvalidNameOrPasswordException("Unknown user");
			if (! password.equals((String)_passwords.get(index)))
				throw new InvalidNameOrPasswordException("Bad password");

			return new LoginTicket(loginInfo.getUserName());
		} // end getLoginTicket()


		/**
		 *  Given a valid login ticket, this returns a new login
		 *  ticket which will not expire as soon as the current
		 *  login ticket.  Otherwise, throws a BadTicketException.
		 */
		public LoginTicket renewLoginTicket (LoginTicket oldTicket)
	throws BadTicketException 
		{
			if (oldTicket == null)
				throw new BadTicketException("No ticket");
			if (oldTicket.hasExpired())
				throw new BadTicketException("Expired ticket");
			return new LoginTicket(oldTicket.getUserName());
		} // end renewLoginTicket()


		/**
		 *  Given a valid login ticket, this returns a file server
		 *  ticket for that login ticket's user, with the correct
		 *  permission bits set.
		 */
		public FSTicket getFSTicket (LoginTicket loginTicket)
			throws BadTicketException 
		{
	
			if (loginTicket == null)
				throw new BadTicketException("No ticket");
			if (loginTicket.hasExpired())
				throw new BadTicketException("Expired ticket");

			int index = _userids.indexOf(loginTicket.getUserName());
			return new FSTicket(loginTicket.getUserName(),
					((Boolean)_directoryAccess.get(index)).booleanValue(),
					((Boolean)_fileAccess.get(index)).booleanValue());
		} // end getFSTicket()


		/**
		 *  Given a valid login ticket, this returns a print server
		 *  ticket for that login ticket's user, with the correct
		 *  permission bits set.
		 */
		public PSTicket getPSTicket (LoginTicket loginTicket)
			throws BadTicketException 
		{
	
			if (loginTicket == null)
				throw new BadTicketException("No ticket");
			if (loginTicket.hasExpired())
				throw new BadTicketException("Expired ticket");

			int index = _userids.indexOf(loginTicket.getUserName());
			return new PSTicket(loginTicket.getUserName(),
					((Boolean)_printQueueAccess.get(index)).booleanValue(),
					((Boolean)_printAccess.get(index)).booleanValue());
		} // end getPSTicket()


		/**
		 *  Main program/test program.  This program reads in the
		 *  contents of the password file "password.txt" in the
		 *  current directory, prints out the data that it has
		 *  received, and also prints out one of each of the kinds
		 *  of tickets for each of the users in the list.
		 */
		public static void main (String args[]) 
		{
	
			try 
			{
				PasswordFile pf = new PasswordFile("password.txt");
				SerializablePasswordAuthentication pa;
				LoginTicket lt;
				System.err.println(pf.toString());
				System.err.println("Tickets granted:\n");
				for (int i = 0; i < pf._userids.size(); i++) 
				{
					pa = new SerializablePasswordAuthentication((String)pf._userids.get(i),
								((String)pf._passwords.get(i)).toCharArray());
					try 
					{
						lt = pf.getLoginTicket(pa);
						System.err.print(lt.toString());
						try 
						{
							System.err.print((pf.getPSTicket(lt)).toString());
							System.err.print((pf.getFSTicket(lt)).toString());
						} 
						catch (BadTicketException b) 
						{
							System.err.println(b.getMessage());
							b.printStackTrace();
							System.exit(1);
						}
						System.err.print("\n");
					} 
					catch (InvalidNameOrPasswordException e) 
					{
						System.err.println(e.getMessage());
						e.printStackTrace();
						System.exit(1);
					}
				} // end for
			} 
			catch (FileNotFoundException f) 
			{
				System.err.println(f.getMessage());
				f.printStackTrace();
				System.exit(1);
			} // end try-catch
		} // end main()
} // end class PasswordFile
