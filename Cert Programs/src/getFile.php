<?
	include_once("session.php");
	include_once("cert_functions.php");

	if (isset($_GET["getid"]) && isset($_GET["ppl"])) {
		if (!isset($_SESSION["Certs"][$_GET["ppl"]])) {
		    exit;
		}

  		if(isset($_SERVER['HTTP_USER_AGENT']) && preg_match("/MSIE/", $_SERVER['HTTP_USER_AGENT'])) {
  		     // IE Bug in download name workaround
  		     ini_set( 'zlib.output_compression','Off' );
  		 }
   


	    //find the file in the db
	    $file = GetFile($_GET["getid"]);

	    header('Content-type: '.$file[0]['type']);
   	    header("Pragma: public");
   	    header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
	    header('Content-Disposition: attachment; filename="'.$file[0]["name"].'"');
	    echo file_get_contents($file[0]["path"]);
	}
?>
