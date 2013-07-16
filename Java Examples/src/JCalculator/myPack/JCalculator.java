package myPack;
import javax.swing.*;
import java.awt.event.*;
import java.awt.*;

public class JCalculator extends JPanel implements ActionListener,KeyListener{

	private static final int OPERATOR = 0, NUMBER = 1;
	private JButton[] numButton, opButton;
	private JButton decimalButton, equalsButton, clearAllButton,clearButton;
	private JTextField resultTextField = null;
	private JPanel mainPanel,buttonPanel,allButtonPanel,resultPanel;
	private BoxLayout numBoxLayout[];

	private String[] opArray = {"+", "-", "*", "/" };
	private int prevButton = OPERATOR;
	private boolean decButton = false;
	private double operand[] = new double[4];
	private int operator[] = new int[4],presOperator;
	private int oprdTop = 0, opTop = 0;

	public JCalculator(){
	/* Create the UI here*/
		
		super(new BorderLayout());
		addKeyListener(this);

		addResultTextField();
		addNumberButtons();
	
		this.add(resultPanel,BorderLayout.NORTH);
		this.add(buttonPanel,BorderLayout.CENTER);

		requestFocus();
	}

	private void addResultTextField(){
		resultPanel = new JPanel();
		BoxLayout bl = new BoxLayout(resultPanel,BoxLayout.X_AXIS);
		resultTextField = new JTextField(15);
		resultTextField.setText("0");
		resultTextField.setEnabled(false);

		resultPanel.add(Box.createGlue());
		resultPanel.add(resultTextField);
	}

	private void addNumberButtons(){
		numBoxLayout = new BoxLayout[4];
		buttonPanel = new JPanel(new GridLayout(5,4));

		/* Create the Buttons */
		numButton = new JButton[10];
		for(int i = numButton.length-1  ;i>=0; i--){
			numButton[i] = new JButton(""+i);
			numButton[i].setFocusable(false);
			numButton[i].addActionListener(this);
		}

		opButton = new JButton[4];
		for (int i = 0 ;i<opButton.length ; i++){
			opButton[i] = new JButton(opArray[i]);
			opButton[i].setFocusable(false);
			opButton[i].addActionListener(this);
		}
		
		clearAllButton = new JButton("C");
		clearAllButton.addActionListener(this);
		clearAllButton.setFocusable(false);
		clearButton = new JButton("C E");
		clearButton.addActionListener(this);
		clearButton.setFocusable(false);

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
		decimalButton.setFocusable(false);
		
		equalsButton = new JButton("=");
		equalsButton.addActionListener(this);
		equalsButton.setFocusable(false);

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
			return;
		}
		if (src == clearAllButton) {
			resultTextField.setText("0");
			clearAll();	
			return;
		}
		if (src == decimalButton && decButton == false) {
			decButton = true;
			resultTextField.setText( resultTextField.getText()+".");
		}
		if (src == equalsButton ) {
			operand[oprdTop] = Double.parseDouble(resultTextField.getText());
			oprdTop++;
			presOperator = 0;
			calculate();
			resultTextField.setText(Double.toString(operand[oprdTop-1]));
			clearAll();
			return;
		}
		for (int i = 0 ;i<numButton.length ;i++ ){
			if( numButton[i] == src) {
				if( prevButton == OPERATOR) {
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
	public void keyTyped(KeyEvent ke){
		int key = ke.getKeyCode();
		char ch = ke.getKeyChar();
		if(key==KeyEvent.VK_BACK_SPACE) {
			resultTextField.setText("0");
			prevButton=OPERATOR;
			return;
		}
		if (key==KeyEvent.VK_ESCAPE) {
			resultTextField.setText("0");
			clearAll();	
			return;
		}
		if (ch=='.' && decButton == false) {
			decButton = true;
			resultTextField.setText( resultTextField.getText()+".");
		}
		if (ch=='=') {
			operand[oprdTop] = Double.parseDouble(resultTextField.getText());
			oprdTop++;
			presOperator = 0;
			calculate();
			resultTextField.setText(Double.toString(operand[oprdTop-1]));
			clearAll();
			return;
		}
		switch (ch)	{
		case '1' :
		case '2' :
		case '3' :
		case '4' :
		case '5' :
		case '6' :
		case '7' :
		case '8' :
		case '9' :
		case '0' :
			if( prevButton == OPERATOR) {
				prevButton = ch=='0'?OPERATOR:NUMBER;
				resultTextField.setText( ((ch == '0')?"0":Character.toString(ch)));
			} else {
				resultTextField.setText( resultTextField.getText()+ch);
			}
		}
	
		int i;
		switch(ch) {
			case '+':
				i = 0; evaluate(i); break;
			case '-':
				i = 1; evaluate(i); break;
			case '*':
				i = 2; evaluate(i); break;
			case '/':
				i = 3; evaluate(i); break;
		}
		
	}
	public void keyReleased(KeyEvent ke){}
	public void keyPressed(KeyEvent ke){}
	public static void main(String[] arg){
		

		JFrame calc = new JFrame("Calculator");
		calc.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

		calc.getContentPane().add(new JCalculator());
		calc.pack();
		calc.setResizable(false);
		calc.setVisible(true);
		calc.requestFocus();
	}
}

