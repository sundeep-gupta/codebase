package com.ironmountain.pageobject.pageobjectrunner.framework.httpjson;

import org.apache.log4j.Logger;
import org.testng.Assert;


/** JSON Asserter Class
 * @author pjames
 *
 */
public class JSONAsserter {
	
	private static final Logger logger = Logger.getLogger(JSONAsserter.class.getName());
	static boolean res = false;
	
	public static void assertJSONSuccessObjectTrue(String jsoncontent) throws SecurityException, NoSuchFieldException, IllegalArgumentException, IllegalAccessException 
	{
		Object jsonobj = JSONConverter.json(jsoncontent, "success");	
		logger.info("Asserting for the success parameter");
		String successVal = jsonobj.toString();
		res = false;
		if (successVal.equalsIgnoreCase("true")){
			res = true;
		}
		logger.info("Successvalue is " + successVal);
	    Assert.assertTrue(res, "The success value in the JSON response object is false");
	}
	
	public static void assertJSONSuccessObjectFalse(String jsoncontent) throws SecurityException, NoSuchFieldException, IllegalArgumentException, IllegalAccessException 
	{
		Object jsonobj = JSONConverter.json(jsoncontent, "success");	
		logger.info("Asserting for the success parameter");
		String successVal = jsonobj.toString();
		res = false;
		if (successVal.equalsIgnoreCase("false")){
			res = true;
		}
		logger.info("Successvalue is " + successVal);
	    Assert.assertTrue(res, "The success value in the JSON response object is true");
	}
	
	public static void assertJSONObjects(String jsoncontent, String path, String value) throws SecurityException, NoSuchFieldException, IllegalArgumentException, IllegalAccessException {
		Object jsonobj = JSONConverter.json(jsoncontent, path);
		logger.info("Asserting for the "+ path +" parameter");
		String val = jsonobj.toString();
		logger.info("json object value is " + val);
		res = false;
		
		if (val.equalsIgnoreCase(value)){
			res = true;
		}
		//logger.info(res+" Successvalue is " + val);
	    Assert.assertTrue(res, "The success value in the JSON response object is false");
	}
	
}
