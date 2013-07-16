// stores the reference to the XMLHttpRequest object
var xmlHttp = createXmlHttpRequestObject();
// retrieves the XMLHttpRequest object


// make asynchronous HTTP request using the XMLHttpRequest object
function process() {
  // proceed only if the xmlHttp object isn't busy
  if (xmlHttp.readyState == 4 || xmlHttp.readyState == 0) {
    // retrieve the name typed by the user on the form

    // execute the quickstart.php page from the server
    xmlHttp.open("GET", "bubble.php" , true);
    // define the method to handle server responses
    xmlHttp.onreadystatechange = handleServerResponse;
    // make the server request
    xmlHttp.send(null);
  } else // if the connection is busy, try again after one second
    setTimeout('process()', 1000);
}
