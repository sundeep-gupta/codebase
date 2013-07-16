<?php
require_once('User.php');
require_once('Account.php');
    session_start();
  //  $_SESSION['userid'] = 8;
    if(isset($_SESSION['userid'])) {
        $user = new User($_SESSION['userid']);
      //  $user->set_userid($_SESSION['userid']);
        echo $user->get_name();
        print_r($user->get_address());
        echo $user->get_area();
        echo $user->get_city();
        echo $user->get_phone();


        $account = new Account($user->get_userid());
        echo $account->get_balance();
        // Show the user's subscriptions here.
        $query = "SELECT S.ID AS ID, C.NAME AS CUISINE, S.START_DATE AS START_DATE, S.END_DATE AS END_DATE ".
        "FROM CUISINE C, SUBSCRIPTION S WHERE C.ID = S.CUISINEID AND S.ACTIVE = 1 AND S.USERID = ?";
        $conn = Connection::get_connection();
        $statement = $conn->prepare($query);
        $statement->bindParam(1,$_SESSION['userid']);
        $statement->execute();
        while($result = $statement->fetch(PDO::FETCH_ASSOC)) {
            echo $result['CUISINE'] . " " . $result['START_DATE'] . " " . $result['END_DATE'];
        }
        // Link to display all cuisines.
        echo '<a href="cuisine_show.php">Show Cuisines</a>';
        exit;
    }
?>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title></title>
  </head>
  <body>
      <h3>Register to get suscribed</h3>
      <a href="register.php">Register</a> or <a href="login.php">Login Here</a>
  </body>
</html>
