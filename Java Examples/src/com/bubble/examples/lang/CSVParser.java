public class CSVParser {
    public static void main(String[] args) {
        for(String arg : args ) {
            String output = parseLine(arg, ",");   
            System.out.println(output);
        }
    }
    private static String parseLine(String line, String delimiter) {
        String token = "";
        String output = "";
        boolean insideQuote = false;
        boolean escapeChar = false;
	int quotePos = -1;
        while( line.length() > 0 ) {
            
                if( line.startsWith( delimiter) && ! insideQuote ) {
                    output = output + token  + "\n";
                    token = "";
                    line = line.substring(delimiter.length());
		    continue;
                }
            if ( insideQuote ) {
		if ( line.startsWith("\\") && ! escapeChar){
                    escapeChar = true;
                    token = token + "\\";
                } else if ( line.startsWith("\"")) {
                    if( escapeChar ) {
	                token = token + "\"";
			escapeChar = false;
		    } else {
                        insideQuote = false;
                        String dqString = token.substring(quotePos + 1);
		        token = token.substring(0,quotePos) + 
			    processToken(dqString);
		        quotePos = -1;
		    }
                } else {
		    token = token + line.substring(0,1);
                    escapeChar = false;
		}
                line = line.substring(1);
            } else {
		if( line.startsWith("\"") ) {
	            quotePos = token.length();
                    insideQuote = true;
	        } 
                token = token + line.substring(0,1);
                line = line.substring(1);
            }
        }
	output = output + token;
        return output;
    }
    /**
     * Processes escape characaters in the given token.
     */
    private static String processToken(String token) {
	String nToken = "";
	for(int i =0 ; i< token.length(); i++) {
            if( token.charAt(i) == '\\' && i < token.length() - 1) {
		i++;
            }
	    nToken = nToken + token.charAt(i);
        }
	return nToken;
   }
}
