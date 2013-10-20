<?php

class Email {

    const autogen_message = "\n---- Please DO NOT REPLY to this mail. This is automatically generated mail --- \n";
    // Email sender for contact us
    public static function contact_us($name, $from, $phone_m, $phone_l, $subject, $message) {
	$to = EMAIL_CONTACT;
	$from = 'From: '.$from;
	$main_message = "Hi Premium Brokers\n\n".$message."\n\nContact Details:\n";
	$main_message .= "Name: $name\nPhone(M): $phone_m\nPhone(L): $phone_l\nEmail: $from\n\n";
	$main_message .= Email::autogen_message;
	if(mail($to, $subject, $main_message, $from)) {
#	    echo 'Message Sent';
	}
    }

    
    public static function buy($properties, $contact) {
		    
	$from = "From: ".$contact['email'];
	$to   = EMAIL_BUY;
	$subject = $contact['firstname'].' is interested to buy property';
	$message = "Hi Premium Brokers,\n\nI have visited your web-site and found the following property(ies) meeting my requirements.\n";
	
	foreach ($properties as $property) {
	    $message .= 'Title: '. $property['title']."\n";
	    $message .= 'Location: '. $property['location']."\n";
	    $message .= 'Contact: '. $property['contact']."\n";
	    $message .= "\n";
	}
	
	$message .= "I would be pleased to hear from you for further details\n\n";
	$message .= "\n\nContact Details:\n";
	$message .= "Name:".$contact['name']."\nPhone: ".$contact['phone']."\nEmail: ".$from."\n\n";
	$message .= Email::autogen_message;
	if(mail($to, $subject, $message, $from)) {
#	    echo 'Message Sent';
	}
    }


    public static function rent_in($properties, $contact) {
	$rc   = 1;
	$from = "From: ".$contact['email'];
	$to   = EMAIL_RENTIN;
	$subject = $contact['firstname'].' is interested to rent in property';
	$message = "Hi Premium Brokers,\n\nI have visited your web-site and found the following property(ies) meeting my requirements.\n";

	foreach ($properties as $property) {
	    $message .= 'Title: '. $property['title']."\n";
	    $message .= 'Location: '. $property['location']."\n";
	    $message .= 'Contact: '. $property['contact']."\n";
	    $message .= "\n";
	}
	
	$message .= "I would be pleased to hear from you for further details\n\n";
	$message .= "\n\nContact Details:\n";
	$message .= "Name:".$contact['name']."\nPhone: ".$contact['phone']."\nEmail: ".$from."\n\n";
	$message .= Email::autogen_message;
	if(!mail($to, $subject, $message, $from)) {
	    #echo 'Message Sent';
	    $rc = 0;
	}
	return $rc;
    }

    public static function send_message_to_contacts ($contacts, $message) {
	$rc = 1;
	
	foreach ($contacts as $row) {
	    $to          = $row['email'];
	    $subject     = 'Message from Premeium Brokers';
	    $from_header = 'From: '.EMAIL_PB;
	    $main_message = 'Hi '.$row['name']."\n\n".$message;
	    $main_message .= "\n\n Thanks & Regards,\n\n Premium Brokers\nwww.premiumbrokers.co.in\n\n";
	    $main_message .= Email::autogen_message;

	    if (! mail($to, $subject, $main_message, $from_header)) {

		$rc = 0;
	    }
	}
	return $rc;
    }

    public static function property_added_for_sell($property, $contact) {
	$rc       = 1;
	$message  = "Hi,\n";
	$message .= "A property has been added for selling by ".$contact['name']."\n";
	$message .= "\n";
	$message .= "Contact person details\n";
	$message .= "Name: ".$contact['name']."\nPhone: ".$contact['phone']."\nEmail: ".$contact['email']."\n\n";
	$message .= "Property details \n";
	$message .= "\nTitle: ".$property['title'];
	$message .= "\nLocation: ".$property['location'];
	$message .= "\nDescription: ".$property['description'];
	$message .= "\n\n";
	$message .= Email::autogen_message;
	
	$to       = EMAIL_SELL;
	$from     = 'From: '.EMAIL_NOREPLY;
	$subject  = 'Property to Sell';

	if( ! mail($to, $subject, $message, $from)) {
	    $rc = 0;
	}
	return $rc;
    }

    public static function property_added_for_rent($property, $contact) {

	$rc       = 1;
	$message  = "Hi,\n";
	$message .= "A property has been added for renting by ".$contact['name']."\n";
	$message .= "\n";
	$message .= "Contact person details\n";
	$message .= "Name: ".$contact['name']."\nPhone: ".$contact['phone']."\nEmail: ".$contact['email']."\n\n";
	$message .= "Property details \n";
	$message .= "\nTitle: ".$property['title'];
	$message .= "\nLocation: ".$property['location'];
	$message .= "\nDescription: ".$property['description'];
	$message .= "\n\n";
	$message .= Email::autogen_message;
	
	$to       = EMAIL_RENOUT;
	$from     = 'From: '.EMAIL_NOREPLY;
	$subject  = 'Property to Rent Out';

	if( ! mail($to, $subject, $message, $from)) {
	    $rc = 0;
	}
	return $rc;
    }

    public static function property_required($property, $contact) {
	$rc       = 1;
	
	$message  = "Hi,\n";
	
	$message .= "I have the following requirement \n\n";
	$message .= "Requirement details \n";
	$message .= "\nTitle: ".$property['title'];
	$message .= "\nLocation: ".$property['location'];
	$message .= "\nDescription: ".$property['description'];
	$message .= "\n\n";
	$message .= "Contact person details\n";
	$message .= "Name: ".$contact['name']."\nPhone: ".$contact['phone']."\nEmail: ".$contact['email']."\n\n";
	$message .= "Please contact me if you have property with the given requirements\n\n";

	$message .= Email::autogen_message;
	$to       = EMAIL_REQUIRE;
	$from     = 'From: '.$contact['email'];
	$subject  = $contact['name']. " needs Property";
	if( ! mail($to, $subject, $message, $from)) {
	    $rc = 0;
	}
	return $rc;
    }

}


?>