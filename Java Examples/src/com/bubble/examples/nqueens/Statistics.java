public class Statistics implements java.io.Serializable{
	public static final int EASY_LEVEL = 0;
	public static final int HARD_LEVEL = 1;
	private int[] total= {0,0},wins={0,0},losses={0,0};
	public void setWin(int index){
		wins[index]++;
		total[index]++;
	}
	public int getWin(int index){
		return wins[index];
	}
	public int[] getWin(){
		return wins;
	}
	public void setLoss(int index){
		losses[index]++;
		total[index]++;
	}	
	public int getLoss(int index){
		return losses[index];
	}
	public int[] getLoss(){
		return losses;
	}
	public int[] getTotal(){
		return total;
	}
	public int getTotal(int index){
		return total[index];
	}
}