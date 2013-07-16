import java.util.*;

public class quote{

public String addSlashes(String str){
if(str==null) return "";

StringBuffer s = new StringBuffer ((String) str);
System.out.println(s);
for (int i = 0; i < s.length(); i++)
if (s.charAt (i) == '\"')
s.insert (i++, '\\');

return s.toString();

}

public static void main(String args[]) {
quote qt=new quote();
String str="This is Prav\"s World";
System.out.println(qt.addSlashes(str));
}

}
