package mail;
public class ServerException extends Exception{
	String message = "Exception at server";
	public ServerException(String message){
		this.message = message;
	}
	public ServerException(){
	}
	public String toString(){
		return message;
	}
};
