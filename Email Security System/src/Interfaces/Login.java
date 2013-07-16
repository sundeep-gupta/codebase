package interfaces;
import java.util.*;
import java.io.Serializable;
public class Login implements Comparable,Serializable{
	private String id = null;
	private String password = null;
	public Login(String id,String pwd){
		this.id = id;
		password = pwd;
	}
	public int compareTo(Object o){
		return id.compareTo(((Login)o).getID());
	}
	public boolean equals(Login o){
		return (o.getID().equals(this.id) && o.getPassword().equals(this.password));
	}
	public String getID(){
		return id;
	}
	public String getPassword(){
		return password;
	}
	public String toString(){
		return id+password;
	}
}