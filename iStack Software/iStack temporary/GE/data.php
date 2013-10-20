<?php
session_start(); 
$ebits = ini_get('error_reporting');
error_reporting($ebits ^ E_NOTICE);


//Logging in with Google accounts requires setting special identity, so this example shows how to do it.
require 'openid.php';

try 
{
	# Change 'localhost' to your domain name.
	$openid = new LightOpenID($_SERVER['HTTP_HOST']);
	
	//Not already logged in
	if(!$openid->mode)
	{
		//The google openid url
		$openid->identity = 'https://www.google.com/accounts/o8/id';
		
		//Get additional google account information about the user , name , email , country
		$openid->required = array('contact/email' , 'namePerson/first' , 'namePerson/last' , 'pref/language' , 'contact/country/home'); 
		
		//start discovery
		header('Location: ' . $openid->authUrl());
	}
	
	else if($openid->mode == 'cancel')
	{
		echo 'User has canceled authentication!';
		//redirect back to login page ??
	}
	
	//Echo login information by default
	else
	{
		if($openid->validate())
		{
			//User logged in
			$d = $openid->getAttributes();
			$first_name = $d['namePerson/first'];
			$last_name = $d['namePerson/last'];
		//	$password = $d['contact/password'];
			$email = $d['contact/email'];
			$language_code = $d['pref/language'];
	//		$country_code = $d['contact/country/home'];
			
			$data = array(
				'first_name' => $first_name ,
				'last_name' => $last_name ,
				'email' => $email ,
			);
			
                        //now signup/login the user.
			process_google_data2($data);
			
			
			//echo $data['email'];
			
			$_SESSION["email"] = $email;
	//		$_SESSION["password"] = $password;
		}
		else
		{
			//user is not logged in
		}
	}
}

catch(ErrorException $e) 
{
	echo $e->getMessage();
}

function process_google_data($data)
{
	$email = $data['email'];
	$username = $data['username'];
	$source = $data['source'];
	
	$result = $this->db->get_where('users' , array('email' => $email));
	
        //if the user already exists , then log him in rightaway
	if($result->num_rows() > 0)
	{
		//already registered , just login him
		$row = $result->row_array();
		$this->do_login($row);
	}
        //new user, first sign him up, then log him in
	else
	{
		//register him , and login
		$toi = array(
			'email' => $email ,
			'username' => $username ,
			'password' => md5($this->new_password()) ,
			'source' => $source ,
		);
		
		$this->db->insert('users' , $toi);
		
		$result = $this->db->get_where('users' , array('email' => $email));
		
		if($result->num_rows() > 0)
		{
			$row = $result->row_array();
			$this->do_login($row);
		}
	}
	
        //redirect to somewhere
	redirect(site_url());
}

function process_google_data2($data)
{
 //	$email = $data['email'];
//	$username = $data['username'];
//	$source = $data['source'];
	
//	#$result = $this->db->get_where('users' , array('email' => $email));
	
        //if the user already exists , then log him in rightaway
	
	
        //redirect to somewhere
	// $red = "http://istacksoftware.com/apps/ttrack/appindex.php";	
	$red = "http://localhost/itrack/GE/appindex.php";	
	//redirect(site_url());
	redirect($red);
}

function redirect($red) {
header("Location: ".$red);
}

/**
	Do login taking a row of resultset
*/
function do_login($row)
{
	session_set('uid' , $row['id']);
	session_set('email' , $row['email']);
	session_set('logged_in' , true);
	
	$_SESSION["email"] = $row['email'];
	
	
	return true;
}
?>
