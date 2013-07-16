<?
session_start();
if (isset($_SESSION['counter'])) {
    $_SESSION['counter']++;
} else {
    echo 'I came here';
  $_SESSION['counter'] = 1;
}
$counter = $_SESSION['counter'];
print "You have visited this page $counter times during this session";
echo "<a href='sess_ex_2.php'>sess</a>";

?>