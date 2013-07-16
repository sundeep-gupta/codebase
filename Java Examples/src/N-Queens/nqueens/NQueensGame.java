import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.plaf.basic.*;
import java.beans.*;
/* The class to display the matrix for the NQueens Game 
 * It renders the queens on the clicked locations 
 * if the clicked location is not valid then
 * Nothing is rendered. i.e., if clicked in valid Location
 * the queen appears in the cell 
 */ 
public class NQueensGame implements ActionListener,PropertyChangeListener{
	/* Declaration of variables used in creating the Panel */
	JPanel layout;
	JButton[][] box;
	Icon blackIcon, whiteIcon, blackQueenIcon, whiteQueenIcon;

	/* The serializable object to store the positions of the queen */
	NQueens queen;

	/* Size of the game */
	int size;

	/* Constructor to render the panel as per the specified size */
	public NQueensGame(int size){
		this.size = size;
		queen = new NQueens(size);
		queen.addPositionChangeListener(this);

		layout = new JPanel( new GridLayout(size,size,0,0));
		layout.setSize(size * 20, size * 20);

		blackIcon = new ImageIcon("images/blackIcon.gif");
		whiteIcon = new ImageIcon("images/whiteIcon.gif");
		whiteQueenIcon = new ImageIcon("images/whiteQueenIcon.gif");
		blackQueenIcon = new ImageIcon("images/blackQueenIcon.gif");

		box = new JButton[size][size];
		
		for(int i = 0; i<size; i++)
		for(int j = 0; j<size; j++){
			box[i][j] = new JButton( ( (i+j)%2==0 )?whiteIcon : blackIcon);
			box[i][j].setPreferredSize(new Dimension(57,57));
			box[i][j].addActionListener(this);
			layout.add(box[i][j]);
		}
		
	}
	/* return the panel */
	public JPanel getGamePanel(){
		return layout;
	} 
	
	/* return the object containing the NQueens */
	public NQueens getNQueens(){
		return queen;
	}
	
	/*Method to perform action when button clicked */
	public void actionPerformed(ActionEvent ae){
		/* if valid location then inform the queen object  to place the queen in the cell */
		for(int i = 0;i<size;i++)
		for(int j =0;j<size; j++)
			if( ((JButton)ae.getSource()) == box[i][j] ){
				queen.setPosition(i,j);
			}
	}
	
	public void propertyChange(PropertyChangeEvent pce){
		int row = Integer.valueOf(pce.getPropertyName()).intValue();
		int col = ( (Integer)pce.getNewValue()).intValue();
		if(row >= 0 && col >= 0)
			box[row][col].setIcon( (( row+col)%2 ==0 )?whiteQueenIcon : blackQueenIcon);
		else
			box[row][col].setIcon(( (row+col)%2==0 )?whiteIcon : blackIcon);
	}
	public static void main(String[] arg){
		int size = 4;
		JFrame frame = new JFrame("8 Queens Game ");
		NQueensGame nqg = new NQueensGame(size);
		JPanel layout = nqg.getGamePanel();
		frame.getContentPane().add(layout);	

		frame.setSize((size+1)*60,(size+1)*60);	
		frame.setVisible(true);
		frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
	}
}