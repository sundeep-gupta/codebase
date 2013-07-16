package com.ironmountain.pageobject.pageobjectrunner.framework.httpjson;

import org.apache.log4j.Logger;
import org.json.JSONObject;

public class JSONConverter {
	private static final Logger logger = Logger.getLogger(JSONConverter.class.getName());
	
	
	 /** Method to convert json string to json object
	 * @param reqPath
	 * @param jsonPath
	 * @return
	 */
	public static Object json(String reqPath, String path) {
		
		 if (reqPath != null) {
	            String json = reqPath;
	            JSONComparator comp = new JSONComparator(true);
	            return comp.deserializeJSON(json, path);
	        }
	        return null;
	    }
	
}
