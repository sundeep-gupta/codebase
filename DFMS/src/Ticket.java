import java.util.*;

public class Ticket implements java.io.Serializable 
{
		private String _userid;
		private Date _grantTime;
		private Date _expirationTime;
		
		/**
		 *  Manual ticket constructor.  Given all of the values
		 *  for all of the data fields, this assignes the
		 *  correct value to each field.
		 */
		public Ticket(String userid, Date gTime, Date eTime)
		{
			_userid = userid;
			_grantTime = gTime;
			_expirationTime = eTime;
		} // end manual Ticket constructor

		/**
		 *  Relative date constructor.  Given the userid and
		 *  a lifetime, this determines the dates to use from
		 *  the current date and the lifetime of the ticket.
		 */
		public Ticket(String userid, long lifetime) 
		{
			this(userid, new Date(), new Date((new Date()).getTime() + lifetime));
		} // end relative Ticket constructor
		
		/**
		 *  Method for accessing the user name.
		 */
		public String getUserName() 
		{
			return new String(_userid);
		} // end getUserName()
		
		/**
		 *  Returns true if the current date is after the date
		 *  stored in _expirationTime.
		 */
		public boolean hasExpired()
		{
			return (new Date()).after(_expirationTime);
		} // end hasExpired()

		public static boolean valid(Ticket t)
		{
			return (t!=null) && ! t.hasExpired();
		}

		/** The remaining interval (in milliseconds) untill  the ticket expires*/
		public long timeTillExpiration()
		{
			return _expirationTime.getTime()-new Date().getTime();
		}
		
		public String toString()
		{
			return new String("User name: " + _userid 
				+ "\nGrant date: " + _grantTime.toString() + 	
				"\nExpiration date: " + _expirationTime.toString() + "\n");
		} // end toString()
} // end class Ticket
