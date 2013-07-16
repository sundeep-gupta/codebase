public class GameEvent extends java.util.EventObject{
	public static final boolean WIN_STATE = true;
	public static final boolean LOST_STATE = false;
	boolean state;
	public GameEvent(Object src,boolean state){
		super(src);
		this.state = state;				
	}
	public boolean getState(){
		return state;
	}
}