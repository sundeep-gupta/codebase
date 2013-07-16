import java.rmi.*;
import java.io.*;

public class LocalAuthenticationServer implements ASInterface 
{
	PasswordFile pf = null;
	public LocalAuthenticationServer() throws RemoteException
	{
			try
			{
				pf = new PasswordFile("password.txt");
			}
			catch (FileNotFoundException ex)
			{
				throw new RemoteException (ex.getMessage());
			}
	}

	public LoginTicket login(SerializablePasswordAuthentication loginInfo) throws InvalidNameOrPasswordException, RemoteException 
	{
		return pf.getLoginTicket(loginInfo);
	}

	public LoginTicket renewLogin(LoginTicket lt)throws BadTicketException
	{
		return new LoginTicket(lt.getUserName());
	}

	public FSTicket getFSTicket(LoginTicket lt)throws BadTicketException
	{
		return pf.getFSTicket(lt);
	}

	public PSTicket getPSTicket(LoginTicket lt)throws BadTicketException
	{
		return pf.getPSTicket(lt);
	}

}
