<?php 

$a = "hello";
$b = "hi";

$var = sprintf("\n%s", $a);
$var2 =    sprintf("%s\n\t", $b);

$var3 = $var.$var2;

echo $var3;


?>
