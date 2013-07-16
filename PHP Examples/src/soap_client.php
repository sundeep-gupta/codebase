<?php  
  $client = new SoapClient("catalog.wsdl");
  $catalogId='catalog1';
$output_headers = array();
$response = $client->__soapCall("getCatalogEntry", array($catalogId),null, $header, &$output_headers);
#  $response = $client->getCatalogEntry($catalogId);
  echo $response;
?>