package nqueen;
import java.util.*;
public class NQueen{
	ArrayList solList = new ArrayList();
	Iterator itr;
	static int count = 0;
	int[] position ;
	int n;

	public NQueen(int n){
		this.n = n;
		position = new int[n];
		generateSolution(0);
	}
	
	private boolean place(int k, int i){
		for(int j = 0; j < k; j++) {
			if( ( position[j] == i) || ( Math.abs(position[j] - i ) == Math.abs(j-k) ) ){
				return false;
			}
		}
		return true;
	}
	public int[] getNextSolution()throws SolutionNotFoundException{
		if(itr.hasNext())
			return (int[])itr.next();
		else	
			throw new SolutionNotFoundException();
	}
	private void generateSolution(int k){
		for( int i = 0;i < n; i++){
			if( place(k,i)) {
				position[k] = i;
				if( k == (n-1)){
					count++;
					int[] temp = new int[position.length];
					for(int m = 0;m<n;m++) temp[m]=position[m];
					solList.add(temp);
				}
				else
					generateSolution(k+1);
			}
		}	
		itr = solList.iterator();
	}
	public static void main(String[] arg){
		NQueen nq = new NQueen(8);
		System.out.println("There are " + count + " combinations");
	}
}