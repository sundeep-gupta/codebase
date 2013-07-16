function createXmlHttpRequestObject() {
  // will store the reference to the XMLHttpRequest object
  if(window.ActiveXObject) {
    try {
      xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    } catch (e) {
      xmlHttp = false;
    }
  } else { // if running Mozilla or other browsers
    try {
      xmlHttp = new XMLHttpRequest();
    } catch (e) {
      xmlHttp = false;
    }
  }
// return the created object or display an error message
  if (!xmlHttp)
     alert("Error creating the XMLHttpRequest object.");
  else
     return xmlHttp;
}


// executed automatically when a message is received from the server
function handleServerResponse() {
// move forward only if the transaction has completed
  if (xmlHttp.readyState == 4) {
    // status of 200 indicates the transaction completed successfully
    if (xmlHttp.status == 200) {
      // extract the XML retrieved from the server
      xmlResponse = xmlHttp.responseXML;
      // obtain the document element (the root element) of the XML structure
      xmlDocumentElement = xmlResponse.documentElement;
      // get the text message, which is in the first child of
      // the the document element
      helloMessage = xmlHttp.responseText;
      // update the client display using the data received from the server
      document.getElementById("CONTENT").innerHTML =
      '<i>' + helloMessage + '</i>';
      // restart sequence
      setTimeout('process()', 1000);
    } else { // a HTTP status different than 200 signals an error
      alert("There was a problem accessing the server: " + xmlHttp.statusText);
    }
  }
}
