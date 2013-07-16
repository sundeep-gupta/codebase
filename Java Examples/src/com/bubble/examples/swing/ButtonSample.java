import java.awt.BorderLayout;
import java.awt.EventQueue;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JFrame;
public class ButtonSample {
    JFrame frame;
    JButton btnNext;

    public ButtonSample() {
        this.frame = new JFrame("Example");
        this.frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.btnNext = new JButton("Next");
        // Define ActionListener
        ActionListener actionListener = new ActionListener() {
          public void actionPerformed(ActionEvent actionEvent) {
            System.out.println("I was selected.");
          }
        };
        this.btnNext.addActionListener(actionListener);
        frame.add(btnNext, BorderLayout.SOUTH);
        frame.setSize(300, 100);
    }
    public void show() {
        frame.setVisible(true);
    }
  public static void main(String args[]) {
        new ButtonSample().show();
  }
}
