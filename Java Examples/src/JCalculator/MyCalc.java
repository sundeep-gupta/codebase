import java.applet.Applet;
import javax.swing.*;
import myPack.JCalculator;
public class MyCalc extends Applet {
	//Calc calc;
	JCalculator calc;
	public void start(){
		calc = new JCalculator();
		add(calc);
		//calc.addActionListener(calc);
		addKeyListener(calc);
		calc.setFocusable(true);
	}
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
/*<HTML>
	<BODY>
  <APPLET code = "MyCalc.class" width = 300 height=300>
  </APPLET>
  </BODY>
  </HTML>
*/
