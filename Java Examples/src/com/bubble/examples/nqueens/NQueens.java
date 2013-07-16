import java.util.*;
import java.beans.*;
public class NQueens implements java.io.Serializable{
	private static final int WIN = 1;
	private static final int LOST = 0;
	private static final int GAME_NOT_OVER = 2;
	protected int[] position;
	protected GameListener wll = null;
	protected PropertyChangeSupport pcs = null;
	int size;

	public NQueens(int size){
		this.size = size;
		position = new int[size];
		for(int i = 0;i<size; i++)
		    position[i] = -1 ;
		pcs = new PropertyChangeSupport(this);
	}

	
	public int[] getPosition() {
		return position;
	}

	public void setPosition(int[] pos){
		size = pos.length;
		position = new int[size];
		for(int i = 0;i<size; i++)
		    position[i] = -1 ;
		for(int i = 0;i<pos.length;i++)
			setPosition(i,pos[i]);
	}
	public void setPosition(int index, int value){
		if( isPlaceable(index,value) ) {
			position[index] = value;
			pcs.firePropertyChange(""+index,-1, position[index]);
			switch( getGameState() ){
			case WIN:
				fireWinGame(new GameEvent(this,GameEvent.WIN_STATE) );
				break;
			case LOST:
				fireLostGame(new GameEvent(this,GameEvent.LOST_STATE) );
				break;
			case GAME_NOT_OVER:
				/* do nothing as game is not completed */
				break;
			default:
				/* control should never come here */
			}
		} else {
			fireLostGame(new GameEvent(this, GameEvent.LOST_STATE) );
		}
			
	}

	protected void fireLostGame(GameEvent ge){
		if( wll != null)
			wll.lostGame(ge);
	}

	protected void fireWinGame(GameEvent ge){
		if( wll != null){
			wll.winGame(ge);
		}
	}

	public void addGameListener(GameListener wll){
		this.wll = wll;
	}
	public void removeGameListener(GameListener gl){
		this.wll = null;
	}
	public void addPositionChangeListener(PropertyChangeListener pcl){
		pcs.addPropertyChangeListener(pcl);
	}
	public void removePositionChangeListener(PropertyChangeListener pcl){
		pcs.removePropertyChangeListener(pcl);
	}

	protected boolean isPlaceable(int index, int value){
		/* check if index already contains same value */
		if(  position[index] == value )
			return true;

		/* check if index contains any other value */
		if( position[index] != -1)
			return false;
		for(int j = 0, x=0; j < size; j++) {
			if( position[j] == -1) continue;

			if(  (position[j] == value) || ( Math.abs(position[j] - value ) == Math.abs(j-index) ) ){
				return false;
			}
		}
		return true;
	}

	protected int getGameState(){
		int test = size * (size - 1) / 2 ;
		int sum = 0;
		for(int i = 0,val; i<size;i++){
			if( position[i] == -1){
				if( isAvailable(i) )
					return GAME_NOT_OVER;
				else
					return LOST;
			}
			else	
				sum += position[i];
		}
		if( (test - sum ) !=0)
			return LOST;
		return WIN;
	}

	protected boolean isAvailable(int index){
		int[] lst = getAvailableLocations(index);
		int pos;
		WHILE:
		for(int c=0;c<lst.length;c++){
			pos = lst[c];
			for(int i = 0;i<size;i++){
				if( (position[i] != -1) && ( (position[i] == pos) || (Math.abs(position[i]-pos) == Math.abs(i-index) ) ) )
					continue WHILE;
			}
			return true;
		}
		return false;
	}
	protected int[] getAvailableLocations(int index){
		boolean boolArray[] = new boolean[size];
		int count = 0;
		for(int i=0;i<size;i++)
			if( position[i] != -1 ){
				boolArray[position[i]] = true;
				count++;
			}
		int[] arr = new int[size - count];
		
		for(int i =0,j=0;i<boolArray.length;i++)
			if(!boolArray[i]) 
				arr[j++] = i;
		return arr;
	}
}