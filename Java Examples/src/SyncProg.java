public class SyncProg implements Runnable{

	static int bal = 100000;
	Thread t = null;

	public SyncProg(){
	try{
		t = new Thread(this);
		System.out.println(bal);
	}catch(Exception e){
		System.out.println("In main Class");
		e.printStackTrace();
	}
	}

	public void run(){
		
		bal -= 100;
		System.out.println(bal + "\n");

	}

	public void actualWork(){
		this.t.start();
	}

	public static void main(String[] args){
	try{
		SyncProg k = new SyncProg();
		k.actualWork();
//		k.actualWork();
	}catch(Exception e){
		System.out.println("In main Class");
		e.printStackTrace();
	}




	}
}
