import javax.swing.JTextArea;
import java.util.*;
import java.io.*;
import javax.swing.*;
import javax.swing.text.*;
import java.awt.*;
import java.awt.event.*;

public class ShellTextArea extends JTextArea 
{
	JFrame _frame;
	WorkStation _workstation;
	String _prompt;
	Vector _commandHistory = new Vector(30);
	int    _positionInHistory = 0;
	int    _leftmostAcceptablePosition = 0;

	/** this prevents the events to be displays while waiting for a reply. */
	boolean _isWaiting = false;
	/* the above boolean variable will be access only inside synchronized blocks*/
	/** this is the lock for the synchronized blocks in which _isWaiting should be accessed  exclusively */
	Object lock = new Object();
	Date _unblockingMoment = new Date();
	public static final String PROMPT_POSTFIX = ">";

	public ShellTextArea(String initialPrompt, JFrame _frame, WorkStation _workstation) 
	{
		this._frame = _frame;
		this._workstation = _workstation;
		this.addKeyListener( new ShellKeyListener(this) );
		setPrompt(initialPrompt);
		setEnabled(false);
	}

	public void setPrompt(String pwd)
	{
		_prompt = "\n" + pwd + PROMPT_POSTFIX;
	}

	/**
	 * This operation is done through the swing queue
	 *
	 * Both the gui and the workstation will use this
	 * method, and there is a slight posibility they
	 * will use it in the same time
	 */
	public synchronized void write(String s)
	{
		SwingUtilities.invokeLater(new DoLater(DoLater.WRITE, "\n" + s + _prompt));
	}

	public void displayPrompt()
	{
		write("");//_prompt is added automatically
	}

	/**
	 * It moves the caret to the end of the last line
	 */
	private int moveCaretToEnd()
	{
			int lastLine = getLineCount()-1;
			int lastPosition = -1;
			try
			{
				lastPosition=getLineEndOffset(lastLine);
				setCaretPosition(lastPosition);
			}
			catch(BadLocationException ex){ ex.printStackTrace();}
			return lastPosition;
	}

	private boolean isCaretOnLastLine()
	{
		try
		{
			int lastLine = getLineCount()-1;
			int currentLine = getLineOfOffset(getCaretPosition());
			return (lastLine == currentLine);
		}
		catch(BadLocationException ex){ex.printStackTrace();return false;}
	}

	private boolean isSelectionDeletable()
	{
		if (getSelectedText() == null)
			//there is no selection
			return true;
		if(getSelectionStart() <_leftmostAcceptablePosition)
			return false;
		return true;
	}

	public void previousCommand()
	{
		//System.out.println("prev command, "+_positionInHistory);
		if(_positionInHistory>0)
		{
			try
			{
				int position = getCaretPosition();
				int line = getLineOfOffset(position);
				int startLine = getLineStartOffset(line);
				int endLine = getLineEndOffset(line);

				select(startLine-1, endLine+1);
				String newLine = _prompt+_commandHistory.elementAt(--_positionInHistory );
				replaceSelection(newLine);
			}
			catch (BadLocationException ex){ ex.printStackTrace(); }
		}
	}

	public void nextCommand()
	{
		//	System.out.println("next command, "+_positionInHistory);
		try
		{
					int position = getCaretPosition();
					int line = getLineOfOffset(position);
					int startLine = getLineStartOffset(line);
					int endLine = getLineEndOffset(line);

					select(startLine-1, endLine+1);
					String newLine = _prompt;
					if(_positionInHistory< _commandHistory.size()-1)
							newLine += _commandHistory.elementAt(++_positionInHistory);
					else
							if(_positionInHistory< _commandHistory.size())
									_positionInHistory++;
					replaceSelection( newLine);
		}
		catch (BadLocationException ex){ ex.printStackTrace(); }
	}

	public boolean canGoLeft()
	{
//		System.out.println("canGO LEFT , position "+ getCaretPosition()+ " leftmost pos "+_leftmostAcceptablePosition);
		if(getCaretPosition() > _leftmostAcceptablePosition)
				return true;
		return false;
	}

	public void processCommand()
	{
//		System.out.println("enter");
		try
		{
			int position = getCaretPosition();
			int line = getLineOfOffset(position);
			int lineStart = getLineStartOffset(line)-1;
			int commandStart = lineStart + _prompt.length();
			int lineEnd = getLineEndOffset(line);
//System.out.println(position+"-"+line+"-"+lineStart+"-"+commandStart+"-"+lineEnd);
			int commandLength = lineEnd - commandStart;
			String command = getText(commandStart, commandLength);
			if(command.length() >0)
			{
				_commandHistory.add(command);
				_positionInHistory = _commandHistory.size();
			}
			System.out.println("call parser for "+command);
			_workstation.passCommand(command);
//know I block the GUI till I get a reply. (placed by the main thread in the swing/awt queue
			synchronized(lock){_isWaiting = true;}
		}
		catch(BadLocationException ex){ ex.printStackTrace();}
	}

	public void DisplayReply(String reply)
	{
		write(reply);
		displayPrompt();
		synchronized(lock){_isWaiting = false;}
	}

	public void setEnabledLater(boolean b)
	{
		SwingUtilities.invokeLater(new DoLater(DoLater.SET_ENABLED, b));
	}

	public void clearLater()
	{
		SwingUtilities.invokeLater(new DoLater(DoLater.CLEAR));
	}

	public void logoutLater()
	{
		SwingUtilities.invokeLater(new DoLater(DoLater.LOGOUT));
	}

	public void saveLater(String fileName)
	{
		SwingUtilities.invokeLater(new DoLater(DoLater.SAVE, fileName));
	}

	//**************************************************************//
	class ShellKeyListener implements KeyListener
	{
		private JTextArea _txtArea = null;
		private boolean _backslash_pressed= false;
		private boolean _blockNextOne = false;

		public ShellKeyListener(JTextArea textArea)
		{
			this._txtArea = textArea;
		}
		public void keyReleased(KeyEvent e){}
		public void keyPressed(KeyEvent e)
		{
			//if the user placed the caret up with the mouse, he won't be able to type anything, except copy (not even paste)
			if(! isCaretOnLastLine() || ! isSelectionDeletable())
				if(! (e.isControlDown() && (e.getKeyCode()==KeyEvent.VK_C)))
				{
					e.consume();
					return;
				}
//				else
//					System.out.println("copy in keyPressed");

			synchronized(lock)
			{
				if (_isWaiting)
				{
					e.consume();
					return;
				}
			}

			switch(e.getKeyCode())
			{
				case KeyEvent.VK_HOME:
									setCaretPosition(_leftmostAcceptablePosition);
									e.consume();
									return;
				case KeyEvent.VK_UP:
				case KeyEvent.VK_KP_UP:
									previousCommand();
									e.consume();
									return;
				case KeyEvent.VK_DOWN:
				case KeyEvent.VK_KP_DOWN:
									nextCommand();
									e.consume();
									return;
				case KeyEvent.VK_PAGE_DOWN:
				case KeyEvent.VK_PAGE_UP:
									e.consume();
									break;
				case KeyEvent.VK_ENTER:
									processCommand();
									e.consume();
									return;
				case KeyEvent.VK_BACK_SPACE:
								if(! canGoLeft() || ! isSelectionDeletable())
									_backslash_pressed = true; //mark the event for destruction
								return;
				case KeyEvent.VK_LEFT:
				case KeyEvent.VK_KP_LEFT:
								if(!canGoLeft())
									e.consume();
									return;
			}
		}
		public void keyTyped(KeyEvent e)
		{
			synchronized(lock)
			{
				if (_isWaiting)
				{
					e.consume();
					return;
				}
			}
//			if( _blockNextOne){
//				_blockNextOne = false;
//				e.consume();
//				return;
//			}
//if the user placed the caret up with the mouse, he won't be able to type anything, except copy (not even paste)
			if(! isCaretOnLastLine() || ! isSelectionDeletable())
					e.consume();
			if(_backslash_pressed)
			{
					_backslash_pressed = false;
				//at this point the key code is not set, so I cannot recognize the backSlash
					e.consume();
			}
		}
	}

	class DoLater implements Runnable
	{
		public static final int SET_ENABLED = 0;
		public static final int CLEAR       = 1;
		public static final int LOGOUT      = 2;
		public static final int WRITE       = 3;
		public static final int SET_PROMPT  = 4;
		public static final int SAVE        = 5;
		//the WorkStation changes the prompt through this lazy mechanism
		// so than only one thread uses the variable _prompt
		int _action;
		boolean _b;
		String _s;

		/**
		 * Constructor for Set_Enabled mode.
		 */
		public DoLater(int action, boolean b)
		{
			if(action != SET_ENABLED)
			{
				System.out.println("Invalid mode for this constructor.");
				return;
			}
			this._action = action;
			this._b = b;
		}

		/**
		 * Constructor for CLEAR  & LOGOUT modes.
		 */
		public DoLater(int action)
		{
			if(action != CLEAR && action != LOGOUT)
			{
				System.out.println("Invalid mode for this constructor.");
				return;
			}
			this._action = action;
		}

		/**
		 * Constructor for Write, SAVE and SET_Prompt.
		 */
		public DoLater(int action, String s)
		{
			if(action != WRITE && action != SET_PROMPT && action != SAVE)
			{
				System.out.println("Invalid mode for this constructor.");
				return;
			}
			if( s == null)
			{
				System.out.println("Null string passed to DoLater constructor");
				return;
			}
			this._action = action;
			this._s = s;
		}

		public void run()
		{
			switch(_action)
			{
  				case SAVE:
								try
								{
									PrintWriter outfile= new PrintWriter(new BufferedWriter(new FileWriter(_s)));
									outfile.print(getText());
									outfile.close();
								}
								catch(IOException ex)
								{
									JOptionPane.showMessageDialog( _frame, ex.getMessage(),
										"Error while saving", JOptionPane.OK_OPTION );
								}
								return;
				case SET_ENABLED:
								setEnabled(_b);
								if(_b)
								{
									displayPrompt();
								}
								else
								{
									selectAll();
									replaceSelection("");
								}
								return;
				case LOGOUT:
								_commandHistory = new Vector(30);
								_positionInHistory = 0;
								getCaret().setVisible(false);
								setText("");
								return;
				case CLEAR:
								setText("");
								displayPrompt();
								return;
				case SET_PROMPT:
								_prompt = _s;
								return;
				case WRITE:
								append(_s);
								_leftmostAcceptablePosition = moveCaretToEnd();
								getCaret().setVisible(true);
								requestFocus();
								synchronized(lock){_isWaiting = false;}
			}//switch
		}//run()
	}//DoLater
}
