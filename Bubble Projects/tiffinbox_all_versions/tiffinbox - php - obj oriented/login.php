<?php
require_once 'User.php';
if (!isset($_POST['email'])) {
?>

<html><head>
<title>User Login page</title>
</head><body>

<form action="login.php" method="post">

Username (email): <input type="text" name="email" size="20"><br>
Password: <input type="password" name="password" size="20"><br>
<input type="submit" value="Log In">
</form>
<a href=register.php>Register</a>
</body></html>

<?php
} else {
    $user = new User();
    $user->set_email($_POST['email']);
    if($user->exists() && $user->get_password() == $_POST['password']) {
        $_SESSION['userid'] = $user->get_userid();
    } else {
        echo "Incorrect username / password!"; exit;
    }
}
?>