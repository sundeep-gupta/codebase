class ExecuteBatch {
	public static void main(String[] args){
	try{
		Process p = Runtime.getRuntime().exec("mysql -u root -ppassword < xyz.bat");
		p.waitFor();
	}catch(Exception e){
		System.out.println("Exception");
	}
	}
}
