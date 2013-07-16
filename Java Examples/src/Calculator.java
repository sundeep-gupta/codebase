import javax.swing.*;
import java.awt.*;
import java.awt.event.*;


public class Calculator implements KeyListener, ActionListener{

	JFrame backGround;
	java.awt.Container bg;
	JTextField enteredString;
	JButton one;

	public Calculator(){
		
		backGround = new JFrame();
		enteredString = new JTextField(10);
		one = new JButton("1");
		//enteredString.setFocusable(false);
		//one.setFocusable(false);
		backGround.setFocusable(true);


		backGround.setSize(300,300);
		backGround.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

		bg = backGround.getContentPane();
		bg.add(enteredString);
		bg.setLayout(new FlowLayout(5,5,FlowLayout.LEFT));
		bg.add(one);
		one.addActionListener(this);

		backGround.addKeyListener(this);
		backGround.setVisible(true);
		
	}

	public static void main(String[] args){
		Calculator calc = new Calculator();
	}

	public void keyPressed(KeyEvent ke){
	}

	public void keyTyped(KeyEvent ke){
		if(Character.isDigit(ke.getKeyChar())){
			enteredString.setText(enteredString.getText()+ke.getKeyChar());
		}
		if(ke.getKeyChar()==KeyEvent.VK_ESCAPE){
			enteredString.setText("");
		}
	}

	public void keyReleased(KeyEvent ke){
	}

	public void actionPerformed(ActionEvent ae){
		if(ae.getActionCommand().equals("1"))
			enteredString.setText(enteredString.getText()+"1");

		one.setFocusable(false);
		//backGround.setFocusable(true);
	}

}