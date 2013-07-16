function validateAddressBook() {
    var form   = document.addressbook;
    var rc = __validateContact(form);

    var element    = form.address;
    var v_element    = element.value;
    var t_element    = '<input id="address" type="text" name="address" />';
    var div       = document.getElementById("d_other");

    div = document.getElementById("d_other");
    if (element.value.length > 50) {
	div.innerHTML = t_element + '<span class="red">Cannot be more than 50 characters</span>';
	rc = false;
    } else {
	div.innerHTML = t_element;
    }
    form.address.value = v_element;
    return rc;
}

function validateRequestProperty() {
    var form   = document.request_property;
    var rc     = __validateContact(form);

    var element    = form.address;
    var v_element    = element.value;
    var t_element    = '<input id="address" type="text" name="address" />';
    var div       = document.getElementById("d_other");

    div = document.getElementById("d_other");
    if (element.value.length > 50) {
	div.innerHTML = t_element + '<span class="red">Cannot be more than 50 characters</span>';
	rc = false;
    } else {
	div.innerHTML = t_element;
    }
    form.address.value = v_element;

    return rc;
    
}

function validateResidential() {
    var form = document.residential;
    var rc   = true;
    var error3 = '';

    /* Validate Name : Optional, Text, Length */
    var element    = form.p_name;
    var v_element    = element.value;
    var error1    = '<span class="red">Valid characters are a-z, A-Z, 0-9 and {_,. , -, space)</span>';
    var error2    = '<span class="red">Max 30 characters allowed</span>';
    var t_element    = '<input id="p_name" :type="text" name="p_name">';
    var div       = document.getElementById("d_name");
    if(! isAlphaNumeric(element.value)) {
	div.innerHTML = t_element + error1; rc = false;      
    } else if ( element.value.length > 30) {
	div.innerHTML = t_element + error2; rc = false;
    } else {
	div.innerHTML = t_element;
    }
    form.p_name.value = v_element;


    /* Validate : Compulsory,  length */
    element = form.p_address 
    v_element = element.value;
    error1 = '<span class="red">Valid characters are a-z, A-Z, 0-9 and {_,. , -, space)</span>';
    error2 = '<span class="red">Max 60 characters allowed</span>';
    error3 = '<span class="red">Address cannot be empty</span>';
    t_element = '<input id="p_address" name="p_address" type="text">';
    div  = document.getElementById("d_address");
    if (element.value == null || element.value == "") {
	div.innerHTML = t_element + error3;  rc = false;
    } else if(! isAlphaNumeric(element.value)) {
	div.innerHTML = t_element + error1;   rc = false; 
    } else if ( element.value.length > 60) {
	div.innerHTML = t_element + error2; rc = false;
    } else {
	div.innerHTML = t_element;
    }
    form.p_address.value = v_element;


    /* Validate age : Numeric, Length */
    element       = form.p_age    
    v_element    = element.value;
    t_element   = '<input id="p_age" name="p_age" type="text">' ;
    error1    = '<span class="red">Please specify correct age</span>';
    error2 = '<span class="red">Max 3 digits allowed</span>';
    div = document.getElementById("d_age");
    if(! isInteger(element.value)) {
	div.innerHTML = t_element + error1;  rc = false;
       
    } else if (element.value.length > 3) {
	div.innerHTML = t_element + error2; rc = false;

    } else {
	div.innerHTML = t_element;
    }    
    form.p_age.value = v_element;


    /* Validate bed rooms: Compulsory, Numeric, Length */
    element    = form.broom  
    v_element   = element.value;
    t_element   = '<input id="broom" name="broom" type="text">' ;
    error1   = '<span class="red">Invalid number of bedrooms</span>';
    error3   = '<span class="red">Bedrooms cannot be empty</span>';
    error2   = '<span class="red">Max 3 digits allowed</span>';
    div = document.getElementById("d_broom");

    if(element.value == "" || element.value == null) {
	div.innerHTML = t_element + error3; rc = false;

    } else if(! isInteger(element.value)) {
	div.innerHTML = t_element + error1;  rc = false;
       
    } else if (element.value.length > 3) {
	div.innerHTML = t_element + error2; rc = false;

    } else {
	div.innerHTML = t_element;
    }
    form.broom.value = v_element;


    /* Validate b area : Compulsory, Numeric, Length */
    element    = form.b_area ;
    v_element   = element.value;
    t_element   = '<input id="b_area" name="b_area" type="text">' ;
    error3   = '<span class="red">Built area cannot be empty</span>';
    error1   = '<span class="red">Invalid Built area</span>';
    error2   = '<span class="red">Max 7 digits allowed</span>';
    div = document.getElementById("d_barea");
    if (element.value == "" || element.value == null) {
	div.innerHTML = t_element + error3; rc = false;

    } else if(! isInteger(element.value)) {
	div.innerHTML = t_element + error1;      rc = false;
   
    } else if (element.value.length > 7) {
	div.innerHTML = t_element + error2; rc = false;

    } else {
	div.innerHTML = t_element;
    }
    form.b_area.value = v_element;



    element    = form.c_area ;
    v_element   = element.value;
    t_element   = '<input id="c_area" name="c_area" type="text">' ;
    error1   = '<span class="red">Invalid Carpet area</span>';
    error2 = '<span class="red">Max 7 digits allowed</span>';
    div = document.getElementById("d_carea");
    /* Validate b area : Numeric, Length */

    if(! isInteger(element.value) ) {
	div.innerHTML = t_element + error1;      rc = false;
   
    } else if (element.value.length > 7) {
	div.innerHTML = t_element + error2; rc = false;

    } else {
	div.innerHTML = t_element;
    }
    form.c_area.value = v_element;



    /* Validate amount : Optional, Numeric, length */
    element  = form.amount ;
    v_element  = element.value;
    t_element  = '<input id="amount" name="amount" type="text">';
    error1  = '<span class="red">Invalid amount</span>';
    error2  = '<span class="red">Max 11 digits allowed</span>';
    div = document.getElementById("d_amount");

    if(! isInteger(element.value) ) {
	div.innerHTML = t_element + error1;      rc = false;
   
    } else if (element.value.length > 11) {
	div.innerHTML = t_element + error2; rc = false;

    } else {
	div.innerHTML = t_element;
    }
    form.amount.value = v_element;


    element     = form.floor;
    v_element    = element.value;
    t_element   = '<input id="floor" name="floor" type="text">';
    error1   = '<span class="red">Invalid number</span>';
    error2   = '<span class="red">Max 3 digits allowed</span>';
    div = document.getElementById("d_floor");
    /* Validate floor : Numeric, Length */
    if(! isInteger(element.value) ) {
	div.innerHTML = t_element + error1;      rc = false;
   
    } else if (element.value.length > 3) {
	div.innerHTML = t_element + error2; rc = false;

    } else {
	div.innerHTML = t_element;
    }
    form.floor.value = v_element;


    element     = form.terrace ;
    v_element   = element.value;
    t_element   = '<input id="terrace" name="terrace" type="text">' ;
    error1   = '<span class="red">Terrace must be a number</span>';
    error2   = '<span class="red">Max 2 digits allowed</span>';
    error3   = '<span class="red">Terrace cannot be empty</span>';
    div = document.getElementById("d_terrace");
    /* Validate b area : Compulsory, Numeric, Length */
  
    if (element.value == "" || element.value == null) {
	div.innerHTML = t_element + error3; rc = false;

    } else if(! isInteger(element.value) ) {
	div.innerHTML = t_element + error1 ;      rc = false;
   
    } else if (element.value.length > 2) {
	div.innerHTML = t_element + error2; rc = false;

    } else {
	div.innerHTML = t_element;
    }
    form.terrace.value = v_element;



    element   = form.balcony;
    v_element = element.value;
    t_element   = '<input id="balcony" name="balcony" type="text">' ;
    error1   = '<span class="red">Balcony must be a number</span>';
    error2   = '<span class="red">Max 2 digits allowed</span>';
    div = document.getElementById("d_balcony");
    if(! isInteger(element.value)) {
	div.innerHTML = t_element + error1;    rc = false;
     
    } else if (element.value.length > 2) {
	div.innerHTML = t_element + error2; rc = false;

    } else {
	div.innerHTML = t_element;
    }
    form.balcony.value = v_element;

    element = form.garden 
    v_element   = element.value;
    t_element   = '<input id="garden" name="garden" type="text">' ;
    error1   = '<span class="red">Garden must be a number</span>';
    error2   = '<span class="red">Max 2 digits allowed</span>';
    div = document.getElementById("d_garden");
    if(! isInteger(element.value) ) {
	div.innerHTML = t_element + error1; rc = false;

    } else if (element.value.length > 2) {
	div.innerHTML = t_element + error2; rc = false;

    } else {
	div.innerHTML = t_element;
    }
    form.garden.value = v_element;

    /* Validate : Length */
    element   = form.amenities ;
    v_element    = element.value;
    t_element   = '<input id="amenities" name="amenities" type="text">' ;
    error2   = '<span class="red">Max 30 characters allowed</span>';
    div = document.getElementById("d_amenities");

    if (element.value.length > 30) {
	div.innerHTML = t_element + error2; rc = false;

    } else {
	div.innerHTML = t_element;
    }
   form.amenities.value = v_element;


    element   = form.water
    v_element    = element.value;
    t_element   = '<input id="water" name="water" type="text">';
    error2   = '<span class="red">Max 20 characters allowed</span>';
    div = document.getElementById("d_water");
    if (element.value.length > 20) {
	div.innerHTML = t_element + error2; rc = false;

    } else {
	div.innerHTML = t_element;
    }
   form.water.value = v_element;
 

    element   = form.details
    v_element    = element.value;
    t_element   = '<textarea name="details" cols="30" rows="10"></textarea>' ;
    error2   = '<span class="red">Max 100 characters allowed</span>';
    div = document.getElementById("d_details");
    if (element.value.length > 100) {
	div.innerHTML = t_element + error2; rc = false;

    } else {
	div.innerHTML = t_element;
    }
    form.details.value = v_element;

    return rc;
    
}

function validateCommercial() {
    var rc        = true;
    var form      = document.commercial;
    var error3 = '';

    /* Validate Name : Optional, Text, Length */
    var element    = form.p_name;
    var v_element    = element.value;
    var error1    = '<span class="red">Valid characters are a-z, A-Z, 0-9 and {_,. , -, space)</span>';
    var error2    = '<span class="red">Max 30 characters allowed</span>';
    var t_element    = '<input id="p_name" :type="text" name="p_name">';
    var div       = document.getElementById("d_name");

    if(! isAlphaNumeric(element.value)) {
	div.innerHTML = t_element + error1; rc = false;      
    } else if ( element.value.length > 30) {
	div.innerHTML = t_element + error2; rc = false;
    } else {
	div.innerHTML = t_element;
    }
    form.p_name.value = v_element;

   /* Validate : Compulsory,  length */
    element = form.p_address ;
    v_element = element.value;
    error1 = '<span class="red">Valid characters are a-z, A-Z, 0-9 and {_,. , -, space)</span>';
    error2 = '<span class="red">Max 60 characters allowed</span>';
    error3 = '<span class="red">Address cannot be empty</span>';
    t_element = '<input id="p_address" name="p_address" type="text">';
    div  = document.getElementById("d_address");
    if (element.value == null || element.value == "") {
	div.innerHTML = t_element + error3;  rc = false;
    } else if(! isAlphaNumeric(element.value)) {
	div.innerHTML = t_element + error1;   rc = false; 
    } else if ( element.value.length > 60) {
	div.innerHTML = t_element + error2; rc = false;
    } else {
	div.innerHTML = t_element;
    }
    form.p_address.value = v_element;


    /* Validate age : Numeric, Length */
    element       = form.p_age   ;
    v_element    = element.value;
    t_element   = '<input id="p_age" name="p_age" type="text">' ;
    error1    = '<span class="red">Please specify correct age</span>';
    error2 = '<span class="red">Max 3 digits allowed</span>';
    div = document.getElementById("d_age");
    if(! isInteger(element.value)) {
	div.innerHTML = t_element + error1;  rc = false;
       
    } else if (element.value.length > 3) {
	div.innerHTML = t_element + error2; rc = false;

    } else {
	div.innerHTML = t_element;
    }    
    form.p_age.value = v_element;



    /* Validate b area : Compulsory, Numeric, Length */
    element    = form.b_area // must, numeric
    v_element   = element.value;
    t_element   = '<input id="b_area" name="b_area" type="text">' ;
    error3   = '<span class="red">Built area cannot be empty</span>';
    error1   = '<span class="red">Invalid Built area</span>';
    error2   = '<span class="red">Max 7 digits allowed</span>';
    div = document.getElementById("d_barea");
    if (element.value == "" || element.value == null) {
	div.innerHTML = t_element + error3; rc = false;

    } else if(! isInteger(element.value)) {
	div.innerHTML = t_element + error1;      rc = false;
   
    } else if (element.value.length > 7) {
	div.innerHTML = t_element + error2; rc = false;

    } else {
	div.innerHTML = t_element;
    }
    form.b_area.value = v_element;




    element    = form.c_area  // numeric
    v_element   = element.value;
    t_element   = '<input id="c_area" name="c_area" type="text">' ;
    error1   = '<span class="red">Invalid Carpet area</span>';
    error2 = '<span class="red">Max 7 digits allowed</span>';
    div = document.getElementById("d_carea");
    /* Validate b area : Numeric, Length */

    if(! isInteger(element.value) ) {
	div.innerHTML = t_element + error1;      rc = false;
   
    } else if (element.value.length > 7) {
	div.innerHTML = t_element + error2; rc = false;

    } else {
	div.innerHTML = t_element;
    }
    form.c_area.value = v_element;


    /* Validate amount : Optional, Numeric, length */
    element  = form.amount    // numeric
    v_element  = element.value;
    t_element  = '<input id="amount" name="amount" type="text">';
    error1  = '<span class="red">Invalid amount</span>';
    error2  = '<span class="red">Max 11 digits allowed</span>';
    div = document.getElementById("d_amount");

    if(! isInteger(element.value) ) {
	div.innerHTML = t_element + error1;      rc = false;
   
    } else if (element.value.length > 11) {
	div.innerHTML = t_element + error2; rc = false;

    } else {
	div.innerHTML = t_element;
    }
    form.amount.value = v_element;


    element     = form.floor //numeric
    v_element    = element.value;
    t_element   = '<input id="floor" name="floor" type="text">';
    error1   = '<span class="red">Invalid number</span>';
    error2   = '<span class="red">Max 3 digits allowed</span>';
    div = document.getElementById("d_floor");
    /* Validate floor : Numeric, Length */
    if(! isInteger(element.value) ) {
	div.innerHTML = t_element + error1;      rc = false;
   
    } else if (element.value.length > 3) {
	div.innerHTML = t_element + error2; rc = false;

    } else {
	div.innerHTML = t_element;
    }
    form.floor.value = v_element;


    element     = form.height // numeric
    v_element   = element.value;
    t_element   = '<input id="height" name="height" type="text">' ;
    error1   = '<span class="red">Height must be a number</span>';
    error2   = '<span class="red">Max 3 digits allowed</span>';
    div = document.getElementById("d_height");
    if(! isInteger(element.value) ) {
	div.innerHTML = t_element + error1;    rc = false;
    
    } else if (element.value.length > 3) {
	div.innerHTML = t_element + error2;rc = false;

    } else {
	div.innerHTML = t_element;
    }
   form.height.value = v_element;


    element     = form.frontage
    v_element   = element.value;
    t_element   = '<input id="frontage" name="frontage" type="text">' ;
    error1   = '<span class="red">Frontage must be a number</span>';

    error2   = '<span class="red">Max 5 digits allowed</span>';
    div = document.getElementById("d_frontage");
    if(! isInteger(element.value) ) {
	div.innerHTML = t_element + error1;    rc = false;
    
    } else if (element.value.length > 5) {
	div.innerHTML = t_element + error2;rc = false;

    } else {
	div.innerHTML = t_element;
    }
   form.frontage.value = v_element;


    element     = form.mezzanine
    v_element   = element.value;
    t_element   = '<input id="mezzanine" name="mezzanine" type="text">' ;
    error1   = '<span class="red">Mezzanine must be a number</span>';
    error2   = '<span class="red">Max 5 characters allowed</span>';
    div = document.getElementById("d_mezzanine");
    if(! isInteger(element.value) ) {
	div.innerHTML = t_element + error1;    rc = false;
    
    } else if (element.value.length > 5) {
	div.innerHTML = t_element + error2;rc = false;

    } else {
	div.innerHTML = t_element;
    }
   form.mezzanine.value = v_element;


    element = form.e_cap  // numeric
    v_element   = element.value;
    t_element   = '<input id="e_cap" name="e_cap" type="text">' ;
    error1   = '<span class="red">Electricity Capacity must be a number</span>';
    error2   = '<span class="red">Max 8 digits allowed</span>';
    div = document.getElementById("d_ecap");
    /* Validate b area : Numeric, Length */
    if(! isInteger(element.value) ) {
	div.innerHTML = t_element + error1;rc = false;

    } else if (element.value.length > 8) {
	div.innerHTML = t_element + error2;rc = false;

    } else {
	div.innerHTML = t_element;
    }
   form.e_cap.value = v_element;


    var gen_cap   = form.g_cap ;
    v_element   = element.value;
    t_element   = '<input id="g_cap" name="g_cap" type="text">' ;
    error1   = '<span class="red">Generator Capacity must be a number</span>';
    error2   = '<span class="red">Max 8 digits allowed</span>';
    div = document.getElementById("d_gcap");
    if(! isInteger(element.value) ) {
	div.innerHTML = t_element + error1;rc = false;
    } else if (element.value.length > 8) {
	div.innerHTML = t_element + error2;rc = false;
    } else {
	div.innerHTML = t_element;
    }
   form.g_cap.value = v_element;


    element   = form.water
    v_element    = element.value;
    t_element   = '<input id="water" name="water" type="text">';
    error2   = '<span class="red">Max 20 characters allowed</span>';
    div = document.getElementById("d_water");
    if (element.value.length > 20) {
	div.innerHTML = t_element + error2; rc = false;
    } else {
	div.innerHTML = t_element;
    }
   form.water.value = v_element;
 

    element   = form.details
    v_element    = element.value;
    t_element   = '<textarea name="details" cols="30" rows="10"></textarea>' ;
    error2   = '<span class="red">Max 60 characters allowed</span>';
    div = document.getElementById("d_details");
    if (element.value.length > 60) {
	div.innerHTML = t_element + error2; rc = false;

    } else {
	div.innerHTML = t_element;
    }
    form.details.value = v_element;

    return rc;
}

function deleteContacts() {

    var form = document.contacts;
    var prop_id = form.contact;
    var count    = 0;

    for(var i = 0; i < prop_id.length; i++) {
	if (prop_id[i].checked == true) {
	    count++;
	}
    }

    if (count > 0) {
        var res = confirm("Are you sure you want to delete the contacts and all the property details of these contacts permanently?");
	if(res == true) {
    	    form.action = "controller.php?action=AddressBook&event=delete_contact";
	    form.submit();
        }
    } else {
	alert("Please select one or more contacts to delete");	
    }
    return false;
}
function select_all(contacts,all) {

    for(var i = 0; i < contacts.length; i++) {
	contacts[i].checked = all.checked;
    }
}

function validateContactUs() {
    var rc        = true;
    var form      = document.contact;
    var error3 = '';
    rc = __validateContact(form);


    var element    = form.message;
    var v_element    = element.value;
    var error3    = '<span class="red">Message cannot be empty</span>';
    var t_element    = '<textarea cols=40 rows=10 name="message" value=""></textarea>';
    var div       = document.getElementById("d_message");

    if(element.value == null || element.value == "") {
	div.innerHTML = t_element + error3; rc = false;
    } else {
	div.innerHTML = t_element;
    }
    form.message.value = v_element;
return rc;
}


function __validateContact(form) {

    /* Validate Name : Optional, Text, Length */
    var element    = form.firstname;
    var v_element    = element.value;
    var error1    = '<span class="red">Valid characters are a-z, A-Z, 0-9 and {_,. , -, space)</span>';
    var error2    = '<span class="red">Max 20 characters allowed</span>';
    var error3    = '<span class="red">First Name cannot be empty</span>';
    var t_element    = '<input id="firstname" type="text" name="firstname" />';
    var div       = document.getElementById("d_firstname");

    if(element.value == null || element.value == "") {
	div.innerHTML = t_element + error3; rc = false;
    } else if(! isAlphaNumeric(element.value)) {
	div.innerHTML = t_element + error1; rc = false;      
    } else if ( element.value.length > 20) {
	div.innerHTML = t_element + error2; rc = false;
    } else {
	div.innerHTML = t_element;
    }
    form.firstname.value = v_element;

    element    = form.lastname;
    v_element    = element.value;
    error1    = '<span class="red">Valid characters are a-z, A-Z, 0-9 and {_,. , -, space)</span>';
    error2    = '<span class="red">Max 20 characters allowed</span>';
    error3    = '<span class="red">Last Name cannot be empty</span>';
    t_element    = '<input id="lastname" type="text" name="lastname" />';
    div       = document.getElementById("d_lastname");

    if(element.value == null || element.value == "") {
	div.innerHTML = t_element + error3; rc = false;
    } else if(! isAlphaNumeric(element.value)) {
	div.innerHTML = t_element + error1; rc = false;      
    } else if ( element.value.length > 20) {
	div.innerHTML = t_element + error2; rc = false;
    } else {
	div.innerHTML = t_element;
    }
    form.lastname.value = v_element;


    element    = form.phonem;
    v_element    = element.value;
    error2    = '<span class="red">Invalid phone number</spam>';
    error1    = '<span class="red">Phone number cannot be empty</spam>';
    t_element    = '<input id="phonem" type="text" name="phonem" />';
    div       = document.getElementById("d_phonem");

    if (element.value == null || element.value == "") {
	div.innerHTML = t_element + error1; rc = false;
    } else if (checkInternationalPhone(element) == false || element.value.length > 15) {
	div.innerHTML = t_element + error2;	rc = false;
    } else {
	div.innerHTML = t_element;
    }
    form.phonem.value = v_element;



    element    = form.email;
    v_element    = element.value;
    error2    = '<span class="red">Invalid email</spam>';
    error1    = '<span class="red">Email cannot be empty</spam>';
    t_element    = '<input id="email" type="text" name="email" />';
    div       = document.getElementById("d_email");

    if (element.value == null || element.value == "") {
	div.innerHTML = t_element + error1; rc = false;
    } else if (verifyEmail(element) == false ) {
	div.innerHTML = t_element + error2;	rc = false;
    } else {
	div.innerHTML = t_element;
    }
    form.email.value = v_element;




    return rc;
}