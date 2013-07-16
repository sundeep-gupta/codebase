import java.awt.Frame;
import java.awt.Label;
import java.awt.TextField;
import java.awt.FlowLayout;
import java.awt.Panel;
import java.awt.event.WindowEvent;
import java.awt.event.ActionEvent;
import java.awt.event.WindowAdapter;
import java.awt.event.ActionListener;

class PasswdFrame extends WindowAdapter implements ActionListener{

	Frame mainFrm;
	TextField passwdField;
	Label text,lbl;

	PasswdFrame(){
		mainFrm = new Frame("My Password Window");
		mainFrm.setSize(300,150);
		mainFrm.setLayout(new FlowLayout());

		text = new Label("Enter something and press \"Enter Key\"");
		mainFrm.add(text);

		lbl = new Label("");

		passwdField = new TextField(20);
		passwdField.setEchoChar('*');
		passwdField.addActionListener(this);
		mainFrm.add(passwdField);

		mainFrm.addWindowListener(this);
		mainFrm.setVisible(true);

	}

	public void windowClosing(WindowEvent we){
		System.exit(1);
	}

	public void actionPerformed(ActionEvent ae){
		String str = "Hi " + passwdField.getText() + ", how do u do?";
		mainFrm.remove(lbl);
		lbl.setText(str);
		mainFrm.add(lbl);
		mainFrm.setVisible(true);
		return;
	}

	public static void main(String[] args) 
	{
		new PasswdFrame();

	}
}
