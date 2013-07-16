import java.io.*;
import java.util.Properties;
import java.util.GregorianCalendar;
import java.util.Calendar;

class GetAbsPath {

	public GetAbsPath(String kPath, String propName){

//		File f = new File("D:\\new\\new\\Modified http2-result.csv");
try{
		Properties prop = new Properties(System.getProperties());
		prop.load(new FileInputStream(kPath + "jmeter.properties"));
		System.out.println(prop.getProperty(propName));
}catch(Exception e){
	e.printStackTrace();
}

	}
	public static void main(String[] args) {

		int l = args.length;
		if(l == 2)	 new GetAbsPath(args[0], args[1]);
		GregorianCalendar calendar = new GregorianCalendar();
		System.out.println(calendar.get(Calendar.MONTH) + "." + calendar.get(Calendar.YEAR) + "." + calendar.get(Calendar.DATE));

		String date = calendar.getTime().toString();
		System.out.println(calendar.get(Calendar.DATE) + "-" + (calendar.get(Calendar.MONTH) + 1)  + "-" + calendar.get(Calendar.YEAR) + "_" + calendar.get(Calendar.HOUR) + "-" + calendar.get(Calendar.MINUTE)+ "-" + calendar.get(Calendar.SECOND));

		System.out.println(calendar.get(Calendar.DATE) + (calendar.get(Calendar.MONTH) + 1) + calendar.get(Calendar.YEAR) + "_" + calendar.get(Calendar.HOUR) + calendar.get(Calendar.MINUTE)+ calendar.get(Calendar.SECOND));

		System.out.println(new File("D:\\new\\jmeter.properties").exists());

	}
}
