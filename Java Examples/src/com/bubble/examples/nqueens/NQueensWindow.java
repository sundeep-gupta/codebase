import javax.swing.*;
import javax.swing.event.*;
import java.awt.event.*;
import java.awt.*;
import java.io.*;
import java.util.ArrayList;
import java.beans.Beans;
public class NQueensWindow implements GameListener{
	
	int size;
	JFrame window;
	JDialog aboutDialog;
	JPanel board;
	NQueensGame nqg;
	Statistics stat;
	Difficulty diff;	
		
	JToolBar toolbar;
	JMenuBar menuBar;
	JMenu gameMenu, optionMenu, helpMenu;
	JMenuItem miGameNew, miGameOpen, miGameSave, miGameExit;
	JMenuItem miOptionDifficulty, miOptionStatistics,miHelpAbout;
	
	JButton btnNew, btnOpen, btnSave, btnDifficulty, btnStatistics,btnAbout;
	
	AbstractAction aaNew, aaOpen, aaSave, aaExit;
	AbstractAction aaDifficulty, aaStatistics,aaAbout;

	JDesktopPane dtp = null;
	JInternalFrame jif = null;
	
	/* Constructor to display the window of specified size of row and cols */
	public NQueensWindow(int size){

		this.size = size;
		window = new JFrame("N Queens Game");
		
		/*Load the available data */
		loadStatistics();
		loadDifficulty();

		/* create the toolbars and menubars */
		createActions();
		createMenuBar();
		createToolBar();
		window.setJMenuBar(menuBar);

		/* create the main panel and add toolbar on top */
		board = new JPanel(new BorderLayout());
		board.add(toolbar,BorderLayout.NORTH);

		/* create and add the other components ( board to play ) of the window */
		init();	

		/* finally put the board in window to be rendered */
		window.setContentPane(board);

		/* do settings to the main window */
		window.setSize(57*size+150, 57*size+150);
		window.setResizable(false);
		window.setVisible(true);
		window.addWindowListener(new WindowAdapter(){
						/* save the settings while closing */
						public void windowClosing(WindowEvent we){
							try{
							ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("StatValue.ser"));
							oos.writeObject(stat);
							oos.close();
							oos = new ObjectOutputStream(new FileOutputStream("DiffLevel.ser"));
							oos.writeObject(diff);
							}catch(IOException ioe){
								JOptionPane.showMessageDialog(window,"An Input/Output error while closing application","Error",JOptionPane.ERROR_MESSAGE);
							}catch(Exception e){
								JOptionPane.showMessageDialog(window,"An undefined error while closing application","Error",JOptionPane.ERROR_MESSAGE);
							}
							window.setVisible(false);
							window.dispose();
							System.exit(1);
						}
						});		
	}
	
	private void loadStatistics(){
		try{
	      	stat = (Statistics)Beans.instantiate(null, "StatValue");
	      }catch(Exception e){
  		    try{
	      	  stat = (Statistics)Beans.instantiate(null, "Statistics");
	          }catch (Exception ex){
		        System.err.println("Exception:");
	      	  System.err.println(ex);
		    }
	     }	
	}
	private void loadDifficulty(){
		try{
			diff = (Difficulty)Beans.instantiate(null,"DiffLevel");
		}catch(Exception e){
			try{
				diff = (Difficulty)Beans.instantiate(null,"Difficulty");
			}catch(Exception e2){
				System.out.println("Exception:");
				System.err.println(e2);
			}
		}
	}

	private void init(){
		nqg = new NQueensGame(size);
		nqg.getNQueens().addGameListener(this);
		dtp = new JDesktopPane();
		createInternalFrame();
		try{
			jif.setMaximum(true);
			jif.setSelected(true);
		}catch(Exception e){};
		board.add(dtp,BorderLayout.CENTER);
	}	
	private void createInternalFrame(){
		jif = new JInternalFrame("as",true,true,true,true);
		jif.getContentPane().add(nqg.getGamePanel());
		jif.setSize(40*size,40*size);
		jif.setVisible(true);
		jif.addInternalFrameListener(new InternalFrameAdapter(){
						public void internalWindowClosing(InternalFrameEvent iwe){
							dtp.remove(jif);
System.out.println("Now disabling");
							aaSave.setEnabled(false);
							miGameSave.setEnabled(false);
							btnSave.setEnabled(false);
											
						}
					});
		dtp.add(jif);	
	}

	private void createActions(){
		aaNew = new AbstractAction ("New"){
				public void actionPerformed(ActionEvent ae){
					/* Operations to do when New button clicked */
					newGame();
				}
			  };
		aaOpen = new AbstractAction("Open"){
				public void actionPerformed(ActionEvent ae){
					/* Operations to do when Open is clicked */
					openGame();
				}
			  };
		aaSave = new AbstractAction("Save"){
				public void actionPerformed(ActionEvent ae){
					/* Operations to do when Save is clicked */
					saveGame();
				}
			  };
		aaExit = new AbstractAction("Exit"){
				public void actionPerformed(ActionEvent ae){
					/* Exit the application */
				}
			  };
		
		aaDifficulty = new AbstractAction("Difficulty"){
				public void actionPerformed(ActionEvent ae){
					/* Setting the difficulty level */
				}
			  };
		aaStatistics = new AbstractAction("Statistics"){
				public void actionPerformed(ActionEvent ae) {	
					/* Maintain the statistics */
				}
			  };
		
		aaAbout = new AbstractAction("About"){
				public void actionPerformed(ActionEvent ae){

					/* Display the About box of the game */
					aboutDialog = new JDialog(window,"About N Queen",true);
					JPanel mainP = new JPanel(), p1 = new JPanel(), p2 = new JPanel(),p3 = new JPanel();
					BoxLayout bl1 = new BoxLayout(p1,BoxLayout.X_AXIS);
					BoxLayout bl2 = new BoxLayout(p2,BoxLayout.X_AXIS);
					BoxLayout bl3 = new BoxLayout(p3,BoxLayout.X_AXIS);
						
					BoxLayout bl = new BoxLayout(mainP,BoxLayout.Y_AXIS);
					JLabel appl = new JLabel("N Queen");
					p1.add(appl); p1.add(Box.createGlue());
					
					JLabel author = new JLabel("By: Sundeep Kumar Gupta");
					p2.add(author); p2.add(Box.createGlue());
					
					JLabel comp = new JLabel("Applabs Technologies Ltd");
					p3.add(comp); p3.add(Box.createGlue());
					
					mainP.add(p1); mainP.add(p2);mainP.add(p3);
					JButton ok = new JButton("Ok");
					ok.addActionListener(new ActionListener(){
								public void actionPerformed(ActionEvent al){
									aboutDialog.hide();
								}
								});
					mainP.add(ok,BorderLayout.SOUTH);
					aboutDialog.setContentPane(mainP);
					aboutDialog.setSize(200,160);
					aboutDialog.setLocation(160,100);
					aboutDialog.show();
				}
			  };

	}
	private void createToolBar() {
		toolbar = new JToolBar();
		btnNew = toolbar.add(aaNew);
		btnOpen= toolbar.add(aaOpen);
		btnOpen = toolbar.add(aaSave);
		toolbar.addSeparator();
		btnDifficulty = toolbar.add(aaDifficulty);
		btnStatistics = toolbar.add(aaStatistics);
		toolbar.addSeparator();
		btnAbout = toolbar.add(aaAbout);
	}
	private void createMenuBar(){
		menuBar = new JMenuBar();
	
		gameMenu = new JMenu("Game");
		gameMenu.setMnemonic(KeyEvent.VK_G);

		optionMenu = new JMenu("Option");
		optionMenu.setMnemonic(KeyEvent.VK_O);

		helpMenu = new JMenu("Help");
		helpMenu.setMnemonic(KeyEvent.VK_H);

		menuBar.add(gameMenu);
		menuBar.add(optionMenu);
		menuBar.add(helpMenu);
		miGameNew = gameMenu.add(aaNew);
		miGameNew.setAccelerator( KeyStroke.getKeyStroke(KeyEvent.VK_N,InputEvent.CTRL_MASK) );
		miGameNew.setMnemonic(KeyEvent.VK_N);
		
		miGameOpen = gameMenu.add(aaOpen);
		miGameOpen.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_O,InputEvent.CTRL_MASK));
		miGameOpen.setMnemonic(KeyEvent.VK_O);

		miGameSave = gameMenu.add(aaSave);
		miGameSave.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_S,InputEvent.CTRL_MASK));
		miGameSave.setMnemonic(KeyEvent.VK_S);

		gameMenu.addSeparator();

		miGameExit = gameMenu.add(aaExit);
		miGameExit.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_F4,InputEvent.ALT_MASK));
		miGameExit.setMnemonic(KeyEvent.VK_X);

		
		miOptionDifficulty = optionMenu.add(aaDifficulty);
		miOptionDifficulty.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_D,InputEvent.CTRL_MASK));
		miOptionDifficulty.setMnemonic(KeyEvent.VK_D);
		
		miOptionStatistics = optionMenu.add(aaStatistics);
		miOptionStatistics.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_T,InputEvent.CTRL_MASK));
		miOptionStatistics.setMnemonic(KeyEvent.VK_T);
		
		miHelpAbout = helpMenu.add(aaAbout);	
		miHelpAbout.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_F1,0));
		miHelpAbout.setMnemonic(KeyEvent.VK_A);
	}
private void newGame(){
/*
	nqg.getNQueens().removePositionChangeListener(nqg);
	nqg.getNQueens().removeGameListener(this);
*/	
	init();

}
private void openGame() {

	JFileChooser fcOpen =new  JFileChooser();
	int res = fcOpen.showOpenDialog(window);
	if(res == JFileChooser.APPROVE_OPTION && fcOpen.getSelectedFile().exists()) {
		try{
			ObjectInputStream ois = new ObjectInputStream(new FileInputStream(fcOpen.getSelectedFile()));
			ArrayList al = (ArrayList)ois.readObject();
			int[] position = new int[ ((Integer)al.get(0)).intValue()];
			size = position.length;
			for(int i = 1 ;i<position.length+1 ;i++)
				position[i-1] = ((Integer)al.get(i)).intValue();
			if(jif != null) {
				jif.setVisible(false);
				dtp.remove(jif);
				jif = null;		
			}
			
			nqg = new NQueensGame(size);
			nqg.getNQueens().addGameListener(this);
			createInternalFrame();
			nqg.getNQueens().setPosition(position);
			ois.close();
		}catch(IOException ioe) {
			JOptionPane.showMessageDialog(window,"Unable to restore Game","Error",JOptionPane.ERROR_MESSAGE);
		}catch(ClassNotFoundException cnfe){
			JOptionPane.showMessageDialog(window,"Undefined Error occured.\nCannot Open the saved Game","Error",JOptionPane.ERROR_MESSAGE);
		}

	}
}
private void saveGame() {
	JFileChooser fcSave = new JFileChooser();
	int res = fcSave.showSaveDialog(window);
	if(res == JFileChooser.APPROVE_OPTION) {
		File fSave = fcSave.getSelectedFile();
		int confirm = JOptionPane.YES_OPTION;
		if( fSave.exists() )
			/* Ask for confirmation */
			confirm = JOptionPane.showConfirmDialog(fcSave, fSave.getName() + " already exists. \n Do you want to replace it ?","Save As...",JOptionPane.YES_NO_OPTION, JOptionPane.WARNING_MESSAGE);
		if(confirm == JOptionPane.YES_OPTION){
			try{
				int[] position = nqg.getNQueens().getPosition();

				ArrayList al = new ArrayList(position.length+1 );
				al.add(new Integer(position.length));
				for(int i = 1  ;i<position.length + 1; i++)
					al.add(new Integer(position[i-1]));

				ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(fSave));
				oos.writeObject(al);
				oos.close();	
			}catch(IOException ioe){
				JOptionPane.showMessageDialog(window,"File Saving Failed","Error",JOptionPane.ERROR_MESSAGE);
			}
		}
	}
}

	public void winGame(GameEvent ge){
		JOptionPane.showMessageDialog(null,"Won the Game");
		jif.setVisible(false);
		dtp.remove(jif);
		jif = null;		
		aaSave.setEnabled(false);
	}
	public void lostGame(GameEvent ge){
		JOptionPane.showMessageDialog(null,"Lost the Game");
		jif.setVisible(false);
		dtp.remove(jif);
		jif = null;
		aaSave.setEnabled(false);		
	}
	private JToolBar getToolBar(){
		return toolbar;
	}
	public void setVisible(boolean visible){
		window.setVisible(visible);
	}
	public static void main(String[] arg){
		new NQueensWindow(8);
	}
	
}