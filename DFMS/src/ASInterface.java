import java.rmi.Remote;
import java.rmi.RemoteException;

public interface ASInterface extends Remote {

		/**
		 *  The workstation invokes this method, providing the
		 *  username and password.  If the username and password
		 *  match the password file, then the correct ticket is
		 *  constructed and returned to the workstation.
		 *  Otherwise, an exception is thrown.
		 */
		public LoginTicket login(SerializablePasswordAuthentication loginInfo)
	throws InvalidNameOrPasswordException, RemoteException;


		/**
		 *  The workstation can invoke this method anytime
		 *  before the login ticket has expired, as long as the
		 *  user is still logged in.  This method returns a new
		 *  ticket that will not expire as soon as the current
		 *  one.
		 */
		public LoginTicket renewLogin(LoginTicket lt)
	throws BadTicketException, RemoteException;

		/**
		 *  The workstation can invoke this method at any
		 *  time to get a ticket for use at the file server,
		 *  assuming that it has a valid login ticket to
		 *  provide to the authentication server.
		 */
		public FSTicket getFSTicket(LoginTicket lt)
	throws BadTicketException, RemoteException;

		/**
		 *  The workstation can invoke this method at any
		 *  time to get a ticket for use at the print server,
		 *  assuming that it has a valid login ticket to
		 *  provide to the authentication server.
		 */
		public PSTicket getPSTicket(LoginTicket lt)
	throws BadTicketException, RemoteException;

}
