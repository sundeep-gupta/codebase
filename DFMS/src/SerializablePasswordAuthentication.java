import java.io.Serializable;

public class SerializablePasswordAuthentication implements Serializable 
{
		private String userName;
		private char[] password;

		public SerializablePasswordAuthentication(String userName, char[] password) 
		{
			this.userName = userName;
			this.password = (char[])password.clone();
		}

		public String getUserName() 
		{
			return userName;
		}

		public char[] getPassword() 
		{
			return password;
		}

}
