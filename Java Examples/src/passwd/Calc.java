//package calculator;

import java.awt.event.ActionListener;
import java.awt.event.KeyListener;

import java.awt.BorderLayout;
import java.awt.GridLayout;
import java.awt.event.KeyEvent;
import java.awt.event.ActionEvent;
import javax.swing.JFrame;
import javax.swing.JButton;
import javax.swing.JPanel;
import javax.swing.BoxLayout;
import javax.swing.JTextField;
import javax.swing.Box;


public class Calc implements ActionListener, KeyListener{

	private static final int OPERATOR = 0, NUMBER = 1, DECPOINT = 2, BACKSPACE = 3;
	private int prevButton = OPERATOR;
	private boolean decButton = false;

	JFrame calcFrame = null;

	JButton[] numButton, opButton;
	JButton decimalButton, equalsButton;
	JButton clearAllButton,clearButton;

	JTextField resultTextField = null;

	JPanel mainPanel = null;
	JPanel buttonPanel = null;
	JPanel resultPanel = null;

	BoxLayout numBoxLayout[], buttonBoxLayout,opBoxLayout,allButtonLayout,mainBoxLayout;

	String[] opArray = {"+", "-", "*", "/" };
	
	

	double operand[] = new double[4];
	int operator[] = new int[4],presOperator;
	int oprdTop = 0, opTop = 0;

	public Calc(){
	/* Create the UI here*/
		calcFrame = new JFrame("Calculator");
		calcFrame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

		calcFrame.setFocusable(true);		// kndn

		mainPanel = new JPanel(new BorderLayout());

		addResultTextField();
		addNumberButtons();
	
		mainPanel.add(resultPanel,BorderLayout.NORTH);
		mainPanel.add(buttonPanel,BorderLayout.CENTER);

		calcFrame.getContentPane().add(mainPanel);
		calcFrame.pack();
		calcFrame.setResizable(false);
		calcFrame.addKeyListener(this);
		calcFrame.setVisible(true);
	}
	private void addResultTextField(){
		resultPanel = new JPanel();
		BoxLayout bl = new BoxLayout(resultPanel,BoxLayout.X_AXIS);
		resultTextField = new JTextField(15);
		resultTextField.setText("0");
		resultTextField.setEnabled(false);

		resultPanel.add(resultTextField);
	}

	private void addNumberButtons(){
		numBoxLayout = new BoxLayout[4];
		buttonPanel = new JPanel(new GridLayout(5,4));

		/* Create the Buttons */
		numButton = new JButton[10];
		for(int i = numButton.length-1  ;i>=0; i--){
			numButton[i] = new JButton(""+i);
			numButton[i].addActionListener(this);
		}

		opButton = new JButton[4];
		for (int i = 0 ;i<opButton.length ; i++){
			opButton[i] = new JButton(opArray[i]);
			opButton[i].addActionListener(this);
		}
		
		clearButton = new JButton("C");
		clearButton.addActionListener(this);
		clearAllButton = new JButton("CE");
		clearAllButton.addActionListener(this);

		buttonPanel.add(Box.createGlue());
		buttonPanel.add(Box.createGlue());
		buttonPanel.add(clearButton);
		buttonPanel.add(clearAllButton);
		/* Add Buttons to the panel */
		for (int i = 2; i >=0  ;i--) {
			for (int j = 0;j<3 ;j++ ) {
				buttonPanel.add(numButton[i*3+j+1]);
			}
			buttonPanel.add(opButton[i+1]);
		}
		
		decimalButton = new JButton(".");
		decimalButton.addActionListener(this);
		
		equalsButton = new JButton("=");
		equalsButton.addActionListener(this);

		buttonPanel.add(decimalButton);
		buttonPanel.add(numButton[0]);
		buttonPanel.add(equalsButton);
		buttonPanel.add(opButton[0]);

		
	}
	private void evaluate(int i){
		if (oprdTop>0 && prevButton == NUMBER) {
			prevButton = OPERATOR;
			decButton = false;
			operand[oprdTop] = Double.parseDouble(resultTextField.getText());
			oprdTop++;
			if (opTop > 0) {
				presOperator = i;
				calculate();
				resultTextField.setText(Double.toString(operand[oprdTop-1]));
				operator[opTop] = i;
				opTop++;
			} else {
				operator[opTop] = i;
				opTop++;	
			}
		} else if (oprdTop==0){
			prevButton = OPERATOR;
			operand[oprdTop] = Double.parseDouble(resultTextField.getText());
			oprdTop++;
			operator[opTop] = i;
			opTop++;
		}else{
			operator[opTop-1] = i;
		}
	}
	private void clearAll() {
		oprdTop=0;
		opTop=0;
		prevButton=OPERATOR;
	}
	/* ActionPerformed Event */
	public void actionPerformed(ActionEvent ae){
	
		JButton src = (JButton)ae.getSource();
		if(src == clearButton) {
			resultTextField.setText("0");
			prevButton=OPERATOR;
			relieveFocus();		//kndn
			return;
		}
		if (src == clearAllButton) {
			resultTextField.setText("0");
			clearAll();	
			relieveFocus();		//kndn
			return;
		}
		if (src == decimalButton && decButton == false) {
			decButton = true;
			String stringToBeSet = null;
			if(prevButton == OPERATOR){
				stringToBeSet = "0.";
				resultTextField.setText(stringToBeSet);
				prevButton = DECPOINT;
			}
			else{
				stringToBeSet = ".";
				if((resultTextField.getText()).indexOf('.')==-1)
					resultTextField.setText(resultTextField.getText()+stringToBeSet);				
			}
		}
		if (src == equalsButton ) {
			operand[oprdTop] = Double.parseDouble(resultTextField.getText());
			oprdTop++;
			presOperator = 0;
			calculate();
			resultTextField.setText(Double.toString(operand[oprdTop-1]));
			clearAll();
			relieveFocus();		//kndn
			return;
		}
		for (int i = 0 ;i<numButton.length ;i++ ){
			if( numButton[i] == src) {
				if( prevButton == OPERATOR || prevButton == BACKSPACE) {
					prevButton = NUMBER;
					resultTextField.setText(""+i);
				}
				else {
					resultTextField.setText( resultTextField.getText()+i);
				}
			}
		}

		for (int i = 0;i < opButton.length ;i++ ) {
			if( src == opButton[i]) {
				/* save the info that prevButton is OPERATOR */
				evaluate(i);
			}
		}

		relieveFocus();			// kndn

		
		
	}

	private void calculate(){
		if(opTop > 0 && precedence()) {
			switch(operator[opTop-1] ){
			case 0:
				operand[oprdTop-2] = operand[oprdTop-2] + operand[oprdTop-1];
				break;
			case 1:
				operand[oprdTop-2] = operand[oprdTop-2] - operand[oprdTop-1];
				break;
			case 2:
				operand[oprdTop-2] = operand[oprdTop-2] * operand[oprdTop-1];
				break;
			case 3:
				operand[oprdTop-2] = operand[oprdTop-2] / operand[oprdTop-1];
				break;
			}
			oprdTop--;
			opTop--;
			calculate();
		}
	}

	private boolean precedence(){

		if((presOperator == 2 || presOperator == 3 )&& (operator[opTop-1] == 1 || operator[opTop - 1] == 0 ) )
			return false;
		return true;
	}

	// kndn

	public void keyPressed(KeyEvent ke){
	}

	public void keyReleased(KeyEvent ke){
	}

	public void keyTyped(KeyEvent ke){

		//JButton src = (JButton)ae.getSource();
		char keyTyped = ke.getKeyChar();

		// Cancel All Button or ESCAPE key
		if (keyTyped == KeyEvent.VK_ESCAPE) {
			resultTextField.setText("0");
			clearAll();	
			relieveFocus();		
			return;
		}

		// Enter Key or Equals Button
		if (keyTyped == KeyEvent.VK_ENTER){
			operand[oprdTop] = Double.parseDouble(resultTextField.getText());
			oprdTop++;
			presOperator = 0;
			calculate();
			resultTextField.setText(Double.toString(operand[oprdTop-1]));
			clearAll();
			relieveFocus();		
			return;
		}

		// BackSpace key
		if (keyTyped == KeyEvent.VK_BACK_SPACE){
			if(resultTextField.getText().length()>0)
				resultTextField.setText(resultTextField.getText().substring(0,resultTextField.getText().length()-1));
			if(resultTextField.getText().length()==0)
				resultTextField.setText("0");
			prevButton = BACKSPACE;
				
		}

		// Operator Keys
		for (int i = 0;i < opButton.length ;i++ ) {
			if(Character.toString(keyTyped).equals(opButton[i].getText())) {
				/* save the info that prevButton is OPERATOR */
				evaluate(i);
			}
		}

		
		// Digits keys

/*		for (int i = 0 ;i<numButton.length ;i++ ){
			if(Character.toString(keyTyped).equals(numButton[i].getText())) {
				if( prevButton == OPERATOR) {
					prevButton = NUMBER;
					resultTextField.setText(""+i);
				}
				else {
					resultTextField.setText( resultTextField.getText()+i);
				}
			}
		}
*/
		if(Character.isDigit(keyTyped)){
			if( prevButton == OPERATOR || prevButton == BACKSPACE) {
					prevButton = NUMBER;
					resultTextField.setText(""+keyTyped);
				}
				else {
					resultTextField.setText( resultTextField.getText()+keyTyped);
				}
		}


		// Decimal Point
		if (Character.toString(keyTyped).equals(decimalButton.getText()) && decButton==false) {
			decButton = true;
			String stringToBeSet = null;
			if(prevButton == OPERATOR){
				stringToBeSet = "0.";
				resultTextField.setText(stringToBeSet);
				prevButton = DECPOINT;
			}
			else{
				stringToBeSet = ".";
				if((resultTextField.getText()).indexOf('.')==-1)
					resultTextField.setText(resultTextField.getText()+stringToBeSet);				
			}
			
		}

		relieveFocus();			
	}

	public void relieveFocus(){
		int i=0;
		for(i=0;i<10;i++)
			numButton[i].setFocusable(false);
		for(i=0;i<4;i++)
			opButton[i].setFocusable(false);

		
		decimalButton.setFocusable(false);
		equalsButton.setFocusable(false);
		clearAllButton.setFocusable(false);
		clearButton.setFocusable(false);

		decButton = false;
		calcFrame.setFocusable(true);
	}



	// kndn
	
	public static void main(String[] arg){
		new Calc();
	}

}