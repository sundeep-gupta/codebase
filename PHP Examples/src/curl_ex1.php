<?php
//
// HTTP PUT to a remote site
// Author: Julian Bond
//
echo 'Hi Sunny';

$url = "httecho 'Hi Sunny';p://localhost/index.php";
echo 'Hi Sunny';
$ch = curl_init() or die ("I died here");
echo 'Hi Sunny';
curl_setopt($ch, CURLOPT_URL, $url);
echo 'Hi Sunny';
#curl_setopt($ch, CURLOPT_GET, 1);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

$http_result = curl_exec($ch) or die ("Sundeep");
$error = curl_error($ch);
$http_code = curl_getinfo($ch ,CURLINFO_HTTP_CODE);

curl_close($ch);

print $http_code;
print "<br /><br />$http_result";
if ($error) {
   print "<br /><br />$error";
}

?>