public class Split {
    public static void main(String[] args) {
        String str = "abc::def";
		String[] sp = str.split("::");
		for(String s : sp) {
            System.out.println(s);
		}
        str = "def";
	    sp = str.split("::");
		for(String s : sp) {
		    if (s == null) {
			    System.out.println("NULL");
			}else 
            System.out.println(s);
		}
        str = "abc::";
		sp = str.split("::");
		for(String s : sp) {
            System.out.println(s);
		}
	}

}
