package interfaces;
public class LoginNotFoundException extends Exception{
	private String message = "Login Not Found";
	public LoginNotFoundException(){
		super();
	}
	public LoginNotFoundException(String message){
		super();
		this.message = message;
	}
	public String toString(){
		return message;
	}
}
