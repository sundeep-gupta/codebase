import java.util.*;


public class ServiceTicket extends Ticket {

    // Service tickets should last for 60 minutes (3600,000 msec)
    public static final long LIFETIME = 3600000;

    /**
     *  ServiceTicket constructor.  Given a userid, passes
     *  the userid and the lifetime of the ticket up to
     *  the parent constructor.
     */
    public ServiceTicket(String userid){
	super(userid, LIFETIME);
    } // end ServiceTicket constructor

}
