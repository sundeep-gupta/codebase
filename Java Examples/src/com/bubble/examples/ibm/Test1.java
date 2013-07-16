import java.io.*;
import com.ibm.jp.fss.textfiledivider.TextFileDivider;
public class Test{
    public static void main(String[] args) throws Exception{
	    System.setIn( new FileInputStream( new File("test_files/test_input.txt")));
	    TextFileDivider.main(null);
		
        //System.setOut( new PrintStream( new File("test_files/one.txt")));
		//Thread thread = new Thread ( new Runnable() {
		 //        TextFileDivider.main(null);
	//				});
	    
    //Process p = Runtime.getRuntime().exec("java -cp build/classes:$CLASSPATH com.ibm.jp.fss.textfiledivider.TextFileDivider > test_files/one.txt 2>&1");
/*	BufferedWriter stdin = new BufferedWriter( new OutputStreamWriter(p.getOutputStream()));
	stdin.write("test_files/big_file.txt\n");
	stdin.flush();
	stdin.write("test_files/demo\n");
	stdin.flush();
	stdin.write("3");
	stdin.flush();
	BufferedReader r = new BufferedReader(new InputStreamReader(p.getInputStream()));
	String line = null;
	while ((line = r.readLine()) != null) {
	    System.out.println(line);
	}*/
	//p.waitFor();
	System.out.println("Completed.");
	}
}
