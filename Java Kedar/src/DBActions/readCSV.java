import java.io.*;

public class readCSV{
	public static void main(String[] args){
	try{

		FileReader sourceCSV = new FileReader("C:\\Documents and Settings\\050330\\Desktop\\STAF\\STAFProject\\Modified http2-result.csv");
		BufferedReader br = new BufferedReader(sourceCSV);
	
		PrintWriter pw = new PrintWriter(new FileWriter("C:\\Documents and Settings\\050330\\Desktop\\STAF\\STAFProject\\test321.csv"));		

		
		String line="", tempStr="";
		StringBuffer entireThing = new StringBuffer("");

//klsdfj, lkfjl , lfkdslkfk, lskdfnldm kf, dflsdfj ,jdflsd kfdsfl, lkfdslf kk dfdsm,, flkdjsflksdfl m l, lksdflkdjf,lnfldkjf <html>kedar, nath, is, working, at \" visual, soft\"</html>

		int loopCount=0;

		while((line = br.readLine())!= null){
			entireThing.append(line);
		}		


//		System.out.println("\n\n" + entireThing + "\t\t" + entireThing.length());

		int startHtml=0, endHtml=0, toBeReplaced=0, tempInt = 0;
		
		startHtml = entireThing.indexOf("html>");
		endHtml = entireThing.indexOf("</html>");

//		int x = startHtml;

		int quoteMark = startHtml, comma = startHtml;

		while((startHtml != -1) || (endHtml != -1)){
			
			while((toBeReplaced  = entireThing.indexOf("\"",quoteMark))< entireThing.indexOf("</html>")){
//				toBeReplaced = ;
				if ((toBeReplaced == -1))	break;
				entireThing.replace(toBeReplaced, toBeReplaced+1, "\\\"");
				quoteMark = toBeReplaced + 2;
			}

			while((toBeReplaced  = entireThing.indexOf(",",comma))< entireThing.indexOf("</html>")){
//				toBeReplaced;
				if ((toBeReplaced == -1))	break;
				entireThing.replace(toBeReplaced, toBeReplaced+1, "\\,");
				comma = toBeReplaced + 2;
			}

			tempInt = entireThing.indexOf("]")+ 1;
		
			tempStr = entireThing.substring(0, tempInt);		
			entireThing = entireThing.delete(0, tempInt);

			pw.write(tempStr);
//			System.out.println(tempStr + "\n\n\n");
	
			startHtml = quoteMark = comma = entireThing.indexOf("html>" );
			endHtml = entireThing.indexOf("</html>");
			
		}

//		System.out.println(entireThing.toString());

		pw.write(entireThing.toString());

/*		do{

			toBeReplaced = entireThing.indexOf("\"", x);
			if(toBeReplaced == -1)break;
			entireThing.replace(toBeReplaced, toBeReplaced+1, "\\\"");
			//entireThing.setCharAt(toBeReplaced-1 ,'\\');
			x = toBeReplaced  + 3;
			endHtml = entireThing.indexOf("</html>");

		}while(toBeReplaced != -1);

		x = startHtml;

		do{

			toBeReplaced = entireThing.indexOf(",", x);
			if(toBeReplaced == -1)break;
			entireThing.replace(toBeReplaced, toBeReplaced+1, "\\,");
//			entireThing.setCharAt(toBeReplaced-1 ,'\\');
			x = toBeReplaced  + 2;
			endHtml = entireThing.indexOf("</html>");

		}while(toBeReplaced != -1);

*/	

		
		pw.close();
		br.close();

//		System.out.println("\n\n" + entireThing + "\t\t" + entireThing.length());


//		System.out.println(entireThing);
	}catch(Exception ioe){
		ioe.printStackTrace();
		System.out.println(ioe.getMessage() + " exception");
	}

	}
}