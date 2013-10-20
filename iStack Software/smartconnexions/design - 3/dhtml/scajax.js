// stores the reference to the XMLHttpRequest object
var ajax_obj = new BubbleAJAX();

// retrieves the XMLHttpRequest object


// make asynchronous HTTP request using the XMLHttpRequest object
function process(url) {
  // proceed only if the xmlHttp object isn't busy
  if (ajax_obj.isReadyState(4) || ajax_obj.isReadyState(0) ) {
    // retrieve the name typed by the user on the form

    // execute the quickstart.php page from the server
    ajax_obj.xmlHttp.open("GET", "AJAXController.php?action="+url , true);

    // define the method to handle server responses
    ajax_obj.xmlHttp.onreadystatechange = handleServerResponse;

    // make the server request
    ajax_obj.xmlHttp.send(null);

  } else // if the connection is busy, try again after one second
    setTimeout('process()', 1000);
}




// executed automatically when a message is received from the server
function handleServerResponse() {
// move forward only if the transaction has completed
  if (ajax_obj.isReadyState(4)) {
    // status of 200 indicates the transaction completed successfully
    if (ajax_obj.isStatus(200)) {
      // extract the XML retrieved from the server
      helloMessage = ajax_obj.responseText();
      // update the client display using the data received from the server
      document.getElementById("cdata").innerHTML = helloMessage ;
      // restart sequence
    } else { // a HTTP status different than 200 signals an error
      alert("There was a problem accessing the server: " + ajax_obj.statusText());
    }
  }
}
