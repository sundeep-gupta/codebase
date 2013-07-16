package mail;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.File;
import java.util.StringTokenizer;
import java.util.Iterator;
import java.util.ArrayList;
import java.util.TreeSet;
import java.net.Socket;
import java.net.InetAddress;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.math.BigInteger;
import java.security.NoSuchAlgorithmException;
import java.util.zip.DataFormatException;
import interfaces.*;
public class MailClient{

	Socket clientSocket = null;	
	BufferedReader br;
	PrintWriter pw = null;
	Login login;
	private byte[] pubKey,priKey;

	private String attachments = null;
/*
 * Constructor to connect to the server
 * arguments: Login object that contains loginID and Password
 * 		String host: to which the connection is to be established
 * 		int port : port to which the connection is to be established
 * throws: LoginNotFoundException, when specified login is not found or incorrect
 * 		IOException, if any Input output exception occurs.
 *		UnKnownHostException, if the specified host/server doesnot exist.
 *		ClassNotFoundException, if any problem occurs when object is read from stream.
 */		
public MailClient(String host,int port)throws IOException, UnknownHostException{
	/*Connect to server*/
	this(InetAddress.getByName(host),port);
}
public MailClient(InetAddress ia,int port)throws IOException,UnknownHostException{
	clientSocket = new Socket(ia,port);
	pw = new PrintWriter(clientSocket.getOutputStream(), true);
      br = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
	br.readLine();
}

public String getKeyIDFromMessage(String msg){
	byte[] message = msg.getBytes();

	byte[] mergedMessage = new Radix64().decode(message);

	/*deMerge sessionkey,encryptedMessage and PrivateKeyID  Here */

	Demerger demerge = new Demerger(mergedMessage);
	byte[] privateKeyId = demerge.getFirst();

	return new String(privateKeyId);
}

public byte[] encrypt(FileInputStream messageStream, String pubKeyID,String priKeyID,String to)
								throws NoSuchAlgorithmException,
									 DataFormatException,
									 IOException,
									 FileNotFoundException,
									 VeryBigMessageException,
									 LoginNotFoundException{
	if(messageStream.available() > 1024 * 1024 * 10)
		throw new VeryBigMessageException("Cannot send file of size more than 10MB");
	
	byte[] message = new byte[messageStream.available()];
	messageStream.read(message);
	return encrypt(message,pubKeyID,priKeyID,to);
}

public byte[] encrypt(byte[] message,String pubKeyID,String priKeyID,String to)
								throws NoSuchAlgorithmException,
									 DataFormatException,
									 IOException,
									 FileNotFoundException,
									 VeryBigMessageException,
									 LoginNotFoundException{

	/* get the keys */

	byte[] recPubKey = getPublicKey(to,pubKeyID);
	byte[] senPriKey = getPrivateKey(priKeyID);
	
	/* retrieve the Modulus and Exponents */
	
	Demerger demerge = new Demerger(senPriKey);
	byte[] modA = demerge.getFirst();
	byte[] expA = demerge.getSecond();
	BigInteger aMod = new BigInteger(1,modA);
	BigInteger aExp = new BigInteger(1,expA);

	demerge = new Demerger(recPubKey);
	byte[] modB = demerge.getFirst();
	byte[] expB = demerge.getSecond();
	BigInteger bMod = new BigInteger(1,modB);
	BigInteger bExp = new BigInteger(1,expB);		

	/* 
	 * Generate the SHA value
	 * Sign the message using the sender's private Key.
	 */ 

	 byte[] hash = SecureHash.generateSecureHash(message).getHashValue();	
       BigInteger cHash = new BigInteger(1,hash).modPow(aExp,bMod);


	/*
	 * compress the message
	 */
	byte[] compressedData = Zip.compress(message);

	/*
	 * Merge the message + signed hash value + privateKeyId
	 */	
	byte[] cryptHash = cHash.toByteArray();
	byte[] privateKeyId = priKeyID.getBytes();
	byte[] merged =  new Merger(privateKeyId,new Merger(cryptHash,compressedData).merge()).merge();
		
	/*
	 * generate the session key.
	 */
	byte[] sessionKey = new byte[16];
	System.arraycopy(hash,0,sessionKey,0,sessionKey.length);
	
	IDEA eIdea = new IDEA(merged,sessionKey);
	eIdea.encrypt();
	byte[] encryptedMessage = eIdea.getCipherText();

	/* 
	 * encrypt the session key using the public key of sender
	 */
	BigInteger eSessionKey = new BigInteger(1,sessionKey).modPow(bExp,bMod);
	byte[] enSessionKey = eSessionKey.toByteArray();

	byte[] publicKeyId = pubKeyID.getBytes();

	/* Merge sessionkey Here with encryptedMessage */
	byte[] mergedSession = new Merger(publicKeyId,new Merger(enSessionKey,encryptedMessage).merge()).merge();
	

	/* base 64 conversion */
	Radix64 radix64 = new Radix64();
	byte[] r64 = radix64.encode(mergedSession);
	return r64;

}
public byte[] decrypt(byte[] r64,String from)throws DataFormatException,
								    FileNotFoundException,
								    LoginNotFoundException,
								    IOException,
								    VeryBigMessageException{

	/*ascii to bin */
	byte[] mergedSession = new Radix64().decode(r64);

	/*deMerge sessionkey,encryptedMessage and PrivateKeyID  Here */

	Demerger demerge = new Demerger(mergedSession);
	byte[] privateKeyId = demerge.getFirst();
	
	demerge = new Demerger(demerge.getSecond());
	byte[] eSessionKey = demerge.getFirst();
	byte[] encryptedMessage = demerge.getSecond();


	/* get the private key from the keyID obtained */
	/* get the Modulus and exponent from the key */

	byte[] recPriKey = getPrivateKey( new String(privateKeyId));
javax.swing.JOptionPane.showMessageDialog(null,"Private Key found");	
	demerge = new Demerger(recPriKey);
	byte[] modB = demerge.getFirst();
	byte[] expB = demerge.getSecond();
	BigInteger bMod = new BigInteger(1,modB);
	BigInteger bExp = new BigInteger(1,expB);								

	/*decrypt Sessionkey using the private key of reciever */

	BigInteger sKey =new BigInteger(1,eSessionKey).modPow(bExp,bMod);
	byte[] sessionKey = sKey.toByteArray();

	if(sessionKey.length == 17){
		byte[] tempSkey = sessionKey;
		sessionKey = new byte[16];
		System.arraycopy(tempSkey,1,sessionKey,0,sessionKey.length);
	}

	/*
	 * Decrypt the encryptedMessage using the sessionkey
	 */
	IDEA dIdea = new IDEA(encryptedMessage,sessionKey);
	dIdea.decrypt();
	byte[] decryptedMessage = dIdea.getPlainText();

	/*
	 * demerge the message, signed hash value and pubKeyID
	 */		
	demerge = new Demerger(decryptedMessage);
	byte[] publicKey = demerge.getFirst();

	demerge = new Demerger(demerge.getSecond());
	byte[] cHash = demerge.getFirst();
	byte[] compressedMessage = demerge.getSecond();
	
	/* get the public key of sender */
	byte[] senPubKey = getPublicKey(from,new String(publicKey));

	demerge = new Demerger(senPubKey);
	byte[] modA = demerge.getFirst();
	byte[] expA = demerge.getSecond();
	BigInteger aMod = new BigInteger(1,modA);
	BigInteger aExp = new BigInteger(1,expA);

	/* 
	 * DeCompress the message 
	 */
	byte[] message = Zip.decompress(compressedMessage);

	/*
	 * Decrypt the signed hash value
	 */
	BigInteger pHash = new BigInteger(1,cHash).modPow(aExp,aMod);
	byte[] recievedHash = pHash.toByteArray();
		
	/*
	 * Calculate hash value of the recieved message
	 */
	return message;
									
}


/*
 * New Login creattion. 
 */
public void newLogin(Login login)throws IOException,SocketException,ServerException{
	this.login = login;			/*Store login for future use */
	pw.println("NEW");			/*Check for validity of login */
	String server = br.readLine();
	if(server.equals("OK")){	
		pw.println("LOGIN:"+login.getID());
		pw.println("PASSWORD:"+login.getPassword());
		server = br.readLine();
		if(server.equals("YES")){
			this.login = login;
			String serverKey = br.readLine();
			saveServerKey(serverKey);
			return;
		}else{
			throw new ServerException(server);
		}
	}
	throw new ServerException("Socket streams currupted");
}

/* 
 * store the server key in the client's machine 
 * argument: serverKey in radix64 format.
 */
private void saveServerKey(String serverKey)
			throws IOException,FileNotFoundException{
	new File(login.getID()).mkdir();
	FileOutputStream serkeyfile = new FileOutputStream(login.getID()+"/.key");
	PrintWriter pw = new PrintWriter(serkeyfile,true);
	pw.println(serverKey);
	pw.close();
	serkeyfile.close();
}

/* 
 * public key recieved in b64 format
 * returned in binary format 
 */
public byte[] getPublicKey(String reciever,String keyID)
			throws LoginNotFoundException,IOException,FileNotFoundException{

	if(new File(login.getID()+"/.key").exists()){
		FileInputStream keyFile = new FileInputStream(login.getID()+"/.key");
		BufferedReader brKey = new BufferedReader(new InputStreamReader(keyFile));
		String keyStr = brKey.readLine();
		brKey.close();
		byte[] pubKey = keyStr.getBytes();
		pubKey = new Radix64().decode(pubKey);				/* convert b64 to binary */

												/* demerge the keys to exponent and modulus */
		Demerger demerge = new Demerger(pubKey);
		byte[] mod = demerge.getFirst();
		byte[] exp = demerge.getSecond();
		BigInteger exponent = new BigInteger(1,exp);
		BigInteger modulus = new BigInteger(1,mod);

		BigInteger signReciever = new BigInteger( 1, reciever.getBytes()).modPow(exponent,modulus);
		
		byte[] signRec = signReciever.toByteArray();
		signRec = new Radix64().encode(signRec);				/* convert the message to b64 before sending */
		String signRecStr = new String(signRec);
		pw.println("PKEY");
		String serverString = "";
		serverString = br.readLine();
//System.out.println(serverString);
		if(serverString.equals("OK")){
			pw.println(signRecStr);
			pw.println(keyID);
			serverString = br.readLine();
//System.out.println(serverString);
			if(serverString.equals("YES")){
				serverString = br.readLine();	
				byte[] retKey = new Radix64().decode(serverString.getBytes());
				return retKey;
			}else	throw new IOException("Socket Streams currpted");
		}else	throw new IOException("Socket Streams currpted");
	}else	throw new IOException("Missing file containing KEY for server");
}

/* 
 * save the public key at server
 * recieved in bin format
 * send the key in b64 format
 */
public boolean savePublicKey(byte[] key,String keyID)throws IOException{
	pw.println("SAVEKEY");
	String serverString = br.readLine();
	if(serverString.equals("OK")){
		pw.println("KEYID");
		pw.println(keyID);
		serverString = br.readLine();
		if(serverString.equals("OK")){
			byte[] b64Key = new Radix64().encode(key);
			pw.println(new String(b64Key));
			serverString = br.readLine();
			if(serverString.equals("YES"))
				return true;
		}
	}
	return false;
}

/*
 * SavePrivate key in the client
 * key recieved in bin format converted to b64 format
 */
public void setPrivateKey(byte[] key,String passphrase,String keyID)throws IOException,FileNotFoundException{
	byte[] b64Key = new Radix64().encode(key);
	String strKey = new String(b64Key);
	if( ! (new File(login.getID()+"/.private").exists()))
		new File(login.getID()+"/.private").createNewFile();
	PrintWriter pwKey = new PrintWriter(new FileOutputStream(login.getID()+"/.private",true));
	pwKey.println(keyID+":"+passphrase+":"+strKey);
	pwKey.close();
}

/*
 * private key stored in b64 is converted to bin and sent.
 */
private byte[] getPrivateKey(String keyID)throws FileNotFoundException,IOException,LoginNotFoundException{
	if( ! (new File(login.getID()+"/.private").exists()))
		throw new FileNotFoundException("No Keys Exists.");

	BufferedReader brKey = new BufferedReader( new InputStreamReader(
								new FileInputStream(login.getID()+"/.private")));
	String key;
	while((key = brKey.readLine())!= null){
		StringTokenizer st = new StringTokenizer(key,":");
		if(st.hasMoreTokens() && st.nextToken().equals(keyID)){
			st.nextToken(); /* leave passphrase */
			brKey.close();
			return new Radix64().decode(st.nextToken().getBytes());
		}	
	}
	brKey.close();
	throw new LoginNotFoundException("Error occured:\nEither specified key does not exist or \npassword may be wrong.");

}

public boolean isValidPassphrase(String passphrase,String keyID)
				throws LoginNotFoundException,FileNotFoundException,IOException{
	if( ! (new File(login.getID()+"/.private").exists()))
		throw new FileNotFoundException("No Keys Exists.");

	BufferedReader brKey = new BufferedReader( new InputStreamReader(
								new FileInputStream(login.getID()+"/.private")));
	String key;
//System.out.println(keyID);
	while((key = brKey.readLine())!= null){
		StringTokenizer st = new StringTokenizer(key,":");
//StringTokenizer temp = new StringTokenizer(key,":");
//System.out.println("KeyID:"+temp.nextToken()+" Password:"+temp.nextToken().length()+" " +passphrase.length());
		if(st.hasMoreTokens() && st.nextToken().equals(keyID) && st.nextToken().equals(passphrase) ){
			brKey.close();
//System.out.println("Returning true");
			return true;
		}	
	}
	brKey.close();
	return false;
}

public String[] getPrivateKeyIDList()throws FileNotFoundException,IOException{
	if(!(new File(login.getID()+"/.private").exists()))
		throw new FileNotFoundException("No Private Key exists");
	BufferedReader brKey = new BufferedReader(new InputStreamReader(
								new FileInputStream(login.getID()+"/.private")));
	TreeSet ts = new TreeSet();
	String key;
	while((key = brKey.readLine())!= null){
		StringTokenizer st = new StringTokenizer(key,":");
		if(st.hasMoreTokens())
			ts.add(st.nextToken());
	}
	Iterator i = ts.iterator();
	String[] keyIds = new String[ts.size()];
	int index = 0;
	while(i.hasNext())	
		keyIds[index++] = (String)i.next();
	return keyIds;
}

public String[] getPublicKeyIDList(String other)throws IOException,ServerException{
	pw.println("KEYLIST");	
	String serverResponse = br.readLine();
	if(serverResponse.equals("OK")){
		pw.println(other);
		TreeSet ts = new TreeSet();
		String key = br.readLine();
		while(!key.equals("END")){
			ts.add(key);
			key = br.readLine();
		}
		Iterator i = ts.iterator();
		String[] keyList = new String[ts.size()];
		int index =0;
		while(i.hasNext())
			keyList[index++] = (String)i.next();
		return keyList;
	}
	throw new ServerException("Error in Client/Server Connection");
	
}


public boolean keyIDExists(String keyID)throws FileNotFoundException,IOException{
	if(! new File(login.getID()+"/.private").exists())
		return false;
	BufferedReader brKey = new BufferedReader( new InputStreamReader(
								new FileInputStream(login.getID()+"/.private")));
	String key;
	while((key = brKey.readLine())!= null){
		StringTokenizer st = new StringTokenizer(key,":");
		if(st.hasMoreTokens() && st.nextToken().equals(keyID) ){
			brKey.close();
			return true;
		}	
	}
	brKey.close();
	return false;
}

/*
 * Generate a new Key and store it 
 */
public void generateKey(String keyID,String passphrase)
				throws IOException,LoginNotFoundException,FileNotFoundException,NoSuchAlgorithmException{ 
	
	PGPKeys pgpKey = PGPKeys.generateKeys();
	byte[] mod = pgpKey.getModulus();
	byte[] priExp = pgpKey.getPrivateExponent();
	byte[] pubExp = pgpKey.getPublicExponent();

	pubKey = new Merger(mod,pubExp).merge();

	priKey = new Merger(mod,priExp).merge();
	
	savePublicKey(pubKey,keyID);			/* Save the public key at server */
	setPrivateKey(priKey,passphrase,keyID); 	/* Save private Key with passphrase in client*/
	
}	

/*
 * communicates with server to see whether given loginid exist or not.
 */
public void signAs(Login login)throws IOException,ServerException{
	/*Store login for future use */
	this.login = login;
	
	/*Check for validity of login */
	pw.println("SIGN");
	String server = br.readLine();
	if(server.equals("OK")){	
		pw.println("LOGIN:"+login.getID());
		pw.println("PASSWORD:"+login.getPassword());
		server = br.readLine();
		if(server.equals("YES")){
			this.login = login;
			return;
		}else 
			throw new ServerException(server);
	}
	throw new ServerException("Socket streams currupted");
}


/*
 * The getter method to return the Login object
 */
public Login getLogin(){
	return login;
}

public void sendMessage(String to,String subject,boolean encrypted,int attachments,byte[] message,String fileName,byte[] fileContents)
					throws LoginNotFoundException,IOException,ServerException{
	String server;
	sendMessage(to,subject,encrypted,attachments,message);


	pw.println("ATTACHMENT");
	if( ! (server = br.readLine()).equals("OK"))
		throw new ServerException("Error sending attachment \n" + server);
	pw.println(fileName);
	if( ! (server = br.readLine()).equals("OK"))
		throw new ServerException("Error sending attachment \n" + server);
	
	pw.println("CONTENT");
	if( !(server = br.readLine()).equals("OK"))
		throw new ServerException("Error sending attachment \n"+server);

	/* send messages in blocks*/
	int i;
System.out.println("Size while sending"+fileContents.length);
System.out.println("Contents  :"+new String(fileContents,0,20) );
	if(!encrypted)
		fileContents = new Radix64().encode(fileContents);
System.out.println("Size just b4 sending:"+fileContents.length);
System.out.println(new String(fileContents,0,20) );
	for(i = 0;i < fileContents.length / 8192 ;i++)
		pw.println(new String(fileContents,i*8192,8192));
	pw.println(new String(fileContents,i*8192,fileContents.length % 8192));

	pw.println("END");
	server = br.readLine();
	if(server.equals("OK"))
		return;
	else	
	 	throw	new ServerException(server);
	
}

/* 
 * sendMessage : send's the MyMessage object that contains the message along with the header
 * return : list of mail id's that doesnot recieve mail
 * 		or an empty list of the mail is successfully sent to all
 */
public void sendMessage(String to,String subject,boolean encrypted,int attachments,byte[] message)
					throws LoginNotFoundException,IOException,ServerException{
	String server;
	pw.println("MAIL");
	if( ! (server = br.readLine()).equals("OK"))
		throw new ServerException("Socket streams currupted\n"+server);
	pw.println("FROM"+login.getID());
	if( ! (server = br.readLine()).equals("OK"))
		throw new ServerException("Socket streams currupted\n"+server);
	pw.println("RCPT"+to);
	if( ! (server = br.readLine()).equals("OK"))
		throw new ServerException("Socket streams currupted\n"+server);
	pw.println("SBJT"+subject);
	if( ! (server = br.readLine()).equals("OK"))
		throw new ServerException("Socket streams currupted\n"+server);
	pw.println("ENCR"+encrypted);
	if(! (server = br.readLine()).equals("OK"))
		throw new ServerException("Socket streams currupted\n"+server);
	pw.println("ATMT"+attachments);
	if(! (server = br.readLine()).equals("OK"))
		throw new ServerException("Socket streams currupted\n"+server);
	pw.println("DATA");
	if( ! (server = br.readLine()).equals("OK"))
		throw new ServerException("Socket streams currupted\n"+server);
	/* send messages in blocks*/
	int i;
	for(i = 0;i < message.length / 8192 ;i++)
		pw.println(new String(message,i*8192,8192));
	pw.println(new String(message,i*8192,message.length % 8192));
	pw.println("END");
	if( ! (server = br.readLine()).equals("OK"))
		throw new ServerException("Socket streams currupted\n"+server);
	return;

}
	
/*
 * getMessageHeaders: get's the messageHeaders for the given user
 * 	Arguments:	Nothing
 * 	return :	an array of messageHeader object
 *		 	
 */
public String[] getMessageHeaders()throws IOException{
	pw.println("INBOX");
	String serverReply;
	ArrayList al  = new ArrayList();
	serverReply = br.readLine();
	while(! serverReply.equals("END")){
		al.add(serverReply);
		serverReply = br.readLine();
	}
	String[] messageHeaders = new String[al.size()];
	Iterator i = al.iterator();
	for(int index = 0;index < messageHeaders.length;index++){
		messageHeaders[index] =(String) i.next();
	}
	return messageHeaders;
}
/* return the attachment name
 */
public String getAttachments(){
	return attachments;
}
/*
 * Get the specified message from the server
 * irrespective of encryption or not
 */

public String getMessage(String from,String msgID)
			throws ServerException,ServerIOException,
				IOException{
	String message = "";
	pw.println("READ");
	String serverOutput = br.readLine();
	if(serverOutput.equals("OK")){
		pw.println(msgID);
		String msg="";
		try{
			do{
				message = message + msg+ "\n";
				msg = br.readLine();
			}while(!msg.equals("END"));
		}catch(IOException sioe){throw new IOException("Server Input output exception");}
		message = new String(getMessageOnly(message));
		return message;
	}	
	throw new ServerException();
}

public String getAttachment(String attName,boolean encrypted)throws ServerException,IOException{
	String server;

	pw.println("ATTACH");
	if(!(server = br.readLine()).equals("OK"))
		throw new ServerException("Server Exception : " + server);
System.out.println("Reading from server :" + attName);
	pw.println(attName);
	if(!(server = br.readLine()).equals("OK"))
		throw new ServerException("Server Exception :"+server);
	if(encrypted){
		pw.println("ASIS");
System.out.println("Recieving encrypted message");
	}
	else
		pw.println("R64");
	String message = "",msg = "";
	try{
		do{
			message = message + msg ;
			msg = br.readLine();
		}while(!(msg.equals("END")));
	}catch(IOException ioe){
		throw new ServerException("Server Input Output Exception ");
	}
System.out.println("Length of message Recieved"+message.length());
System.out.println("from server recieved :"+message.substring(0,20) );
	if(!encrypted)
		message = new String( new Radix64().decode(message.getBytes()) );
System.out.println("After decoding the message is :"+message.length());
System.out.println(message.substring(0,20));
	return message;
}
/* 
 * Fetches the message text from complete message.
 */
protected byte[] getMessageOnly(String msg){
	StringTokenizer st = new StringTokenizer(msg,"\n");
	int i;
	for(i=0;i<6;i++){
		String str = st.nextToken();
		if(i == 4){
			StringTokenizer st2 = new StringTokenizer(str,":");
			st2.nextToken();
			if (Integer.parseInt(st2.nextToken()) > 0 )
				attachments = st.nextToken();
			else
				attachments = null;
		}
	}
	String enc = "";
	while(st.hasMoreTokens()){
		enc = enc + st.nextToken();
	}
	return enc.getBytes();
}
/* 
 * Delete the specified message from the inbox  
 */
public void deleteMessage(String msgID)throws ServerException,IOException{
	pw.println("DELETE");
	String ser = br.readLine();
	if(ser.equals("OK")){
		pw.println(msgID);
		ser = br.readLine();
		if(ser.equals("OK"))
			return;
		else
			throw new ServerException(ser);
	}
	throw new ServerException("Unable to delete the message");
}

public void close()throws IOException{
	pw.close();
	br.close();
	clientSocket = null;
}
} /* end of MailClient class */