package ui;
import javax.swing.*;
import java.awt.event.*;
import java.awt.*;
public class PassphraseDialog extends JDialog{
	private String[] senKeyID,recKeyID;
	private JPanel dialogPanel,buttonPanel,senPanel,ppPanel,recPanel;
	private JLabel msg,ppLabel,recLabel,senLabel;
	private JPasswordField passphrase;
	private JComboBox senCombo,recCombo;
	private JButton cancel,ok;
	private boolean cancelled = true;
public PassphraseDialog(Frame owner,String[] senKeyID,String[] recKeyID){

	super(owner,"Select key",true);

	this.senKeyID = senKeyID;
	this.recKeyID = recKeyID;

	dialogPanel = new JPanel();
	dialogPanel.setLayout(new BoxLayout(dialogPanel,BoxLayout.Y_AXIS));

	
	msg = new JLabel("Select KeyID's to be used in Encrypttion");
	msg.setFont(new Font("Times New Roman",Font.BOLD,18));
	dialogPanel.add(msg);
	
	senPanel = new JPanel();
	senPanel.setLayout(new BoxLayout(senPanel,BoxLayout.X_AXIS));

	
	senLabel = new JLabel("Key ID of Private Key");
	senCombo = new JComboBox(senKeyID);
	senPanel.add(Box.createRigidArea(new Dimension(10,0)));
	senPanel.add(senLabel);
	senPanel.add(Box.createRigidArea(new Dimension(10,0)));
	senPanel.add(senCombo);
	senPanel.add(Box.createRigidArea(new Dimension(10,0)));
	
	recPanel = new JPanel();
	recPanel.setLayout(new BoxLayout(recPanel,BoxLayout.X_AXIS));
	
	recLabel = new JLabel("Key ID of Public Key");
	recCombo = new JComboBox(recKeyID);
	recPanel.add(Box.createRigidArea(new Dimension(10,0)));
	recPanel.add(recLabel);
	recPanel.add(Box.createRigidArea(new Dimension(20,0)));
	recPanel.add(recCombo);
	recPanel.add(Box.createRigidArea(new Dimension(10,0)));

	ppPanel = new JPanel();
	ppPanel.setLayout(new BoxLayout(ppPanel,BoxLayout.X_AXIS));

	ppLabel = new JLabel("Password :");
	passphrase = new JPasswordField(20);
	ppPanel.add(Box.createRigidArea(new Dimension(10,0)));
	ppPanel.add(ppLabel);
	ppPanel.add(Box.createRigidArea(new Dimension(70,0)));
	ppPanel.add(passphrase);
	ppPanel.add(Box.createRigidArea(new Dimension(10,0)));
		
	buttonPanel = new JPanel();
	buttonPanel.setLayout(new BoxLayout(buttonPanel,BoxLayout.X_AXIS));
	
	cancel = new JButton("Cancel");
	cancel.setMnemonic(KeyEvent.VK_C);
	ok = new JButton("OK");
	ok.setEnabled(false);
	ok.setMnemonic(KeyEvent.VK_O);
	buttonPanel.add(Box.createGlue());
	buttonPanel.add(ok);
	buttonPanel.add(Box.createRigidArea(new Dimension(10,0)));
	buttonPanel.add(cancel);
	buttonPanel.add(Box.createRigidArea(new Dimension(10,0)));

	dialogPanel.add(Box.createRigidArea(new Dimension(0,10)));
	dialogPanel.add(msg);
	dialogPanel.add(Box.createRigidArea(new Dimension(0,10)));
	dialogPanel.add(senPanel);
	dialogPanel.add(Box.createRigidArea(new Dimension(0,10)));
	dialogPanel.add(ppPanel);
	dialogPanel.add(Box.createRigidArea(new Dimension(0,10)));
	dialogPanel.add(recPanel);
	dialogPanel.add(Box.createRigidArea(new Dimension(0,10)));
	dialogPanel.add(buttonPanel);
	dialogPanel.add(Box.createRigidArea(new Dimension(0,10)));
	setContentPane(dialogPanel);

	pack();
	setResizable(false);
	
	ok.addActionListener(new ActionListener(){
				public  void actionPerformed(ActionEvent ae){
					cancelled = false;
					dispose();
				}
			});
	cancel.addActionListener(new ActionListener(){
				public void actionPerformed(ActionEvent ae){
					cancelled = true;
					dispose();
				}
			});
	passphrase.addKeyListener(new KeyAdapter(){
				public void keyReleased(KeyEvent ke){
					if(new String(passphrase.getPassword()).equals(""))
						ok.setEnabled(false);
					else
						ok.setEnabled(true);
				}	
			});

}
public boolean isCancelled(){ return cancelled;}
public String getPublicKeyID(){return (String) recCombo.getSelectedItem();}
public String getPrivateKeyID(){return (String) senCombo.getSelectedItem();}
public String getPassphrase(){return new String( passphrase.getPassword());}

}
/*
class TestDialog{	
public static void main(String[] arg){
	String[] sen = {"Sandeep","Loves","Programming"},rec = {"Programmes","Love","Sandeep"};
	JFrame testFrame = new JFrame("Sandeep");
	testFrame.setSize(200,200);
	
	PassphraseDialog pd = new PassphraseDialog(testFrame,sen,rec);
System.out.println("Object Created");	
	pd.setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
	pd.addWindowListener(new WindowAdapter(){
				public void windowClosing(WindowEvent we){
					System.exit(0);
				}
			});

	pd.show();
}
}
*/