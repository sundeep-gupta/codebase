package k;

public class CusDetails implements java.io.Serializable{

	volatile int userid;
	volatile String firstname = null;
	volatile String middlename = null;
	volatile String lastname = null;
	volatile int contactid;
	volatile int divisionid;
	volatile String divisionname = null;
	volatile int plantid;
	volatile String plantname = null;
	volatile String username = null;


	public void setUserid(int s){
		this.userid=s;
	}


	public void setFirstname(String s){
		this.firstname=s;
	}

	public void setMiddlename(String s){
		this.middlename=s;
	}

	public void setLastname(String s){
		this.lastname=s;
	}
	public void setContactid(int s){
		this.contactid=s;
	}

	public void setDivisionid(int s){
		this.divisionid=s;
	}

	public void setDivisionname(String s){
		this.divisionname=s;
	}

	public void setPlantid(int s){
		this.plantid=s;
	}

	public void setPlantname(String s){
		this.plantname=s;
	}

	public void setUsername(String s){
		this.username=s;
	}

	


	public int getUserid(){
		return userid;
	}


	public String getFirstname(){
		return firstname;
	}

	public String getMiddlename(){
		return middlename;
	}

	public String getLastname(){
		return lastname;
	}
	public int getContactid(){
		return contactid;
	}

	public int getDivisionid(){
		return divisionid;
	}

	public String getDivisionname(){
		return divisionname;
	}

	public int getPlantid(){
		return plantid;
	}

	public String getPlantname(){
		return plantname;
	}

	public String getUsername(){
		return username;
	}


}