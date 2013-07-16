
import java.io.*;
import java.util.*;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
public class Document {

    public static void main(String[] args) throws Exception {
	     // set up new properties object
		// from file "myProperties.txt"
		FileInputStream propFile = new FileInputStream("myProperties.txt");
		Properties p = new Properties(System.getProperties());
		p.load(propFile);
	    // set the system properties
	    System.setProperties(p);

        DocumentBuilder db = DocumentBuilderFactory.newInstance().newDocumentBuilder();
	}
}
