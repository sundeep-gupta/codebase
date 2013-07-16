import java.util.*;

public class LoginTicket extends Ticket 
{
		// Login tickets should last for 60 minutes (3600,000 msec)
		public static final long LIFETIME = 3600000;

		/**
		 *  LoginTicket constructor.  Given a userid, passes
		 *  the userid and the lifetime of the ticket up to
		 *  the parent constructor.
		 */
		public LoginTicket(String userid) 
		{
			super(userid, LIFETIME);
		} // end LoginTicket constructor

		public String toString()
		{
			return new String("*** LOGIN TICKET ***     " + super.toString());
		} // end toString()
} // end class LoginTicket
