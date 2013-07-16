package mail;
public class VeryBigMessageException extends Exception{
	public VeryBigMessageException(){
		this("Message Too Big");
	}
	public VeryBigMessageException(String message){
		super(message);
	}
}