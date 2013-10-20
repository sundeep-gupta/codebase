<?php
// Author: Razikh. Date: 10th April 2010.
// For: Tiffin Portal system, Bubble.
// Registration Script
# include("db_config.php");

$_POST['name'] = 'Sundeep';
$_POST['street1'] = 'Sundeep';
$_POST['email'] = 'Sundeep2@test.com';
$_POST['street2'] = 'Sundeep';
$_POST['area'] = 'Sundeep';
$_POST['city'] = 'Sundeep';
$_POST['state'] = 'Sundeep';
$_POST['phone'] = 'Sundeep';
$_POST['password'] = 'Sundeep';

require_once 'User.php';
if(isset($_POST['email'])) {
    // TODO : Validate the params recieved.
    // Create a user object.
    $name = $_POST['name'];
    $street1 = $_POST['street1'];
    $street2 = $_POST['street2'];
    $email = $_POST['email'];
    $area = $_POST['area'];
    $city = $_POST['city'];
    $state = $_POST['state'];
    $phone = $_POST['phone'];

    /* Create the user object, set the values and create the user entry in database */
    $user = new User();
    $user->set_address(array($street1, $street2, $area, $city, $state));
    $user->set_email($email);
    $user->set_name($name);
    $user->set_phone($phone);
    if($user->exists()) {
        $message = "The user already exists!";
        echo $message;
        exit;
    } else {
        $user->create();
        $_SESSION['userid'] = $user->get_userid();
        $message = "Created Successfully!";
        echo $message;
        exit;
    }
}
?>

<html>
<head>
<title>Registration Page</title>
</head>
<body>
<h4>Register here...</h4>
<form method="POST" action="register.php">
Email ID (UserID):  <input type="text" name="email" size="20"><br/>
Password:  <input type ="password" name="password" size="15"> (Max 15 Chars) <br/>
Name:  <input type ="text" name= "name" size="20"> <br/>
Phone:  <input type ="text" name= "phone" size="14"><br/>
House/Flat No:  <input type ="text" name= "street1" size="20"> <br/>
Society/Appartment Name:  <input type ="text" name= "street2" size="20"><br/>
Area:  <input type ="text" name= "area" size="20"><br/>
City:  <input type ="text" name= "city" size="20"><br/>
Country:  <input type ="text" name= "country" size="20"><br/><br/>
<input type="submit" value="Register">
</form>
</body></html>