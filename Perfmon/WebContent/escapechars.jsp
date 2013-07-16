<%!
String addSlashes(String str) {
	if(str==null) return "";

	StringBuffer s = new StringBuffer ((String) str);
	for (int i = 0; i < s.length(); i++)
	if (s.charAt (i) == '\"') s.insert (i++, '\\');

	for (int i = 0; i < s.length(); i++)
	if (s.charAt (i) == '\'') s.insert (i++, '\\');

	return s.toString();

}

String dbl(String str) {
	if(str==null) return "";

	StringBuffer s = new StringBuffer ((String) str);
	for (int i = 0; i < s.length(); i++)
	if (s.charAt(i) == '\"') {
		s.setLength(s.length()+50);
  		s.insert(i+6,s.charAt(i+1));
		s.insert(i+7,s.charAt(i+2));
		s.insert(i+8,s.charAt(i+3));
		s.insert(i+9,s.charAt(i+4));
		s.insert(i+10,s.charAt(i+5));
		//s.insert(i+11,s.charAt(i+6));
		s.replace (i,i+6,"&quot;");
		i++;
	}

	return s.toString();
}

String single(String str) {
	if(str==null) return "";
	StringBuffer s = new StringBuffer ((String) str);
	for (int i = 0; i < s.length(); i++)
	if (s.charAt (i) == '\'') s.insert (i++, '\\');
	return s.toString();
}


%>