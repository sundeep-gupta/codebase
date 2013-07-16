package ui;
import java.text.DateFormat;
import java.util.*;
import java.io.*;
import javax.swing.*;
import javax.swing.table.*;
import java.awt.*;
import java.awt.event.*;
public class JInboxFrame extends JInternalFrame{
	final int RECIEVE = 4;

	JPanel framePanel = new JPanel(new BorderLayout());
	JTable table ;
	String[] messageHeaders = new String[0];
	String[][] data ;
	public JInboxFrame(){
	}
	public JInboxFrame(String str){super(str);}
	public JInboxFrame(String title,String[] messageHeaders){
		super(title);
		this.messageHeaders = messageHeaders;
		init();
	}
	public void init(){
	/*	
	 * create toolbar if necessary.
	 */
	/*
 	 * Create the table containing message Headers;
	 */
		String[] title = {"From","Subject","Encrypted","Attachments #","Recieved"};
		data = new String[messageHeaders.length][5];
		StringTokenizer st;
		for(int i = messageHeaders.length-1,j = 0,k = 0;i>=0;i--,k++){
			st = new StringTokenizer(messageHeaders[k],":");
			j = 0;
			while(st.hasMoreTokens()){
				data[i][j++] = st.nextToken();
				if(j == 5){
					data[i][RECIEVE] =DateFormat.getDateTimeInstance(DateFormat.SHORT,DateFormat.SHORT ).format(new Date ( Long.parseLong(data[i][3]) ) );
				}
			}
		}
			
		table = new JTable(data,title);
		table.setShowVerticalLines(false);
		table.setRowHeight(25);
		table.removeEditor();
		table.setCellSelectionEnabled(false);
		table.setRowSelectionAllowed(true);
		table.setPreferredScrollableViewportSize(new Dimension(500, table.getRowHeight()*8));
		JPanel panel = new JPanel(new BorderLayout());
		JScrollPane spane = new JScrollPane( table,ScrollPaneConstants.VERTICAL_SCROLLBAR_AS_NEEDED,ScrollPaneConstants.HORIZONTAL_SCROLLBAR_NEVER );
		panel.add(spane,BorderLayout.CENTER);
		setContentPane(framePanel);
		framePanel.add(panel,BorderLayout.CENTER);
	
	}
public int getSelectedMessage(){
	return table.getSelectedRow();
}
}/* end of main class */