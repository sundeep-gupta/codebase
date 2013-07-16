import nqueen.*;
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
public class NQueenGame implements ActionListener{

	/* Declaration of variables used in creating the Panel */
	JPanel layout,mainPanel;
	BoxLayout bl;
	JFrame frame;
	JLabel[][] box;
	ImageIcon blackIcon, whiteIcon, blackQueenIcon, whiteQueenIcon;
	JButton btnNextSolution;

	/* The serializable object to store the positions of the queen */
	NQueen queen;

	/* Size of the game */
	int size;

	/* Constructor to render the panel as per the specified size */
	public NQueenGame(int size){
		frame = new JFrame("8 Queens Game ");
		mainPanel = new JPanel();
		bl = new BoxLayout(mainPanel,BoxLayout.Y_AXIS);
		mainPanel.setLayout(bl);

		this.size = size;
		queen = new NQueen(size);

		layout = new JPanel( new GridLayout(size,size,0,0));
		layout.setSize(size * 20, size * 20);

		btnNextSolution = new JButton("Next");
		btnNextSolution.addActionListener(this);		

		blackIcon = new ImageIcon("images/blackIcon.gif");
		whiteIcon = new ImageIcon("images/whiteIcon.gif");
		whiteQueenIcon = new ImageIcon("images/whiteQueenIcon.gif");
		blackQueenIcon = new ImageIcon("images/blackQueenIcon.gif");

		box = new JLabel[size][size];
		for(int i = 0; i<size; i++)
		for(int j = 0; j<size; j++){
			box[i][j] = new JLabel( ((i+j)%2==0)?whiteIcon:blackIcon);
			box[i][j].setBorder(javax.swing.plaf.basic.BasicBorders.getProgressBarBorder());
			box[i][j].setIconTextGap(0);
//			box[i][j].setMaximumSize(new Dimension(57,57));	
			box[i][j].setPreferredSize(new Dimension(57,57));
//			box[i][j].setMinimumSize(new Dimension(57,57));
			layout.add(box[i][j]);
		}

		mainPanel.add(btnNextSolution);
		mainPanel.add(new Box(BoxLayout.X_AXIS).createGlue());
		mainPanel.add(layout);

		frame.setContentPane(mainPanel);	

		frame.setSize((size+1)*60,(size+1)*60);	
		frame.setVisible(true);
		frame.addWindowListener(new java.awt.event.WindowAdapter(){
						public void windowClosing(java.awt.event.WindowEvent we){
							frame.setVisible(false);
							frame.dispose();
							System.exit(0);
						}
					});
		frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

	}

	private void clearBoard(){
		for(int i = 0; i<size; i++)
		for(int j = 0; j<size; j++)
			box[i][j].setIcon(( (i+j)%2==0 )?whiteIcon : blackIcon);
		
	}
	/* return the panel */
	public JPanel getGamePanel(){
		return layout;
	} 
	
	/*Method to perform action when button clicked */
	public void actionPerformed(ActionEvent ae){
		int position[];
		try{
			position = queen.getNextSolution();
			clearBoard();	
			for(int i = 0;i<size;i++)
				box[i][position[i]].setIcon( ((i+position[i])%2==0)?whiteQueenIcon:blackQueenIcon);
		}catch(SolutionNotFoundException snfe){
			JOptionPane.showMessageDialog(null,"No more solution","No Solution",JOptionPane.INFORMATION_MESSAGE);
		}
		
	}

	public static void main(String[] arg){
		new NQueenGame(8);
	}
}