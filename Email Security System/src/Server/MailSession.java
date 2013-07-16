package server;
import java.math.BigInteger;
import java.security.*;
import java.security.interfaces.*;
import java.io.*;
import javax.swing.JOptionPane;
import java.net.*;
import java.util.*;

import interfaces.*;

public class MailSession extends Thread{
	Socket socket = null;
	PrintWriter pw;
	BufferedReader br;
	private byte[] priKey,pubKey;
  	Login login;
	long time; 	

/*
 * Create a mailSession object and 
 * store the "socket" for future communication with client
 */
public MailSession(String log,String pass){
	login = new Login(log,pass);
}

public MailSession(String name,Socket socket)throws IOException{
	super(name);
	this.socket = socket;
	try{
		pw = new PrintWriter(socket.getOutputStream(), true);
            br = new BufferedReader(new InputStreamReader(socket.getInputStream()));
		pw.println("ALIVE");
	}catch(IOException e){
			System.out.println("cannot read from socket");
			throw e;
	}
}

public String processNew()throws IOException{
	pw.println("OK");
	String clientInput = br.readLine();
	int end;
	String log,pass;
	if((end = clientInput.indexOf(':'))!= -1){
		String p1 = clientInput.substring(0,end);
		log = clientInput.substring(end+1);
		if(p1.equals("LOGIN")){
			clientInput = br.readLine();
			if((end = clientInput.indexOf(':'))!= -1){
				p1 = clientInput.substring(0,end);
				if(p1.equals("PASSWORD")){
					pass= clientInput.substring(end+1);
					try{
						checkLoginID(log.toLowerCase(),pass);
						return "Cannot create login with this ID";
					}catch(LoginNotFoundException e){
						try{
							createNewLogin(log,pass);
							return "YES";
						}catch(NoSuchAlgorithmException nsae){
							return "Keys cannot be generated.";					
						}catch(FileNotFoundException fnfe){
							return "Some Files missing at Server";
						}
				      }catch(IOException e){
						return "Problem with reading and writing at server";
					}
				}
			}
		}
	}
	return "Recieved Incorrect Data";
}

public void createNewLogin(String log,String pass)
			throws IOException,FileNotFoundException,NoSuchAlgorithmException{
	if(! (new File("loginFile.acc").exists()))
		new File("loginFile.acc").createNewFile();
	FileOutputStream newAcc = new FileOutputStream("loginFile.acc",true);
	PrintWriter pwAcc = new PrintWriter(newAcc,true);

	PGPKeys pgpKey = PGPKeys.generateKeys();
	byte[] mod = pgpKey.getModulus();
	byte[] priExp = pgpKey.getPrivateExponent();
	byte[] pubExp = pgpKey.getPublicExponent();

	pubKey = new Merger(mod,pubExp).merge();
	priKey = new Merger(mod,priExp).merge();

//	generateKeys();

	/* 
	 * convert key into base64 format before storing
	 */
	byte[] priKeyR64 = new Radix64().encode(priKey);

	pwAcc.println(log.toLowerCase()+":"+pass+":"+new String(priKeyR64));
	pwAcc.close();
	newAcc.close();

	/* create inbox and a directory for new User */
	new File(log).mkdir();
	new File(log+"/"+log+".inbox").createNewFile();
	login = new Login(log,pass);
}

/* 
 * retrieve the private key of the server from logfile and 
 * return in bin format.
 */
public byte[] retrievePrivateKey(String log)throws LoginNotFoundException,IOException,FileNotFoundException{
	FileInputStream logFile = new FileInputStream("loginFile.acc");
	BufferedReader brLog = new BufferedReader(new InputStreamReader(logFile));
	TreeSet ts = new TreeSet();
	String logline;
	while((logline = brLog.readLine())!=null)
		ts.add(logline);
	Iterator itr = ts.iterator();
	StringTokenizer st;
	while(itr.hasNext()){
		st = new StringTokenizer((String)itr.next(),":");
		String l = st.nextToken();
		if(l.equals(log)){
			st.nextToken();
			String key64 = st.nextToken();
			byte[] key = new Radix64().decode(key64.getBytes());
			return key;
		}
	}
	throw new LoginNotFoundException();
}

/*
 * 
 */
public byte[] decodeRecieverName(String signRecStr)throws LoginNotFoundException,IOException{

	byte[] pubKey = retrievePrivateKey(login.getID());
	byte[] signRec = new Radix64().decode(signRecStr.getBytes());

	/* demerge the keys to exponent and modulus */
	Demerger demerge = new Demerger(pubKey);
	byte[] mod = demerge.getFirst();
	byte[] exp = demerge.getSecond();
	BigInteger exponent = new BigInteger(1,exp);
	BigInteger modulus = new BigInteger(1,mod);

	BigInteger rec = new BigInteger( 1, signRec).modPow(exponent,modulus);
	byte[] reciever = rec.toByteArray();

	return reciever;
}

public String[] getPublicKeyListOf(String other)throws IOException,FileNotFoundException{
	FileInputStream fis = new FileInputStream(other+"/.public");
	BufferedReader brPublic = new BufferedReader(new InputStreamReader(fis));

	String key;
	TreeSet ts = new TreeSet();
	while((key = brPublic.readLine())!=null){
		StringTokenizer st = new StringTokenizer(key,":");
		if(st.hasMoreTokens())
			ts.add(st.nextToken());
	}
	Iterator i = ts.iterator();
	String[] keyList = new String[ts.size()];
	int index=0;
	while(i.hasNext())
		keyList[index++] = (String) i.next();
	
	brPublic.close();
	fis.close();
	return keyList;
}

/* public key stored in base64 format is 
 * sent in base64 format only.
 */ 
public byte[] getPublicKey(String signRecStr,String keyID)throws LoginNotFoundException,IOException,FileNotFoundException{
	String reciever = new String( decodeRecieverName(signRecStr));
	FileInputStream fis = new FileInputStream(reciever+"/.public");
	BufferedReader brPublic = new BufferedReader(new InputStreamReader(fis));
//System.out.println("file exist");
	String key;
	while((key = brPublic.readLine())!=null){
//System.out.println(key);
		StringTokenizer st = new StringTokenizer(key,":");
		if(st.hasMoreTokens() && st.nextToken().equals(keyID)){
			brPublic.close();	
			fis.close();
			return st.nextToken().getBytes();
		}
	}
	brPublic.close();
	fis.close();
	throw new LoginNotFoundException("Invalid KeyID");
}

/*
 * public key is in base64 format when recieved
 */
public void storePublicKey(String pubKey,String keyID)throws FileNotFoundException,IOException{
	if(!(new File(login.getID()+"/.public").exists()))
		new File(login.getID()+"/.public").createNewFile();
	FileOutputStream fos = new FileOutputStream(login.getID()+"/.public",true);
	PrintWriter pwKey = new PrintWriter(fos);
	
	pwKey.println(keyID+":"+pubKey);
	
	pwKey.close();
	fos.close();
}

protected String processSign()throws IOException{
	pw.println("OK");
	String clientInput = br.readLine();
	int end;
	String log,pass;
	if((end = clientInput.indexOf(':'))!= -1){
		String p1 = clientInput.substring(0,end);
		log = clientInput.substring(end+1);
		if(p1.equals("LOGIN")){
			clientInput = br.readLine();
			if((end = clientInput.indexOf(':'))!= -1){
				p1 = clientInput.substring(0,end);
				if(p1.equals("PASSWORD")){
					pass= clientInput.substring(end+1);
					try{
						checkLoginID(log.toLowerCase(),pass);
						login = new Login(log.toLowerCase(),pass);
						return "YES";
					}catch(LoginNotFoundException e){
						return "Incorrect loginid or password";
				      }catch(IOException e){
						return "Incorrect loginId or password";
					}
				}
			}
		}
	}
	return "Recieved Incorrect Data at server";
}

String[] processInbox()throws IOException,FileNotFoundException{
	FileInputStream inbox = new FileInputStream(login.getID().toLowerCase()+"/"+login.getID().toLowerCase()+".Inbox");
	BufferedReader br = new BufferedReader(new InputStreamReader(inbox));
	String msg;
	String[] messageHeaders;
	ArrayList al = new ArrayList();
	msg = br.readLine();
	while( msg != null){
		al.add(msg);
		msg = br.readLine();
	}
	Iterator i = al.iterator();
	messageHeaders =new String[al.size()];
	for(int index = 0;i.hasNext();index++)
		messageHeaders[index] =(String) i.next();
	return messageHeaders;
}
private String processMail()throws FileNotFoundException,IOException{
	String clientInput;
	String from, type,to,subject;
	boolean encrypted;
	String fileName = null;
	String message="";
	pw.println("OK");

	clientInput = br.readLine();
	type = clientInput.substring(0,4);
	if(! (type.equals("FROM")))
		return "Incorrect command recieved : ";
	from = clientInput.substring(4);
	pw.println("OK");

	clientInput = br.readLine();
	type = clientInput.substring(0,4);
	if(!(type.equals("RCPT"))){	
		return "Error during recieving mail";
	}
	to = clientInput.substring(4);
	if(!(isRcptExist(to))){
		return "Error during recieving mail";
	}
	pw.println("OK");

	clientInput = br.readLine();
	type = clientInput.substring(0,4);
	if(!(type.equals("SBJT"))){
		return "Error during recieving mail";
	}
	subject = clientInput.substring(4);
	pw.println("OK");
	
	clientInput = br.readLine();
	type = clientInput.substring(0,4);
	if(!(type.equals("ENCR"))){
		return "Error during recieving mail";
	}
	encrypted =new  Boolean(clientInput.substring(4)).booleanValue();
	pw.println("OK");

/* attachments */	
	clientInput = br.readLine();
	type = clientInput.substring(0,4);
	if(!(type.equals("ATMT"))){
		return "Error during recieving mail";
	}
	int attachments = Integer.parseInt(clientInput.substring(4));
	pw.println("OK");
	
	clientInput = br.readLine();
	type = clientInput.substring(0,4);
	if(!(type.equals("DATA"))){
		return "Error during recieving mail";
	}
	pw.println("OK");
	do{
		clientInput = br.readLine();
		if(!clientInput.equals("END"))
			message = message+clientInput;
	}while(! clientInput.equals("END"));

	if( attachments > 0){
		pw.println("OK");

		clientInput = br.readLine();
		if(!(clientInput.equals("ATTACHMENT"))){
			return "Recieved incorrect command";
		}
		pw.println("OK");

/* get appropriate file name */
		fileName = br.readLine();
		if( new File("./"+login.getID()+"/"+fileName).exists()){
			int i = 0;
			String name = fileName.substring(0,fileName.lastIndexOf('.'));
			String ext = fileName.substring(fileName.lastIndexOf('.'));
			
			while(true){
//System.out.println("Checking the fileName validity");
				if(new File("./"+to+"/"+name+i+ext).exists())
					i++;
				else{
					fileName = name+i+ext;
					break;
				}
			}
		}
 /* now i have correct file name */
		pw.println("OK");

		clientInput = br.readLine();
		if(!(clientInput.equals("CONTENT"))){
			return "Recieved incorrect command";
		}		
		pw.println("OK");
		String fileContentsString = "";
		do{
			clientInput = br.readLine();
			if(!clientInput.equals("END"))
				fileContentsString = fileContentsString + clientInput;
		}while(! clientInput.equals("END"));
System.out.println("Size of contentst recieved "+fileContentsString.getBytes().length);
System.out.println("contents :"+fileContentsString.substring(0,20) );
		byte[] fileContents = fileContentsString.getBytes();
		if(!encrypted)
			fileContents = new Radix64().decode(fileContents);
System.out.println("Size of the contents stored :"+ fileContents.length);		
System.out.println("Contents b4 saving " + new String(fileContents,0,20) );
		try{
			FileOutputStream fos = new FileOutputStream(new File("./"+to+"/"+fileName));
			fos.write(fileContents);
			fos.close();
		}catch(IOException ioe){
			return "Error saving attachment at server";
		}
	} /* end of if */
	String response = "OK";
	try{
		saveMessageHeader(from,to,subject,encrypted,attachments);	
		saveMessage(from,to,subject,encrypted,attachments,(attachments > 0 ?fileName:null),message);
	}catch(IOException ioe){
		response = "Error writing into login file";
	}
return response;
}
void saveMessageHeader(String from,String to,String subject,boolean encrypted,int attachments)
						throws IOException,FileNotFoundException{
	time = new Date().getTime();
	FileOutputStream inbox = new FileOutputStream(to.toLowerCase()+"/"+to.toLowerCase()+".Inbox",true);
	PrintWriter pwInbox = new PrintWriter(inbox, true);
	pwInbox.println(from+":"+subject+":"+encrypted+":"+attachments+":"+String.valueOf(time));
	pwInbox.close();
	inbox.close();
}

void saveMessage(String from,String to,String subject,boolean encrypted,int attachments,String attachFileName,String message)
						throws IOException,FileNotFoundException{
	FileOutputStream msg = new FileOutputStream(to+"/msg"+String.valueOf(time)+".msg");
	PrintWriter pwMsg = new PrintWriter(msg,true);
	pwMsg.println("FROM:"+from);
	pwMsg.println("SUBJECT:"+subject);
	pwMsg.println("ENCRYPTED:"+encrypted);
	pwMsg.println("TIME:"+ String.valueOf(time));	
	pwMsg.println("ATTACHMENT:"+ attachments);
	if(attachments > 0){
		pwMsg.println(attachFileName);
	}
	pwMsg.println("MESSAGE:");
	pwMsg.println(message);
	pwMsg.close();
	msg.close();
}

public boolean isRcptExist(String to)throws IOException,FileNotFoundException{
	to = to.toLowerCase();
	FileInputStream fis = new FileInputStream("loginfile.acc");
	BufferedReader br = new BufferedReader(new InputStreamReader(fis));
	String r;
      TreeSet ts = new TreeSet();
      try{
		while((r = br.readLine())!=null){
			 int index = r.indexOf(':');
			 if(index > 0)
	                    ts.add(r.substring(0,index));
  	      }
      }catch(EOFException e){
            System.out.println("End of File Encountered :");
	}catch(IOException e){}
	return ts.contains(to);
}

/*
 * check's the given id in the file and returnst if id matches,
 * throws LoginNotFoundException if loginid doesnot exist
 */
protected void checkLoginID(String log,String pass)throws LoginNotFoundException,IOException{
	if(!(new File("loginFile.acc").exists())){
//		System.out.println("LoginFile Missing");
		throw new LoginNotFoundException();
	}
      FileInputStream fis = new FileInputStream("loginFile.acc");
	BufferedReader br = new BufferedReader(new InputStreamReader(fis));
      ArrayList al = new ArrayList();
	String r;
      try{
            while((r = br.readLine())!=null){
      	      al.add(r);
	      }
      }catch(IOException e){}       
	finally{
	     	  br.close();
	        fis.close();
	}

	/*if login exists then check for password correctness */
	Iterator i =  al.iterator();
	StringTokenizer st;
	while(i.hasNext()){
		st = new StringTokenizer((String)i.next(),":");
		String l = st.nextToken();
		String p = st.nextToken();
		if(l.equals(log) && p.equals(pass)){
			return;
		}
	}
	throw new LoginNotFoundException();
}


public String getMessage(String id)throws IOException,FileNotFoundException{
	if(new File(login.getID()+"/msg"+id+".msg").exists()){
		BufferedReader br1 = new BufferedReader(new InputStreamReader(new FileInputStream(login.getID()+"/msg"+id+".msg")));
		String s,str = "";
		while((s=br1.readLine())!= null)
			str = str+s+"\n";
		return str;
	}
	throw new FileNotFoundException("File containing the message is missing");
}

protected void deleteMessage(String msgId)throws FileNotFoundException,IOException{
	/* remove the message from inbox */
	FileInputStream fisInbox = new FileInputStream(login.getID()+"/"+login.getID()+".inbox");
	BufferedReader brInbox = new BufferedReader(new InputStreamReader(fisInbox));
	boolean found = false;
	ArrayList al = new ArrayList();
	String msg;
	while((msg = brInbox.readLine())!=null){
		al.add(msg);
	}
	Iterator it = al.iterator();
	String timeID="";
	while(it.hasNext()){
		msg = (String) it.next();
		timeID = msg.substring(msg.lastIndexOf(':')+1);
		if(timeID.equals(msgId)){
			al.remove(msg);
			found = true;
			break;
		}
	}
	brInbox.close();
	fisInbox.close();
	if(found){
		FileOutputStream fosInbox = new FileOutputStream(login.getID()+"/"+login.getID()+".inbox");
		PrintWriter pwInbox = new PrintWriter(fosInbox);
		it = al.iterator();
		while(it.hasNext()){
			msg = (String) it.next();
			pwInbox.println(msg);
		}
		pwInbox.close();
		fosInbox.close();
		File msgFile = new File(login.getID()+"/msg"+timeID+".msg");
		if(msgFile.exists()){
			msgFile.delete();
		}
	}
}

/*
 * overridden method for the Thread.run 
 * the mail center of thread's functionality.
 */
public void run(){
	String clientInput;
	while(! socket.isClosed()){
		try{
			
		/* 
		 * Read the type of object and check which type of request 
		 */
			clientInput = br.readLine();
			/*
			 * If it is a authentication request then 
			 * check whether the specified login exist or not
			 */
			if(clientInput.equals("SIGN")){
				pw.println(processSign());
			}else
			if(clientInput.equals("NEW")){
				try{
					String ret = processNew();
					pw.println(ret);
					if(ret.equals("YES")){
						byte[] b64PubKey = new Radix64().encode(pubKey);
						pw.println(new String(b64PubKey));
					}
				}catch(IOException ioe){
					pw.println("Problem with reading and writing at server");
				}
			}else
			if(clientInput.equals("MAIL")){		
				try{
					pw.println(processMail());
				}catch(IOException ioe){
					pw.println("Input output Exception at server.");
				}				
			}else
			if( clientInput.equals("INBOX")){
				try{
					String[] messageHeaders = processInbox();
					for(int i = 0;i<messageHeaders.length;i++)
						pw.println(messageHeaders[i]);
				}catch(IOException ioe){}
				pw.println("END");
			}else
			if(clientInput.equals("KEYLIST")){
				pw.println("OK");
				String other = br.readLine();
				try{
					String[] keyList = getPublicKeyListOf(other);
					for(int i = 0;i<keyList.length;i++)
						pw.println(keyList[i]);
				}catch(IOException ioe){
				}
				pw.println("END");
			}else
			if(clientInput.equals("PKEY")){
				pw.println("OK");
				String rec = br.readLine();
				String keyID = br.readLine();
				try{
					byte[] recPubKey = getPublicKey(rec,keyID);
					pw.println("YES");
					pw.println(new String(recPubKey));
				}catch(LoginNotFoundException lnfe){
					pw.println("No Public key exist for specified account.");
				}catch(IOException lnfe){
					pw.println("No Public key exist for specified account.");
				}
			}else
			if(clientInput.equals("SAVEKEY")){
				pw.println("OK");
				if(br.readLine().equals("KEYID")){
					String keyID = br.readLine();
					pw.println("OK");
					String pubKey = br.readLine();
					try{
						storePublicKey(pubKey,keyID);
						pw.println("YES");
					}catch(IOException ioe){
						pw.println("Error writing public key into server");
					}
				}
			}else
			if(clientInput.equals("READ")){
			/*
			 * do the operation for reading the mail and sending to the client
			 */
				pw.println("OK");
				String msgId = br.readLine();
				try{
					String message = getMessage(msgId);
					pw.println(message);
				}catch(FileNotFoundException fnfe){
				}catch(IOException ioe){};
				pw.println("END");
			}else
			if(clientInput.equals("DELETE")){
				pw.println("OK");
				String msgId = br.readLine();
				try{
					deleteMessage(msgId);
					pw.println("OK");
				}catch(FileNotFoundException fnfe){	
					pw.println(fnfe.toString());
				}catch(IOException ioe){
					pw.println(ioe.toString());
				}
			}else
			if(clientInput.equals("ATTACH")){
				pw.println("OK");
				String attach = br.readLine();
				pw.println("OK");
				String e = br.readLine();
				byte[] fileContents = getAttachment(attach);
				if(e.equals("R64")){
System.out.println("File is not encrypted");
					fileContents =new Radix64().encode(fileContents);
System.out.println("After R64 conversion :"+fileContents.length);
//System.out.println("Just to send file : "+ fileContents.substring(0,20) );
				}
				int i;
				for(i = 0;i < fileContents.length / 8192 ;i++)
					pw.println(new String(fileContents,i*8192,8192));
				pw.println(new String(fileContents,i*8192,fileContents.length % 8192));
				pw.println("END");
			}else{
				System.out.println("Recieved Incorect command"+clientInput);
			}
		}catch(IOException e){
			System.out.println("Error Writing Object");
			e.printStackTrace();
			endSession();
		}
	}
	endSession();
}
protected byte[] getAttachment(String attach)throws FileNotFoundException,IOException{
	if(new File("./"+login.getID()+"/"+attach).exists()){
		FileInputStream fis = new FileInputStream("./"+login.getID()+"/"+attach);
		byte[] fc = new byte[fis.available()];
		fis.read(fc);
System.out.println("Size of file contents in file is :"+fc.length);
System.out.println("Printing part of file :"+ new String(fc,0,20));
		return fc;
	}
	throw new FileNotFoundException("Invalid attachment! Please try again");
}
public void endSession(){
	try{
		br.close();
		pw.close();
		socket.close();
		
	}catch(IOException e){
	}
}
}
