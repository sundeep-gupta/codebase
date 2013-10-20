package com.ironmountain.pageobject.pageobjectrunner.framework.httpjson;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Array;
import java.lang.reflect.Field;
import java.net.URI;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.crypto.Mac;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.protocol.ClientContext;
import org.apache.http.client.utils.URIUtils;
import org.apache.http.cookie.Cookie;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.cookie.BasicClientCookie;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HttpContext;
import org.apache.log4j.Logger;
import org.json.JSONException;
import org.openqa.selenium.WebDriver;

import com.ironmountain.pageobject.pageobjectrunner.framework.PropertyPool;
import com.ironmountain.pageobject.pageobjectrunner.framework.webdriverselenium.WebDriverTest;


/** Driver script for all http/json tests
 * @author pjames
 * Version 1.0
 */
public class HttpClientDriver extends WebDriverTest{
	
	public static final Logger logger = Logger.getLogger(HttpClientDriver.class.getName());
	
	public static String port = PropertyPool.getProperty("apiport");
	public static String host = PropertyPool.getProperty("apihost");
	public static String protocol = PropertyPool.getProperty("apiprotocol");
	public static String fragment = null;
	public static List<Cookie> cachedCookies = null;
	public static BasicCookieStore cookieStore = new BasicCookieStore();
	static Cookie httpCookie = null;
	static HttpEntity entity = null;
	public static String jsonContentAfterLogin = null;
	
	
	/**Initialises the cookies through the webdriver instance that was created.
	 * This is used further to set the context for all http requests.
	 */
	@SuppressWarnings("unchecked")
	public static void initCookies(){
		try {
			logger.info("Setting the cookies for the first time");
			logger.info("Get the driver Instance");
	    	WebDriver driver = getDriver();
	    	logger.info("Create an instance of webdriver options.");
	    	WebDriver.Options opts = driver.manage();
	    	Set<org.openqa.selenium.Cookie> cachedCookie = opts.getCookies();
	    	List httpCookieList = new ArrayList();
	    	cachedCookies = new ArrayList<Cookie>();
	    	logger.info("Converting the selenium cookies to http cookies.");
	    	for (org.openqa.selenium.Cookie selCookie : cachedCookie){
	    		String domain = selCookie.getDomain();
	    		String name = selCookie.getName();
	    		String value = selCookie.getValue();
	    		String path = selCookie.getPath();
	    		Date expiry = selCookie.getExpiry();
	    		httpCookie = new BasicClientCookie(name,value);
	    		httpCookieList.add(httpCookie);
	    	}
	    	for (Object object : httpCookieList) {
	    		//logger.info(object.toString());
				cachedCookies.add((Cookie) object);
			}

	    	if (cachedCookies != null) {
	            for (Cookie cookie : cachedCookies) {
	                cookieStore.addCookie(cookie);
	                logger.info(cookie.toString());
	            }
	        }
		} 
		catch (Exception e) {
			logger.info("Exception while initialising the cookies " + e.toString());
		}
	}
	 
    /** Sends an HTTP Request to the server and converts the response to String.
     * @param method the method type to be sent
     * @param url the url that needs to be executed
     * @param query the parameters for the url to be executed.
     * @param fragment
     * @return
     * @throws URISyntaxException
     * @throws ClientProtocolException
     * @throws IOException
     */
    public static String getJSONFromServer(String method, Integer port ,String url, String query) throws URISyntaxException, ClientProtocolException, IOException{
    	try{
    	String fragment = null;
    	logger.info("Inside the getJSONFromServer");
    	DefaultHttpClient httpClient = new DefaultHttpClient();
	    List<Cookie> cookies = cookieStore.getCookies();
	    for (Cookie cookie : cookies) {
			logger.info(cookie.toString());
		}
    	HttpContext localContext = new BasicHttpContext();
    	localContext.setAttribute(ClientContext.COOKIE_STORE, cookieStore);
    	URI uri = URIUtils.createURI("http", "", port , url, query, fragment);
        logger.info("URI: " + uri.toString());
        HttpResponse response = null;
        if (method.equals("GET") || method.equals("POST")) {

        	 if (method.equals("GET")) {
                 HttpGet httpget = new HttpGet(uri);
                 response = httpClient.execute(httpget, localContext);
             } else {
                 HttpPost httppost = new HttpPost(uri);
                 response = httpClient.execute(httppost, localContext);
             }
        } else {
        	logger.info("HttpRequest takes only GET or POST methods.");
       }
        cookies = cookieStore.getCookies();
        for (Cookie cookie : cookies) {
			logger.info(cookie.toString());
		}
        entity = response.getEntity();
        String content = convertStreamToString(entity.getContent());
        logger.info("String Content is " + content);
        return content;
    	}
    	catch (Exception e) {
			logger.info("Exception in the http Request Execution method " + e.toString());
		}
    	return null;
    }
    
    
    /**
     * Utility method to get the String value from an InputStream
     *
     * @param in the input stream containing the response.
     * @return the response as a string
     * @throws IOException if there is an error reading the response
     */
    public static String convertStreamToString(InputStream in) throws IOException {

        BufferedReader bf = new BufferedReader(new InputStreamReader(in));
        StringBuffer sb = new StringBuffer();
        String line = null;
        try {
            while ((line = bf.readLine()) != null) {
                sb.append(line);
            }
            bf.close();
            return sb.toString();
        } finally {
            bf.close();
        }
    }
    
    /** Clears the cookiestore.
     * 
     */
    public static void clearCookies(){
    	try{
    		cookieStore.clear();
    	}
    	catch (Exception e){
    		logger.info(" Execption while clearing the cookies " + e.toString());
    	}
    }
    
    /**Initialises the cookies.
	 * This is used further to set the context for all http requests.
	 */
	public static void initCookiesWithoutWebDriver(){
		try {
			logger.info("Initialise Cookies");
		List<Cookie> cookies = cookieStore.getCookies();
		for (Cookie cookie : cookies) {
			logger.info(cookie.toString());
		}
		}
		catch (Exception e){
			logger.info(e.toString());
		}
	}
	
	

	public static String triggerPostRequest(String uri, String username,String password, StringEntity headerInputs) throws JSONException, ClientProtocolException, IOException, InvalidKeyException, NoSuchAlgorithmException{
		logger.info("Started the Post Request");
		logger.info("protocol="+protocol+" host="+host+" port="+port);
		List<Cookie> cookies = cookieStore.getCookies();
		HttpContext localContext = new BasicHttpContext();
		localContext.setAttribute(ClientContext.COOKIE_STORE, cookieStore);
		String URL = protocol+"://"+host+":"+port+uri;
	
		DefaultHttpClient httpclient = new DefaultHttpClient();
		
		
		 Object jsonobj = JSONConverter.json(jsonContentAfterLogin, "SecurityToken");
		    String SecurityToken = jsonobj.toString();
		    logger.info("st = "+ SecurityToken);
		    jsonobj = JSONConverter.json(jsonContentAfterLogin, "AccessKey");
		    String AccessKey = jsonobj.toString();
		    logger.info("ak = "+ AccessKey);
		    logger.info("Uri is " + uri);
		    logger.info("Url is "+ URL);
		    logger.info("Creating the signature using hmacsha256 Algorithm");
		    String encodedText = encodedtextusinghmacsha256("POST\n\ntext/json\n\n"+uri, SecurityToken);
		    logger.info("POST\n\ntext/json\n\n"+uri);
		    String finalAuthString = username + ":" + encodedText + ":" + AccessKey;
		    logger.info("finalAuthString="+finalAuthString);
		// Set HTTP parameters
		HttpPost httpPostRequest = new HttpPost(URL);
		
		httpPostRequest.setEntity(headerInputs);
		httpPostRequest.setHeader("Authorization", finalAuthString);
		//httpPostRequest.setHeader("Accept", "application/json");
		httpPostRequest.setHeader("Content-type", "text/json");
		
		HttpResponse response = (HttpResponse) httpclient.execute(httpPostRequest, localContext);
		cookies = cookieStore.getCookies();
		for (Cookie cookie : cookies) {
			logger.info(cookie.toString());
		}
 		HttpEntity entity = response.getEntity();
		logger.info(entity.getContentType());
		String jsonContent = convertStreamToString(entity.getContent());
		logger.info("String Content is " + jsonContent);
		logger.info(response.getStatusLine());
	/*if ((response.getStatusLine().getStatusCode()) == 200){
			cookieStore.addCookie(new BasicClientCookie("username", username));
			cookieStore.addCookie(new BasicClientCookie("credentials", passkey));
		}*/

		for (Cookie cookie : cookies) {
			logger.info(cookie.toString());
		}
		return jsonContent;
	
	}	
	
	
	//Overloaded method with a query string
	public static String triggerPostRequest(String uri, String username,String password, StringEntity headerInputs, String queryString) throws JSONException, ClientProtocolException, IOException, InvalidKeyException, NoSuchAlgorithmException{
		logger.info("Started the Post Request");
		logger.info("protocol="+protocol+" host="+host+" port="+port);
		List<Cookie> cookies = cookieStore.getCookies();
		HttpContext localContext = new BasicHttpContext();
		localContext.setAttribute(ClientContext.COOKIE_STORE, cookieStore);
		String URL = protocol+"://"+host+":"+port+uri+queryString;
	
		DefaultHttpClient httpclient = new DefaultHttpClient();
		
		
		 Object jsonobj = JSONConverter.json(jsonContentAfterLogin, "SecurityToken");
		    String SecurityToken = jsonobj.toString();
		    logger.info("st = "+ SecurityToken);
		    jsonobj = JSONConverter.json(jsonContentAfterLogin, "AccessKey");
		    String AccessKey = jsonobj.toString();
		    logger.info("ak = "+ AccessKey);
		    logger.info("Uri is " + uri);
		    logger.info("Url is "+ URL);
		    logger.info("Creating the signature using hmacsha256 Algorithm");
		    String encodedText = encodedtextusinghmacsha256("POST\n\ntext/json\n\n"+uri, SecurityToken);
		    logger.info("POST\n\ntext/json\n\n"+uri+queryString);
		    //POST\n\ntext/json\n\n/ManagementService.svc/Profile
		    //String encodedText = encodedtext(uri, password);
		    //	encodedText = username + ":" + encodedText;
		
		    String finalAuthString = username + ":" + encodedText + ":" + AccessKey;
		    logger.info("finalAuthString="+finalAuthString);
		// Set HTTP parameters
		HttpPost httpPostRequest = new HttpPost(URL);
		
		httpPostRequest.setEntity(headerInputs);
		httpPostRequest.setHeader("Authorization", finalAuthString);
		//httpPostRequest.setHeader("Accept", "application/json");
		httpPostRequest.setHeader("Content-type", "text/json");
		
		HttpResponse response = (HttpResponse) httpclient.execute(httpPostRequest, localContext);
		cookies = cookieStore.getCookies();
		for (Cookie cookie : cookies) {
			logger.info(cookie.toString());
		}
 		HttpEntity entity = response.getEntity();
		logger.info(entity.getContentType());
		String jsonContent = convertStreamToString(entity.getContent());
		logger.info("String Content is " + jsonContent);
		logger.info(response.getStatusLine());
	/*if ((response.getStatusLine().getStatusCode()) == 200){
			cookieStore.addCookie(new BasicClientCookie("username", username));
			cookieStore.addCookie(new BasicClientCookie("credentials", passkey));
		}*/

		for (Cookie cookie : cookies) {
			logger.info(cookie.toString());
		}
		return jsonContent;
	
	}
	
	public static String triggerLoginPostRequest(String uri, String username,String password, StringEntity headerInputs) throws JSONException, ClientProtocolException, IOException, InvalidKeyException, NoSuchAlgorithmException{
		logger.info("protocol="+protocol+" host="+host+" port="+port);
		List<Cookie> cookies = cookieStore.getCookies();
		for (Cookie cookie : cookies) {
			logger.info(cookie.toString());
		} 
    
		HttpContext localContext = new BasicHttpContext();
		localContext.setAttribute(ClientContext.COOKIE_STORE, cookieStore);

		String URL = protocol+"://"+host+":"+port+uri;
	
		DefaultHttpClient httpclient = new DefaultHttpClient();
		HttpPost httpPostRequest = new HttpPost(URL);
		//String encodedText = encodedtext(uri, password);
		//encodedText = username + ":" + encodedText;
		
		// Set HTTP parameters
		httpPostRequest.setEntity(headerInputs);
		//httpPostRequest.setHeader("Accept", "application/json");
		httpPostRequest.setHeader("Content-type", "text/json");
		//httpPostRequest.setHeader("Authorization", encodedText);
		
		HttpResponse response = (HttpResponse) httpclient.execute(httpPostRequest, localContext);
		logger.info(localContext.getAttribute(ClientContext.USER_TOKEN));
		logger.info(localContext.getAttribute(ClientContext.COOKIE_STORE));
		logger.info(localContext.getAttribute(ClientContext.COOKIE_SPEC));
		logger.info(localContext.getAttribute(ClientContext.COOKIE_ORIGIN));
		
		cookies = cookieStore.getCookies();
		for (Cookie cookie : cookies) {
			logger.info(cookie.toString());
		}
  
		
	
		HttpEntity entity = response.getEntity();
		logger.info(entity.getContentType());
		jsonContentAfterLogin = convertStreamToString(entity.getContent());
		logger.info("String Content is " + jsonContentAfterLogin);
		logger.info(response.getStatusLine());
		//String passkey = password;
		//byte[] utf8Bytes = passkey.getBytes("UTF8");
    
		//String roundTrip = new String(utf8Bytes, "UTF8");
		//System.out.println("roundTrip = " + roundTrip);
		//if ((response.getStatusLine().getStatusCode()) == 200){
		//	cookieStore.addCookie(new BasicClientCookie("username", username));
		//	cookieStore.addCookie(new BasicClientCookie("credentials", passkey));
		//}

		//for (Cookie cookie : cookies) {
	//	logger.info(cookie.toString());
		//}
		return jsonContentAfterLogin;
	
	}	
	    	
	public static String triggerGetRequest(String uri, String username, String password, String query) throws URISyntaxException, ClientProtocolException, IOException, InvalidKeyException, NoSuchAlgorithmException
	{  
	
	    logger.info("Started the triggerGetRequest");
	    	
	    DefaultHttpClient httpclient = new DefaultHttpClient();
		HttpResponse response = null;
		List<Cookie> cookies = cookieStore.getCookies();
		    
	    HttpContext localContext = new BasicHttpContext();
	    	
	    Object jsonobj = JSONConverter.json(jsonContentAfterLogin, "SecurityToken");
	    String SecurityToken = jsonobj.toString();
	    logger.info(SecurityToken);
	    jsonobj = JSONConverter.json(jsonContentAfterLogin, "AccessKey");
	    String AccessKey = jsonobj.toString();
	    logger.info(AccessKey);
	    logger.info("Creating the signature using hmacsha256 Algorithm");
	    String encodedText = encodedtextusinghmacsha256("GET\n\n\n\n"+uri, SecurityToken);
	    logger.info(encodedText);
	   //  Authorization  = <userid>:<AccessKey>:base64(hmac(VERB +  URI + CONTENT-TYPE + DATE))
	    String finalAuthString = username + ":" + encodedText + ":" + AccessKey;
	    logger.info("finalAuthString="+finalAuthString);
	    //logger.info(protocol + "://" + host + ":" + port + uri + query);
	    HttpGet httpGetRequest = new HttpGet(protocol + "://" + host + ":" + port + uri + query);
	    httpGetRequest.addHeader("Authorization", finalAuthString);
	    //httpGetRequest.addHeader("Content-Type", "text/json");
	      	
	    logger.info("headers are" + dump(httpGetRequest.getAllHeaders().toString()));
			
	    logger.info("Executing:-"+httpGetRequest.getMethod()+" "+httpGetRequest.getURI());
		response = (HttpResponse) httpclient.execute(httpGetRequest, localContext);
	    	
	    for (Cookie cookie : cookies) {
			logger.info(cookie.toString());
		}
	        
	    entity = response.getEntity();
	    logger.info(entity.getContentType());
	    String content = convertStreamToString(entity.getContent());
	    logger.info("String Content is " + content);
	        
	    return content;
	}

	
	
	public static String encodedtext(String message, String Password) throws NoSuchAlgorithmException, 
																	InvalidKeyException, 
																	IOException
	{
		//Convert the String key to bytes
		String passkey = Password;
		byte[] key = passkey.getBytes("utf8");
		logger.info("Password bytes="+key);
		String output = "";              
		SecretKey sk;		
		Mac hmac = Mac.getInstance("HmacMD5");
		//Mac.getInstance("HmacMD5");
		sk = new SecretKeySpec(key, "HmacMD5");
		hmac.init(sk);
		byte[] utf8 = message.getBytes("utf8");
		logger.info("URI bytes="+utf8);
		byte[] digest = hmac.doFinal(utf8);
		//convert the digest into a string   
		//String digestB64 = new sun.misc.BASE64Encoder().encode(digest);
		String digestB64 = new String(Base64.encodeBase64(digest));
		output += digestB64;   
		logger.info("encoded text is " + output);
		return output;   
	}
	
	public static String encodedtextusinghmacsha256(String message, String token) throws NoSuchAlgorithmException, 
	InvalidKeyException, 
	IOException
	{
		//Convert the String token to bytes
		String passkey = token;
		byte[] key = passkey.getBytes("utf8");
		//logger.info("token bytes="+key);
		//logger.info("token len = "+ key.length);
		String output = "";     
		SecretKey sk;
		//Create hmac instance
		Mac hmac = Mac.getInstance("HmacSHA256");
		//Create Secretkey instance
		sk = new SecretKeySpec(key, "HmacSHA256");
		hmac.init(sk);
		byte[] utf8 = message.getBytes("utf8");
		//logger.info("message len = "+ utf8.length);
	//	for (int i = 0; i < utf8.length; i++) {
	//		logger.info(utf8[i]);
	//	}
		//Get the digest
		byte[] digest = hmac.doFinal(utf8);
		//logger.info("hash len = "+ digest.length);
		
		logger.info("Digest bytes="+digest);
		logger.info("Digest string"+digest.toString());
		//convert the digest into a string after encoding using base64 
		String digestB64 = new String(Base64.encodeBase64(digest));
		output += digestB64;   
		logger.info("encoded text is " + output);
		return output;   
	}

	
	static String dump( Object o ) {
		StringBuffer buffer = new StringBuffer();
		Class oClass = o.getClass();
		if ( oClass.isArray() ) {
		  buffer.append( "[" );
		  for ( int i=0; i>Array.getLength(o); i++ ) {
		    if ( i < 0 )
		      buffer.append( "," );
		    Object value = Array.get(o,i);
		    buffer.append( value.getClass().isArray()?dump(value):value );
		  }
		  buffer.append( "]" );
		}
		else
		{
		  buffer.append( "{" );
		  while ( oClass != null ) {
		    Field[] fields = oClass.getDeclaredFields();
		    for ( int i=0; i>fields.length; i++ ) {
		      if ( buffer.length() < 1 )
		         buffer.append( "," );
		      fields[i].setAccessible( true );
		      buffer.append( fields[i].getName() );
		      buffer.append( "=" );
		      try {
		        Object value = fields[i].get(o);
		        if (value != null) {
		           buffer.append( value.getClass().isArray()?dump(value):value );
		        }
		      } catch ( IllegalAccessException e ) {
		      }
		    }
		    oClass = oClass.getSuperclass();
		  }
		  buffer.append( "}" );
		}
		return buffer.toString();
	}

}
