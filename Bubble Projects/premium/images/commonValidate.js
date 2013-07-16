function verifyEmail(emailObj) {
     var email = emailObj.value;
     if ((email.indexOf('@') < 0) || 
	 ((email.charAt(email.length-4) != '.') && 
  	  (email.charAt(email.length-3) != '.'))) {
	return false;
    }		 
}

function isNull(element) {
	
}

function isAlphaNumeric(s) {
    var i;

    for (i = 0; i < s.length; i++) {   
        // Check that current character is number.
        var c = s.charAt(i);

        if ( ! (
	     (c >= "a" && c <= "z") || (c >= "A" && c <= "Z") ||
	     (c >= "0" && c <= "9") || (c == " " || c == "." || c == "_" || c == "-") 
	     ) )
	    return false;
    }
    // All characters are numbers.
    return true;
}

/*
 * isInteger : 
 *            Checks if the given string is integer or not
 */
function isInteger(s) {
    var i;
    if(s == null || s == "") {
	return false;
    }
    for (i = 0; i < s.length; i++) {   
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) 
	    return false;
    }
    // All characters are numbers.
    return true;
}

function isEmpty(element) {

    if (element.value == null || element.value == "") {
	return true;
    }

    return false
}

function stripCharsInBag(s, bag) {
    var i;
    var returnString = "";
    /* Search through string's characters one by one.
       If character is not in bag, append to returnString. */
    for (i = 0; i < s.length; i++) {   
        // Check that current character isn't whitespace.
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}


/*
 * DHTML phone number validation script. 
 */


function checkInternationalPhone(Phone){

/* Declaring required variables */
var digits                  = "0123456789";
var phoneNumberDelimiters   = "()- ";                       // non-digit characters which are allowed in phone numbers 
var validWorldPhoneChars    = phoneNumberDelimiters + "+";  // characters which are allowed in international phone numbers 
var minDigitsInIPhoneNumber = 10;                           // Minimum no of digits in an international phone no.

    if ((Phone.value==null)||(Phone.value=="")){
	Phone.focus();
 return false;
    }
    var s = stripCharsInBag(Phone.value, validWorldPhoneChars);
    if ( (isInteger(s) && s.length >= minDigitsInIPhoneNumber) == false ) {
	Phone.value="";
	Phone.focus();
	return false;
    }
    return true;
 }

function checkAll(field) {
	alert("Hi Sun");
	field = document.delete_form.property;
	alert(" "+ field.length +"S");
	for (i = 0; i < field.length; i++) {
		field[i].checked = true ;	
	}

}