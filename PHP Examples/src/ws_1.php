<?php 
require_once 'SOAP/Client.php';

$wsdl_url = 
  'http://soap.amazon.com/schemas3/AmazonWebServices.wsdl';
$WSDL     = new SOAP_WSDL($wsdl_url); 
$client   = $WSDL->getProxy(); 

$params   = array(
    'manufacturer' => "O'Reilly",
    'mode'         => 'books',
    'sort'         => '+title',
    'page'         => 1,
    'type'         => 'lite',
    'tag'          => 'trachtenberg-20',
    'devtag'       => 'XXXXXXXXXXXXXX',
);

$books    = $client->ManufacturerSearchRequest($params);
if (function_exists("xmlrpc_server_create"))
echo ("Hi Sun");
#print_r ( $books);
?>