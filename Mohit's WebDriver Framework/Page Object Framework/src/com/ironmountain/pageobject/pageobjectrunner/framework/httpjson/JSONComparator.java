/**
 * Copyright 1999-2011  Iron Mountain Incorporated.  All Rights Reserved
 */
package com.ironmountain.pageobject.pageobjectrunner.framework.httpjson;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParseException;
import com.google.gson.JsonPrimitive;
import com.google.gson.reflect.TypeToken;
import org.apache.log4j.Logger;


/**
 * @author pjames
 *
 */

public class JSONComparator {

    private static final String KEY_STRING_OBJECT_MAP = "StringObjectMap";
    private static final String KEY_OBJECT_LIST = "ObjectList";
    private static final String KEY_STRING = "Boolean";
    private static final String KEY_BOOLEAN = "String";
    private static final String KEY_NUMBER = "Number";
    private static final Map<String, Type> TYPES;
    private static final Logger LOGGER = Logger.getLogger(JSONComparator.class);

    private final boolean subsetVerification;

    static {
        Map<String, Type> types = new HashMap<String, Type>(4);
        types.put(KEY_STRING_OBJECT_MAP, new TypeToken<Map<String, Object>>() {
        }.getType());
        types.put(KEY_OBJECT_LIST, new TypeToken<List<Object>>() {
        }.getType());
        types.put(KEY_STRING, new TypeToken<String>() {
        }.getType());
        types.put(KEY_BOOLEAN, new TypeToken<Boolean>() {
        }.getType());
        types.put(KEY_NUMBER, new TypeToken<Number>() {
        }.getType());
        TYPES = Collections.unmodifiableMap(types);
    }

    private final Gson gson;

    public JSONComparator() {
        this(false);
    }

    public JSONComparator(final boolean subsetVerification) {
        GsonBuilder builder = new GsonBuilder();
        builder.registerTypeAdapter(TYPES.get(KEY_STRING_OBJECT_MAP), new StringObjectMapDeserializer());
        builder.registerTypeAdapter(TYPES.get(KEY_OBJECT_LIST),new ObjectListDeserializer());
        gson = builder.create();
        this.subsetVerification = subsetVerification;
    }



    /**
     * @param json1
     * @return
     */
    private Type getType(String json) {
        String trimmed = json.trim();
        if (trimmed.startsWith("{")) {
            return TYPES.get(KEY_STRING_OBJECT_MAP);
        } else if (trimmed.startsWith("[")) {
            return TYPES.get(KEY_OBJECT_LIST);
        } else {
            return TYPES.get(KEY_STRING);
        }
    }

    
    
    /** Deserialise the JSON string to object
     * @param json
     * @param path
     * @return json object
     */
    public Object deserializeJSON(String json, String path) {
        Object jsonMap = gson.fromJson(json, getType(json));
        Object jsonObject = getPathObject(jsonMap, path);
        return jsonObject;
    }

   

    public static class StringObjectMapDeserializer implements JsonDeserializer<Map<String, Object>> {

        /*
         * (non-Javadoc)
         * 
         * @see
         * com.google.gson.JsonDeserializer#deserialize(com.google.gson.JsonElement
         * , java.lang.reflect.Type, com.google.gson.JsonDeserializationContext)
         */
        @Override
        public Map<String, Object> deserialize(
            JsonElement element,
            Type type,
            JsonDeserializationContext context) throws JsonParseException {
            JsonObject jsonObj = element.getAsJsonObject();
            Map<String, Object> map = new HashMap<String, Object>(5);
            for (Entry<String, JsonElement> entry : jsonObj.entrySet()) {
                map.put(entry.getKey(), JSONComparator.deserialize(entry.getValue(), context));
            }
            return map;
        }
    }

    public static class ObjectListDeserializer implements JsonDeserializer<List<Object>> {

        /*
         * (non-Javadoc)
         * 
         * @see
         * com.google.gson.JsonDeserializer#deserialize(com.google.gson.JsonElement
         * , java.lang.reflect.Type, com.google.gson.JsonDeserializationContext)
         */
        @Override
        public List<Object> deserialize(
            JsonElement element,
            Type type,
            JsonDeserializationContext context) throws JsonParseException {
            List<Object> list = new ArrayList<Object>(2);
            JsonArray array = (JsonArray) element;
            for (int i = 0; i < array.size(); i++) {
                list.add(JSONComparator.deserialize(array.get(i), context));
            }

            return list;
        }
    }

    /**
     * @param element
     * @param context
     */
    protected static Object deserialize( JsonElement element, JsonDeserializationContext context) {
        Type type = null;
        if (element.isJsonArray()) {
            type = TYPES.get(KEY_OBJECT_LIST);
        } else if (element.isJsonObject()) {
            type = TYPES.get(KEY_STRING_OBJECT_MAP);
        } else if (element.isJsonPrimitive()) {
            JsonPrimitive prim = element.getAsJsonPrimitive();
            if (prim.isString())
                type = TYPES.get(KEY_STRING);
            else if (prim.isNumber())
                type = TYPES.get(KEY_NUMBER);
            else if (prim.isBoolean())
                type = TYPES.get(KEY_BOOLEAN);
        }

        if (type == null)
            type = TYPES.get(KEY_STRING);
        return context.deserialize(element, type);
    }

    @SuppressWarnings("unchecked")
    private static Object getPathObject(Object json, String path) {
        if (path == null || path.trim().length() == 0) {
            return json;
        }
        if (json instanceof Map<?, ?>) {
        	String pathParts[] = getPathParts(path, Map.class);
        	Object nested = ((Map<String, Object>) json).get(pathParts[0]);
            return getPathObject(nested, pathParts[1]);
        } else if (json instanceof List<?>) {
        	List<Object> jsonList = (List<Object>) json;
            String pathParts[] = getPathParts(path, List.class);
            int index = Integer.valueOf(pathParts[0]);
            Object nested = jsonList.size() > index ? jsonList.get(index) : null;
            return getPathObject(nested, pathParts[1]);
        } else {
            return json;
        }
    }

    /** Splitting the parts of the path
     * @param path
     * @param class
     * @return
     */
    private static String[] getPathParts(String path, Class<?> clazz) {
        if (clazz == Map.class) {
            int idx = path.indexOf('/');
            if (idx != -1) {
                return new String[] {
                    path.substring(0, idx),
                    path.substring(idx + 1) };
            } else {
                return new String[] { path, null };
            }
        } else if (clazz == List.class) {
            int idx = path.indexOf('/');
            String sub = null;
            String next = null;
            if (idx != -1) {
                sub = path.substring(0, idx);
                next = path.substring(idx + 1);
            } else {
                sub = path;
            }
            if (sub.startsWith("[") && sub.endsWith("]")) {
                sub = sub.substring(1, sub.length() - 1);
            }
            return new String[] { sub, next };
        }

        return new String[] { null, null };

    }

}
