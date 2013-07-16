import java.awt.*;

public class AWTProg{
	
	public static void main(String[] args){
		Frame f = new Frame("Kedar");
		Button b = new Button("Push");
		f.setSize(300,300);
		f.add(b);
		f.setVisible(true);
	}
}